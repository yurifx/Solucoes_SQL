--Cria o banco de dados
Create Database MeuBanco

--Cria a tabela
USE [MeuBanco]
create table MinhaTabela(campo1 int, campo2 varchar(25))

--Cria a procedure
USE [MeuBanco]
Create Procedure MinhaProcedure (@c1 int, @c2 varchar (25))
AS
insert into MinhaTabela values (@c1, @c2)

--Executa a procedure
USE MeuBanco
exec MinhaProcedure 1, 'Teste1'
exec MinhaProcedure 2, 'Teste2'

--Verifica se os dados estão ok na tabela
select * from MinhaTabela
