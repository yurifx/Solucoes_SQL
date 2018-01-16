--------------------------------------------------------------------------------
-- spBoletoInstrucaoIns.sql
-- Data   : 29/08/2013
-- Autor  : Amauri
-- Stored procedure para inserir instru��es de boletos 
--------------------------------------------------------------------------------

USE ArquivosAvon
GO

Alter Procedure BoletoInstrucaoIns
(
  @pNome                Varchar(84),
  @pBoletoInstrucao_ID  Int OUTPUT
)
AS

Declare @ID Int

Select @ID = BoletoInstrucao_ID
From   BoletoInstrucao (nolock)
Where  Nome = @pNome

If @ID Is Null Begin  -- Se ainda n�o existir na tabela
   Insert Into BoletoInstrucao (   Nome) 
               Values          ( @pNome )
                  
   Set @ID = SCOPE_IDENTITY()                  
End

Set @pBoletoInstrucao_ID = @ID

GO

-- FIM
