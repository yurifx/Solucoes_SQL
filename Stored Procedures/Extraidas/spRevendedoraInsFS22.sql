--------------------------------------------------------------------------------
-- spRevendedoraInsFS22.sql
-- Data   : 29/08/2013
-- Autor  : Amauri
-- Stored procedure para inserir revendedoras, a partir de dados de FS22 
--------------------------------------------------------------------------------

USE ArquivosAvon
GO

Alter Procedure RevendedoraInsFS22
(
  @pIDDEVEDOR    Int,
  @pMunicipio_ID Int,
  @pBairro_ID    Int,  
  @pDEVNOME      Varchar(50),
  @pDEVENDERECO  Varchar(65),
  @pDEVCOMPL     Varchar(20),
  @pDEVCEP       Varchar(8),
  @pArquivo_ID   Int  -- Fonte de dados mais recente
)
AS

Declare @Endereco Varchar(60)
Set     @Endereco = RTrim(Left(@pDEVENDERECO, 5))

Declare @Numero Varchar(5)
Set     @Numero = SubString(@pDEVENDERECO, 61, 5)
Set     @Numero = dbo.RemoveZeros(@Numero)

If Not Exists ( Select 1 From Revendedora (nolock) Where Revendedora_ID = @pIDDEVEDOR ) Begin

   Insert Into Revendedora ( Revendedora_ID,  
                             Municipio_ID,
                             Bairro_ID,          
                             Nome, 
                             EndLogradouro, 
                             EndNumero, 
                             EndComplemento, 
                             EndCep, 
                             Arquivo_ID )
                             
                    Values ( @pIDDEVEDOR, 
                             @pMunicipio_ID, 
                             @pBairro_ID, 
                             @pDEVNOME, 
                             @Endereco, 
                             @Numero, 
                             @pDEVCOMPL, 
                             @pDEVCEP, 
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
                      and  EndComplemento    = @pDEVCOMPL                 
                      and  EndCep            = @pDEVCEP ) Begin
          
   Update Revendedora
      Set Municipio_ID      = @pMunicipio_ID,      
          Bairro_ID         = @pBairro_ID,            
          Nome              = @pDEVNOME,                 
          EndLogradouro     = @Endereco,             
          EndNumero         = @Numero,               
          EndComplemento    = @pDEVCOMPL,                 
          EndCep            = @pDEVCEP,                  
          Arquivo_ID        = 123456 -- @pArquivo_ID 
          
   Where  Revendedora_ID = @pIDDEVEDOR                       
End

GO 

-- FIM
