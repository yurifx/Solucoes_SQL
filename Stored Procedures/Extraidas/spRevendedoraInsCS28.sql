--------------------------------------------------------------------------------
-- spRevendedoraInsCS28.sql
-- Data   : 26/08/2013
-- Autor  : Amauri
-- Stored procedure para inserir revendedoras, a partir de dados de CS28 
--------------------------------------------------------------------------------

USE ArquivosAvon
GO

Alter Procedure RevendedoraInsCS28
(
  @pREGASC             Int,
  @pREGASC_RA_INDICA   Int,
  @pMunicipio_ID       Int,
  @pBairro_ID          Int,
  @pNOME               Varchar(50), 
  @pSETOR              SmallInt, 
  @pDT_NASCIMENTO      SmallDateTime, 
  @pRG_RA              Varchar(13), 
  @pCPF_RA             Varchar(14), 
  @pENDERECO           Varchar(65), 
  @pNUMERO             Varchar(5), 
  @pCOMP               Varchar(20), 
  @pCEP                Varchar(8), 
  @pDT_ESTABELECIMENTO SmallDateTime, 
  @pEQUIPE             TinyInt, 
  @pLOS                SmallInt,
  @pArquivo_ID         Int  -- Fonte de dados mais recente
)
AS

Declare @CPF Varchar(11)
Set     @CPF = Replace( Replace(@pCPF_RA, '.', ''), '-', '')

-- Print @pCPF_RA
-- Print @CPF

Declare @NUMERO Varchar(5)
Set     @NUMERO = dbo.RemoveZeros(@pNUMERO)

If Not Exists ( Select 1 From Revendedora (nolock) Where Revendedora_ID = @pREGASC ) Begin

   Insert Into Revendedora ( Revendedora_ID,  
                             Indicante_ID,
                             Municipio_ID,
                             Bairro_ID,          
                             Nome, 
                             Setor, 
                             DtNascimento, 
                             RGNumero, 
                             CPF, 
                             EndLogradouro, 
                             EndNumero, 
                             EndComplemento, 
                             EndCep, 
                             DtEstabelecimento, 
                             Equipe, 
                             LOS,
                             Arquivo_ID )
                             
                    Values ( @pREGASC, 
                             @pREGASC_RA_INDICA,
                             @pMunicipio_ID, 
                             @pBairro_ID, 
                             @pNOME, 
                             @pSETOR, 
                             @pDT_NASCIMENTO, 
                             @pRG_RA, 
                             @CPF, 
                             @pENDERECO, 
                             @NUMERO, 
                             @pCOMP, 
                             @pCEP, 
                             @pDT_ESTABELECIMENTO, 
                             @pEQUIPE, 
                             @pLOS,
                             @pArquivo_ID ) 
End
Else If Not Exists ( Select 1 
                     From  Revendedora (nolock) 
                     Where Revendedora_ID    = @pREGASC
                      and  Municipio_ID      = @pMunicipio_ID      
                      and  Bairro_ID         = @pBairro_ID            
                      and  Nome              = @pNOME                 
                      and  Setor             = @pSETOR                
                      and  DtNascimento      = @pDT_NASCIMENTO        
                      and  RGNumero          = @pRG_RA                
                      and  CPF               = @CPF               
                      and  EndLogradouro     = @pENDERECO             
                      and  EndNumero         = @NUMERO               
                      and  EndComplemento    = @pCOMP                 
                      and  EndCep            = @pCEP                  
                      and  DtEstabelecimento = @pDT_ESTABELECIMENTO   
                      and  Equipe            = @pEQUIPE               
                      and  LOS               = @pLOS ) Begin
          
   Update Revendedora
      Set Municipio_ID      = @pMunicipio_ID,      
          Bairro_ID         = @pBairro_ID,            
          Nome              = @pNOME,                 
          Setor             = @pSETOR,                
          DtNascimento      = @pDT_NASCIMENTO,        
          RGNumero          = @pRG_RA,                
          CPF               = @CPF,               
          EndLogradouro     = @pENDERECO,             
          EndNumero         = @NUMERO,               
          EndComplemento    = @pCOMP,                 
          EndCep            = @pCEP,                  
          DtEstabelecimento = @pDT_ESTABELECIMENTO,   
          Equipe            = @pEQUIPE,               
          LOS               = @pLOS,
          Arquivo_ID        = @pArquivo_ID 
          
   Where  Revendedora_ID = @pREGASC                       
End

GO 

-- FIM
