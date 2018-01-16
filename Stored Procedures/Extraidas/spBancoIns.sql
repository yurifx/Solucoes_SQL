--------------------------------------------------------------------------------
-- spBancoIns.sql
-- Data   : 29/08/2013
-- Autor  : Amauri
-- Stored procedure para inserir bancois 
--------------------------------------------------------------------------------

USE ArquivosAvon
GO

Alter Procedure BancoIns
(
  @pBanco_ID   Int,
  @pNome       Varchar(30)
)
AS

If Not Exists ( Select 1 From Banco (nolock) Where Banco_ID = @pBanco_ID ) Begin  -- Se ainda não existir na tabela
   
   Insert Into Banco (   Banco_ID,   Nome )
              Values ( @pBanco_ID, @pNome )
End
Else If Not Exists ( Select 1 From Banco (nolock) Where Banco_ID = @pBanco_ID and Nome = @pNome ) Begin  -- Se existir com outro nome

   Update Banco
      Set Nome     = @pNome
   Where  Banco_ID = @pBanco_ID   
End


GO

-- FIM
