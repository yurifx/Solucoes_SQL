If  Exists (Select Name
            From   sysobjects
            Where  Name = 'FrotaViagem_Sel' and type = 'P')
    Drop Procedure dbo.FrotaViagem_Sel
GO

Create Procedure dbo.FrotaViagem_Sel
----------------------------------------------------------------------------------------------------
-- Consulta os dados de uma frota/viagem
----------------------------------------------------------------------------------------------------
(
@p_FrotaViagem_ID Int
)
AS

SET NOCOUNT ON

Select f.FrotaViagem_ID,
       f.Transportador_ID,
       f.Nome,
       f.Ativo,

       t.Nome  as TransportadorNome,
       t.Tipo  as TransportadorTipo,  -- T:Terrestre M:Marítimo
       t.Ativo as TransportadorAtivo

From       FrotaViagem   f
Inner Join Transportador t on f.Transportador_ID = t.Transportador_ID

Where FrotaViagem_ID = @p_FrotaViagem_ID

GO

/*
EXEC FrotaViagem_Sel @p_FrotaViagem_ID = 1
*/

-- FIM
