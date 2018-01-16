PRINT ' '
PRINT ' '
PRINT ' '
PRINT ' -- **************************************'
PRINT ' -- **            SMTI150018.sql ' 
PRINT ' -- **************************************'


 -- Atualiza tabela de controle de scripts executados
insert into gemco_scripts_executados (script, dthrexecucao) select 'SMTI150018.sql', getdate()
go


IF EXISTS (SELECT 1 FROM SYSOBJECTS WHERE NAME ='PRODUTOS')
     DROP VIEW PRODUTOS
GO

CREATE VIEW DBO.PRODUTOS
( codprod, preco, digprod, descricao, descresumida, ctf, aliqicms, aliqicmred, aliqicmsub, tipoprod, flnrserie, 
  nivelprod1, flcoringa, flcontrolado, tipoprocesso, flservico, flpromocao, cmup, foto, qtembmovim, flterceiro, 
  flcomissao, comissao, pmarginf, codembal, flselfcolor, pdescprom, dtvalinic, dtvalfim, descautoitem, codforne, 
  cor, especificacao, unidmaior, unidmenor, qtemb, codproddf, codfam, flmontagem, qtembmovimvenda, codprodvasilhame, 
  flredudifer, codocorrpreco, conversao, fllotevencto, flrepi, flestdir, flnrsimcard, precoref, flnumlinhatel, 
  fatoriv, flcupomextra, flvalepresente, ctfredudifer, flservcel, flimpmenvenda, flmultiplicar, precopes0, precopes1, 
  precopes2, flpromocaonestle, flmarcapropria, vldescpromprivate,origem,ncm,vllimite,FLIPISAI, VLIPI, ALIQIPI, FLRAMOATIV, FATIPI, 
  FLPADRAOIRRIGACAO, CSTCOFINS, CSTPIS, PPIS, PCONTSOC, ALIQIBPT, VERSAOIBPT, QTATACAREJO, PRECOATACAREJO, FLIPIPRODIMP,
  ALIQIBPTEST, ALIQIBPTMUN, CHAVEIBPT, FONTEIBPT)
