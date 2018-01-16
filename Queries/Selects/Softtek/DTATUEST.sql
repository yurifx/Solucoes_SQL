select status,codfil, numnota, serie, dtnota, dtatuest, numpedven, codcli, vlmercad, vltotal  from mov_saida where
codfil = 526 and
--numcxa = 8 and
dtnota =  '18/09/2015'
--and numnota =60695
and trunc(dtatuest) > dtnota


