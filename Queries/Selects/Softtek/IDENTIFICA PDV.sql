--identifica ip do pdv
SELECT *--codfil, pdv, numseqini, numseqfim, grantotal, enderecoip, tipo, data
FROM			PDV_FISCAL
WHERE		1 = 1
AND				CODFIL = 	&FILIAL
AND 			DATA   >= sysdate - 30
AND				PDV    = 	&PDV


SELECT * FROM CXA_CAIXAS
WHERE CODFIL = 34