AS
--**********************************************************************
--* View para listar PRODUTOS no SMARTECF.                             *
--* Fev 16, 2005 - Cristina Co - D007849 - Versao 30 - Acrescenta colu-*
--*  luna FLREPI. (FCampos).                                           *
--* Fev 24, 2005 - Marcelo Canale - D007887 - Versao 31 - Acrescenta   *
--* coluna FLESTDIR. (FCampos).                                        *
--* Mar 04, 2005 - Cristina Co - D007904 - Versao 32 - Acrescenta a co-*
--*  luna FLNRSIMCARD. (FCampos).                                      *
--* Mar 28, 2005 - Cristina Co - D007992 - Versao 33 - Acrescenta tra- *
--*  tamento para TPNFVDDEFECF. Se for null TPNOTA = 51. (Shozo).      *
--* Abr 01, 2005 - Cristina Co - D008018 - Versao 34 - Acrescenta tra- *
--*  tamento para TPNFVDDEFECF = 0. (Shozo). Acrescenta coluna PRECOREF*
--*  (Nunzio).                                                         *
--* Jul 07, 2005 - Cristina Co - D008280 - Versao 35 - Acertar condicao*
--*  para CTF. (Shozo).                                                *
--* Jul 26, 2005 - Patricia Bernini -    - Versao 36 - Acrescenta colu-*
--*  una CAD_PROD.FLNUMLINHATEL (Marcelo Jose).                        *
--* Ago 02, 2005 - Patricia Bernini - D008360 - Versao 37 - Acrescenta *
--*   coluna CAD_PRECO.FATORIV (Marcelo Jose).                         *
--* Ago 04, 2005 - Cristina Co - D008392 - Versao 38 - Voltar CTF como *
--*  estava antes. (Shozo).                                            *
--* Ago 22, 2005 - Cristina Co - D008442 - Versao 39 - Utilizar flag da*
--*  CAD_FILIAL_COMPL (TPDESCMDB) para identificar qual descricao sera *
--*  utilizada. (AVasconcelos).                                        *
--* Ago 30, 2005 - Cristina Co -         - Versao 40 - Acrescenta colu-*
--*  na FLCUPOMEXTRA. (Nunzio). Alteracao CTF. (CFedericci).           *
--* Abr 03, 2006 - Cristina Co - D008852 - Versao 41 - Acrescenta colu-*
--*  na FLVALEPRESENTE. (GLabone).                                     *
--* Mai 25, 2006 - Patricia Bernini - D008915 - Versao 41 - Acrescenta *
--*  coluna CTFREDUDIFER. (MJose).                                     *
--* Jun 16, 2006 - Patricia Bernini -                     - Acrescenta *
--*  coluna FLSERVCEL. (MJose).                                        *
--* Jul 10, 2006 - Patricia Bernini -                     - Acrescenta *
--*  coluna FLIMPMENVENDA. (MSantos).                                  *
--* Jul 21, 2006 - Patricia Bernini - D009143 - Versao 42 - Reliberacao*
--* Out 09, 2006 - Patricia Bernini - D009285 - Versao 43 - Acrescenta *
--*  coluna FLMULTIPLICAR.(CCamargo).                                  *
--* Out 19, 2006 - Patricia Bernini - D009306 - Versao 44 - Acrescenta *
--*  as colunas PRECOPES0,PRECOPES1,PRECOPES2.(CCamargo).              *
--* Ago 08, 2008 - Jefferson Ralo - 	      - Versao 45 - Acrescenta *
--*  a coluna FLPROMOCAONESTLE da CAD_PROD (FLPROMOCAO).(Cokamoto).    *
--* Jul 27, 2009 - SA_IMPL_1950_0 - Alterar o campo Descricao Resumida *
--* Willian Silva. De: PRO.DESCRICAO para PRO.DESCRESUMIDA             *
--* Set 09, 2010 - adicionado o tratamento de ISNULL nos calculos:     * 
--* FATICM,FATICMRED,FATICMSUB                                         * 
--  Fev 25, 2011 - Felipe Lernic - Inclusão da coluna                  *
--  	CAD_PRECO.VLDESCPROMPRIVATE (Cesar Camargo)                    *
--* Mar 30, 2011 - Felipe Lernic  - Oc. 124463 (Roberto Cesar)         *
--* Set 29, 2011 - Andre Baptista - Oc. 128050 (Cesar Camargo) adicao  *
--*                das colunas ORIGEM,NCM da tabela CAD_PROD           *
--* Jun 11, 2012 - Vivian Martins - Oc. 131328 (Roberto Cesar)         *
--*	ADICAO DA COLUNA VLLIMITE                                      *
--* Jun 22, 2012 - Vivian Martins - Oc. 122055 (Roberto Cesar)         *
--*	ADICAO DAS COLUNAS FLIPISAI, VLIPI, ALIQIPI, FLRAMOATIV, FATIPI*
--* Jan 27, 2015 - pfernandes - task 4654 - ALIQIBPTEST, ALIQIBPTMUN,  *
--*     CHAVEIBPT, FONTEIBPT            	                       *       
--**********************************************************************
SELECT ITP.CODITPROD, 
       --Roberto Cesar - oc. 124463 - Não ler o PRECOAUX quando a promoção não estiver ativa. --
       CASE 
       		WHEN ISNULL(PRE.PRECOAUX,0) = 0 THEN PRE.PRECO
       		ELSE
       			CASE 
       				WHEN SIGN(DATEDIFF(D, PRE.DTVALINIC, FIL.DTPROC)) = 1 THEN
       						CASE 
       							WHEN SIGN(DATEDIFF(D, FIL.DTPROC, PRE.DTVALFIM)) = 1 THEN PRE.PRECOAUX
       							WHEN SIGN(DATEDIFF(D, FIL.DTPROC, PRE.DTVALFIM)) = 0 THEN PRE.PRECOAUX
       							ELSE PRE.PRECO
       						END
       				WHEN SIGN(DATEDIFF(D, PRE.DTVALINIC, FIL.DTPROC)) = 0 THEN
       						CASE 
       							WHEN SIGN(DATEDIFF(D, FIL.DTPROC, PRE.DTVALFIM)) = 1 THEN PRE.PRECOAUX
       							WHEN SIGN(DATEDIFF(D, FIL.DTPROC, PRE.DTVALFIM)) = 0 THEN PRE.PRECOAUX
       							ELSE PRE.PRECO
       						END
       			END
       END,
       ITP.DIGITPROD,
       CASE WHEN ISNULL(COM.TPDESCMDB,0) = 0 THEN ISNULL(PRO.DESCRESUMIDA,'')+' '+ISNULL(COR.DESCRICAO,'')+' '+ISNULL(ESP.DESCRICAO,'') -- PRODUTOS
            WHEN ISNULL(COM.TPDESCMDB,0) = 2 THEN ISNULL(PRO.DESCRICAO,'')+' '+ISNULL(COR.DESCRICAO,'')+' '+ISNULL(ESP.DESCRICAO,'') -- PRODUTOS_DESC
            WHEN ISNULL(COM.TPDESCMDB,0) = 5 THEN ISNULL(PRO.DESCRESUMIDA,'') -- PRODUTOS_DESC_RESUM
            WHEN ISNULL(COM.TPDESCMDB,0) = 1 THEN ISNULL(PRO.DESCRESUMIDA,'')+' '+ISNULL(COR.DESCRICAO,'')+' '+ISNULL(ESP.DESCRICAO,'')+ ' '+ISNULL(EMB.UNIDMAIOR,'') -- PRODUTOS_EMB
            WHEN ISNULL(COM.TPDESCMDB,0) = 4 THEN ISNULL(PRO.DESCRESUMIDA,'')+' '+ISNULL(COR.DESCRICAO,'')+' '+ISNULL(ESP.DESCRICAO,'')+ ' '+ISNULL(EMB.UNIDMAIOR,'')+ISNULL(RIGHT('0000'+LTRIM(STR(EMB.QTEMB)),4),'')+ISNULL(EMB.UNIDMENOR,'') -- PRODUTOS_EMB_COMPL
            WHEN ISNULL(COM.TPDESCMDB,0) = 3 THEN ISNULL(PRO.DESCRESUMIDA,'')+' '+ISNULL(COR.DESCRICAO,'')+' '+ISNULL(ESP.DESCRICAO,'')+CASE WHEN ISNULL(ITP.CODITFORN,'') = '' THEN '' ELSE ' - '+ITP.CODITFORN END -- PRODUTOS_FORNE
       END DESCRICAO,
       PRO.DESCRESUMIDA,
       CASE WHEN EMP.FLIMPCTF = 'S' 
            THEN CASE WHEN ISNULL(PRO.CODICMS,0) > 0 
                      THEN CASE WHEN ISNULL((SELECT ITR.CTF FROM CAD_IMPTRIBUT ITR, CAD_TPNOTA TPN, CAD_TRIBUT TRI WHERE ITR.TPIMP = 'I' AND ITR.ESTORIG = FIL.ESTADO AND ITR.ESTDEST = FIL.ESTADO AND ITR.CODIMP = PRO.CODICMS AND ITR.CODGRPTPNOTA = TPN.CODGRPTPNOTA AND TPN.TPNOTA = CASE WHEN ISNULL(FIL.TPNFVDDEFECF,0) = 0 THEN 51 ELSE FIL.TPNFVDDEFECF END AND ITR.CTF = TRI.CTF AND TRI.FATICM = 0),0) > 0
                                THEN (SELECT ITR.CTF FROM CAD_IMPTRIBUT ITR, CAD_TPNOTA TPN, CAD_TRIBUT TRI WHERE ITR.TPIMP = 'I' AND ITR.ESTORIG = FIL.ESTADO AND ITR.ESTDEST = FIL.ESTADO AND ITR.CODIMP = PRO.CODICMS AND ITR.CODGRPTPNOTA = TPN.CODGRPTPNOTA AND TPN.TPNOTA = CASE WHEN ISNULL(FIL.TPNFVDDEFECF,0) = 0 THEN 51 ELSE FIL.TPNFVDDEFECF END AND ITR.CTF = TRI.CTF AND TRI.FATICM = 0)
                                ELSE CASE WHEN ISNULL(PRO.CODICMSUB,0) > 0
                                          THEN CASE WHEN ISNULL((SELECT ITR.CTF FROM CAD_IMPTRIBUT ITR, CAD_TPNOTA TPN, CAD_TRIBUT TRI WHERE ITR.TPIMP = 'S' AND ITR.ESTORIG = FIL.ESTADO AND ITR.ESTDEST = FIL.ESTADO  AND ITR.CODIMP = PRO.CODICMSUB AND ITR.CODGRPTPNOTA = TPN.CODGRPTPNOTA AND TPN.TPNOTA = CASE WHEN ISNULL(FIL.TPNFVDDEFECF,0) = 0 THEN 51 ELSE FIL.TPNFVDDEFECF END AND ITR.CTF = TRI.CTF AND TRI.FATICMSUB > 0),0) > 0
                                                    THEN (SELECT ITR.CTF FROM CAD_IMPTRIBUT ITR, CAD_TPNOTA TPN, CAD_TRIBUT TRI WHERE ITR.TPIMP = 'S' AND ITR.ESTORIG = FIL.ESTADO AND ITR.ESTDEST = FIL.ESTADO AND ITR.CODIMP = PRO.CODICMSUB AND ITR.CODGRPTPNOTA = TPN.CODGRPTPNOTA AND TPN.TPNOTA = CASE WHEN ISNULL(FIL.TPNFVDDEFECF,0) = 0 THEN 51 ELSE FIL.TPNFVDDEFECF END AND ITR.CTF = TRI.CTF AND TRI.FATICMSUB > 0)
                                                    ELSE CASE WHEN (SELECT ISNULL(TRI.FATICM,0) + ISNULL(TRI.FATICMRED,0) + ISNULL(TRI.FATICMSUB,0) FROM CAD_IMPTRIBUT ITR, CAD_TPNOTA TPN, CAD_TRIBUT TRI WHERE ITR.TPIMP = 'S' AND ITR.ESTORIG = FIL.ESTADO AND ITR.ESTDEST = FIL.ESTADO AND ITR.CODIMP = PRO.CODICMSUB AND ITR.CODGRPTPNOTA = TPN.CODGRPTPNOTA AND TPN.TPNOTA = CASE WHEN ISNULL(FIL.TPNFVDDEFECF,0) = 0 THEN 51 ELSE FIL.TPNFVDDEFECF END AND ITR.CTF = TRI.CTF) = 0
                                                              THEN (SELECT ITR.CTF FROM CAD_IMPTRIBUT ITR, CAD_TPNOTA TPN, CAD_TRIBUT TRI WHERE ITR.TPIMP = 'S' AND ITR.ESTORIG = FIL.ESTADO AND ITR.ESTDEST = FIL.ESTADO AND ITR.CODIMP = PRO.CODICMSUB AND ITR.CODGRPTPNOTA = TPN.CODGRPTPNOTA AND TPN.TPNOTA = CASE WHEN ISNULL(FIL.TPNFVDDEFECF,0) = 0 THEN 51 ELSE FIL.TPNFVDDEFECF END AND ITR.CTF = TRI.CTF)
                                                              ELSE CASE WHEN ISNULL(PRO.CODICMRED,0) > 0
                                                                        THEN CASE WHEN ISNULL((SELECT ITR.CTF FROM CAD_IMPTRIBUT ITR, CAD_TPNOTA TPN, CAD_TRIBUT TRI WHERE ITR.TPIMP = 'R' AND ITR.ESTORIG = FIL.ESTADO AND ITR.ESTDEST = FIL.ESTADO AND ITR.CODIMP = PRO.CODICMRED AND ITR.CODGRPTPNOTA = TPN.CODGRPTPNOTA AND TPN.TPNOTA = CASE WHEN ISNULL(FIL.TPNFVDDEFECF,0) = 0 THEN 51 ELSE FIL.TPNFVDDEFECF END AND ITR.CTF = TRI.CTF AND TRI.FATICMRED > 0),0) > 0
                                                                                  THEN (SELECT ITR.CTF FROM CAD_IMPTRIBUT ITR, CAD_TPNOTA TPN, CAD_TRIBUT TRI WHERE ITR.TPIMP = 'R' AND ITR.ESTORIG = FIL.ESTADO AND ITR.ESTDEST = FIL.ESTADO AND ITR.CODIMP = PRO.CODICMRED AND ITR.CODGRPTPNOTA = TPN.CODGRPTPNOTA AND TPN.TPNOTA = CASE WHEN ISNULL(FIL.TPNFVDDEFECF,0) = 0 THEN 51 ELSE FIL.TPNFVDDEFECF END AND ITR.CTF = TRI.CTF AND TRI.FATICMRED > 0)
                                                                                  ELSE CASE WHEN ISNULL((SELECT ITR.CTF FROM CAD_IMPTRIBUT ITR, CAD_TPNOTA TPN, CAD_TRIBUT TRI WHERE ITR.TPIMP = 'I' AND ITR.ESTORIG = FIL.ESTADO AND ITR.ESTDEST = FIL.ESTADO AND ITR.CODIMP = PRO.CODICMS AND ITR.CODGRPTPNOTA = TPN.CODGRPTPNOTA AND TPN.TPNOTA = CASE WHEN ISNULL(FIL.TPNFVDDEFECF,0) = 0 THEN 51 ELSE FIL.TPNFVDDEFECF END AND ITR.CTF = TRI.CTF AND TRI.FATICM > 0),0) > 0
                                                                                            THEN (SELECT ITR.CTF FROM CAD_IMPTRIBUT ITR, CAD_TPNOTA TPN, CAD_TRIBUT TRI WHERE ITR.TPIMP = 'I' AND ITR.ESTORIG = FIL.ESTADO AND ITR.ESTDEST = FIL.ESTADO AND ITR.CODIMP = PRO.CODICMS AND ITR.CODGRPTPNOTA = TPN.CODGRPTPNOTA AND TPN.TPNOTA = CASE WHEN ISNULL(FIL.TPNFVDDEFECF,0) = 0 THEN 51 ELSE FIL.TPNFVDDEFECF END AND ITR.CTF = TRI.CTF AND TRI.FATICM > 0)
                                                                                            ELSE (SELECT ITR.CTF FROM CAD_IMPTRIBUT ITR, CAD_TPNOTA TPN, CAD_TRIBUT TRI WHERE ITR.TPIMP = 'S' AND ITR.ESTORIG = FIL.ESTADO AND ITR.ESTDEST = FIL.ESTADO AND ITR.CODIMP = PRO.CODICMSUB AND ITR.CODGRPTPNOTA = TPN.CODGRPTPNOTA AND TPN.TPNOTA = CASE WHEN ISNULL(FIL.TPNFVDDEFECF,0) = 0 THEN 51 ELSE FIL.TPNFVDDEFECF END AND ITR.CTF = TRI.CTF AND TRI.FATICMSUB = 0)
                                                                                       END
                                                                             END
                                                                        ELSE CASE WHEN ISNULL((SELECT ITR.CTF FROM CAD_IMPTRIBUT ITR, CAD_TPNOTA TPN, CAD_TRIBUT TRI WHERE ITR.TPIMP = 'I' AND ITR.ESTORIG = FIL.ESTADO AND ITR.ESTDEST = FIL.ESTADO AND ITR.CODIMP = PRO.CODICMS AND ITR.CODGRPTPNOTA = TPN.CODGRPTPNOTA AND TPN.TPNOTA = CASE WHEN ISNULL(FIL.TPNFVDDEFECF,0) = 0 THEN 51 ELSE FIL.TPNFVDDEFECF END AND ITR.CTF = TRI.CTF AND TRI.FATICM > 0),0) > 0
                                                                                  THEN (SELECT ITR.CTF FROM CAD_IMPTRIBUT ITR, CAD_TPNOTA TPN, CAD_TRIBUT TRI WHERE ITR.TPIMP = 'I' AND ITR.ESTORIG = FIL.ESTADO AND ITR.ESTDEST = FIL.ESTADO AND ITR.CODIMP = PRO.CODICMS AND ITR.CODGRPTPNOTA = TPN.CODGRPTPNOTA AND TPN.TPNOTA = CASE WHEN ISNULL(FIL.TPNFVDDEFECF,0) = 0 THEN 51 ELSE FIL.TPNFVDDEFECF END AND ITR.CTF = TRI.CTF AND TRI.FATICM > 0)
                                                                                  ELSE (SELECT ITR.CTF FROM CAD_IMPTRIBUT ITR, CAD_TPNOTA TPN, CAD_TRIBUT TRI WHERE ITR.TPIMP = 'S' AND ITR.ESTORIG = FIL.ESTADO AND ITR.ESTDEST = FIL.ESTADO AND ITR.CODIMP = PRO.CODICMSUB AND ITR.CODGRPTPNOTA = TPN.CODGRPTPNOTA AND TPN.TPNOTA = CASE WHEN ISNULL(FIL.TPNFVDDEFECF,0) = 0 THEN 51 ELSE FIL.TPNFVDDEFECF END AND ITR.CTF = TRI.CTF AND TRI.FATICMSUB = 0)
                                                                             END
                                                                   END
                                                         END

                                               END
                                          ELSE CASE WHEN ISNULL(PRO.CODICMRED,0) > 0
                                                    THEN CASE WHEN ISNULL((SELECT ITR.CTF FROM CAD_IMPTRIBUT ITR, CAD_TPNOTA TPN, CAD_TRIBUT TRI WHERE ITR.TPIMP = 'R' AND ITR.ESTORIG = FIL.ESTADO AND ITR.ESTDEST = FIL.ESTADO AND ITR.CODIMP = PRO.CODICMRED AND ITR.CODGRPTPNOTA = TPN.CODGRPTPNOTA AND TPN.TPNOTA = CASE WHEN ISNULL(FIL.TPNFVDDEFECF,0) = 0 THEN 51 ELSE FIL.TPNFVDDEFECF END AND ITR.CTF = TRI.CTF AND TRI.FATICMRED > 0),0) > 0
                                                              THEN (SELECT ITR.CTF FROM CAD_IMPTRIBUT ITR, CAD_TPNOTA TPN, CAD_TRIBUT TRI WHERE ITR.TPIMP = 'R' AND ITR.ESTORIG = FIL.ESTADO AND ITR.ESTDEST = FIL.ESTADO AND ITR.CODIMP = PRO.CODICMRED AND ITR.CODGRPTPNOTA = TPN.CODGRPTPNOTA AND TPN.TPNOTA = CASE WHEN ISNULL(FIL.TPNFVDDEFECF,0) = 0 THEN 51 ELSE FIL.TPNFVDDEFECF END AND ITR.CTF = TRI.CTF AND TRI.FATICMRED > 0)
                                                              ELSE CASE WHEN ISNULL((SELECT ITR.CTF FROM CAD_IMPTRIBUT ITR, CAD_TPNOTA TPN, CAD_TRIBUT TRI WHERE ITR.TPIMP = 'I' AND ITR.ESTORIG = FIL.ESTADO AND ITR.ESTDEST = FIL.ESTADO AND ITR.CODIMP = PRO.CODICMS AND ITR.CODGRPTPNOTA = TPN.CODGRPTPNOTA AND TPN.TPNOTA = CASE WHEN ISNULL(FIL.TPNFVDDEFECF,0) = 0 THEN 51 ELSE FIL.TPNFVDDEFECF END AND ITR.CTF = TRI.CTF AND TRI.FATICM > 0),0) > 0
                                                                        THEN (SELECT ITR.CTF FROM CAD_IMPTRIBUT ITR, CAD_TPNOTA TPN, CAD_TRIBUT TRI WHERE ITR.TPIMP = 'I' AND ITR.ESTORIG = FIL.ESTADO AND ITR.ESTDEST = FIL.ESTADO AND ITR.CODIMP = PRO.CODICMS AND ITR.CODGRPTPNOTA = TPN.CODGRPTPNOTA AND TPN.TPNOTA = CASE WHEN ISNULL(FIL.TPNFVDDEFECF,0) = 0 THEN 51 ELSE FIL.TPNFVDDEFECF END AND ITR.CTF = TRI.CTF AND TRI.FATICM > 0)
                                                                        ELSE (SELECT ITR.CTF FROM CAD_IMPTRIBUT ITR, CAD_TPNOTA TPN, CAD_TRIBUT TRI WHERE ITR.TPIMP = 'R' AND ITR.ESTORIG = FIL.ESTADO AND ITR.ESTDEST = FIL.ESTADO AND ITR.CODIMP = PRO.CODICMRED AND ITR.CODGRPTPNOTA = TPN.CODGRPTPNOTA AND TPN.TPNOTA = CASE WHEN ISNULL(FIL.TPNFVDDEFECF,0) = 0 THEN 51 ELSE FIL.TPNFVDDEFECF END AND ITR.CTF = TRI.CTF AND TRI.FATICMRED = 0)
                                                                   END 
                                                         END
                                                    ELSE (SELECT ITR.CTF FROM CAD_IMPTRIBUT ITR, CAD_TPNOTA TPN WHERE ITR.TPIMP= 'I' AND ITR.ESTORIG = FIL.ESTADO AND ITR.ESTDEST = FIL.ESTADO AND ITR.CODIMP = PRO.CODICMS AND ITR.CODGRPTPNOTA = TPN.CODGRPTPNOTA AND TPN.TPNOTA = CASE WHEN ISNULL(FIL.TPNFVDDEFECF,0) = 0 THEN 51 ELSE FIL.TPNFVDDEFECF END)
                                               END
                                     END
                           END
                      ELSE PRO.CTF
                 END
            ELSE PRO.CTF
       END,
       CASE WHEN EMP.FLIMPCTF = 'S'
            THEN CASE WHEN ISNULL(PRO.CODICMS,0) > 0 THEN (SELECT ITR.ALIQUOTA FROM CAD_IMPTRIBUT ITR, CAD_TPNOTA TPN WHERE ITR.TPIMP= 'I' AND ITR.ESTORIG = FIL.ESTADO AND ITR.ESTDEST = FIL.ESTADO AND ITR.CODIMP = PRO.CODICMS AND ITR.CODGRPTPNOTA = TPN.CODGRPTPNOTA AND TPN.TPNOTA = CASE WHEN ISNULL(FIL.TPNFVDDEFECF,0) = 0 THEN 51 ELSE FIL.TPNFVDDEFECF END) ELSE NULL END
            ELSE CASE WHEN ISNULL(PRO.CODICMS,0) > 0 THEN (SELECT IMP.ALIQUOTA FROM CAD_IMPOSTO IMP WHERE 1 = 1 AND IMP.TPIMP = 'I' AND IMP.ESTORIG = FIL.ESTADO AND IMP.ESTDEST = FIL.ESTADO AND IMP.CODIMP = PRO.CODICMS ) ELSE NULL END
       END,
       CASE WHEN EMP.FLIMPCTF = 'S'
            THEN CASE WHEN ISNULL(PRO.CODICMRED,0) > 0 THEN (SELECT ITR.ALIQUOTA FROM CAD_IMPTRIBUT ITR, CAD_TPNOTA TPN WHERE ITR.TPIMP = 'R' AND ITR.ESTORIG= FIL.ESTADO AND ITR.ESTDEST = FIL.ESTADO AND ITR.CODIMP = PRO.CODICMRED AND ITR.CODGRPTPNOTA = TPN.CODGRPTPNOTA AND TPN.TPNOTA = CASE WHEN ISNULL(FIL.TPNFVDDEFECF,0) = 0 THEN 51 ELSE FIL.TPNFVDDEFECF END) ELSE NULL END
            ELSE CASE WHEN ISNULL(PRO.CODICMRED,0) > 0 THEN (SELECT IMP.ALIQUOTA FROM CAD_IMPOSTO IMP WHERE 1 = 1 AND IMP.TPIMP = 'R' AND IMP.ESTORIG= FIL.ESTADO AND IMP.ESTDEST = FIL.ESTADO AND IMP.CODIMP = PRO.CODICMRED ) ELSE NULL END
       END,
       CASE WHEN EMP.FLIMPCTF = 'S'
            THEN CASE WHEN ISNULL(PRO.CODICMSUB,0) > 0 THEN (SELECT ITR.ALIQUOTA FROM CAD_IMPTRIBUT ITR, CAD_TPNOTA TPN WHERE ITR.TPIMP = 'S' AND ITR.ESTORIG= FIL.ESTADO AND ITR.ESTDEST = FIL.ESTADO AND ITR.CODIMP = PRO.CODICMSUB AND ITR.CODGRPTPNOTA = TPN.CODGRPTPNOTA AND TPN.TPNOTA = CASE WHEN ISNULL(FIL.TPNFVDDEFECF,0) = 0 THEN 51 ELSE FIL.TPNFVDDEFECF END) ELSE NULL END
            ELSE CASE WHEN ISNULL(PRO.CODICMSUB,0) > 0 THEN (SELECT IMP.ALIQUOTA FROM CAD_IMPOSTO IMP WHERE 1 = 1 AND IMP.TPIMP = 'S' AND IMP.ESTORIG= FIL.ESTADO AND IMP.ESTDEST = FIL.ESTADO AND IMP.CODIMP = PRO.CODICMSUB ) ELSE NULL END
       END,
       CASE WHEN PRO.DIFER = 7 THEN 0
            WHEN PRO.DIFER = 8 THEN 0
            ELSE PRO.DIFER END,
       PRO.FLNRSERIE, PRO.CODLINHA, PRO.FLCORINGA,
       ISNULL(PRO.FLCONTROLADO,'N'), CASE WHEN PRO.DIFER = 7 THEN 2 ELSE 0 END, CASE WHEN PRO.DIFER = 8 THEN 'S' ELSE 'N' END,
       PRE.FLPROMOCAO, 0, ISNULL(PRO.CAMINHOFOTO,'')+'\'+PRO.FOTO, PRO.QTEMBMOVIM,
       PRO.FLTERCEIRO, 'N', 0, PRO.PMARGINF, PRE.CODEMBAL, PRO.FLSELFCOLOR, PRE.PDESCPROM, PRE.DTVALINIC, PRE.DTVALFIM,
       PRE.DESCAUTOITEM, PRO.CODFORNE, COR.DESCRES, ESP.DESCRES, EMB.UNIDMAIOR, EMB.UNIDMENOR, EMB.QTEMB, ITP.CODPRODDF,
       PRO.CODFAM, PRO.FLMONTAGEM, EMB.QTEMBMOVIMVENDA, PRO.CODITPRODVASILHAME, PRO.FLREDUDIFER, PRE.CODOCORRPRECO,
       EMB.CONVERSAO, PRO.FLLOTEVENCTO, PRO.FLREPI, PRO.FLESTDIR, PRO.FLNRSIMCARD, PRE.PRECOREF,
       PRO.FLNUMLINHATEL,PRE.FATORIV,ITP.FLCUPOMEXTRA,PRO.FLVALEPRESENTE,PRO.CTFREDUDIFER,PRO.FLSERVCEL,
       PRO.FLIMPMENVENDA,PRO.FLMULTIPLICAR,PRE.PRECOPES0,PRE.PRECOPES1,PRE.PRECOPES2,PRO.FLPROMOCAO, PRO.FLMARCAPROPRIA,
       --Roberto Cesar - oc. 124463 - Considerar data de início e fim da promoção para retornar o valor do campo VLDESCPROMPRIVATE --
       case when SIGN(DATEDIFF(D, PRE.DTVALINIC, FIL.DTPROC)) >= 0 and SIGN(DATEDIFF(D, FIL.DTPROC, PRE.DTVALFIM)) >= 0 then 
            ISNULL(PRE.VLDESCPROMPRIVATE,0) else 0 end,
       ISNULL(ORI.ORIGEM, PRO.ORIGEM),
       PRO.NCM,
       PRO.VLLIMITE,
       '' FLIPISAI,       
       PRO.VLIPI,        
       PRO.ALIQIPI,
       PRO.FLRAMOATIV,
       case when EMP.FLIMPCTF = 'S' 
            then case when isnull(PRO.CODICMS,0) > 0 
                      then case when isnull((select TRI.FATIPI from CAD_IMPTRIBUT ITR, CAD_TPNOTA TPN, CAD_TRIBUT TRI where ITR.TPIMP = 'I' and ITR.ESTORIG = FIL.ESTADO and ITR.ESTDEST = FIL.ESTADO and ITR.CODIMP = PRO.CODICMS and ITR.CODGRPTPNOTA = TPN.CODGRPTPNOTA and TPN.TPNOTA = case when isnull(FIL.TPNFVDDEFECF,0) = 0 then 51 else FIL.TPNFVDDEFECF end and ITR.CTF = TRI.CTF and TRI.FATICM = 0),0) > 0
                                then (select TRI.FATIPI from CAD_IMPTRIBUT ITR, CAD_TPNOTA TPN, CAD_TRIBUT TRI where ITR.TPIMP = 'I' and ITR.ESTORIG = FIL.ESTADO and ITR.ESTDEST = FIL.ESTADO and ITR.CODIMP = PRO.CODICMS and ITR.CODGRPTPNOTA = TPN.CODGRPTPNOTA and TPN.TPNOTA = case when isnull(FIL.TPNFVDDEFECF,0) = 0 then 51 else FIL.TPNFVDDEFECF end and ITR.CTF = TRI.CTF and TRI.FATICM = 0)
                                else case when isnull(PRO.CODICMSUB,0) > 0
                                          then case when isnull((select TRI.FATIPI from CAD_IMPTRIBUT ITR, CAD_TPNOTA TPN, CAD_TRIBUT TRI where ITR.TPIMP = 'S' and ITR.ESTORIG = FIL.ESTADO and ITR.ESTDEST = FIL.ESTADO  and ITR.CODIMP = PRO.CODICMSUB and ITR.CODGRPTPNOTA = TPN.CODGRPTPNOTA and TPN.TPNOTA = case when isnull(FIL.TPNFVDDEFECF,0) = 0 then 51 else FIL.TPNFVDDEFECF end and ITR.CTF = TRI.CTF and TRI.FATICMSUB > 0),0) > 0
                                                    then (select TRI.FATIPI from CAD_IMPTRIBUT ITR, CAD_TPNOTA TPN, CAD_TRIBUT TRI where ITR.TPIMP = 'S' and ITR.ESTORIG = FIL.ESTADO and ITR.ESTDEST = FIL.ESTADO and ITR.CODIMP = PRO.CODICMSUB and ITR.CODGRPTPNOTA = TPN.CODGRPTPNOTA and TPN.TPNOTA = case when isnull(FIL.TPNFVDDEFECF,0) = 0 then 51 else FIL.TPNFVDDEFECF end and ITR.CTF = TRI.CTF and TRI.FATICMSUB > 0)
                                                    else case when (select TRI.FATICM + TRI.FATICMRED + TRI.FATICMSUB from CAD_IMPTRIBUT ITR, CAD_TPNOTA TPN, CAD_TRIBUT TRI where ITR.TPIMP = 'S' and ITR.ESTORIG = FIL.ESTADO and ITR.ESTDEST = FIL.ESTADO and ITR.CODIMP = PRO.CODICMSUB and ITR.CODGRPTPNOTA = TPN.CODGRPTPNOTA and TPN.TPNOTA = case when isnull(FIL.TPNFVDDEFECF,0) = 0 then 51 else FIL.TPNFVDDEFECF end and ITR.CTF = TRI.CTF) = 0
                                                              then (select TRI.FATIPI from CAD_IMPTRIBUT ITR, CAD_TPNOTA TPN, CAD_TRIBUT TRI where ITR.TPIMP = 'S' and ITR.ESTORIG = FIL.ESTADO and ITR.ESTDEST = FIL.ESTADO and ITR.CODIMP = PRO.CODICMSUB and ITR.CODGRPTPNOTA = TPN.CODGRPTPNOTA and TPN.TPNOTA = case when isnull(FIL.TPNFVDDEFECF,0) = 0 then 51 else FIL.TPNFVDDEFECF end and ITR.CTF = TRI.CTF)                                                              else case when isnull(PRO.CODICMRED,0) > 0
                                                                        then case when isnull((select TRI.FATIPI from CAD_IMPTRIBUT ITR, CAD_TPNOTA TPN, CAD_TRIBUT TRI where ITR.TPIMP = 'R' and ITR.ESTORIG = FIL.ESTADO and ITR.ESTDEST = FIL.ESTADO and ITR.CODIMP = PRO.CODICMRED and ITR.CODGRPTPNOTA = TPN.CODGRPTPNOTA and TPN.TPNOTA = case when isnull(FIL.TPNFVDDEFECF,0) = 0 then 51 else FIL.TPNFVDDEFECF end and ITR.CTF = TRI.CTF and TRI.FATICMRED > 0),0) > 0
                                                                                  then (select TRI.FATIPI from CAD_IMPTRIBUT ITR, CAD_TPNOTA TPN, CAD_TRIBUT TRI where ITR.TPIMP = 'R' and ITR.ESTORIG = FIL.ESTADO and ITR.ESTDEST = FIL.ESTADO and ITR.CODIMP = PRO.CODICMRED and ITR.CODGRPTPNOTA = TPN.CODGRPTPNOTA and TPN.TPNOTA = case when isnull(FIL.TPNFVDDEFECF,0) = 0 then 51 else FIL.TPNFVDDEFECF end and ITR.CTF = TRI.CTF and TRI.FATICMRED > 0)
                                                                                  else case when isnull((select TRI.FATIPI from CAD_IMPTRIBUT ITR, CAD_TPNOTA TPN, CAD_TRIBUT TRI where ITR.TPIMP = 'I' and ITR.ESTORIG = FIL.ESTADO and ITR.ESTDEST = FIL.ESTADO and ITR.CODIMP = PRO.CODICMS and ITR.CODGRPTPNOTA = TPN.CODGRPTPNOTA and TPN.TPNOTA = case when isnull(FIL.TPNFVDDEFECF,0) = 0 then 51 else FIL.TPNFVDDEFECF end and ITR.CTF = TRI.CTF and TRI.FATICM > 0),0) > 0                                                                                            then (select TRI.FATIPI from CAD_IMPTRIBUT ITR, CAD_TPNOTA TPN, CAD_TRIBUT TRI where ITR.TPIMP = 'I' and ITR.ESTORIG = FIL.ESTADO and ITR.ESTDEST = FIL.ESTADO and ITR.CODIMP = PRO.CODICMS and ITR.CODGRPTPNOTA = TPN.CODGRPTPNOTA and TPN.TPNOTA = case when isnull(FIL.TPNFVDDEFECF,0) = 0 then 51 else FIL.TPNFVDDEFECF end and ITR.CTF = TRI.CTF and TRI.FATICM > 0)
                                                                                            else (select TRI.FATIPI from CAD_IMPTRIBUT ITR, CAD_TPNOTA TPN, CAD_TRIBUT TRI where ITR.TPIMP = 'S' and ITR.ESTORIG = FIL.ESTADO and ITR.ESTDEST = FIL.ESTADO and ITR.CODIMP = PRO.CODICMSUB and ITR.CODGRPTPNOTA = TPN.CODGRPTPNOTA and TPN.TPNOTA = case when isnull(FIL.TPNFVDDEFECF,0) = 0 then 51 else FIL.TPNFVDDEFECF end and ITR.CTF = TRI.CTF and TRI.FATICMSUB = 0)
                                                                                      end
                                                                             end
                                                                        else case when isnull((select TRI.FATIPI from CAD_IMPTRIBUT ITR, CAD_TPNOTA TPN, CAD_TRIBUT TRI where ITR.TPIMP = 'I' and ITR.ESTORIG = FIL.ESTADO and ITR.ESTDEST = FIL.ESTADO and ITR.CODIMP = PRO.CODICMS and ITR.CODGRPTPNOTA = TPN.CODGRPTPNOTA and TPN.TPNOTA = case when isnull(FIL.TPNFVDDEFECF,0) = 0 then 51 else FIL.TPNFVDDEFECF end and ITR.CTF = TRI.CTF and TRI.FATICM > 0),0) > 0
                                                                                  then (select TRI.FATIPI from CAD_IMPTRIBUT ITR, CAD_TPNOTA TPN, CAD_TRIBUT TRI where ITR.TPIMP = 'I' and ITR.ESTORIG = FIL.ESTADO and ITR.ESTDEST = FIL.ESTADO and ITR.CODIMP = PRO.CODICMS and ITR.CODGRPTPNOTA = TPN.CODGRPTPNOTA and TPN.TPNOTA = case when isnull(FIL.TPNFVDDEFECF,0) = 0 then 51 else FIL.TPNFVDDEFECF end and ITR.CTF = TRI.CTF and TRI.FATICM > 0)
                                                                                  else (select TRI.FATIPI from CAD_IMPTRIBUT ITR, CAD_TPNOTA TPN, CAD_TRIBUT TRI where ITR.TPIMP = 'S' and ITR.ESTORIG = FIL.ESTADO and ITR.ESTDEST = FIL.ESTADO and ITR.CODIMP = PRO.CODICMSUB and ITR.CODGRPTPNOTA = TPN.CODGRPTPNOTA and TPN.TPNOTA = case when isnull(FIL.TPNFVDDEFECF,0) = 0 then 51 else FIL.TPNFVDDEFECF end and ITR.CTF = TRI.CTF and TRI.FATICMSUB = 0)
                                                                             end
                                                                   end
                                                         end
                                               end
                                          else case when isnull(PRO.CODICMRED,0) > 0
                                                    then case when isnull((select TRI.FATIPI from CAD_IMPTRIBUT ITR, CAD_TPNOTA TPN, CAD_TRIBUT TRI where ITR.TPIMP = 'R' and ITR.ESTORIG = FIL.ESTADO and ITR.ESTDEST = FIL.ESTADO and ITR.CODIMP = PRO.CODICMRED and ITR.CODGRPTPNOTA = TPN.CODGRPTPNOTA and TPN.TPNOTA = case when isnull(FIL.TPNFVDDEFECF,0) = 0 then 51 else FIL.TPNFVDDEFECF end and ITR.CTF = TRI.CTF and TRI.FATICMRED > 0),0) > 0
                                                              then (select TRI.FATIPI from CAD_IMPTRIBUT ITR, CAD_TPNOTA TPN, CAD_TRIBUT TRI where ITR.TPIMP = 'R' and ITR.ESTORIG = FIL.ESTADO and ITR.ESTDEST = FIL.ESTADO and ITR.CODIMP = PRO.CODICMRED and ITR.CODGRPTPNOTA = TPN.CODGRPTPNOTA and TPN.TPNOTA = case when isnull(FIL.TPNFVDDEFECF,0) = 0 then 51 else FIL.TPNFVDDEFECF end and ITR.CTF = TRI.CTF and TRI.FATICMRED > 0)
                                                              else case when isnull((select TRI.FATIPI from CAD_IMPTRIBUT ITR, CAD_TPNOTA TPN, CAD_TRIBUT TRI where ITR.TPIMP = 'I' and ITR.ESTORIG = FIL.ESTADO and ITR.ESTDEST = FIL.ESTADO and ITR.CODIMP = PRO.CODICMS and ITR.CODGRPTPNOTA = TPN.CODGRPTPNOTA and TPN.TPNOTA = case when isnull(FIL.TPNFVDDEFECF,0) = 0 then 51 else FIL.TPNFVDDEFECF end and ITR.CTF = TRI.CTF and TRI.FATICM > 0),0) > 0
                                                                        then (select TRI.FATIPI from CAD_IMPTRIBUT ITR, CAD_TPNOTA TPN, CAD_TRIBUT TRI where ITR.TPIMP = 'I' and ITR.ESTORIG = FIL.ESTADO and ITR.ESTDEST = FIL.ESTADO and ITR.CODIMP = PRO.CODICMS and ITR.CODGRPTPNOTA = TPN.CODGRPTPNOTA and TPN.TPNOTA = case when isnull(FIL.TPNFVDDEFECF,0) = 0 then 51 else FIL.TPNFVDDEFECF end and ITR.CTF = TRI.CTF and TRI.FATICM > 0)
                                                                        else (select TRI.FATIPI from CAD_IMPTRIBUT ITR, CAD_TPNOTA TPN, CAD_TRIBUT TRI where ITR.TPIMP = 'R' and ITR.ESTORIG = FIL.ESTADO and ITR.ESTDEST = FIL.ESTADO and ITR.CODIMP = PRO.CODICMRED and ITR.CODGRPTPNOTA = TPN.CODGRPTPNOTA and TPN.TPNOTA = case when isnull(FIL.TPNFVDDEFECF,0) = 0 then 51 else FIL.TPNFVDDEFECF end and ITR.CTF = TRI.CTF and TRI.FATICMRED = 0)
                                                                   end 
                                                         end
                                                    else (select TRI.FATIPI from CAD_IMPTRIBUT ITR, CAD_TPNOTA TPN,CAD_TRIBUT TRI where ITR.TPIMP= 'I' and ITR.ESTORIG = FIL.ESTADO and ITR.ESTDEST = FIL.ESTADO and ITR.CODIMP = PRO.CODICMS and ITR.CODGRPTPNOTA = TPN.CODGRPTPNOTA and ITR.CTF = TRI.CTF and TPN.TPNOTA = case when isnull(FIL.TPNFVDDEFECF,0) = 0 then 51 else FIL.TPNFVDDEFECF end)
                                               end
                                     end
                           end
                      else TBT.FATIPI
                 end
            else TBT.FATIPI
       end FATIPI, PRO.FLPADRAOIRRIGACAO,
       (select FIS.CSTBASE from FIS_CSTPISCOFINS FIS where PRO.CODCSTCOFINSSAI = FIS.CODCST AND FIS.FLMOVIMENTO = 'S') as CSTCOFINS, 
       (select FIS.CSTBASE from FIS_CSTPISCOFINS FIS where PRO.CODCSTPISSAI = FIS.CODCST AND FIS.FLMOVIMENTO = 'S') as CSTPIS,
       PRO.PPIS, PRO.PCONTSOC,
       CASE WHEN ISNULL(ORI.ORIGEM, PRO.ORIGEM) IN (0, 4) THEN IBPT.ALIQNAC ELSE IBPT.ALIQIMP END ALIQIBPT,
       IBPT.VERSAO, MTAB.QTATACAREJO, MTAB.PRECOATACAREJO, PRO.FLIPIPRODIMP,
       IBPT.ALIQEST, IBPTMUN.ALIQMUN, IBPT.CHAVE, IBPT.FONTE 
  FROM CAD_ITPROD ITP
	INNER JOIN CAD_PROD PRO ON (PRO.CODPROD = ITP.CODPROD)
	INNER JOIN CAD_PRECO PRE ON (PRE.CODITPROD = ITP.CODITPROD )
	INNER JOIN CAD_FILIAL FIL ON (FIL.CODFIL = PRE.CODFIL)
	INNER JOIN GER_EMPRESA EMP ON EMP.CHAVE = 1
	INNER JOIN CAD_COR COR ON (COR.CODCOR = ITP.CODCOR)
	INNER JOIN CAD_ESPEC ESP ON (ESP.ESPECIFIC = ITP.ESPECIFIC AND ESP.CODFAM = ITP.CODFAM)
	INNER JOIN CAD_SITPRO SIT ON (PRE.CODSITPROD = SIT.CODSITPROD)
	INNER JOIN CAD_EMBAL EMB ON (PRE.CODEMBAL = EMB.CODEMBAL AND EMB.CODPROD = PRO.CODPROD)
	INNER JOIN CAD_FILIAL_COMPL COM ON (FIL.CODFIL = COM.CODFIL)
	INNER JOIN CAD_TRIBUT TBT ON (PRO.CTF = TBT.CTF)
	INNER JOIN USUARIOBD_CODFIL UC ON (UC.USUARIO = SYSTEM_USER AND PRE.CODFIL = UC.CODFIL)	LEFT JOIN CAD_PROD_ORIGEM ORI ON (ORI.CODPROD = PRO.CODPROD AND ORI.CODFIL = UC.CODFIL)
	LEFT JOIN CAD_MANUTTABPRECO MTAB ON (MTAB.CODFIL = FIL.CODFIL AND MTAB.CODITPROD = ITP.CODITPROD AND MTAB.CODEMBAL = PRE.CODEMBAL)
	LEFT JOIN FIS_TABIBPT IBPT    ON (IBPT.UF = FIL.ESTADO AND IBPT.CODIGO = PRO.NCM AND IBPT.TABELA=0 AND IBPT.DTINICIO <= GETDATE() AND IBPT.DTFIM >= GETDATE())
	LEFT JOIN FIS_TABIBPT IBPTMUN ON (IBPTMUN.UF = FIL.ESTADO AND IBPTMUN.CODIGO = PRO.NBS AND IBPTMUN.TABELA = 1 AND IBPTMUN.DTINICIO <= GETDATE() AND IBPTMUN.DTFIM >= GETDATE())
  WHERE SIT.FLVENDA = 'S'
         AND (EMB.TPEMB = 'T' OR EMB.TPEMB = 'V')
         AND EMB.STATUS <> 9 
   
go
grant select on PRODUTOS to PUBLIC
go


