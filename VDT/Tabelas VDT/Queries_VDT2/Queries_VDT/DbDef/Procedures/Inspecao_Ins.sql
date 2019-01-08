If  Exists (Select Name
            From   sysobjects
            Where  Name = 'Inspecao_Ins' and type = 'P')
    Drop Procedure dbo.Inspecao_Ins
GO

Create Procedure dbo.Inspecao_Ins
----------------------------------------------------------------------------------------------------
-- Insere um novo registro de inspeção (não é uma nova inspeção)
-- Uma ou mais linhas compõem uma inspeção pois:
-- a) Vários inspetores podem registrar dados ao mesmo tempo durante a mesma operação de inspeção)
-- b) Uma inspeção pode envolver vários transportadores
----------------------------------------------------------------------------------------------------
(
@p_Cliente_ID         Int,
@p_LocalInspecao_ID   Int,
@p_LocalCheckPoint_ID Int,
@p_Transportador_ID   Int,
@p_FrotaViagem_ID     Int,
@p_Navio_ID           Int,
@p_Usuario_ID         Int,  -- Identificação do inspetor
@p_Data               Date, -- Data da inspeção
@p_Inspecao_ID        Int OUTPUT
)
AS

SET NOCOUNT ON

-- Verifica se o 'check-point' corresponde ao 'local'
If Not Exists ( Select 1
                From  LocalCheckPoint
                Where LocalCheckPoint_ID = @p_LocalCheckPoint_ID
                 and  LocalInspecao_ID   = @p_LocalInspecao_ID ) Begin

  THROW 50000, 'LocalCheckPoint incompatível com LocalInspecao',1
End

-- Verifica se 'trota/viagem' corresponde ao 'transportador'
If Not Exists ( Select 1
                From  FrotaViagem
                Where FrotaViagem_ID   = @p_FrotaViagem_ID
                 and  Transportador_ID = @p_Transportador_ID ) Begin

  THROW 50000, 'FrotaViagem incompatível com Transportador',1
End

-- Insere a nova linha
Insert Into Inspecao ( Cliente_ID,
                       LocalInspecao_ID,
                       LocalCheckPoint_ID,
                       Transportador_ID,
                       FrotaViagem_ID,
                       Navio_ID,
                       Usuario_ID,
                       Data )
Values ( @p_Cliente_ID,
         @p_LocalInspecao_ID,
         @p_LocalCheckPoint_ID,
         @p_Transportador_ID,
         @p_FrotaViagem_ID,
         @p_Navio_ID,
         @p_Usuario_ID,
         @p_Data )

Set @p_Inspecao_ID = SCOPE_IDENTITY()

GO

/*
Declare @Cliente_ID         Int,
        @LocalInspecao_ID   Int,
        @LocalCheckPoint_ID Int,
        @Transportador_ID   Int,
        @FrotaViagem_ID     Int,
        @Navio_ID           Int,
        @Usuario_ID         Int,  -- Identificação do inspetor
        @Data               Date, -- Data da inspeção
        @Inspecao_ID        Int

Set @Cliente_ID         = 1
Set @LocalInspecao_ID   = 1
Set @LocalCheckPoint_ID = 2
Set @Transportador_ID   = 1
Set @FrotaViagem_ID     = 1
Set @Navio_ID           = 1
Set @Usuario_ID         = 1
Set @Data               = '2017-03-01'

EXEC Inspecao_Ins @Cliente_ID,
                  @LocalInspecao_ID,
                  @LocalCheckPoint_ID,
                  @Transportador_ID,
                  @FrotaViagem_ID,
                  @Navio_ID,
                  @Usuario_ID,
                  @Data,
                  @Inspecao_ID OUTPUT

Print '@Inspecao_ID:' + Cast(@Inspecao_ID as Varchar)

EXEC Inspecao_Sel @p_Inspecao_ID = @Inspecao_ID
*/

-- FIM