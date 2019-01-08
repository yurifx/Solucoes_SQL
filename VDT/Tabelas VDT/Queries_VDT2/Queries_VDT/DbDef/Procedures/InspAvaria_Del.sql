If  Exists (Select Name
            From   sysobjects
            Where  Name = 'InspAvaria_Del' and type = 'P')
    Drop Procedure dbo.InspAvaria_Del
GO

Create Procedure dbo.InspAvaria_Del
----------------------------------------------------------------------------------------------------
-- Remove um registro de avaria de um veículo
----------------------------------------------------------------------------------------------------
(
@p_InspAvaria_ID Int
)
AS

SET NOCOUNT ON

Delete From InspAvaria Where InspAvaria_ID = @p_InspAvaria_ID

GO

-- FIM
