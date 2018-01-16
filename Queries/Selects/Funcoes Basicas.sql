-- Filtros texto
select * from modelo where nome LIKE 'che%' -- inicia com Co
select * from modelo where nome LIKE '%vrolet' -- finaliza com balt
select * from modelo where nome like '%vr%' -- tudo que tiver vr no meio


--Funções básicas

select TOP 1 *  from modelo

select RIGHT(m.Nome, 3) from Marca m

SELECT RTRIM (' AAAAA   '), LTRIM ('   BBBB   ') -- REMOVE ESPAÇOS

select LEFT(m.Nome, 3) from Modelo m

select SUBSTRING (m.Nome, 1, 4) from Modelo m

select IIF(m.Nome = 'F', 'FABRICA', 'TRANSPORTE') from Modelo m

select LEN(m.Nome) from Modelo m

select CHARINDEX('z', m.Nome, 0), m.Nome from Modelo m -- "Termo procurado", "Onde procurar", Onde começar

select CONCAT(m.Nome, '_', m.Ativo) from modelo m

SELECT REPLACE('aaabcdeaaafghiaaacde','aaa','xxxx');  -- muda todos aaa por xxx (string, string procurado, string novo)

SELECT REVERSE ('YURI') -- IRUY

SELECT UPPER('yuri')  -- YURI
SELECT LOWER('ABC')   -- abc

--CASE
use vdt2
SELECT CASE InspVeiculo_ID
WHEN 1 THEN 'primeiro'
WHEN 2 THEN 'segundo'
WHEN 3 THEN 'teceiro'
ELSE 'outros'
END
from inspVeiculo u;



--ISNULL
declare @x  as varchar(10)
set @x = null
SELECT ISNULL (@x, 'AAA')


--HEXADECIMAL DO VALOR INFORMADO
select SOUNDEX('ha'), SOUNDEX('he'), DIFFERENCE('ha', 'he') --4 é igual / 2 = diferente / 0 - totalmente diferente


--Funções de agregação
select AVG(m.Modelo_ID) from modelo m

select MAX(m.Modelo_ID) from modelo m

select MIN(m.Modelo_ID), from modelo m


--?
select 'YURI' as nome --sample



--DATAS
DECLARE @d DATETIME = '10/01/2011';  
SELECT FORMAT ( @d, 'd', 'en-US' ) AS 'US English Result'  
      ,FORMAT ( @d, 'd', 'en-gb' ) AS 'Great Britain English Result'  
      ,FORMAT ( @d, 'd', 'de-de' ) AS 'German Result'  
      ,FORMAT ( @d, 'd', 'pt-BR' ) AS 'BR'  
      ,FORMAT ( @d, 'd', 'zh-cn' ) AS 'Simplified Chinese (PRC) Result';   

SELECT FORMAT ( @d, 'D', 'en-US' ) AS 'US English Result'  
      ,FORMAT ( @d, 'D', 'en-gb' ) AS 'Great Britain English Result'  
      ,FORMAT ( @d, 'D', 'de-de' ) AS 'German Result'  
      ,FORMAT ( @d, 'D', 'zh-cn' ) AS 'Chinese (Simplified PRC) Result'; 