use vdt2
select t1.c1 * t2.c2 as maxPlanilha from 
(select count(1) as c1 from AvArea) t1,
(select count(1) as c2 from AvGravidade) t2

