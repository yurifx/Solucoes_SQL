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
