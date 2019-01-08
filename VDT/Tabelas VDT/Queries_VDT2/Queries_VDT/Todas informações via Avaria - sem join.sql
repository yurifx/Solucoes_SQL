--RECEBE TODAS AS INFORMAÇÕES SEM JOIN VIA AVARIA
declare @p_avaria_id int,
		@p_inspVeiculo_id int,
		@p_inspecao_id int,
		@p_navio_id int,
		@p_frotaviagem_id int,
		@p_transportador_id int

set @p_avaria_id = 3061   --digite aqui a avaria

select * from InspAvaria where InspAvaria_ID = @p_avaria_id
set @p_inspVeiculo_id = (select InspVeiculo_ID from InspAvaria where InspAvaria_ID = @p_avaria_id)
  
set @p_inspecao_id =  (select Inspecao_ID from InspVeiculo where InspVeiculo_ID = @p_inspVeiculo_id)
set @p_navio_id  = (select navio_id from Inspecao where Inspecao_id = @p_inspecao_id)
set @p_frotaviagem_id = (select FrotaViagem_ID from Inspecao where Inspecao_id = @p_inspecao_id)
set @p_transportador_id = (select Transportador_ID from FrotaViagem where FrotaViagem_ID = @p_frotaviagem_id)

select * from InspVeiculo where InspVeiculo_ID = @p_inspVeiculo_id
select * from Inspecao where Inspecao_ID = @p_inspecao_id
select * from navio where Navio_ID = @p_navio_id
select * from FrotaViagem where FrotaViagem_ID =  @p_frotaviagem_id
select * from Transportador where Transportador_ID = @p_transportador_id


