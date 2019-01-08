If  Exists (Select Name
            From   sysobjects
            Where  Name = 'InspAvaria_Ins' and type = 'P')
    Drop Procedure dbo.InspAvaria_Ins
GO

Create Procedure dbo.InspAvaria_Ins
----------------------------------------------------------------------------------------------------
-- Insere um novo registro de avaria de um veículo
----------------------------------------------------------------------------------------------------
(
@p_InspVeiculo_ID     Int,
@p_AvArea_ID          Int,
@p_AvDano_ID          Int,
@p_AvSeveridade_ID    Int,
@p_AvQuadrante_ID     Int,
@p_AvGravidade_ID     Int,
@p_AvCondicao_ID      Int,
@p_FabricaTransporte  Char(1), -- F:Defeito de Fábrica  T:Avaria de Transporte
@p_InspAvaria_ID      Int OUTPUT
)
AS

SET NOCOUNT ON

Declare @Inspecao_ID Int
Select  @Inspecao_ID = Inspecao_ID From InspVeiculo Where InspVeiculo_ID = @p_InspVeiculo_ID

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

-- Insere a nova avaria
Insert Into InspAvaria ( InspVeiculo_ID,
                         AvArea_ID,
                         AvDano_ID,
                         AvSeveridade_ID,
                         AvQuadrante_ID,
                         AvGravidade_ID,
                         AvCondicao_ID,
                         FabricaTransporte )

Values ( @p_InspVeiculo_ID,
         @p_AvArea_ID,
         @p_AvDano_ID,
         @p_AvSeveridade_ID,
         @p_AvQuadrante_ID,
         @p_AvGravidade_ID,
         @p_AvCondicao_ID,
         @p_FabricaTransporte )

Set @p_InspAvaria_ID = SCOPE_IDENTITY()

GO

/*
Declare @InspVeiculo_ID     Int,
        @AvArea_ID          Int,
        @AvDano_ID          Int,
        @AvSeveridade_ID    Int,
        @AvQuadrante_ID     Int,
        @AvGravidade_ID     Int,
        @AvCondicao_ID      Int,
        @FabricaTransporte  Char(1), -- F:Defeito de Fábrica  T:Avaria de Transporte
        @InspAvaria_ID      Int

Set @InspVeiculo_ID    = 1
Set @AvArea_ID         = 1
Set @AvDano_ID         = 1
Set @AvSeveridade_ID   = 1
Set @AvQuadrante_ID    = 1
Set @AvGravidade_ID    = 1
Set @AvCondicao_ID     = 1
Set @FabricaTransporte = 'T'

EXEC InspAvaria_Ins @InspVeiculo_ID,
                    @AvArea_ID,
                    @AvDano_ID,
                    @AvSeveridade_ID,
                    @AvQuadrante_ID,
                    @AvGravidade_ID,
                    @AvCondicao_ID,
                    @FabricaTransporte,
                    @InspAvaria_ID      OUTPUT

Print '@InspAvaria_ID:' + Cast(@InspAvaria_ID as Varchar)

EXEC InspAvaria_Sel @p_InspAvaria_ID = @InspAvaria_ID
*/

-- FIM
