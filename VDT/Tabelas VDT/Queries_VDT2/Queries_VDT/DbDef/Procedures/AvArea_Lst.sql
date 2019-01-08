If  Exists (Select Name
            From   sysobjects
            Where  Name = 'AvArea_Lst' and type = 'P')
    Drop Procedure dbo.AvArea_Lst
GO

Create Procedure dbo.AvArea_Lst
----------------------------------------------------------------------------------------------------
-- Lista as áreas avariadas de um cliente
----------------------------------------------------------------------------------------------------
(
@p_Cliente_ID  Int -- Identificação do cliente
)
AS

SET NOCOUNT ON

Select AvArea_ID,
       Cliente_ID,

       Codigo,

       Nome_Pt,
       Nome_En,
       Nome_Es

From   AvArea
Where  Cliente_ID = @p_Cliente_ID

 and   Ativo = 1

Order by Codigo, AvArea_ID

GO

/*
EXEC AvArea_Lst @p_Cliente_ID = 1
*/

-- FIM

