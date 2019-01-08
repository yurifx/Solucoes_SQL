select * from ent_notaped
where numpedcomp  = 5699645
and codfil = 535

select * from dbagemco_p.int_prenf_ent_nota where numnota = 16464 and codfil = 535 and tpnota = 1 and dtnota = '14/04/2015' and codremet = 10820;

select * from ent_nota
where numnota = 645514
and Codfil = 37
and serie = 1

select * from ent_itent
where numnota = 645514
and Codfil = 37
and serie = 1

SELECT *
  FROM DBAGEMCO_P.INT_PRENF_ENT_NOTA
 WHERE CODFIL = 535
   AND NUMNOTA = 16464
   
   SELECT CODFIL, TPNOTA, CODREMET, SERIE, NUMNOTA, DTNOTA, DHRCADASTRO, STATUSINT, OBS, CODUSER
  FROM DBAGEMCO_P.INT_PRENF_ENT_NOTA_HST
 WHERE CODFIL = 535
   AND NUMNOTA = 16464
   
 
   
   SELECT CODFIL
      ,NUMNOTA
      ,SERIE
      ,TPNOTA
      ,CODREMET
      ,DTNOTA
      ,DTEMISSAO
      ,STATUS
      ,CODFUNCCONF
      ,VLTOTAL
      ,CODUSER
      ,CODMOTIVOPEND
      ,DTATUEST
      ,DTHRCONFERENCIA
  FROM ENT_NOTA
 WHERE CODFIL = 535
   AND NUMNOTA = 16464
   And serie = 1;
   
   SELECT *
  FROM DBAGEMCO_P.INT_PRENF_ENT_NOTA
 WHERE CODFIL = 535
   AND NUMNOTA = 16464

   