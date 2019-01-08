If  Exists (Select Name
            From   sysobjects
            Where  Name = 'AvCondicao_Lst' and type = 'P')
    Drop Procedure dbo.AvCondicao_Lst
GO

Create Procedure dbo.AvCondicao_Lst
----------------------------------------------------------------------------------------------------
-- Lista as condições de inspeção de um cliente
----------------------------------------------------------------------------------------------------
(
@p_Cliente_ID  Int -- Identificação do cliente
)
AS

SET NOCOUNT ON

Select AvCondicao_ID,

       Codigo,

       Nome_Pt,
       Nome_En,
       Nome_Es

From   AvCondicao
Where  Ativo = 1

Order by Codigo, AvCondicao_ID

GO

/*
EXEC AvCondicao_Lst @p_Cliente_ID = 1
*/

-- FIM
