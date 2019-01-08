if Exists(select 1 from 
          sys.objects where name like '%TodasInfoAvarias%')
Drop Procedure TodasInfoAvarias
GO

Create Procedure TodasInfoAvarias (@InspAvaria_ID int)
AS 

Select 
        a.Data
      , a.Usuario_ID
      , a.Cliente_ID,                 ac.Nome             as NomeCliente
      , a.LocalInspecao_ID,           al.Nome             as LocalInspecao
      , a.LocalCheckPoint_ID,         alc.Nome_Pt         as LocalCheckPoint
      , a.Transportador_ID,           at.Nome             as Transportador
      , a.FrotaViagem_ID,             af.Nome             as FrotaViagem
      , a.Navio_ID,                   an.Nome             as Navio
      , b.Marca_ID,                   bma.Nome            as Marca
      , b.Modelo_ID,                  bmo.Nome            as Modelo
      , c.AvArea_ID,                  ca.Nome_Pt          as Area
      , c.AvCondicao_ID,              cc.Nome_Pt          as Condicao
      , c.AvDano_ID,                  cd.Nome_Pt          as Dano
      , c.AvQuadrante_ID,             cq.Nome_Pt          as Quadrante
      , c.AvGravidade_ID,             cg.Nome_Pt          as Gravidade
      , c.AvSeveridade_ID,            cs.Nome_Pt          as Severidade


from Inspecao a
  
inner join InspVeiculo b on b.Inspecao_ID = a.Inspecao_ID

--Dados Inspecao
inner join Cliente              ac     on ac.Cliente_ID           = a.Cliente_ID
inner join LocalInspecao	al     on al.LocalInspecao_ID     = a.LocalInspecao_ID
inner join LocalCheckPoint     alc     on alc.LocalCheckPoint_ID  = a.LocalCheckPoint_ID
inner join Transportador        at     on at.Transportador_ID     = a.Transportador_ID
inner join Navio	        an     on an.Navio_ID             = a.Navio_ID
inner join FrotaViagem          af     on af.FrotaViagem_ID       = a.FrotaViagem_ID 
							      
--Dados Veiculo				      
inner join Marca	        bma    on b.Marca_ID              = bma.Marca_ID
inner join Modelo	        bmo    on b.Modelo_ID             = bmo.Modelo_ID

--Dados Avaria
inner join InspAvaria            c     on c.InspVeiculo_ID       = b.InspVeiculo_ID
inner join AvArea	        ca     on ca.AvArea_ID           = c.AvArea_ID
inner join AvCondicao           cc     on cc.AvCondicao_ID       = c.AvCondicao_ID
inner join AvDano	        cd     on cd.AvDano_ID           = c.AvDano_ID
inner join AvGravidade          cg     on cg.AvGravidade_ID      = c.AvGravidade_ID
inner join AvQuadrante          cq     on cq.AvQuadrante_ID      = c.AvQuadrante_ID
inner join AvSeveridade         cs     on cs.AvSeveridade_ID     = c.AvSeveridade_ID


where c.InspAvaria_ID = @InspAvaria_ID


GO
--exec TodasInfoAvarias 1
