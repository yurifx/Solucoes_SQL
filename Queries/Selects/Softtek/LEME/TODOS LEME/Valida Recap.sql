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

-- Cartão Credito
SELECT SUM(VALLAN) Credito
  FROM CXA_LANCTO
 WHERE CODFIL = &CODFIL
   AND DATENT = '&DATA'
   AND STATUS = 2
   AND CODEVE IN (7,30);

-- Cartão Debito
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
   
-- Vales emitidos por devolução
SELECT SUM(VLORIG) "6.1"
  FROM CRC_TITULO        TIT
  INNER JOIN CRC_ORIGEM ORIG ON TIT.CODORIGCRC = ORIG.CODORIGCRC
                             AND ORIG.CODGRPORIGCRC = 8
 WHERE TIT.TPCLICRC = 1
   AND TIT.CODFIL IN (&CODFIL, &CODDEP)
   AND TIT.DTEMISSAO = '&DATA'
   AND TIT.STATUS <> 9
   AND TIT.NUMNOTA IS NOT NULL;

-- Cancelamento dos vales emitidos por devolução
SELECT SUM(EN.VLTOTAL) "6.1.1"
  FROM ENT_NOTA EN, MOV_SAIDA MV
 WHERE EN.CODFILSAI = MV.CODFIL
   AND EN.NUMNOTASAI = MV.NUMNOTA
   AND EN.TPNOTASAI = MV.TPNOTA
   AND EN.SERIESAI = MV.SERIE
   AND EN.DTNOTASAI = MV.DTNOTA
   AND EN.CODFIL IN (&CODFIL, &CODDEP)
   AND EN.TPNOTA IN (5, 53)
   AND EN.DTNOTA = '&DATA'
   AND EN.STATUS = 9
   AND MV.CONDPGTO <> 33;

-- Vales emitidos por canc. pedido
SELECT SUM(VLORIG) "6.2"
  FROM CRC_TITULO TIT
 INNER JOIN CRC_ORIGEM ORIG ON TIT.CODORIGCRC = ORIG.CODORIGCRC
                            AND ORIG.CODGRPORIGCRC = 8
 WHERE TPCLICRC = 1
   AND CODFIL IN (&CODFIL, &CODDEP)
   AND DTEMISSAO = '&DATA'
   AND TIT.STATUS <> 9
   AND NUMNOTA IS NULL
   AND TIPOPED IS NOT NULL;

-- Vales emitidos no contas receber
SELECT SUM(VLORIG) "6.3"
  FROM CRC_TITULO
 WHERE TPCLICRC = 1
   AND CODFIL IN (&CODFIL, &CODDEP)
   AND DTEMISSAO = '&DATA'
   AND CODORIGCRC = 17;

-- Vales baixados no caixa
SELECT SUM(VALLAN) "6.5"
  FROM CXA_LANCTO
 WHERE CODFIL = &CODFIL
   AND DATENT = '&DATA'
   AND STATUS = 2
   AND CODEVE = 17;

-- Vales baixados por reembolso de troca
SELECT SUM(VALOR) "6.6"
  FROM CXA_SANGRIA
 WHERE CODFIL = &CODFIL
   AND DATDEP = '&DATA'
   AND CODEVE = 35;

