If  Exists (Select Name
            From   sysobjects
            Where  Name = 'IntegraVinVeiculos' and type = 'P')
    Drop Procedure dbo.IntegraVinVeiculos
GO

Create Procedure dbo.IntegraVinVeiculos
----------------------------------------------------------------------------------------------------
-- Realiza update do VIN na tabela InspVeiculo recebendo os dados da Tabela ListaVeiculos 
-- Testes 23/03/2017
----------------------------------------------------------------------------------------------------
(
@p_Cliente_ID  Int,
@p_LocalInspecao_ID Int
)
AS

SET NOCOUNT ON

Update InspVeiculo  
   Set VIN = lvv.VIN

From InspVeiculo v

inner join Inspecao i on i.Inspecao_ID = v.Inspecao_ID
inner join ListaVeiculos lv on i.Cliente_ID = lv.Cliente_ID and lv.LocalInspecao_ID = i.LocalInspecao_ID
inner join ListaVeiculosVin lvv on lv.ListaVeiculos_ID = lvv.ListaVeiculos_ID

Where i.Cliente_ID = @p_Cliente_ID
and   i.LocalInspecao_ID = @p_LocalInspecao_ID
and   v.VIN_6 = lvv.VIN_6
and   v.VIN is null

GO