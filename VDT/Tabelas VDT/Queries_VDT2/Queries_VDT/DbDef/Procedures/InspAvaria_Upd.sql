If  Exists (Select Name
            From   sysobjects
            Where  Name = 'InspAvaria_Upd' and type = 'P')
    Drop Procedure dbo.InspAvaria_Upd
GO

Create Procedure dbo.InspAvaria_Upd
----------------------------------------------------------------------------------------------------
-- Modifica os dados de um registro de avaria de um veículo
----------------------------------------------------------------------------------------------------
(
@p_InspAvaria_ID      Int,
@p_AvArea_ID          Int,
@p_AvDano_ID          Int,
@p_AvSeveridade_ID    Int,
@p_AvQuadrante_ID     Int,
@p_AvGravidade_ID     Int,
@p_AvCondicao_ID      Int,
@p_FabricaTransporte  Char(1) -- F:Defeito de Fábrica  T:Avaria de Transporte
)
AS

SET NOCOUNT ON

Declare @InspVeiculo_ID Int
Select  @InspVeiculo_ID = InspVeiculo_ID From InspAvaria Where InspAvaria_ID = @p_InspAvaria_ID

Declare @Inspecao_ID Int
Select  @Inspecao_ID = Inspecao_ID From InspVeiculo Where InspVeiculo_ID = @InspVeiculo_ID

Declare @Cliente_ID Int
Select  @Cliente_ID = Cliente_ID From Inspecao Where Inspecao_ID = @Inspecao_ID

-- Verifica se a 'área' corresponde ao 'cliente'
If Not Exists ( Select 1
                From  AvArea
                Where AvArea_ID   = @p_AvArea_ID
                 and  Cliente_ID  = @Cliente_ID ) Begin

  THROW 50000, 'Área incompatível com Cliente',1
End

-- Verifica se o 'dano' corresponde ao 'cliente'
If Not Exists ( Select 1
                From  AvDano
                Where AvDano_ID   = @p_AvDano_ID
                 and  Cliente_ID  = @Cliente_ID ) Begin

  THROW 50000, 'Dano incompatível com Cliente',1
End

-- Verifica se a 'severidade' corresponde ao 'cliente'
If Not Exists ( Select 1
                From  AvSeveridade
                Where AvSeveridade_ID = @p_AvSeveridade_ID
                 and  Cliente_ID      = @Cliente_ID ) Begin

  THROW 50000, 'Severidade incompatível com Cliente',1
End

-- Verifica se o 'quadrante' corresponde ao 'cliente'
If Not Exists ( Select 1
                From  AvQuadrante
                Where AvQuadrante_ID = @p_AvQuadrante_ID
                 and  Cliente_ID     = @Cliente_ID ) Begin

  THROW 50000, 'Quadrante incompatível com Cliente',1
End

-- Verifica se a 'gravidade' corresponde ao 'cliente'
If Not Exists ( Select 1
                From  AvGravidade
                Where AvGravidade_ID = @p_AvGravidade_ID
                 and  Cliente_ID     = @Cliente_ID ) Begin

  THROW 50000, 'Gravidade incompatível com Cliente',1
End

-- Modifica os dados da avaria de um veículo
Update InspAvaria
   Set AvArea_ID         = @p_AvArea_ID
     , AvDano_ID         = @p_AvDano_ID
     , AvSeveridade_ID   = @p_AvSeveridade_ID
     , AvQuadrante_ID    = @p_AvQuadrante_ID
     , AvGravidade_ID    = @p_AvGravidade_ID
     , AvCondicao_ID     = @p_AvCondicao_ID
     , FabricaTransporte = @p_FabricaTransporte

Where InspAvaria_ID = @p_InspAvaria_ID

GO

/*
Declare @InspAvaria_ID      Int,
        @AvArea_ID          Int,
        @AvDano_ID          Int,
        @AvSeveridade_ID    Int,
        @AvQuadrante_ID     Int,
        @AvGravidade_ID     Int,
        @AvCondicao_ID      Int,
        @FabricaTransporte  Char(1) -- F:Defeito de Fábrica  T:Avaria de Transporte
        
Set @InspAvaria_ID     = 1
Set @AvArea_ID         = 2
Set @AvDano_ID         = 3
Set @AvSeveridade_ID   = 2
Set @AvQuadrante_ID    = 3
Set @AvGravidade_ID    = 2
Set @AvCondicao_ID     = 5
Set @FabricaTransporte = 'M'

EXEC InspAvaria_Upd @InspAvaria_ID,
                    @AvArea_ID,
                    @AvDano_ID,
                    @AvSeveridade_ID,
                    @AvQuadrante_ID,
                    @AvGravidade_ID,
                    @AvCondicao_ID,
                    @FabricaTransporte

EXEC InspAvaria_Sel @p_InspAvaria_ID = @InspAvaria_ID
*/

-- FIM
