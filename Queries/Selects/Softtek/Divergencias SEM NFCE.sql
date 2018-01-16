  --Select Divergências s/ NFCE
  SELECT A.CODFIL,
         A.NUMCXA,
         B.ENDERECOIP,
         A.DTNOTA AS DTNOTA,
         SUM(a.VLTOTAL) AS MOVSAIDA,
         B.VLCONT AS PDVFISCAL,
         NVL(b.VLCONT, 0) - SUM(nvl(a.VLTOTAL, 0)) AS DIVERGÊNCIA
  
    FROM MOV_SAIDA a, PDV_FISCAL b, CXA_CAIXAS c
  
   WHERE a.codfil = b.codfil(+)
     AND a.NUMCXA = b.PDV(+)
     AND a.DTNOTA = b.DATA(+)
     AND A.CODFIL = C.CODFIL
     AND A.NUMCXA = C.NUMCXA
     AND b.TIPO(+) = 'F'
     AND a.TPNOTA = 512
     AND a.STATUS <> 9
     AND a.CODFIL NOT IN (6, 14, 519)
     AND a.SERIE NOT IN ('1', '2', '3', '4', '5')
     AND a.DTNOTA BETWEEN to_date('01'||to_char(sysdate,'mm/yyyy'),'dd/mm/yyyy') and sysdate - 1 
     AND C.MODELONF IS NULL
   GROUP BY a.CODFIL, a.DTNOTA, a.NUMCXA, b.ENDERECOIP, b.VLCONT
  	HAVING abs(sum(a.VLTOTAL) - nvl(b.VLCONT, 0)) > 1

/*
UNION

SELECT B.CODFIL,
       B.PDV numcxa,
       B.ENDERECOIP,
       B.DATA dtnota,
       b.Vlcont PDVFISCAL,
       b.Vlcont DIVERGENCIA
							
FROM PDV_FISCAL b
WHERE
     b.DATA BETWEEN '01/09/2015' and sysdate - 1
     AND b.tipo = 'F'
     AND b.Vlcont > 0
     AND not exists (select 'x'
                     from mov_saida a
                     where a.CODFIL = b.codfil
                     AND a.numcxa = b.pdv
                     AND a.dtnota = b.data
                     AND a.tpnota = 512
                     AND a.status <> 9
                     and a.codfil not in (6, 14, 519)
                     and a.DTNOTA between b.data and b.data)
--group by B.CODFIL, B.PDV numcxa, B.ENDERECOIP, B.DATA dtnota, b.Vlcont PDVFISCAL, b.Vlcont DIVERGENCIA























select *--codfil, numcxa, codoper, numped, datent, codeve, numlan, numnot, status, vallan, nrmultreceb, identproc 
from cxa_lancto
--update cxa_lancto set status = 9
where codfil = 16
--and codeve = 1
--and numped = 20880334
--and status = 8
--and numnot = 14
and numcxa = 51
--and serie = 'U25'
--and numnot = 249335
--and codoper = 276889
--and nrmultreceb = 341441
--and codoper = 11260
and datent = '26/08/2015'






select * from mov_saida where codfil = 520 and numcxa = 33 and
dtnota = '18/09/ */