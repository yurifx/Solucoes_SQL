# # SQL

<br>



## Create table

<br>

```sql
CREATE TABLE City (
  Id 	  INT 		  NOT NULL identity,
  Codigo  CHAR(10)	  NOT NULL default 0,
  Nome 	  VARCHAR(255) NOT NULL,
  Uf	  CHAR(2)	  NOT NULL,
  PRIMARY KEY (Id)
);
```



<br>

## Drop Table

```sql
drop table city
```





<br>

## Alter Table - Add Table Column

```sql
Alter table City 
add test varchar(25) default ''
```





<br>



## Alter Table - Remove Column

```sql
Alter table Bairro 
drop column test
```



<br>



## Insert row

```sql
Insert into Bairro (Codigo, Nome, Uf) 
values ('3548500003','Boqueirão - Santos','SP');
```



<br>



## Insert row with select

```sql
insert into abc
select Codigo, Nome, UF from bairro
```



<br>



## Update

```sql
update abc set nome = 'yuri' where bairro = 'boqueirao'
```



<br>



## Update with join

```sql
update ref_customers
set cus_name = 'yuri'
from ref_customers
join ref_customers_ext on e_cus_id = cus_id
where cus_name = 'abc'
```



<br>



## Delete row

```sql
delete from ref_customers 
where codigo = '1100015001'
```





<br>





## Delete row

```sql
delete from ref_customers 
where codigo = '1100015001'
```





<br>


## Convert UTC date to Local

```sql

select  CONVERT(datetime, SWITCHOFFSET(CONVERT(datetimeoffset, 
                                    LOG_DataLoads.StartTime), 
                            DATENAME(TzOffset, SYSDATETIMEOFFSET()))) 
       AS ColumnInLocalTime,
       * from LOG_DataLoads 
```

or

```sql
SELECT DATEADD(mi, DATEDIFF(mi, GETUTCDATE(), GETDATE()), MyTable.UtcColumn) 
       AS ColumnInLocalTime
FROM MyTable
```

## Convert Local to UTC
```
SELECT DATEADD(second, DATEDIFF(second, GETDATE(), GETUTCDATE()), YOUR_DATE);
```


