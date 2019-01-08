-- TODOS OS DADOS DA ÚLTIMA INSPECAO
select * from inspecao where inspecao_id = (select max(Inspecao_ID) from inspecao)


select * from navio where navio_id = (select navio_id from inspecao where inspecao_id = (select max(Inspecao_ID) from inspecao))
select * from FrotaViagem where FrotaViagem_ID = (select FrotaViagem_ID from inspecao where inspecao_id = (select max(Inspecao_ID) from inspecao))

select * from InspVeiculo where Inspecao_ID = (select max(Inspecao_ID) from inspecao)
select * from InspVeiculo where VIN_6 = 'ABC123' --AND INSPECAO_ID = 

select * from InspAvaria where InspVeiculo_ID = --Inserir veiculo






