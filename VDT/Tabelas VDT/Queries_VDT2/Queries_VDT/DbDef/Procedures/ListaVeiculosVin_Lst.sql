
If  Exists (Select Name
            From   sysobjects
            Where  Name = 'ListaVeiculosVin_Lst' and type = 'P')
    Drop Procedure dbo.ListaVeiculosVin_Lst
GO

Create Procedure dbo.ListaVeiculosVin_Lst
----------------------------------------------------------------------------------------------------
-- Lista os veículos de uma 'lista de veículos' (packing list ou loading list)
----------------------------------------------------------------------------------------------------
(
@p_ListaVeiculos_ID Int
)
AS

SET NOCOUNT ON

Select ListaVeiculosVin_ID,
       ListaVeiculos_ID,
       VIN,                 -- Chassi completo
       VIN_6                -- Últimos seis caracteres do chassi

From       ListaVeiculosVin

Where ListaVeiculos_ID = @p_ListaVeiculos_ID

GO

/*
EXEC ListaVeiculosVin_Lst @p_ListaVeiculos_ID = 1
*/

-- FIM
