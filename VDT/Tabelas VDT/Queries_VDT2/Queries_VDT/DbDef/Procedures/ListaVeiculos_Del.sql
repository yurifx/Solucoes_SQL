If  Exists (Select Name
            From   sysobjects
            Where  Name = 'ListaVeiculos_Del' and type = 'P')
    Drop Procedure dbo.ListaVeiculos_Del
GO

Create Procedure dbo.ListaVeiculos_Del
----------------------------------------------------------------------------------------------------
-- Remove uma lista de veículos (e todos os dados nas tabelas relacionadas)
----------------------------------------------------------------------------------------------------
(
@p_ListaVeiculos_ID Int
)
AS

SET NOCOUNT ON

Delete From ListaVeiculosVin Where ListaVeiculos_ID = @p_ListaVeiculos_ID

Delete From ListaVeiculos    Where ListaVeiculos_ID = @p_ListaVeiculos_ID

GO

-- FIM
