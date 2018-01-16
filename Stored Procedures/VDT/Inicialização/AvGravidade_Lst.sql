If  Exists (Select Name
            From   sysobjects
            Where  Name = 'AvGravidade_Lst' and type = 'P')
    Drop Procedure dbo.AvGravidade_Lst
GO

Create Procedure dbo.AvGravidade_Lst
----------------------------------------------------------------------------------------------------
-- Lista os graus de gravidade de um cliente
----------------------------------------------------------------------------------------------------
(
@p_Cliente_ID  Int -- Identificação do cliente
)
AS

SET NOCOUNT ON

Select AvGravidade_ID,
       Cliente_ID,

       Codigo,

       Nome_Pt,
       Nome_En,
       Nome_Es

From   AvGravidade
Where  Cliente_ID = @p_Cliente_ID

 and   Ativo = 1

Order by Codigo, AvGravidade_ID

GO

/*
EXEC AvGravidade_Lst @p_Cliente_ID = 1
*/

-- FIM
