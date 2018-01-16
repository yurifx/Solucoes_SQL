--------------------------------------------------------------------------------
-- spRevendedoraInsPP28.sql
-- Data   : 02/09/2013
-- Autor  : Amauri
-- Stored procedure para inserir revendedoras, a partir de dados de PP28 
--------------------------------------------------------------------------------

USE ArquivosAvon
GO

Alter Procedure RevendedoraInsPP28
(
  @pRegAsc             Int,
  @pSetor              SmallInt,
  @pNome_Ra            Varchar(50),
  @pArquivo_ID         Int  -- Fonte de dados mais recente
)
AS

If Not Exists ( Select 1 From Revendedora (nolock) Where Revendedora_ID = @pRegAsc ) Begin

   Insert Into Revendedora ( Revendedora_ID,  
                             Setor, 
                             Nome, 
                             Arquivo_ID )
                             
                    Values ( @pRegAsc, 
                             @pSetor,
                             @pNome_Ra,
                             @pArquivo_ID ) 
End
Else If Not Exists ( Select 1 
                     From  Revendedora (nolock) 
                     Where Revendedora_ID = @pRegAsc
                      and  Setor          = @pSetor      
                      and  Nome           = @pNome_Ra ) Begin
          
   Update Revendedora
      Set Setor       = @pSetor,
          Nome        = @pNome_Ra,
          Arquivo_ID  = @pArquivo_ID 
          
   Where  Revendedora_ID = @pRegAsc                       
End

GO 

-- FIM
