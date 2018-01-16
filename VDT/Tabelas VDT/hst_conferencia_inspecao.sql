---------------------------------------------------
-- Tabela HST_CONFERENCIA_INSPECAO
-- Histórico de consultas de conferência.
-- Criação 20/07/2017
---------------------------------------------------

if exists (select 1 from sys.tables obj where obj.name = 'hst_conferencia_inspecao')
begin
drop table hst_conferencia_inspecao
end

create table hst_conferencia_inspecao(
id  int primary key identity not null,
cliente_id int,
Usuario_ID int,
LocalInspecao_ID int,
LocalCheckPoint_ID int,
Data date
)

