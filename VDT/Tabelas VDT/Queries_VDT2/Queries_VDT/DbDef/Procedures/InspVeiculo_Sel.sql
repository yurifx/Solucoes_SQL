If  Exists (Select Name
            From   sysobjects
            Where  Name = 'InspVeiculo_Sel' and type = 'P')
    Drop Procedure dbo.InspVeiculo_Sel
GO

Create Procedure dbo.InspVeiculo_Sel
----------------------------------------------------------------------------------------------------
-- Consulta os dados de um veículo inspecionado
----------------------------------------------------------------------------------------------------
(
@p_InspVeiculo_ID Int
)
AS

SET NOCOUNT ON

Select v.InspVeiculo_ID,
       v.Inspecao_ID,
       v.Marca_ID,
       v.Modelo_ID,

       v.VIN_6,        -- Últimos seis caracteres do chassi
       v.VIN,          -- Chassi completo

       v.Observacoes,  -- Observações gerais sobre o veículo

       a.Nome      as MarcaNome,
       o.Nome      as ModeloNome

From       InspVeiculo  v
Inner Join Marca        a on v.Marca_ID  = a.Marca_ID
Inner Join Modelo       o on v.Modelo_ID = o.Modelo_ID

Where InspVeiculo_ID = @p_InspVeiculo_ID

GO

/*
EXEC InspVeiculo_Sel @p_InspVeiculo_ID = 1
*/

-- FIM
