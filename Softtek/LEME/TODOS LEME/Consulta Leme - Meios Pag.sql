-- Dinheiro
SELECT A - B Dinheiro
  FROM (SELECT (SELECT SUM(VALLAN) AS VALOR
                  FROM CXA_LANCTO
                 WHERE CODFIL = &CODFIL
                   AND DATENT = '&DATA'
                   AND STATUS = 2
                   AND CODEVE IN (1)) A,
               B
          FROM (SELECT SUM(valorB) B
                  FROM (SELECT SUM(VALOR) AS VALORB
                          FROM CXA_SANGRIA
                         WHERE CODFIL = &CODFIL
                           AND DATA = '&DATA'
                           AND CODEVE = 35)));

-- Cheque 
SELECT SUM(VALLAN) Cheque
  FROM CXA_LANCTO
 WHERE CODFIL = &CODFIL
   AND DATENT = '&DATA'
   AND STATUS = 2
   AND CODEVE IN (2,3,32,33);

-- Cart�o Credito
SELECT SUM(VALLAN) Credito
  FROM CXA_LANCTO
 WHERE CODFIL = &CODFIL
   AND DATENT = '&DATA'
   AND STATUS = 2
   AND CODEVE IN (7,30);

-- Cart�o Debito
SELECT SUM(VALLAN) Debito
  FROM CXA_LANCTO
 WHERE CODFIL = &CODFIL
   AND DATENT = '&DATA'
   AND STATUS = 2
   AND CODEVE IN (6,29);

-- Financeiro
SELECT SUM(VALLAN) Financeiro
  FROM CXA_LANCTO
 WHERE CODFIL = &CODFIL
   AND DATENT = '&DATA'
   AND STATUS = 2
   AND CODEVE IN (28);

-- Venda Faturada
SELECT A - B "Venda Faturada"
       FROM (SELECT (SELECT NVL(SUM(VLTOTAL),0) AS VALOR
                             FROM MOV_SAIDA MS
                      WHERE CODFIL IN (&CODFIL, &CODDEP)
                      AND DTNOTA = '&DATA'
                      AND TPNOTA in (511,996)
                      AND NUMPEDVEN <> 999999
                      AND NUMPEDVEN IN (SELECT NUMPED
                                               FROM CXA_LANCTO CL
                                         WHERE CL.CODFIL = MS.FILPED
                                         AND CL.NUMPED = MS.NUMPEDVEN
                                         AND CODEVE = 46)
                      AND STATUS <> 9) A,
        B
        FROM (SELECT SUM(valorB) B
             FROM ((SELECT NVL(SUM(EN.VLTOTAL),0) AS VALORB
                           FROM ENT_NOTA EN
                    INNER JOIN ENT_NOTASAI ENS ON EN.CODFIL = ENS.CODFIL
                                               AND EN.TPNOTA = ENS.TPNOTA
                                               AND EN.SERIE = ENS.SERIE
                                               AND EN.NUMNOTA = ENS.NUMNOTA                 
                    INNER JOIN MOV_SAIDA MS ON MS.CODFIL = ENS.CODFILSAI
                                            AND MS.TPNOTA = ENS.TPNOTASAI
                                            AND MS.NUMNOTA = ENS.NUMNOTASAI
                                            AND MS.SERIE = ENS.SERIESAI
                                            AND MS.DTNOTA = ENS.DTNOTASAI
                                            AND MS.TPNOTA = 512
                                            AND MS.NUMPEDVEN <> 999999
                                            AND MS.NUMPEDVEN IN (SELECT NUMPED
                                                                        FROM CXA_LANCTO CL
                                                                  WHERE CL.CODFIL = MS.FILPED
                                                                  AND CL.NUMPED = MS.NUMPEDVEN
                                                                  AND CODEVE = 46)
                       WHERE EN.CODFIL IN (&CODFIL, &CODDEP)
                       AND EN.TPNOTA IN (5, 53)
                       AND EN.DTNOTA = '&DATA'
                       AND EN.STATUS <> 9))));
   
/*SELECT SUM(VLTOTAL) "Venda Faturada"
  FROM MOV_SAIDA MS
 WHERE CODFIL IN (&CODFIL, &CODDEP)
   AND DTNOTA = '&DATA'
   AND TPNOTA = 512
   AND NUMPEDVEN <> 999999
   AND NUMPEDVEN IN (SELECT NUMPED
                       FROM CXA_LANCTO CL
                      WHERE CL.CODFIL = MS.FILPED
                        AND CL.NUMPED = MS.NUMPEDVEN
                        AND CODEVE = 46)
   AND STATUS <> 9;*/

-- Vendas
SELECT SUM(VLCONT) Vendas
  FROM PDV_FISCAL
 WHERE CODFIL IN (&CODFIL, &CODDEP)
   AND DATA = '&DATA';
   
-- Vendas para filial 19  357300,49
/*SELECT SUM(VLTOTAL) FROM MOV_SAIDA
WHERE CODFIL IN (&CODFIL, &CODDEP)
AND TPNOTA = 512
AND DTNOTA = '&DATA'
AND STATUS <> 9*/

-- Devolucoes
SELECT *
  FROM ENT_NOTA
 WHERE CODFIL IN (&CODFIL, &CODDEP)
   AND TPNOTA IN (5, 53)
   AND DTNOTA = '&DATA'
   AND STATUS <> 9
   



