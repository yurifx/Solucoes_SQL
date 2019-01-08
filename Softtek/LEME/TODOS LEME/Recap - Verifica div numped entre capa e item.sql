SELECT MS.CODFIL FILIAL, MS.DTNOTA DATA, MS.NUMNOTA NOTA, MI.NUMPEDVEN PEDIDO_ITEM, MS.NUMPEDVEN PEDIDO_CAPA, MI.VLTOTITEM VALOR, MI.CODITPROD, MS.IDENTPROC
FROM   MOV_SAIDA MS
INNER  JOIN MOV_ITSAIDA MI ON MI.CODFIL = MS.CODFIL
			AND MI.TPNOTA = MS.TPNOTA
			AND MI.NUMNOTA = MS.NUMNOTA
			AND MI.SERIE = MS.SERIE
			AND MI.DTNOTA = MS.DTNOTA
WHERE  MS.CODFIL = &CODFIL
       AND MS.DTNOTA = '&DATA'
       AND MS.TPNOTA = 512
       AND MS.STATUS <> 9
       AND MI.NUMPEDVEN <> MS.NUMPEDVEN
       AND MI.NUMPEDVEN <> 999999
--Divergencia na linha de retomada referente ao pedido 18592575 no valor de R$1219,13 que não foi incluido nesta linha por um problema sistemico.
--Divergencia na linha de retomada referente ao pedido 18741328 no valor de R$251,91 e ao pedido 18738211 no valor de R$1650,37 totalizando R$1902,28 que não foi incluido nesta linha por um problema sistemico.


