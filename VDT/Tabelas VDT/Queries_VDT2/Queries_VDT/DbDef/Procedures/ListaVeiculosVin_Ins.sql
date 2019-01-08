If  Exists (Select Name
            From   sysobjects
            Where  Name = 'ListaVeiculosVin_Ins' and type = 'P')
    Drop Procedure dbo.ListaVeiculosVin_Ins
GO

Create Procedure dbo.ListaVeiculosVin_Ins
----------------------------------------------------------------------------------------------------
-- Insere um veículo em uma 'lista de veículos'
----------------------------------------------------------------------------------------------------
(
@p_ListaVeiculos_ID    Int,
@p_VIN                 Char(17),
@p_ListaVeiculosVin_ID Int OUTPUT
)
AS

SET NOCOUNT ON

Insert Into ListaVeiculosVin( ListaVeiculos_ID, VIN )

Values ( @p_ListaVeiculos_ID,
         @p_VIN )

Set @p_ListaVeiculosVin_ID = SCOPE_IDENTITY()

GO

Declare @ListaVeiculos_ID    Int,
        @VIN                 Char(17),
        @ListaVeiculosVin_ID Int

Set @ListaVeiculos_ID    = 1
Set @VIN                 = 'ABCDEFGHIJK654321'

EXEC ListaVeiculosVin_Ins @ListaVeiculos_ID,
                          @VIN,
                          @ListaVeiculosVin_ID OUTPUT

Print '@ListaVeiculosVin_ID:' + Cast(@ListaVeiculosVin_ID as Varchar)

EXEC ListaVeiculosVin_Lst @p_ListaVeiculos_ID = @ListaVeiculos_ID

-- FIM