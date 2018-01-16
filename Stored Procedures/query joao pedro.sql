use MeuBanco
GO

create table mov_saida(
codfilial int,
numnota int)
GO

create table quantidadeNotas
(quantidade int)
GO

insert into mov_saida values (1, 1) --nota 1
insert into mov_saida values (1, 2) --nota 2
insert into mov_saida values (1, 3) --nota 3
GO

Create Procedure TesteQuantidade
AS
Declare @v_quantidadeNotas int
select @v_quantidadeNotas = count(*) from mov_saida
insert into quantidadeNotas values (@v_quantidadeNotas)
GO



exec TesteQuantidade
go

select * from quantidadeNotas
go



select * from mov_saida


