If  Exists (Select Name
            From   sysobjects
            Where  Name = 'FrotaViagem_Lst' and type = 'P')
    Drop Procedure dbo.FrotaViagem_Lst
GO

Create Procedure dbo.FrotaViagem_Lst
----------------------------------------------------------------------------------------------------
-- Lista as frotas/viagens (de um tipo de transportador ou todas / de um transportador ou todos)
----------------------------------------------------------------------------------------------------
(
@p_Tipo             Char(1), -- Tipo de transportador - *:Todos T:Terrestre M:Marítimo
@p_Transportador_ID Int,     -- NULL = todos os transportadores
@p_Ativos           Bit      -- 1:Apenas os ativos 0:Todos
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

Where ( @p_Tipo = '*'  or  t.Tipo = @p_Tipo )

 and  ( @p_Transportador_ID Is Null  or  f.Transportador_ID = @p_Transportador_ID)

 and  ( @p_Ativos = 0  or  ( f.Ativo = 1 and t.Ativo = 1 ) )

Order by t.Nome, f.Nome
GO

/*
EXEC FrotaViagem_Lst @p_Tipo = '*', @p_Transportador_ID = NULL, @p_Ativos = 1
EXEC FrotaViagem_Lst @p_Tipo = '*', @p_Transportador_ID = 1,    @p_Ativos = 1
EXEC FrotaViagem_Lst @p_Tipo = 'T', @p_Transportador_ID = NULL, @p_Ativos = 1
EXEC FrotaViagem_Lst @p_Tipo = 'M', @p_Transportador_ID = NULL, @p_Ativos = 1
*/

-- FIM
