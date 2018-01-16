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
