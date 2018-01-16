SELECT CL.CODFIL
      ,CL.DATENT
      ,CL.NUMPED
      ,CL.NUMCXA
      ,CL.CODOPER
      ,MP.VLTOTAL VLPED
      ,SUM(CL.VALLAN) VLLANC
      ,MP.VLTOTAL - SUM(CL.VALLAN) DIV
  FROM CXA_LANCTO CL
 INNER JOIN MOV_PEDIDO MP
    ON CL.NUMPED = MP.NUMPEDVEN
   AND MP.DTPEDIDO = CL.DATENT
 WHERE CL.CODFIL = &CODFIL
   AND CL.DATENT = '&DATA' --between '01/11/2013' and '25/11/2013'
   AND CL.NUMPED <> 999999
   AND CL.STATUS = 2
 GROUP BY CL.CODFIL, CL.DATENT, CL.NUMPED, CL.NUMCXA, CL.CODOPER, MP.VLTOTAL
HAVING(MP.VLTOTAL - SUM(CL.VALLAN)) >= 0.5 OR (MP.VLTOTAL - SUM(CL.VALLAN)) <= -0.5

--Foi verificado que havia uma divergencia entre o valor dos lançamentos com o total do pedido 17125705 no valor de R$3726,9.
--Apos ajuste do lançamento do pedido, a divergencia foi eliminada.


