If  Exists (Select Name
            From   sysobjects
            Where  Name = 'InspAvaria_Sel' and type = 'P')
    Drop Procedure dbo.InspAvaria_Sel
GO

Create Procedure dbo.InspAvaria_Sel
----------------------------------------------------------------------------------------------------
-- Consulta os dados de uma avaria
----------------------------------------------------------------------------------------------------
(
@p_InspAvaria_ID Int
)
AS

SET NOCOUNT ON

Select InspAvaria_ID,
       InspVeiculo_ID,
       AvArea_ID,
       AvDano_ID,
       AvSeveridade_ID,
       AvQuadrante_ID,
       AvGravidade_ID,
       AvCondicao_ID,
       FabricaTransporte

From  InspAvaria
Where InspAvaria_ID = @p_InspAvaria_ID

GO

/*
EXEC InspAvaria_Sel @p_InspAvaria_ID = 1
*/

-- FIM
