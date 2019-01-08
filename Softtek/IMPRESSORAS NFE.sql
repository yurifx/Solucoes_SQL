SELECT SIGLA1,VALOR1, SIGLA2, VALOR2, SIGLA3, VALOR3, SIGLA4, VALOR4
FROM   SAT_INT_PARAM A
WHERE  A.CODINTERFACE IN (9)
and a.valor2 in ('2','502') -- Cadastro das impressoras
and a.sigla1 like 'IMP%' -- Cadastro das impressoras
ORDER BY VALOR2, VALOR1
