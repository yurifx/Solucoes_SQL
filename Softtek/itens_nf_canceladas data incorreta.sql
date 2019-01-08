select SUM(qtcomp * precounit)
  from itens_nf_canceladas a
 where codfil = 15
   and serie = 'U46'
   and tpnota = 512
   AND DTNOTA IN ('16/06/2016', '17/06/2016')
   AND NUMNOTA BETWEEN
      
       (select min(numnota)
          from mov_saida
        
         where codfil = 15
           and numcxa = 46
           and tpnota = 512
           and status <> 9
           and dtnota = '17/06/2016')
      
   AND (select max(numnota)
          from mov_saida
        
         where codfil = 15
           and numcxa = 46
           and tpnota = 512
           and status <> 9
           and dtnota = '17/06/2016')
