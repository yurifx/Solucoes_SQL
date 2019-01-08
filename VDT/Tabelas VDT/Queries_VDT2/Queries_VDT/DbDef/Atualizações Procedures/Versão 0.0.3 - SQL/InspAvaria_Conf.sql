If  Exists (Select Name
            From   sysobjects
            Where  Name = 'InspAvaria_Conf' and type = 'P')
    Drop Procedure dbo.InspAvaria_Conf
GO

Create Procedure dbo.InspAvaria_Conf
----------------------------------------------------------------------------------------------------
-- Consulta os dados de uma avaria_conferencia
-- 23/03/2017 - DanoOrigem
----------------------------------------------------------------------------------------------------
(
@p_LocalInspecao_ID Int,
@p_LocalCheckPoint_ID Int,
@p_Data DateTime
)
AS

SET NOCOUNT ON
SELECT i.data, 
       i.Inspecao_ID,
	   
	   li.LocalInspecao_ID    as LocalCodigo,
	   li.Nome                as LocalNome,

	   lc.LocalCheckPoint_ID  as CheckPointCodigo,
	   lc.Nome_Pt             as CheckPointNome,

	   iv.InspVeiculo_ID      as InspVeiculo_ID, 
       iv.VIN_6               as VIN_6,

	   ia.InspAvaria_ID,
	   ia.FabricaTransporte,
	   ia.DanoOrigem,

	   ma.Marca_ID         as MarcaCodigo,
	   ma.Nome             as MarcaNome, 

	   mo.Modelo_ID        as ModeloCodigo,
	   mo.Nome             as ModeloNome,

       a.AvArea_ID         as AreaCodigo,
	   a.Nome_Pt           as Area_Pt,

	   c.AvCondicao_ID     as CondicaoCodigo,
	   c.Nome_Pt           as Condicao_Pt,

	   d.AvDano_ID         as DanoCodigo,
	   d.Nome_Pt           as Dano_Pt,

	   g.AvGravidade_ID    as GravidadeCodigo,
	   g.Nome_Pt           as Gravidade_Pt,

	   q.AvQuadrante_ID    as QuadranteCodigo,
	   q.Nome_Pt           as Quadrante_Pt,

       s.AvSeveridade_ID   as SeveridadeCodigo,
	   s.Nome_Pt           as Severidade_Pt

from InspVeiculo iv

inner join Inspecao         i   on iv.Inspecao_ID = i.Inspecao_ID
inner join InspAvaria       ia  on iv.InspVeiculo_ID = ia.InspVeiculo_ID
inner join Marca            ma  on iv.Marca_ID = ma.Marca_ID
inner join Modelo           mo  on iv.Modelo_ID = mo.Modelo_ID
inner join avArea           a   on a.AvArea_ID = ia.AvArea_ID
inner join AvCondicao       c   on c.AvCondicao_ID = ia.AvCondicao_ID
inner join AvDano           d   on d.AvDano_ID = ia.AvDano_ID
inner join AvGravidade      g   on g.AvGravidade_ID = ia.AvGravidade_ID
inner join AvQuadrante      q   on q.AvQuadrante_ID = ia.AvQuadrante_ID
inner join AvSeveridade     s   on s.AvSeveridade_ID = ia.AvSeveridade_ID
inner join LocalInspecao    li  on li.LocalInspecao_ID = i.LocalInspecao_ID
inner join LocalCheckPoint  lc  on lc.LocalCheckPoint_ID = i.LocalCheckPoint_ID

where  i.Data               = @p_Data
and    i.LocalInspecao_ID   = @p_LocalInspecao_ID
and    i.LocalCheckPoint_ID = @p_LocalCheckPoint_ID

/*
EXEC InspAvaria_Conf 1, 1, '03/17/2017'
*/

-- FIM