/* Condi��es para truncar uma tabela.

1- N�o pode ter uma chave estrangeira (FK) de outra tabela, que fa�a ref�ncia para tabela que est� sendo truncada 
2- Caso contenha, � necess�rio dropar as foreign keys.
Alter Table (Tabela_que_faz_refer�ncia_a_Tabela_Que_Ira_ser_truncada)
Drop constraint (nome_da_constraint)

Caso voc� n�o saiba o nome, pegar via  select abaixo:

Select @Name = name  
  from sys.objects 
  where type = 'F' and name like '%FK__Inspecao__Trans%' 
PRINT @Name












*/