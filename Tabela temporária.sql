declare @t1 table (a int, b varchar(20))
insert into @t1 select a.InspAvaria_id,  a.FabricaTransporte from InspAvaria a
select * from @t1



declare @t1 table (a int, b varchar(20))
insert into @t1 values (1, 'haha')
select * from @t1
