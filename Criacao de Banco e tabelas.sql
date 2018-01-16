--Criando banco
IF DB_ID ('TESTE_BANCO') IS NULL
	CREATE DATABASE TESTE_BANCO
GO

USE TESTE_BANCO 
GO

--Criando e dropando tabela https://www.w3schools.com/sql/sql_foreignkey.asp
if Exists (select 1 from sys.objects where name like '%t1%')
drop table t1

create table t1 (campo1 int identity, nome varchar(20))

use TESTE_BANCO
Create table foreignTabela (
    id        int primary key not null identity,
    nome      varchar(20),
    campo3    int foreign key references t1 (campo1), --Primeira maneira
    campo4    int,
    campo5    varchar(20) default '1'

    Foreign key (campo4) references t1 (campo1) --Segunda Maneira
)
               
select * from foreignTabela
drop table foreignTabela


--Truncando uma tabela (aqui os registros iniciam do zero novamente)
truncate table t1



--Alterando uma tabela table
ALTER TABLE t1 
    ADD campo3 int

GO

--Inserindo valores
INSERT into t1 (campo1, campo2) values (1,'2')

--Atualizando registros
update t1 set campo2 = 'update' where campo1 = 1
GO

--Selecionando registros
select * from t1

--Deletando registros
delete from t1


--Declarando e setando variaveis
declare @c1   Int,
        @c2   varchar(20),
        @c3   Int 

Set     @c1 = 2
Set     @c2 = 'via declare'
Set     @c3 = 3

insert into t1 values (@c1, @c2, @c3)


--Declarando uma tabela virtual e inserindo valores via select 
use vdt2
Declare @t1 table (num1 int,
                   c1 varchar(20))

insert into @t1 select a.Inspecao_ID, a.Data from Inspecao a
select * from @t1



--Usando IF/Else (ponto e virgula)
if 1=1
    select * from InspAvaria
else
    select * from Inspecao

--Com ponto e virgula no final
if 1=1
select * from InspAvaria;
else select * from Inspecao;
GO

--2° Maneira (begin e end)
if 1=1
begin
  select * from InspAvaria
end

else
  begin select * from Inspecao
end
GO

--USANDO WHILE

use TESTE_BANCO
create table t2 (n1 int primary key identity,
                 c1 varchar(20))

Declare @i int;

set @i = 0;
--Não funcionou
while (@i < 10)
    insert into t2 values('teste');
    set @i = @i+1
    PRINT 'T2'
go

use TESTE_BANCO
go
select * from t2





--Criando procedure
Create Procedure P1
AS
Select * from inspecao
go

--Criando Function




--Criando trigger







/* Diferenças entre SP's e funcoes SQL SERVER 2014 
https://social.msdn.microsoft.com/Forums/pt-BR/df437fd6-ddf5-4b13-a0e8-18121c41cfa9/stored-procedures-x-functions?forum=520 
*/



--Verificando se existe o objeto no banco de dados
If  Exists (Select Name
            From   sysobjects
            Where  Name = 'AvDano_Lst' and type = 'P')
    Drop Procedure dbo.AvDano_Lst
GO

