If  Exists (Select Name
            From   sysobjects
            Where  Name = 'Modelo_Lst' and type = 'P')
    Drop Procedure dbo.Modelo_Lst
GO

Create Procedure dbo.Modelo_Lst
----------------------------------------------------------------------------------------------------
-- Lista as Modelos de um cliente
----------------------------------------------------------------------------------------------------
(
@p_Cliente_ID  Int, -- Identificação do cliente
@p_Ativos      Bit  -- 1:Apenas os modelos ativos 0:Todos
)
AS

SET NOCOUNT ON

Select Modelo_ID,
       Nome,
       Ativo

From   Modelo
Where  Cliente_ID = @p_Cliente_ID

 and  (    Ativo = 1
        or @p_Ativos = 0 )

Order by Nome

GO

/*
EXEC Modelo_Lst @p_Cliente_ID = 1, @p_Ativos = 1
*/

-- FIM
