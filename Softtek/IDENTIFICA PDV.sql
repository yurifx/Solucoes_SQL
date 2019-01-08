SELECT *
FROM   PDV_FISCAL A
WHERE  1 = 1
       AND        CODFIL =        &f
       AND        PDV =           &c
       AND        DATA >= '01/04/2016'     ;
SELECT DISTINCT CODFIL, ENDERECOIP, PDV, NUMSERIE
FROM   PDV_FISCAL A
WHERE  1 = 1
       AND        CODFIL =        &f
       AND        PDV =           &c
       AND        DATA >= '01/04/2016'     ;
--       and IDENTPROC NOT LIKE '%SMARTECF%'


