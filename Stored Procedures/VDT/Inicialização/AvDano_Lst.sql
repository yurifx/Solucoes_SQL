If  Exists (Select Name
            From   sysobjects
            Where  Name = 'AvDano_Lst' and type = 'P')
    Drop Procedure dbo.AvDano_Lst
GO

Create Procedure dbo.AvDano_Lst
----------------------------------------------------------------------------------------------------
-- Lista os tipos de danos de um cliente
----------------------------------------------------------------------------------------------------
(
@p_Cliente_ID  Int -- Identificação do cliente
)
AS

SET NOCOUNT ON

Select AvDano_ID,
       Cliente_ID,

       Codigo,

       Nome_Pt,
       Nome_En,
       Nome_Es

From   AvDano
Where  Cliente_ID = @p_Cliente_ID

 and   Ativo = 1

Order by Codigo, AvDano_ID

GO

/*
EXEC AvDano_Lst @p_Cliente_ID = 1
*/

-- FIM
