If  Exists (Select Name
            From   sysobjects
            Where  Name = 'AvQuadrante_Lst' and type = 'P')
    Drop Procedure dbo.AvQuadrante_Lst
GO

Create Procedure dbo.AvQuadrante_Lst
----------------------------------------------------------------------------------------------------
-- Lista os quadrantes de um cliente
----------------------------------------------------------------------------------------------------
(
@p_Cliente_ID  Int -- Identificação do cliente
)
AS

SET NOCOUNT ON

Select AvQuadrante_ID,
       Cliente_ID,

       Codigo,

       Nome_Pt,
       Nome_En,
       Nome_Es

From   AvQuadrante
Where  Cliente_ID = @p_Cliente_ID

 and   Ativo = 1

Order by Codigo, AvQuadrante_ID

GO

/*
EXEC AvQuadrante_Lst @p_Cliente_ID = 1
*/

-- FIM
