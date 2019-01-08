If  Exists (Select Name
            From   sysobjects
            Where  Name = 'Transportador_Sel' and type = 'P')
    Drop Procedure dbo.Transportador_Sel
GO

Create Procedure dbo.Transportador_Sel
----------------------------------------------------------------------------------------------------
-- Consulta os dados de um transportador
----------------------------------------------------------------------------------------------------
(
@p_Transportador_ID Int
)
AS

SET NOCOUNT ON

Select Transportador_ID,
       Nome,
       Tipo,  -- T:Terrestre M:Marítimo
       Ativo

From   Transportador

Where Transportador_ID = @p_Transportador_ID

GO

/*
EXEC Transportador_Sel @p_Transportador_ID = 1
EXEC Transportador_Sel @p_Transportador_ID = 4
*/

-- FIM
