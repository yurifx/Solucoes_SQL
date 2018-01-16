--------------------------------------------------------------------------------
-- spBoletoLocalPagtoIns.sql
-- Data   : 29/08/2013
-- Autor  : Amauri
-- Stored procedure para inserir locais de pagamento de boletos 
--------------------------------------------------------------------------------

USE ArquivosAvon
GO

Alter Procedure BoletoLocalPagtoIns
(
  @pNome                  Varchar(84),
  @pBoletoLocalPagto_ID   Int OUTPUT
)
AS

Declare @ID Int

Select @ID = BoletoLocalPagto_ID
From   BoletoLocalPagto (nolock)
Where  Nome = @pNome

If @ID Is Null Begin  -- Se ainda não existir na tabela
   Insert Into BoletoLocalPagto (   Nome) 
               Values           ( @pNome )
                  
   Set @ID = SCOPE_IDENTITY()                  
End

Set @pBoletoLocalPagto_ID = @ID

GO

-- FIM
