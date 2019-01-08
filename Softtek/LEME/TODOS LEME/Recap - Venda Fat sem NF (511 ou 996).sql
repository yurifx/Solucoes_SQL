-- TODA NOTA TIPO 512 DEVE CONTER UMA NOTA DO TIPO 511 OU 996
SELECT MS.CODFIL      
      ,MS.NUMNOTA 
      ,MS.SERIE
      ,MS.TPNOTA
      ,CC.NOMCLI
      ,MS.DTNOTA
      ,MS.VLTOTAL
      ,MS.NUMPEDVEN
      ,MS.NUMNOTAPDV
      ,MS.DTNOTAPDV
      ,MS.SERIEPDV
  FROM MOV_SAIDA MS
 INNER JOIN CAD_CLIENTE CC
    ON CC.CODCLI = MS.CODCLI
 WHERE MS.CODFIL IN (&CODFIL, &CODDEP) AND
       MS.DTNOTA = '&DATA'
   AND MS.NUMPEDVEN <> 999999
   AND MS.NUMPEDVEN IN (SELECT CL.NUMPED
                          FROM CXA_LANCTO CL
                         WHERE CL.CODFIL = MS.FILPED
                           AND CL.NUMPED = MS.NUMPEDVEN
                           AND CL.CODEVE = 46)
   AND MS.STATUS <> 9

A divergencia é gerada pois houve faturamento do pedido 17440239 (Venda Faturada) gerando o cupom 25972-U21 no valor de R$65,90 porem a NFE para o cupom não foi gerada e assim o valor do cupom não é somado a linha de Venda Faturada.

A divergencia é apresentada pois no dia 26/08 foi gerada a NFe 306820-5 no valor de R$876,78 referente ao cupom fiscal 240209-U72 do dia 22/08/2014.
Assim, há uma sobra no valor de R$876,78 no dia 26/08 e uma falta no mesmo valor no dia 22/08

-- Verifica quando a NFE foi gerada
SELECT MS.CODFIL
      ,MS.NUMNOTA
      ,MS.SERIE
      ,MS.TPNOTA
      ,CC.NOMCLI
      ,MS.DTNOTA
      ,MS.VLTOTAL
      ,MS.NUMPEDVEN
  FROM MOV_SAIDA MS
 INNER JOIN CAD_CLIENTE CC
    ON CC.CODCLI = MS.CODCLI
 WHERE CODFILPDV = &CODFIL
   AND DTNOTAPDV = '&DATA'
--   AND NUMNOTAPDV = 115161
--   AND SERIEPDV = 'U34'
   AND TPNOTAPDV = 512
 

A divergencia é gerada pois foi gerada a NFE 186325-5 no valor de R$109,50 no dia 09/06/2014 que é referente aos cupom 35049-U31 do dia 04/06/2014 e assim gera a sobra no valor de R$109,50 no dia 09/06/2014 e falta no dia 04/06/2014.

A divergencia é gerada pois há um erro no relatório onde as devoluções de vendas faturadas são contabilizadas com valor positivo quando o correto seria contabiliza-las com valor negativo.
No dia 14/05, foi gerada a NFe 193277-2 no valor de R$211,58 e tambem foi gerada a nota de devolução 193259-5 no valor de R$211,58 da venda faturada referente ao cupom 342050-U14 e assim, o valor da linha 8 deve ser 0.
