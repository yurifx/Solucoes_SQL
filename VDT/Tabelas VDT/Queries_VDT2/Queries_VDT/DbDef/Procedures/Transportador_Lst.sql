If  Exists (Select Name
            From   sysobjects
            Where  Name = 'Transportador_Lst' and type = 'P')
    Drop Procedure dbo.Transportador_Lst
GO

Create Procedure dbo.Transportador_Lst
----------------------------------------------------------------------------------------------------
-- Lista os transportadores
----------------------------------------------------------------------------------------------------
(
@p_Ativos      Bit  -- 1:Apenas os ativos 0:Todos
)
AS

SET NOCOUNT ON

Select Transportador_ID,
       Nome,
       Tipo,  -- T:Terrestre M:Marítimo
       Ativo

From   Transportador

Where (    Ativo = 1
        or @p_Ativos = 0 )

Order by Nome

GO

/*
EXEC Transportador_Lst @p_Ativos = 1
*/

-- FIM
