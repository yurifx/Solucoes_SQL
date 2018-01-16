SELECT OPERADOR, SUM(TOTAL) RECEBIDO, SUM(APURADO) APURADO, SUM(DIV) DIVERGENCIA FROM (
SELECT A.CODFIL FILIAL, A.DATENT DATA, A.NUMCXA "CAIXA", A.CODOPER " ", A.NOME OPERADOR, A.CODEVE " ", A.DSCEVE EVENTO, A.VALLAN "TOTAL", A.VLFORMA "APURADO", 
        CASE
         WHEN FORMA = 1 THEN
          ((VALLAN) - NVL((VALOR), 0)) - VLFORMA
         ELSE
          0
       END DIV
  FROM (SELECT CL.CODFIL, CL.DATENT, CL.NUMCXA, CL.CODOPER, CO.NOME, CE.CODEVE, CE.DSCEVE, CC.FORMA, CC.VLFORMA, CS.VALOR, SUM(CL.VALLAN) VALLAN
          FROM CXA_LANCTO CL
         INNER JOIN CXA_CONTAGEM CC ON CC.CODFIL = CL.CODFIL
                                    AND CC.NUMCXA = CL.NUMCXA
                                    AND CC.DATAINI = CL.DATENT
                                    AND CC.CODOPER = CL.CODOPER
                                    AND CC.FORMA = CL.CODEVE
                                    AND CC.NUMOV = CL.NUMMOV
         INNER JOIN CXA_SANGRIA CS  ON CS.CODFIL = CL.CODFIL
                                    AND CS.NUMCXA = CL.NUMCXA
                                    AND CS.DATA = CL.DATENT
                                    AND CS.CODOPER = CL.CODOPER
                                    AND CS.NUMMOV = CL.NUMMOV
                                    AND CS.CODEVE = 35
         INNER JOIN CXA_EVENTO CE   ON CE.CODEVE = CL.CODEVE
         INNER JOIN CXA_OPERADOR CO ON CO.CODOPER = CL.CODOPER
                                    AND CO.CODFIL = CL.CODFIL
         WHERE CL.CODFIL = 32
           AND CL.DATENT = '19/08/2015'
           --AND CL.NUMCXA IN --(SELECT NUMCXA FROM CXA_MOVIMENTO WHERE CODFIL = 36 AND DATAINI = '08/02/2014')
           --AND CL.CODOPER = 15
           AND CL.STATUS = 2
           -- AND CL.CODEVE NOT IN (25)
         GROUP BY CL.CODFIL, CL.DATENT, CL.NUMCXA, CL.CODOPER, CO.NOME, CE.CODEVE,CE.DSCEVE, CC.FORMA, CC.VLFORMA, CS.VALOR) A)B
GROUP BY OPERADOR;
         
