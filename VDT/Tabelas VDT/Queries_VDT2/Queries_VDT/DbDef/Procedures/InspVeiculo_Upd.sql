If  Exists (Select Name
            From   sysobjects
            Where  Name = 'InspVeiculo_Upd' and type = 'P')
    Drop Procedure dbo.InspVeiculo_Upd
GO

Create Procedure dbo.InspVeiculo_Upd
----------------------------------------------------------------------------------------------------
-- Modifica os dados de um veículo
----------------------------------------------------------------------------------------------------
(
@p_InspVeiculo_ID  Int,
@p_Marca_ID        Int,
@p_Modelo_ID       Int,
@p_VIN_6           Varchar(6),    -- Últimos seis caracteres do chassi
@p_VIN             Char(17),      -- Chassi completo
@p_Observacoes     Varchar(1000)  -- Observações gerais sobre o veículo
)
AS

SET NOCOUNT ON

Declare @Inspecao_ID Int
Select  @Inspecao_ID = Inspecao_ID From InspVeiculo Where InspVeiculo_ID = @p_InspVeiculo_ID

Declare @Cliente_ID Int
Select  @Cliente_ID = Cliente_ID From Inspecao Where Inspecao_ID = @Inspecao_ID

-- Verifica se a 'marca' corresponde ao 'cliente'
If Not Exists ( Select 1
                From  Marca
                Where Marca_ID   = @p_Marca_ID
                 and  Cliente_ID = @Cliente_ID ) Begin

  THROW 50000, 'Marca incompatível com Cliente',1
End

-- Verifica se o 'modelo' corresponde ao 'cliente'
If Not Exists ( Select 1
                From  Modelo
                Where Modelo_ID  = @p_Modelo_ID
                 and  Cliente_ID = @Cliente_ID ) Begin

  THROW 50000, 'Modelo incompatível com Cliente',1
End

Update InspVeiculo

   Set Marca_ID    = @p_Marca_ID
     , Modelo_ID   = @p_Modelo_ID
     , VIN_6       = @p_VIN_6
     , VIN         = @p_VIN
     , Observacoes = @p_Observacoes

Where InspVeiculo_ID = @p_InspVeiculo_ID

GO

/*
Declare @InspVeiculo_ID  Int,
        @Marca_ID        Int,
        @Modelo_ID       Int,
        @VIN_6           Varchar(6),    -- Últimos seis caracteres do chassi
        @VIN             Char(17),      -- Chassi completo
        @Observacoes     Varchar(1000) -- Observações gerais sobre o veículo

Set @InspVeiculo_ID = 1
Set @Marca_ID       = 1
Set @Modelo_ID      = 1
Set @VIN_6          = '123456'
Set @VIN            = NULL
Set @Observacoes    = 'Novas observações gerais sobre o veículo'

EXEC InspVeiculo_Upd @InspVeiculo_ID  ,
                     @Marca_ID,
                     @Modelo_ID,
                     @VIN_6,
                     @VIN,
                     @Observacoes

EXEC InspVeiculo_Sel @p_InspVeiculo_ID = @InspVeiculo_ID
*/

-- FIM
