--------------------------------------------------------------------------------
-- spBoletoCedenteIns.sql
-- Data   : 29/08/2013
-- Autor  : Amauri
-- Stored procedure para inserir cedentes de boletos 
--------------------------------------------------------------------------------

USE ArquivosAvon
GO

Alter Procedure BoletoCedenteIns
(
  @pNome               Varchar(84),
  @pBoletoCedente_ID   Int OUTPUT
)
AS

Declare @ID Int

Select @ID = BoletoCedente_ID
From   BoletoCedente (nolock)
Where  Nome = @pNome

If @ID Is Null Begin  -- Se ainda não existir na tabela
   Insert Into BoletoCedente (   Nome) 
               Values           ( @pNome )
                  
   Set @ID = SCOPE_IDENTITY()                  
End

Set @pBoletoCedente_ID = @ID

GO

-- FIM
