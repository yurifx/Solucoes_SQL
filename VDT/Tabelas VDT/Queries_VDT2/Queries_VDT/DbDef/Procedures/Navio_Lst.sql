If  Exists (Select Name
            From   sysobjects
            Where  Name = 'Navio_Lst' and type = 'P')
    Drop Procedure dbo.Navio_Lst
GO

Create Procedure dbo.Navio_Lst
----------------------------------------------------------------------------------------------------
-- Lista os navios
----------------------------------------------------------------------------------------------------
(
@p_Ativos Bit  -- 1:Apenas os navios ativos 0:Todos
)
AS

SET NOCOUNT ON

Select Navio_ID,
       Nome,
       Ativo

From   Navio
Where (    Ativo = 1
        or @p_Ativos = 0 )

Order by Nome

GO

/*
EXEC Navio_Lst @p_Ativos = 1
EXEC Navio_Lst @p_Ativos = 0
*/

-- FIM
