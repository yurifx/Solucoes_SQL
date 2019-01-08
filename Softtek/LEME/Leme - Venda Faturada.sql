         SELECT S.NUMPEDVEN, S.NUMNOTA, S.SERIE, MAX(S.VLTOTAL) AS TOTAL
           FROM MOV_SAIDA S
          INNER JOIN CXA_LANCTO CL ON S.FILPED = CL.CODFIL
                                  AND S.NUMPEDVEN = CL.NUMPED
                                  AND CL.CODEVE IN (31, 46)
                                AND CL.NUMNOT <> 0
                                  AND CL.STATUS NOT IN (8, 9)
          WHERE S.SERIE NOT LIKE '%U%'         AND 
          S.DTNOTA = TO_DATE('&P_DATA', 'DD-MM-YYYY')
          AND S.FILPED IN (&P_CODFIL, &P_CODDEPOS)
          AND S.NUMPEDVEN NOT IN (999999, 0)
          AND S.STATUS <> 9
          GROUP BY S.NUMPEDVEN, S.NUMNOTA, S.SERIE;
          
          
          

SELECT TRUNC(SYSDATE) DTIMPORT,
       S.CODFIL,
       S.NUMPEDVEN,
       S.NUMNOTA,
       S.DTNOTA,
       S.SERIE,
       S.FILPED,
       S.CODCLI,
       MAX(S.VLTOTAL) AS VLTOTAL,
       P.STATUS,
       P.VLTOTAL AS VLTOTAL_PEDIDO,
       CL.CODFILCXA
  FROM MOV_SAIDA S
 INNER JOIN MOV_PEDIDO P ON S.NUMPEDVEN = P.NUMPEDVEN
 INNER JOIN CXA_LANCTO CL ON S.FILPED = CL.CODFIL   
                         AND S.NUMPEDVEN = CL.NUMPED
                         AND CL.CODEVE IN (31, 46)
                         AND CL.STATUS NOT IN (8, 9)
 WHERE S.SERIE NOT LIKE '%U%'
   AND S.CODFIL IN (4, 504)  
   AND S.DTNOTA between  '16/09/2015' and '16/09/2015'
   AND S.NUMPEDVEN NOT IN (999999, 0)
--   AND CL.NUMPED = 19975609
   AND S.STATUS <> 9
 GROUP BY S.NUMPEDVEN,
          S.NUMNOTA,
          S.SERIE,
          S.FILPED,
          S.CODCLI,
          S.DTNOTA,
          S.CODFIL,
          P.STATUS,
          P.VLTOTAL,
          CL.CODFILCXA;