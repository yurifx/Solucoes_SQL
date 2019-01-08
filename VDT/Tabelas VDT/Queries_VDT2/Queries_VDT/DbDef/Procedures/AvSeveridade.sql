If  Exists (Select Name
            From   sysobjects
            Where  Name = 'AvSeveridade_Lst' and type = 'P')
    Drop Procedure dbo.AvSeveridade_Lst
GO

Create Procedure dbo.AvSeveridade_Lst
----------------------------------------------------------------------------------------------------
-- Lista os graus de severidade de um cliente
----------------------------------------------------------------------------------------------------
(
@p_Cliente_ID  Int -- Identificação do cliente
)
AS

SET NOCOUNT ON

Select AvSeveridade_ID,
       Cliente_ID,

       Codigo,

       Nome_Pt,
       Nome_En,
       Nome_Es

From   AvSeveridade
Where  Cliente_ID = @p_Cliente_ID

 and   Ativo = 1

Order by Codigo, AvSeveridade_ID

GO

/*
EXEC AvSeveridade_Lst @p_Cliente_ID = 1
*/

-- FIM
