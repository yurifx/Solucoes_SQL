SELECT MS.CODFIL, MS.NUMNOTA, MS.TPNOTA, MS.SERIE, MS.DTNOTA, MS.NUMPEDVEN, MS.DTATUEST, MS.VLTOTAL VL_NOTA,
       SUM(MI.VLTOTAL) VL_ITENS,  NVL(MS.VLTOTAL, 0) - SUM(MI.VLTOTAL) DIVERGENCIA
  FROM MOV_SAIDA MS, MOV_ITSAIDA MI
 WHERE MS.CODFIL = MI.CODFIL
   AND MS.NUMNOTA = MI.NUMNOTA
   AND MS.DTNOTA = MI.DTNOTA
   AND MS.TPNOTA = MI.TPNOTA
   AND MS.SERIE = MI.SERIE
   AND MS.DTATUEST >= TO_DATE ('&DATA1 00:00:00','DD/MM/YYYY HH24:MI:SS')
   AND MS.DTATUEST <= TO_DATE ('&DATA2 23:59:59','DD/MM/YYYY HH24:MI:SS')
   AND MS.DTNOTA = TO_DATE ('&DATA1','DD/MM/YYYY')
   AND MS.CODFIL IN (&CODFIL,&CODDEP)
   AND MS.TPNOTA = 512
   AND MS.STATUS <> 9 
   HAVING NVL(MS.VLTOTAL, 0) - SUM(MI.VLTOTAL) >= 0.15 OR NVL(MS.VLTOTAL, 0) - SUM(MI.VLTOTAL) <= -0.15
 GROUP BY MS.CODFIL,
          MS.NUMNOTA,
          MS.TPNOTA,
          MS.SERIE,
          MS.DTNOTA,
          MS.NUMPEDVEN,
          MS.DTATUEST,
          MS.VLTOTAL
 ORDER BY MS.NUMNOTA;
 
Há tambem uma divergencia referente ao cupom 115640-U62 entre o valor total do cupom (R$1899,76) e a somatória dos itens (R$1977,61) no valor de R$ 77,85 e assim a linha de retonada (que é calculada com base nos itens de cada nota) fica maior do que a linha de vendas (que é calculada com base no valor total da nota).

Divergencia apresentada pois o cupom 59165-U24 possui uma diferença entre o valor total (R$622,02) e a somatória dos itens (R$600,27) no valor de R$ 21,75 e assim a linha de retonada (que é calculada com base nos itens de cada nota) fica menor do que a linha de vendas (que é calculada com base no valor total da nota).
 
SELECT MAX(DTATUEST)
  FROM MOV_SAIDA
 WHERE CODFIL IN (&CODFIL, &CODDEP)
   AND TPNOTA = 512
   AND DTNOTA = '&DATA'
   AND STATUS <> 9

-- Valor do frete maior que 0
SELECT NUMNOTA, SERIE, CODITPROD, VLFRETE, VLTOTITEM FROM MOV_ITSAIDA
WHERE CODFIL IN (16,516)
AND DTNOTA >= '02/01/2014'
AND TPNOTA = 512
--AND NUMNOTA IN (86412)
AND (VLFRETE IS NOT NULL AND VLFRETE > 0)

-- Verifica frete negativo
SELECT NUMNOTA, SERIE, CODITPROD, VLFRETE, VLTOTITEM FROM MOV_ITSAIDA
WHERE CODFIL IN (15,515)
AND DTNOTA >= '06/05/2015'
AND TPNOTA = 512
--AND NUMNOTA IN (86412)
AND (VLFRETE < 0)


