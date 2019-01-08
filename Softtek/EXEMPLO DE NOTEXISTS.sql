SELECT *

FROM   MOV_SAIDA MS

WHERE  1=1 
       AND MS.CODFIL = 20
       AND MS.NUMCXA = 28
       AND MS.DTNOTA = '16/12/2015'
--       AND MS.NUMNOTA IN (275176)
       AND NOT EXISTS
                      (SELECT 1
                       FROM   CXA_LANCTO L
                       WHERE  1=1
                       AND MS.CODFIL = L.CODFIL
                       AND MS.NUMCXA = L.NUMCXA 
                       AND MS.NUMNOTA =  L.NUMNOT)
