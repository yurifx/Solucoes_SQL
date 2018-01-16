--------------------------------------------------------------------------------
-- spRevendedoraInsCS28Ind.sql
-- Data   : 26/08/2013
-- Autor  : Amauri
-- Stored procedure para inserir revendedoras indicantes, a partir de dados de CS28 
--------------------------------------------------------------------------------

USE ArquivosAvon
GO

Alter Procedure RevendedoraInsCS28Ind
(
  @pREGASC             Int,
  @pMunicipio_ID       Int,
  @pBairro_ID          Int,
  @pNOME               Varchar(50), 
  @pENDERECO           Varchar(65), 
  @pNUMERO             Varchar(5), 
  @pCOMP               Varchar(20), 
  @pCEP                Varchar(8), 
  @pArquivo_ID         Int  -- Fonte de dados mais recente
)
AS

Declare @NUMERO Varchar(5)
Set     @NUMERO = dbo.RemoveZeros(@pNUMERO)

If Not Exists ( Select 1 From Revendedora (nolock) Where Revendedora_ID = @pREGASC ) Begin

   Declare @NomeIndicante Varchar(50)  
   
   If @pNOME Is Not Null
      Set @NomeIndicante = @pNOME
   Else
      Set @NomeIndicante = '(INDICANTE)'

   Insert Into Revendedora ( Revendedora_ID,  
                             Municipio_ID,
                             Bairro_ID,          
                             Nome, 
                             EndLogradouro, 
                             EndNumero, 
                             EndComplemento, 
                             EndCep,
                             Arquivo_ID )
                             
                    Values ( @pREGASC, 
                             @pMunicipio_ID, 
                             @pBairro_ID, 
                             @NomeIndicante, 
                             @pENDERECO, 
                             @NUMERO, 
                             @pCOMP, 
                             @pCEP,
                             @pArquivo_ID ) 
End
Else If @pNOME Is Not Null and Not Exists ( Select 1 
                                            From  Revendedora (nolock) 
                                            Where Revendedora_ID = @pREGASC
                                             and  Municipio_ID   = @pMunicipio_ID
                                             and  Bairro_ID      = @pBairro_ID
                                             and  Nome           = @pNOME
                                             and  EndLogradouro  = @pENDERECO
                                             and  EndNumero      = @NUMERO
                                             and  EndComplemento = @pCOMP
                                             and  EndCep         = @pCEP ) Begin

   Update Revendedora
      Set Municipio_ID      = @pMunicipio_ID,      
          Bairro_ID         = @pBairro_ID,            
          Nome              = @pNOME,                 
          EndLogradouro     = @pENDERECO,             
          EndNumero         = @NUMERO,               
          EndComplemento    = @pCOMP,                 
          EndCep            = @pCEP,
          Arquivo_ID        = @pArquivo_ID                  
          
   Where  Revendedora_ID = @pREGASC                       
End

GO 

-- FIM
