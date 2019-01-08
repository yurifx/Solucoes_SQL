If  Exists (Select Name
            From   sysobjects
            Where  Name = 'Navio_Sel' and type = 'P')
    Drop Procedure dbo.Navio_Sel
GO

Create Procedure dbo.Navio_Sel
----------------------------------------------------------------------------------------------------
-- Consulta os dados do Navio
----------------------------------------------------------------------------------------------------
(
@p_Navio_ID Int
)
AS

SET NOCOUNT ON

Select n.Navio_ID,
       n.Nome,
       n.Ativo


From       Navio   n

Where Navio_ID = @p_Navio_ID

GO

/*
EXEC Navio_Sel @p_Navio_ID = 1
*/

-- FIM