-- Retomada   
SELECT SUM(VLTOTAL) "Retomada"
  FROM (SELECT I.CODFIL,
               I.TPNOTA,
               I.NUMNOTA,
               I.SERIE,
               I.DTNOTA,
               I.CODITPROD,
               I.NUMPEDVEN,
               CAST(I.VLTOTAL AS NUMBER(15, 2)) VLTOTAL,
               TRUNC(SYSDATE) DTIMPORT,
               I.FILPED,
               I.ITEM,
               P.STATUS,
               NVL(CODFILCXA, 0) CAIXA_GEMCO,
               S.STATUS AS STATUSNOTA
          FROM MOV_SAIDA S
         INNER JOIN MOV_ITSAIDA I ON S.CODFIL = I.CODFIL
                                 AND S.TPNOTA = I.TPNOTA
                                 AND S.NUMNOTA = I.NUMNOTA
                                 AND S.SERIE = I.SERIE
                                 AND S.DTNOTA = I.DTNOTA
                                 AND I.NUMPEDVEN <> 999999
         INNER JOIN MOV_PEDIDO P ON S.NUMPEDVEN = P.NUMPEDVEN
                                AND S.FILPED = P.CODFIL
          LEFT JOIN CXA_LANCTO CL ON CL.DATENT = S.DTPEDIDO
                                 AND CL.CODCLI = S.CODCLI
                                 AND CL.NUMPED = S.NUMPEDVEN
                                 AND CL.CODFILCXA = 999
                                 AND CL.CODFIL = P.CODFIL
         WHERE S.TPNOTA = 512
           AND P.CODFIL IN (&CODFIL, &CODDEP)
           AND S.DTNOTA = '&DATA'
           AND S.CODFIL NOT IN (14, 31, 37)
           AND NOT EXISTS (SELECT 1
                           FROM CXA_LANCTO CL
                                INNER JOIN MOV_SAIDA S ON S.NUMPEDVEN = CL.NUMPED
                                                       AND S.FILPED = CL.CODFIL
                                                       AND S.SERIE NOT LIKE '%U%'
                                                       AND S.STATUS <> 9
                           WHERE I.FILPED = CL.CODFIL
                           AND I.NUMPEDVEN = CL.NUMPED
                           AND CL.CODEVE IN (31, 46)
                           AND CL.STATUS NOT IN (8, 9))
         group by I.CODFIL,I.TPNOTA,I.NUMNOTA,I.SERIE,I.DTNOTA,I.CODITPROD,I.NUMPEDVEN,I.VLTOTAL,I.FILPED,
                  I.ITEM,P.STATUS,S.STATUS,NVL(CODFILCXA, 0));
                  
-- Venda Faturada
SELECT A - B "Venda Faturada"
       FROM (SELECT (SELECT NVL(SUM(MS.VLTOTAL),0) AS VALOR
                             FROM MOV_SAIDA MS
                      WHERE MS.CODFIL IN (&CODFIL, &CODDEP)
                      AND MS.DTNOTA = '&DATA'
                      AND MS.TPNOTA in (511,996)
                      AND MS.NUMPEDVEN <> 999999
                      AND MS.NUMPEDVEN IN (SELECT CL.NUMPED
                                               FROM CXA_LANCTO CL
                                         WHERE CL.CODFIL = MS.FILPED
                                         AND CL.NUMPED = MS.NUMPEDVEN
                                         AND CL.CODEVE = 46)
                      AND MS.STATUS <> 9) A,
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
                                                                  AND CL.CODEVE = 46)
                       WHERE EN.CODFIL IN (&CODFIL, &CODDEP)
                       AND EN.TPNOTA IN (5, 53)
                       AND EN.DTNOTA = '&DATA'
                       AND EN.STATUS <> 9))));
                       
-- Vendas
SELECT SUM(TOTAL) "VENDAS" FROM(
SELECT A.TOTAL 
  FROM (SELECT SUM(VLCONT) TOTAL
          FROM PDV_FISCAL
         WHERE CODFIL IN (&CODFIL, &CODDEP)
           AND CODFIL NOT IN (19, 519)
           AND DATA = '&DATA') A

UNION 
SELECT B.TOTAL
  FROM (SELECT SUM(VLTOTAL) TOTAL
          FROM MOV_SAIDA
         WHERE CODFIL IN (&CODFIL, &CODDEP)
           AND TPNOTA = 512
           AND DTNOTA = '&DATA'
           AND STATUS <> 9
           AND CODFIL IN (19, 519))B);
           
-- Devolucoes
SELECT (SUM(VLTOTAL)*(-1)) Devolucao
  FROM ENT_NOTA
 WHERE CODFIL IN (&CODFIL, &CODDEP)
   AND TPNOTA IN (5, 53)
   AND DTNOTA = '&DATA'
   AND STATUS <> 9;
   
