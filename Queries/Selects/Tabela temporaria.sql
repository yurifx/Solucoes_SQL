-- tabela temporária
declare @tb as table (Nome char(3), Valor smallint, Data date)

--Populando tabela
insert into @tb (nome,valor,data) 
values
('aaa',  1, convert(date,'11/01/2012',103)),
('bbb',  8, convert(date,'12/02/2012',103)),
('aaa',300, convert(date,'15/02/2012',103)),
('bbb', 66, convert(date,'19/04/2012',103))

--usando a função Pivot
SELECT * FROM 
(
    select Nome, Valor, 
      CASE month(data)   
        WHEN  1 THEN 'jan' WHEN  2 THEN 'fev' 
        WHEN  3 THEN 'mar' WHEN  4 THEN 'abr' 
        WHEN  5 THEN 'mai' WHEN  6 THEN 'jun' 
        WHEN  7 THEN 'jul' WHEN  8 THEN 'ago' 
        WHEN  9 THEN 'set' WHEN 10 THEN 'out' 
        WHEN 11 THEN 'nov' WHEN 12 THEN 'dez' 
    END AS Mes
    FROM @tb 
) as x    
PIVOT (
        SUM(valor) FOR Mes in ([jan], [fev], [mar], [abr], [mai], [jun], [jul], [ago], [set], [out], [nov], [dez])
       ) as pv