/* Query que analisa os cupons sem lançamentos */
SELECT CODFIL, NUMCXA, NUMNOTA, DTNOTA, VLTOTAL
FROM   MOV_SAIDA A
WHERE  CODFIL = &CODFIL
       AND NUMCXA = &NUMCXA
       AND DTNOTA = '&DTNOTA'
       AND NOT EXISTS (SELECT 1
        FROM   CXA_LANCTO B
        WHERE  A.CODFIL = B.CODFIL
	     AND A.NUMCXA = B.NUMCXA
	     AND A.NUMNOTA = B.NUMNOT)    
	     
	     
/* Query que analisa os cupons x lançamentos  */


SELECT A.CODFIL, A.NUMCXA, A.DTNOTA, A.VLTOTAL VLSAIDA, A.NUMNOTA, A.NUMPEDVEN, B.NUMNOT, B.SERIE, SUM(B.VALLAN) VLLANCAMENTOS --*/ --  , SUBSTR(B.SERIE, 2,2)
FROM   MOV_SAIDA A
LEFT  JOIN CXA_LANCTO B ON A.CODFIL = B.CODFIL
                             AND A.SERIE = B.SERIE
                             AND A.NUMNOTA = B.NUMNOT
                             AND A.DTNOTA = B.DATENT
WHERE  A.CODFIL = &CODFIL
       AND A.DTNOTA = TO_DATE('&DATA')
       AND A.TPNOTA = 512
       AND A.STATUS = 2          
--       AND A.NUMPED = 999999   -- com esse filtro não retorna resultados
       AND A.TPNOTA = 512

GROUP  BY A.CODFIL, A.NUMCXA, A.DTNOTA,  A.VLTOTAL,  A.NUMNOTA, A.NUMPEDVEN, B.NUMNOT, B.SERIE
HAVING NVL(A.VLTOTAL, 0) - SUM(B.VALLAN) >= 0.15 OR NVL(A.VLTOTAL, 0) - SUM(B.VALLAN) <= -0.15

