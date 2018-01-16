If  Exists (Select Name
            From   sysobjects
            Where  Name = 'InspAvaria_Sel' and type = 'P')
    Drop Procedure dbo.InspAvaria_Sel
GO

Create Procedure dbo.InspAvaria_Sel
----------------------------------------------------------------------------------------------------
-- Consulta os dados de uma avaria
-- 08/03/2017 - Atualização: Adição dos campos com nomes: a.Nome_pt, es, en e seus respectivos joins
-- 08/03/2017 - Atualização: Adição do campos de Inspeção - ID e VIN_6
----------------------------------------------------------------------------------------------------
(
@p_InspAvaria_ID Int
)
AS

SET NOCOUNT ON

Select av.InspAvaria_ID,
       av.InspVeiculo_ID,
       av.AvArea_ID,
       av.AvDano_ID,
       av.AvSeveridade_ID,
       av.AvQuadrante_ID,
       av.AvGravidade_ID,
       av.AvCondicao_ID,
       av.FabricaTransporte,

	   a.Nome_Pt   as Area_Pt,
       a.Nome_En   as Area_En,
       a.Nome_Es   as Area_Es,

	   c.Nome_Pt   as Condicao_Pt,
       c.Nome_En   as Condicao_En,
       c.Nome_Es   as Condicao_Es,


	   d.Nome_Pt,
	   d.Nome_Es,
	   d.Nome_En,

	   d.Nome_Pt,
	   d.Nome_Es,
	   d.Nome_En,

	   q.Nome_Pt,
	   q.Nome_Es,
	   q.Nome_En


From  InspAvaria av

inner join AvArea		a			on av.AvArea_ID = a.AvArea_ID
inner join AvCondicao	c			on av.AvCondicao_ID = c.AvCondicao_ID
inner join AvDano		d			on av.AvDano_ID = d.AvDano_ID
inner join AvQuadrante  q			on av.AvQuadrante_ID = q.AvQuadrante_ID
inner join AvSeveridade s			on av.AvSeveridade_ID = s.AvSeveridade_ID


Where InspAvaria_ID = @p_InspAvaria_ID

GO

/*
EXEC InspAvaria_Sel @p_InspAvaria_ID = 1
*/

-- FIM
