--------------------------------------------------------------------------------
-- spAgenciaIns.sql
-- Data   : 26/08/2013
-- Autor  : Amauri
-- Stored procedure para inserir agências de cobrança 
--------------------------------------------------------------------------------

USE ArquivosAvon
GO

Alter Procedure AgenciaIns
(
  @pAgencia_ID   Int,
  @pNome         Varchar(50)
)
AS

If Not Exists ( Select 1 From Agencia (nolock) Where Agencia_ID = @pAgencia_ID ) Begin  -- Se ainda não existir na tabela
   
   Insert Into Agencia (   Agencia_ID,   Nome )
                Values ( @pAgencia_ID, @pNome )
End
Else If Not Exists ( Select 1 From Agencia (nolock) Where Agencia_ID = @pAgencia_ID and Nome = @pNome ) Begin  -- Se existir com outro nome

   Update Agencia
      Set Nome       = @pNome
   Where  Agencia_ID = @pAgencia_ID   
End


GO

-- FIM
