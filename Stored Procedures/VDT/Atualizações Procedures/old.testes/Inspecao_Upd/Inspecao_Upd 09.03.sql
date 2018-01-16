If  Exists (Select Name
            From   sysobjects
            Where  Name = 'Inspecao_Upd' and type = 'P')
    Drop Procedure dbo.Inspecao_Upd
GO

Create Procedure dbo.Inspecao_Upd
----------------------------------------------------------------------------------------------------
-- Modifica os dados de um registro de inspeção
-- 09/03/2017 Atualização: adição do Cliente_ID 
----------------------------------------------------------------------------------------------------
(
@p_Inspecao_ID        Int,
@p_Cliente_ID         Int,
@p_LocalInspecao_ID   Int,
@p_LocalCheckPoint_ID Int,
@p_Transportador_ID   Int,
@p_FrotaViagem_ID     Int,
@p_Navio_ID           Int
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

-- Modifica os dados da inspeção
Update Inspecao
   Set LocalInspecao_ID   = @p_LocalInspecao_ID
     , Cliente_ID         = @p_Cliente_ID
     , LocalCheckPoint_ID = @p_LocalCheckPoint_ID
     , Transportador_ID   = @p_Transportador_ID
     , FrotaViagem_ID     = @p_FrotaViagem_ID
     , Navio_ID           = @p_Navio_ID

Where  Inspecao_ID = @p_Inspecao_ID

GO

/*
EXEC Inspecao_Upd @p_Inspecao_ID        = 1,
                  @p_Cliente_ID         = 1,
                  @p_LocalInspecao_ID   = 1,
                  @p_LocalCheckPoint_ID = 3,
                  @p_Transportador_ID   = 4,
                  @p_FrotaViagem_ID     = 1,
                  @p_Navio_ID           = 1

EXEC Inspecao_Sel @p_Inspecao_ID = 1
*/