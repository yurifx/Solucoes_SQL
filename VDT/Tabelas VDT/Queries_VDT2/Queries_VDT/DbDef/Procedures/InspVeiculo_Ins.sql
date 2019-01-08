If  Exists (Select Name
            From   sysobjects
            Where  Name = 'InspVeiculo_Ins' and type = 'P')
    Drop Procedure dbo.InspVeiculo_Ins
GO

Create Procedure dbo.InspVeiculo_Ins
----------------------------------------------------------------------------------------------------
-- Insere um novo veículo
----------------------------------------------------------------------------------------------------
(
@p_Inspecao_ID     Int,
@p_Marca_ID        Int,
@p_Modelo_ID       Int,
@p_VIN_6           Varchar(6),    -- Últimos seis caracteres do chassi
@p_VIN             Char(17),      -- Chassi completo
@p_Observacoes     Varchar(1000), -- Observações gerais sobre o veículo
@p_InspVeiculo_ID  Int OUTPUT
)
AS

SET NOCOUNT ON

Declare @Cliente_ID Int
Select  @Cliente_ID = Cliente_ID From Inspecao Where Inspecao_ID = @p_Inspecao_ID

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

Insert Into InspVeiculo ( Inspecao_ID,
                          Marca_ID,
                          Modelo_ID,
                          VIN_6,
                          VIN,
                          Observacoes )

Values ( @p_Inspecao_ID,
         @p_Marca_ID,
         @p_Modelo_ID,
         @p_VIN_6,
         @p_VIN,
         @p_Observacoes )

Set @p_InspVeiculo_ID = SCOPE_IDENTITY()

GO

/*
Declare @Inspecao_ID     Int,
        @Marca_ID        Int,
        @Modelo_ID       Int,
        @VIN_6           Varchar(6),    -- Últimos seis caracteres do chassi
        @VIN             Char(17),      -- Chassi completo
        @Observacoes     Varchar(1000), -- Observações gerais sobre o veículo
        @InspVeiculo_ID  Int

Set @Inspecao_ID    = 1
Set @Marca_ID       = 1
Set @Modelo_ID      = 1
Set @VIN_6          = '123456'
Set @VIN            = NULL
Set @Observacoes    = 'Observações gerais sobre o veículo'

EXEC InspVeiculo_Ins @Inspecao_ID,
                     @Marca_ID,
                     @Modelo_ID,
                     @VIN_6,
                     @VIN,
                     @Observacoes,
                     @InspVeiculo_ID  OUTPUT

Print '@InspVeiculo_ID:' + Cast(@InspVeiculo_ID as Varchar)

EXEC InspVeiculo_Sel @p_InspVeiculo_ID = @InspVeiculo_ID
*/

-- FIM