-- Pedidos Emitidos
SELECT SUM(VLTOTAL) "Pedidos Emitidos"
  FROM (SELECT P.CODFIL,
               P.TIPOPED,
               P.NUMPEDVEN,
               P.DTPEDIDO,
               CASE
                 WHEN (P.DTENTREGA IS NULL OR P.DTENTREGA < TO_DATE('01/01/1900', 'DD/MM/RRRR')) THEN TO_DATE('01/01/1900', 'DD/MM/RRRR')
                 ELSE P.DTENTREGA
                 END DTENTREGA,
               NVL(P.DTENTREGA_ORIGINAL, TO_DATE('01/01/1900', 'DD/MM/RRRR')) DTENTREGA_ORIGINAL,
               P.VLTOTITEMACUM,
               CAST(NVL(P.VLTOTAL, 0) AS NUMBER(15, 2)) AS VLTOTAL_PEDIDO,
               CAST(SUM(NVL(L.VALLAN, 0)) AS NUMBER(15, 2)) AS VLTOTAL,
               P.STATUS,
               P.SITCARGA,
               NVL(P.DTCANCELA, TO_DATE('01/01/1900', 'DD/MM/RRRR')) DTCANCELA,
               L.CODFILCXA,
               NVL(P.CODCLI, 0) CODCLI,
               NVL(L.DATENT, TO_DATE('01/01/1900', 'DD/MM/RRRR')) DATENT
          FROM MOV_PEDIDO P
         INNER JOIN CXA_LANCTO L ON L.NUMPED = P.NUMPEDVEN
                                AND L.CODFIL = P.CODFIL
         WHERE P.CODFIL IN (&CODFIL, &CODDEP)
           AND L.DATENT = TO_DATE('&DATA', 'DD/MM/RRRR')
           AND L.CODOPER IS NOT NULL
           AND L.STATUS <> 9
           AND L.CODEVE <> 19
           AND (L.CODEVE NOT IN (31, 46) OR
               (L.CODEVE IN (31, 46) AND L.STATUS <> 2))
           AND L.STATUS = 2
         GROUP BY P.CODFIL,P.TIPOPED,P.NUMPEDVEN,P.DTPEDIDO,P.DTENTREGA,P.DTENTREGA_ORIGINAL,P.VLTOTITEMACUM,P.VLTOTAL,
         P.STATUS,P.SITCARGA,P.DTCANCELA,L.CODFILCXA,P.CODCLI,L.DATENT);
         
-- Pedidos Cancelados  14.2
SELECT (SUM(VLTOTAL)*(-1)) "Pedidos Cancelados"
  FROM (SELECT P.CODFIL,
               P.NUMPEDVEN,
               P.CODCLI,
               P.DTPEDIDO,
               P.DTCANCELA,
               CAST(MAX(P.VLTOTAL) AS DECIMAL(15, 2)) VLTOTAL,
               TRUNC(SYSDATE) DTIMPORT
          FROM MOV_PEDIDO P
         INNER JOIN CXA_LANCTO L ON L.NUMPED = P.NUMPEDVEN
                                AND L.CODFIL = P.CODFIL
                                AND L.CODOPER IS NOT NULL
                                AND L.CODEVE <> 19
                                AND (L.CODEVE NOT IN (31, 46) OR
                                    (L.CODEVE IN (31, 46) AND L.STATUS <> 2))
                                AND L.STATUS = 2
         WHERE P.CODFIL IN (&CODFIL, &CODDEP)
           AND P.DTCANCELA = TO_DATE('&DATA', 'DD/MM/RRRR')
           AND P.STATUS = 9
         GROUP BY P.CODFIL,
                  P.NUMPEDVEN,
                  P.CODCLI,
                  P.DTPEDIDO,
                  P.DTCANCELA,
                  P.VLTOTAL)                       
                                             
