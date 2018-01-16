SELECT CL.CODFIL,
       CL.DATENT,
       CL.NUMCXA,
       CL.NUMPED,
       CL.CODEVE,
       CL.VALLAN,
       CL.FORMA,
       NVL(CL.FILORI, -1) FILORI,
       CL.CODCLI,
       nvl(CL.NUMTIT, -1) NUMTIT,
       CL.DESTIT,
       CL.FILPED,
       CL.NUMNOT,
       CL.SERIE,
       CL.TPNOTA,
       CL.STATUS,
       nvl(CL.DIGCONTRA, -1) DIGCONTRA,
       nvl(CL.FLDEBCRED, 'X') FLDEBCRED,
       nvl(CL.DIGCONTRAFIN, -1) DIGCONTRAFIN,
       NVL(CL.CODREC, 0) CODREC,
       nvl(CL.CODFILCRC, -1) CODFILCRC,
       nvl(CL.CODORIGCRC, -1) CODORIGCRC,
       nvl(CL.TPCLICRC, 'X') TPCLICRC,
       nvl(CL.NRRECRECEB, -1) NRRECRECEB,
       nvl(CL.DTDIGIT, to_date('01/01/1900', 'dd/mm/rrrr')) DTDIGIT,
       CL.CODFILCXA,
       nvl(CL.TIPOMOVPDV, '-1') TIPOMOVPDV,
       nvl(CL.NUMCCF, -1) NUMCCF,
       nvl(CL.NUMDAV, -1) NUMDAV,
       CL.TIPOPED,
       CL.NUMPRC,
       CL.NUMLAN,
       CL.DATREF
  FROM CXA_LANCTO CL
 INNER JOIN CXA_EVENTO CE ON CL.FORMA = CE.CODEVE
                         AND CE.CODEVE <> 19
                         AND CE.RECDEV = 'S'
                         AND (CE.FLEMITECOBRANCA NOT IN ('B', 'C') OR
                             CE.FLEMITECOBRANCA IS NULL)
 INNER JOIN CAD_FORMA CF ON CL.FORMA = CF.FORMA
                        AND CL.CONDPGTO = CF.CONDPGTO
                        AND CL.CODFIL = CF.CODFIL
                        AND ((CF.GERCXA = 'S') OR (CF.FLGERAER = 'S'))
 INNER JOIN CXA_MOVIMENTO CM ON CL.CODFILCXA = CM.CODFIL
                            AND CL.CODOPER = CM.CODOPER
                            AND CL.NUMCXA = CM.NUMCXA
                            AND CL.NUMMOV = CM.NUMMOV
                            AND CL.DATENT = CM.DATAINI
 WHERE CL.CODFIL IN (08,508)
   AND CL.DATENT = TO_DATE('09/05/2015', 'DD/MM/RRRR')
   AND CL.STATUS <> 9
   AND CL.CODEVE <> 26