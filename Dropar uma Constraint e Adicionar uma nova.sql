Alter Table Inspecao
Drop Constraint FK__Inspecao__Transp__656C112C

Alter Table FrotaViagem
Drop Constraint [FK__FrotaViag__Trans__3A81B327]

Declare @Name varchar(50)

select @Name = name  
  from sys.objects 
  where type = 'F' and name like '%FK__Inspecao__Trans%'
PRINT @Name




Alter Table Inspecao
ADD Foreign Key (Transportador_ID) references Transportador(Transportador_ID)

select * from Transportador