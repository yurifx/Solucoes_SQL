--------------------------------------------------------------------------------
-- spBoletoAgenciaCodCedenteIns.sql
-- Data   : 29/08/2013
-- Autor  : Amauri
-- Stored procedure para inserir ag�ncia e cod cedente de boletos 
--------------------------------------------------------------------------------

USE ArquivosAvon
GO

Alter Procedure BoletoAgenciaCodCedenteIns
(
  @pNome                         Varchar(19),
  @pBoletoAgenciaCodCedente_ID   Int OUTPUT
)
AS

Declare @ID Int

Select @ID = BoletoAgenciaCodCedente_ID
From   BoletoAgenciaCodCedente (nolock)
Where  Nome = @pNome

If @ID Is Null Begin  -- Se ainda n�o existir na tabela
   Insert Into BoletoAgenciaCodCedente (   Nome) 
                                Values ( @pNome )
                  
   Set @ID = SCOPE_IDENTITY()                  
End

Set @pBoletoAgenciaCodCedente_ID = @ID

GO

-- FIM
