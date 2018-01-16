--REFERÊNCIAS https://msdn.microsoft.com/pt-br/library/ms175972.aspx

with TabelaWith (campo1, campo2) as
(
select InspAvaria_ID, DanoOrigem from InspAvaria
)
select * from TabelaWith


----
--Teste 1

with T1 (id, custoReparo) as (
select InspAvaria_Id, a.Custo  from InspAvaria a
)
select avg(custoReparo) from t1

---Teste2
with T1 (area, dano, custo) as (
    select a.AvArea_ID, a.AvDano_ID, SUM(CUSTO)
    from InspAvaria a
    group by a.AvArea_ID, a.AvDano_ID 
)

select area,dano, AvArea.Nome_Pt, avDano.Nome_Pt from t1 
    inner join AvArea on t1.area = AvArea.AvArea_ID
    inner join AvDano on t1.dano = AvDano.AvDano_ID



--DOIS WITHS
with t1 (c1, c2) as (
select InspAvaria.InspAvaria_ID, InspAvaria.InspVeiculo_ID from InspAvaria
), -- USA VIRGULA PARA SEPARAR
t2 (t2c1, t2c2) as (
select InspAvaria.InspAvaria_ID, InspAvaria.InspVeiculo_ID from InspAvaria
)

select * from t1 where exists (select 1 from t2)


--outro
with T1 (id) as (
select InspAvaria_Id  from InspAvaria a
)
select avg(id) from t1



