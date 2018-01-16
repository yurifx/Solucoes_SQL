/* Condições para truncar uma tabela.

1- Não pode ter uma chave estrangeira (FK) de outra tabela, que faça refência para tabela que está sendo truncada 
2- Caso contenha, é necessário dropar as foreign keys.
Alter Table (Tabela_que_faz_referência_a_Tabela_Que_Ira_ser_truncada)
Drop constraint (nome_da_constraint)

Caso você não saiba o nome, pegar via  select abaixo:

Select @Name = name  
  from sys.objects 
  where type = 'F' and name like '%FK__Inspecao__Trans%' 
PRINT @Name












*/