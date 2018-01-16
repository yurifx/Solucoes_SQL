--------------------------------------------------------------------------------
-- spRevendedoraInsFS23.sql
-- Data   : 02/09/2013
-- Autor  : Amauri
-- Stored procedure para inserir revendedoras, a partir de dados de FS23 
--------------------------------------------------------------------------------

USE ArquivosAvon
GO

Alter Procedure RevendedoraInsFS23
(
  @pIDDEVEDOR         Int,
  @pMunicipio_ID      Int,
  @pBairro_ID         Int,  
  @pDEVNOME           Varchar(50),
  @pDEVENDERECO       Varchar(65),
  @pDEVCOMPL          Varchar(20),
  @pDEVCEP            Varchar(8),
  @pDatadenascimento  SmallDateTime,
  @pSexo              Char(1),
  @pCPF               Varchar(14),
  @pSetor             SmallInt,
  @pArquivo_ID   Int  -- Fonte de dados mais recente
)
AS

Declare @CPF Varchar(11)
Set     @CPF = Replace( Replace(@pCPF, '.', ''), '-', '')

-- Separa endereço, número e complemento
Declare @Endereco    Varchar(60)
Declare @Numero      Varchar(5)
Declare @Complemento Varchar(20)
Declare @Aux         Varchar(25)

Declare @p Int
Set     @p = CharIndex(',', RTrim(@pDEVENDERECO))

If @p = 0 Begin
   Set @p = CharIndex(' N ', RTrim(@pDEVENDERECO))
End

If @p = 0 Begin
   Set @p = CharIndex('-', RTrim(@pDEVENDERECO))
End

If @p = 0 Begin  -- Não encontrou vírgula nem ponto separando o número
   Set @Endereco = Left(@pDEVENDERECO, 60)
   Set @Numero   = Null
End
Else Begin
   Set @Endereco = RTrim(Left(@pDEVENDERECO, @p-1))
   Set @Aux      = LTrim(Substring(@pDEVENDERECO, @p+1, 25))
   
   If Left(@Aux, 2) = '- ' Begin
      Set @Aux = LTrim(Substring(@Aux, 3, 25))
   End
   If Left(@Aux, 2) = 'N ' Begin
      Set @Aux = LTrim(Substring(@Aux, 3, 25))
   End
   
   Set @p = CharIndex(' ', @Aux)
   If @p = 0 Begin  -- Não encontrou um espaço separando o número e o complemento
      Set @Numero      = @Aux
      Set @Complemento = @pDEVCOMPL
   End
   Else Begin
      Set @Numero      = RTrim(Left(@Aux, @p))
      Set @Complemento = LTrim(Substring(@Aux, @p, 23))

      If Left(@Complemento, 1) = '- ' Begin
         Set @Complemento = LTrim(Substring(@Complemento, 3, 25))
      End
   End
End

Set @Numero = dbo.RemoveZeros(@Numero)

If Right(@Numero,1) = '-' Begin
   Set @Numero = RTrim(Left(@Numero, Len(@Numero)-1))  -- Linha 68
End

If Not Exists ( Select 1 From Revendedora (nolock) Where Revendedora_ID = @pIDDEVEDOR ) Begin

   Insert Into Revendedora ( Revendedora_ID,  
                             Municipio_ID,
                             Bairro_ID,          
                             Nome, 
                             EndLogradouro, 
                             EndNumero, 
                             EndComplemento, 
                             EndCep, 
                             DtNascimento,
                             Sexo,
                             CPF,
                             Setor,
                             Arquivo_ID )
                             
                    Values ( @pIDDEVEDOR, 
                             @pMunicipio_ID, 
                             @pBairro_ID, 
                             @pDEVNOME, 
                             @Endereco, 
                             @Numero, 
                             @Complemento, 
                             @pDEVCEP, 
                             @pDatadenascimento,
                             @pSexo,
                             @CPF,
                             @pSetor,
                             @pArquivo_ID ) 
End
Else If Not Exists ( Select 1 
                     From  Revendedora (nolock) 
                     Where Revendedora_ID    = @pIDDEVEDOR
                      and  Municipio_ID      = @pMunicipio_ID      
                      and  Bairro_ID         = @pBairro_ID            
                      and  Nome              = @pDEVNOME                 
                      and  EndLogradouro     = @Endereco             
                      and  EndNumero         = @Numero               
                      and  EndComplemento    = @Complemento                 
                      and  EndCep            = @pDEVCEP
                      and  DtNascimento      = @pDatadenascimento
                      and  Sexo              = @pSexo
                      and  CPF               = @CPF
                      and  Setor             = @pSetor ) Begin
          
   Update Revendedora
      Set Municipio_ID      = @pMunicipio_ID,      
          Bairro_ID         = @pBairro_ID,            
          Nome              = @pDEVNOME,                 
          EndLogradouro     = @Endereco,             
          EndNumero         = @Numero,               
          EndComplemento    = @Complemento,                 
          EndCep            = @pDEVCEP,                  
          DtNascimento      = @pDatadenascimento,
          Sexo              = @pSexo,
          CPF               = @CPF,
          Setor             = @pSetor,
          Arquivo_ID        = @pArquivo_ID 
          
   Where  Revendedora_ID = @pIDDEVEDOR                       
End

GO 

-- FIM
