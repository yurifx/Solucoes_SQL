Use [MeuBanco]
GO


create table MinhaTabelaTrigger (
 campo1 int,
 campo2 varchar(25),
 data datetime2 )

GO


------------------------ CRIA TRIGGER INSERT ------------------------------

Create trigger TesteTrigger 
ON MinhaTabela 
FOR INSERT  -- (for | after | instead of) [Antes | depois | em vez de ]   ->> update |  delete |  insert | 

As 

Begin
Declare @campo1 int,
        @campo2 varchar(25)

Select @campo1 = campo1, @campo2 = campo2 from inserted  
Insert into MinhaTabelaTrigger values ( @campo1, @campo2, GETDATE())
End
GO

------------------    FIM DA CRIAÇÃO DA TRIGGER    -------------------------

---TESTES---
INSERT INTO MINHATABELA VALUES (1, 'HAHA') --QUANDO INSERIR AQUI, DEVE ACIONAR A TRIGGER que VAI INSERIR OUTRO REGISTRO NA TABELA 'MINHATABELATRIGGER', CONTENDO A DATA ATUAL
GO

SELECT * FROM MinhaTabelaTrigge
--FIM TESTES


------------------------ CRIA TRIGGER UPDATE ------------------------------
drop trigger TesteTriggerUpdate

Create trigger TesteTriggerUpdate
on MinhaTabela 
AFTER UPDATE  -- (for | after | instead of) [Antes | depois | em vez de ]   ->> update |  delete |  insert | 

As 

Begin
Declare @campo1 int,
        @campo2 varchar(25)

select @campo1 = campo1, @campo2 = campo2 from inserted  
update MinhaTabelaTrigger set campo2 = 'FEZ UPDATE VIA TRIGGER', data =  GETDATE()
End
GO

--fim do teste update

update MINHATABELA set campo1 = 1000 where Campo1 = 1 --QUANDO INSERIR AQUI, DEVE ACIONAR A TRIGGER que VAI INSERIR OUTRO REGISTRO NA TABELA 'MINHATABELATRIGGER', CONTENDO A DATA ATUAL
GO

SELECT * FROM MinhaTabelaTrigger


