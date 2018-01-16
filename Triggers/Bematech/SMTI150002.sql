PRINT ' '
PRINT ' '
PRINT ' '
PRINT ' -- **************************************'
PRINT ' -- **            SMTI150002.sql ' 
PRINT ' -- **************************************'


 -- Atualiza tabela de controle de scripts executados
insert into gemco_scripts_executados (script, dthrexecucao) select 'SMTI150002.sql', getdate()
go

set ansi_nulls off
go
set quoted_identifier off
go

IF EXISTS(SELECT * FROM SYSOBJECTS WHERE NAME = 'ITENS_NF_SAIDA_TR_INS')
   DROP trigger DBO.ITENS_NF_SAIDA_TR_INS
GO
 
create trigger [DBO].[ITENS_NF_SAIDA_TR_INS]
on [DBO].[ITENS_NF_SAIDA]
for insert  
as      
    
--*****************************************************************************    
--* Ago 02, 2005 - Patricia Bernini - D008372 - Versao 52 - Grava coluna      *    
--*   PRECOLISTA na MOV_ITSAIDA (Marcelo Jose).                               *    
--* Ago 30, 2005 - Patricia Bernini - D008477 - Versao 53 - Grava a coluna    *    
--*   NUMGARANTIA na MOV_ITSAIDA (Marcelo Jose).                              *    
--* Set 09, 2005 - Patricia Bernini - D008515 - Versao 54 - Altera tamanho das*    
--*  colunas VLBASEICMSSUBF,VLICMRETF,VLBASEICMSF,VLICMF,VLISENTOF,VLNTRIBUTF,*    
--*  VLOUTRASF N(20,9). (Shozo).                                              *    
--* Out 14, 2005 - Cristina Co - D008598 - Versao 55 - Acerto dos calculos de *    
--*  impostos para ITEM > 2. (Shozo).                                         *    
--* Dez 21, 2005 - Cristina Co - D008674 - Versao 56 - Acerto dos calculos de *    
--*  impostos para ITEM > 2. (Shozo).                                         *    
--* Jan 04, 2006 - Cristina Co - D008686 - Versao 57 - Truncar calculo da co- *    
--*  luna VLOUTRAS da MOV_ITSAIDA e MOV_SAIDA. (FCampos).                     *    
--* Jan 27, 2006 - Patricia Bernini -                - Grava a coluna VLTAC   *    
--*  (Marcelo Jose).                                                          *    
--* Jul 28, 2006 - Cristina Co - D009156 - Versao 58 - Acertar baixa estoque, *    
--*  verificando FLESTDIR da CAD_TPNOTA. (AVasconcelos).                      *    
--* Ago 28, 2006 - Cristina Co - D009221 - Versao 59 - Tratamento para NF ele-*    
--*  tronica. Se DIFER = 8 e CAD_FILIAL_COMPL.FLNFESERVICOS = 'S', gravar as  *    
--*  colunas CODPRESTSERV, ALIQISS e DESCPRESTSERV na MOV_ITSAIDA. (MJose).   *    
--* Set 22, 2006 - Cristina Co -         - Versao 60 - Acerto dos calculos de *    
--*  impostos para ITEM > 2. (Shozo).                                         *    
--* Out 19, 2006 - Patricia Bernini - D009309 - Versao 61 - Grava a  coluna   *    
--*  VLDESCPROM. (FCampos).                                                   *    
--* Nov 10, 2006 - Patricia Bernini - D009335 - Versao 62 - Grava a coluna    *    
--*  VLDESCNOTA. (GLabone).                                                   *    
--* Nov 20, 2006 - Patricia Bernini -                     - Inclui CUSTOGER na*    
--*  chamada da proc ECF_CALCCUSTO, grava coluna MOV_ITSAIDA.CUSTOGER.(MRamos)*    
--* Dez 07, 2006 - Patricia Bernini - D009360 - Versao 63 - Reliberacao.      *
--* Mai 23, 2007 - Patricia Bernini - D009481 - Versao 64 - Atualiza RESFIS   *
--*  quando DIFER = 5 e FLESTDIR = N.(GSuzuki).                               *
--* Jan 07, 2008 - Eduardo Moratto - Acrescentado gravaþÒo do NUMCCF          *
--* Jan 15, 2009 - ADEMIR_JB(SA_IMPL_876_0)-Acrescentado gravaþÒo do NUMDAV   *  
--* Fev 06, 2009 - JosÚ Altair(SA_IMPL_729_14)-Acrescentado gravaþÒo do       *
--*    CODTOTPARCIMPR                                                         *  
--* Jun 25, 2009 - Anderson Vieira (SA_IMPL_2230_0)- Corrigindo a gravaþÒo dos*
--*   Itens da nota fiscal                                                    *
--* Jul,30,2009 - Carlos Colenetz - SA_IMPL_1424_0 - ImplementaþÒo da Verifi- *
--* caþÒo da FLAG FLESTDIR da tabela CAD_TPNOTA.    			      *
--* Nov 25, 2009 - Everson Karl Viebrantz - SA_IMPL_3308_0 - Truncar cßlculo  *
--*  da coluna VLICM da MOV_ITSAIDA e MOV_SAIDA. VersÒo 71.                   *
--* Out 27, 2010 - Jefferson Riva Ralo - Versao 72 - Reliberacao.             *
--* Jun 21, 2011 - Felipe Lernic - Versao 73 - Oc. 126146    		      *
--* Jun 11, 2012 - Vivian Martins -Oc. 131328 -Atualiza MOV_ITSAIDA.FLPREINDIG*
--* Jun 26, 2012 - Vivian Martins - Oc. 122055 ticket #3111 (Roberto Cesar)   *
--* Gravar na tabela MOV_ITSAIDA os campos VLTOTBASEIPI,VLTOTIPI, VLBASEIPI   * 
--* Jul 24, 2012 - Vivian Martins - Oc. 130433 ticket #2531 (Roberto Cesar)   *
--* AlteraþÒo do cßlculo do campo VLTOTAL da tabela MOV_ITSAIDA               *
-- * 01/10/12 -  JMIGUEL - GERAR MOV. EXTRATO DE PRODUTO                      *
--* MAR 11,2013 - PFERNANDES - oc. 134924 - ALTERACOES PARA O SAT             *
--*               acrescentar a CFOP                                          *
--* ABR 01,2013 - PFERNANDES - oc. 135650 - ALTERACOES PARA O SAT             *
--*               acrescentar CSTPIS, PPIS, CSTCOFINS, PCONTSOC               *
--* JUL 10,2014 - PFERNANDES - oc. 147530 #8095 - VLIOFSEG, ITPEDITEM	      *
--* DEZ 17, 2014 -Yuri Vasconcelos  INCLUSÃO CODAUTDESCPDV		      *
--*****************************************************************************
    
set transaction isolation level read uncommitted    
set nocount on    
declare @STPNOTA numeric(3)    
declare @SNUMNOTA numeric(6)    
declare @SDTNOTA datetime     
declare @SSERIE varchar(3)    
declare @SCODPROD numeric(10)    
declare @SITEM numeric(4)    
declare @SQTCOMP numeric(9,3)    
declare @SPRECOUNIT numeric(15,2)    
declare @SALIQICM numeric(4,2)    
declare @SALIQICMSUB numeric(7,4)    
declare @SALIQICMRED numeric(7,4)    
declare @SVLIPI numeric(15,4)    
declare @SPORCIPI numeric(4,2)    
declare @SCODEMBAL numeric(1,0)    
declare @SDPI numeric(11,9)    
declare @SDESCCOMPLE varchar(36)    
declare @SSTATUS numeric(1,0)    
declare @SNUMPEDVEN numeric(12)    
declare @SCODCLI numeric(15)    
declare @SPRECJUR numeric(15,2)    
declare @SQTDEVOL numeric(9,3)    
declare @SPRECOUNITLIQ numeric(15,2)    
declare @SVLSUPINF numeric(8,2)    
declare @SCMUP numeric(15,4)    
declare @SMEDGER numeric(15,4)    
declare @SHRHORA datetime    
declare @SCODSITPROD char(2)    
declare @SALIQICMSUBUF numeric(7,4)    
declare @SQTESTOQUE numeric(9,3)    
declare @SVLDESCITEM numeric(15,5)    
declare @SVLDESCITEMRAT numeric(15,5)    
declare @SCODPROM numeric(6,0)    
declare @SQTEMB numeric(4,0)    
declare @SVLBASEICMSF numeric(20,9)    
declare @SVLISENTOF numeric(20,9)    
declare @SVLNTRIBUTF numeric(20,9)    
declare @SVLOUTRASF numeric(20,9)    
declare @SVLICMF numeric(20,9)    
declare @SVLBASEICMSSUBF numeric(20,9)    
declare @SVLICMRETF numeric(20,9)    
declare @SVLDESPACES numeric(15,4)    
declare @SVLOUTDESP numeric(15,4)    
declare @SCODITPRODKIT numeric(10)    
declare @SCODVENDR numeric(10)    
declare @SNUMRECEITA varchar(12)    
declare @SDTRECEITA datetime    
declare @SCODPRESCRITOR numeric(15,0)    
declare @SQTPRESCRITA numeric(9,3)    
declare @SVLISS numeric(15,2)    
declare @STPPRESCRITOR numeric(1,0)    
declare @SUNIDADE varchar(2)    
declare @SCTF numeric(2,0)    
declare @SFILPED numeric(3)    
declare @SFILORIG numeric(3)    
declare @SVLMONTAGEM numeric(15,2)    
declare @SCODDESPMONTAG numeric(3)    
declare @SFILIAL numeric(5)    
declare @SVLTOTITEM numeric(15,2)    
declare @SFLBUSCATRIBUT char(1)    
declare @SVLFRETERAT numeric(15,4)    
declare @SVLSEGURO numeric(17,7)    
declare @SVLDESPFIN numeric(17,7)    
declare @SVLTOTIPI numeric(17,2)    
declare @SPRECOORIG numeric(17,4)    
declare @SCODJUST char(2)    
declare @STIPOPED numeric(1)    
declare @SITPEDITEM numeric(4)    
declare @SCONVERSAO numeric(11,6)    
declare @SQTVENDAKIT numeric(9,3)    
declare @SVLFRETE numeric(17,4)    
declare @SVLDESCFRETE numeric(17,4)    
declare @SVLBASEICMORIGREPI numeric(15,2)    
declare @SVLICMORIGREPI numeric(15,2)    
declare @SVLICMREPI numeric(15,2)    
declare @SCRM numeric(15)    
declare @SPRECOLISTA numeric(17,4)    
declare @SNUMGARANTIA numeric(10)    
declare @SVLTAC numeric(15,2)    
declare @SVLDESCPROM numeric(15,2)    
declare @SVLDESCNOTA numeric(15,2)    
declare @SNUMCCF numeric(6)    
declare @SNUMDAV numeric(13,0) 
declare @SCODTOTPARCIMPR varchar(8)   
declare @CODBARRA numeric(14)     
declare @DLOCAL numeric(2)    
declare @DTPDEPOS char(1)    
declare @PCUBAGEM numeric(8,4)    
declare @PFLNATOPDIF char(1)    
declare @LRUA varchar(3)    
declare @LAPTO varchar(3)    
declare @LBLOCO numeric(3)    
declare @TNATOP numeric(3)    
declare @TNATOPCOMPL numeric(2)    
declare @TNATOPDIF numeric(3)    
declare @TNATOPDIFCOMPL numeric(2)    
declare @TFLESTDIR char(1)        
declare @PPESOUNIT numeric(7,3)    
declare @PPESOLIQ numeric(7,3)    
declare @PPPIS numeric(4,2)    
declare @PPCONTSOC numeric(4,2)    
declare @PCODPROD numeric(10)    
declare @PESPECIAL char(1)    
declare @PFLBASEICMSBRUTA char(1)    
declare @PFLIPI char(1)    
declare @PDIFER numeric(1)    
declare @PFLESTDIR char(1)    
declare @PSTATUS numeric(1)        
declare @EQTEMB numeric(4)        
declare @HCMUPI numeric(15,4)    
declare @HCUE numeric(15,4)    
declare @HCODNATOP numeric(3)    
declare @HCODNATOPCOMPL numeric(2)    
declare @HCODNATOPDIF numeric(3)    
declare @HCODNATOPDIFCOMPL numeric(2)    
declare @HVLTOTITEM numeric(15,2)    
declare @HITEM numeric(5)    
declare @HCODFIL numeric(5)    
declare @HONLINE char(1)    
declare @HVLICMSFRETE numeric(15,4)    
declare @HVLBASEICMS numeric(15,2)    
declare @HFILIAL numeric(5)    
declare @HQTEMBMENOR numeric(4)    
declare @HCODEMBALMENOR numeric(1)    
declare @HQTDEINSU numeric(9,3)    
declare @HCONVERSAO numeric(11,6)    
declare @HPADM numeric(5,2)    
declare @HCUSTOGER numeric(15,4)    
declare @HELPCMUP numeric(15,4)    
declare @HELPMEDGER numeric(15,4)    
declare @HELPCMUPI numeric(15,4)    
declare @HELPCUE numeric(15,4)     
declare @SVLJUROS numeric(15,2)    
declare @SVLJUROSFIN numeric(15,2)    
declare @VCODITPRODPRINC numeric(10)    
declare @GFLFATPARCIAL char(1)    
declare @GFLCONVERSAOSAIDA char(1)    
declare @GFLKITPRECODIF char(1)    
declare @FFLENDERALEATORIO char(1)    
declare @SFLMULTIREC char(1)    
declare @FFLNFESERVICOS char(1)    
declare @PIISS numeric(6,4)    
declare @PICODPRESTSERV numeric(5)    
declare @PIDESCPRESTSERV varchar(50)
--declare @HVERSAOPDV varchar(6) -- SA_IMPL_2230_0 - Anderson Vieira - 25/06/2009 --pfernandes 145778
declare @SNLOTE numeric(6) --p.fdantas - OC. 125816
declare @SVLBASEISS numeric(15,2) --Roberto Cesar - 128579
declare @FLPREINDIG char(1)
declare @VLTOTBASEIPI numeric(17,4)
declare @VLTOTIPI numeric(15,2)
declare @VLBASEIPI numeric(15,2)
declare @SFLGERAEXTRATOPROD CHAR(1), @SFLERRO char(1), @SCAMPOS varchar(30) --#3462 
declare @NFISICO numeric(9,3), @NRESFIS numeric(9,3), @NFISICOPOS numeric(9,3), @NRESFISPOS numeric(9,3) --#3462 
--Roberto Cesar - 135549 - InÝcio
declare @PVLJUROSFIN numeric(15,2)
declare @PVLJUROS numeric(15,2)
declare @PVLTOTAL numeric(15,2)
declare @PPROPORCIONALITEM numeric(17,4)
--Roberto Cesar - 135549 - Fim
declare @CFOP numeric(4) --oc.134924
--pfernandes - oc. 135650 - inicio
declare @CSTPIS varchar(2)
declare @PPIS numeric(6,4)
declare @CSTCOFINS varchar(2)
declare @PCONTSOC numeric(6,4)
--pfernandes - oc. 135650 - fim
--Roberto Cesar - 139349 - InÝcio
declare @ALIQIBPT numeric(4,2)
declare @VLIBPT numeric(15,2)
declare @VERSAOIBPT varchar(30)
--Roberto Cesar - 139349 - Fim
--PFERNANDES - oc. 147530 #8095 - inicio
declare @VLIOFSEG numeric(15,2) 
declare @ITPEDITEM numeric(4)
--PFERNANDES - oc. 147530 #8095 - fim
declare @CODAUTDESCPDV numeric(5) --Yuri Vasconcelos - 3612

declare SMART cursor static for    
    select TPNOTA,NUMNOTA,DTNOTA,SERIE,CODPROD,ITEM,QTCOMP,PRECOUNIT,ALIQICM,    
           ALIQICMSUB,ALIQICMRED,VLIPI,PORCIPI,CODEMBAL,DPI,DESCCOMPLE,STATUS,    
           NUMPEDVEN,CODCLI,PRECJUR,QTDEVOL,PRECOUNITLIQ,VLSUPINF,CMUP,MEDGER,    
           HRHORA,CODSITPROD,ALIQICMSUBUF,QTESTOQUE,VLDESCITEM,VLDESCITEMRAT,CODPROM,   
           QTEMB,VLBASEICMSF,VLISENTOF,VLNTRIBUTF,VLOUTRASF,VLICMF,VLBASEICMSSUBF,    
           VLICMRETF,VLDESPACES,VLOUTDESP,CODITPRODKIT,CODVENDR,VLISS,CTF,    
           FILPED,FILORIG,VLMONTAGEM,CODDESPMONTAG,FILIAL,VLTOTITEM,FLBUSCATRIBUT,    
           VLFRETERAT,VLSEGURO,VLOUTDESP,VLDESPFIN,VLJUROS,VLJUROSFIN,PRECOORIG,    
           CODJUST,TIPOPED,ITPEDITEM, CONVERSAO,QTVENDAKIT,VLFRETE,VLDESCFRETE,    
           VLBASEICMORIGREPI, VLICMORIGREPI, VLICMREPI, CRM,PRECOLISTA,NUMGARANTIA,    
           VLTAC,VLDESCPROM,VLDESCNOTA, NUMCCF,NUMDAV,CODTOTPARCIMPR,
           NLOTE,VLBASEISS,CODBARRA,FLPREINDIG,VLTOTBASEIPI,VLTOTIPI,VLBASEIPI,
           CFOP,CSTPIS,PPIS,CSTCOFINS,PCONTSOC, ALIQIBPT, VLIBPT, VERSAOIBPT,
           VLIOFSEG, ITPEDITEM, CODAUTDESCPDV
      from INSERTED    
    
select @HCODFIL = UC.CODFIL    
  from USUARIOBD_CODFIL UC    
 where 1 = 1    
   and UC.USUARIO = SYSTEM_USER    
    
select @HONLINE = FLONLINE     
  from GEMCO    
    
select @GFLFATPARCIAL = isnull(FLFATPARCIAL,'N'),    
       @GFLCONVERSAOSAIDA = isnull(FLCONVERSAOSAIDA,'N'),    
       @GFLKITPRECODIF = isnull(FLKITPRECODIF,'N')    
  from GER_EMPRESA_COMPL    
 where 1 = 1    
   and CHAVE = 1    
    
open SMART    
fetch SMART into @STPNOTA,@SNUMNOTA,@SDTNOTA,@SSERIE,@SCODPROD,@SITEM,@SQTCOMP,@SPRECOUNIT,@SALIQICM,    
                 @SALIQICMSUB,@SALIQICMRED,@SVLIPI,@SPORCIPI,@SCODEMBAL,@SDPI,@SDESCCOMPLE,@SSTATUS,    
                 @SNUMPEDVEN,@SCODCLI,@SPRECJUR,@SQTDEVOL,@SPRECOUNITLIQ,@SVLSUPINF,@SCMUP,@SMEDGER,    
                 @SHRHORA,@SCODSITPROD,@SALIQICMSUBUF,@SQTESTOQUE,@SVLDESCITEM,@SVLDESCITEMRAT,@SCODPROM,    
                 @SQTEMB,@SVLBASEICMSF,@SVLISENTOF,@SVLNTRIBUTF,@SVLOUTRASF,@SVLICMF,@SVLBASEICMSSUBF,    
                 @SVLICMRETF,@SVLDESPACES,@SVLOUTDESP,@SCODITPRODKIT,@SCODVENDR,@SVLISS,@SCTF,    
                 @SFILPED,@SFILORIG,@SVLMONTAGEM,@SCODDESPMONTAG,@SFILIAL,@SVLTOTITEM,@SFLBUSCATRIBUT,    
                 @SVLFRETERAT,@SVLSEGURO,@SVLOUTDESP,@SVLDESPFIN,@SVLJUROS,@SVLJUROSFIN,@SPRECOORIG,    
                 @SCODJUST,@STIPOPED,@SITPEDITEM,@SCONVERSAO,@SQTVENDAKIT,@SVLFRETE,@SVLDESCFRETE,    
                 @SVLBASEICMORIGREPI, @SVLICMORIGREPI, @SVLICMREPI, @SCRM, @SPRECOLISTA,@SNUMGARANTIA,    
                 @SVLTAC,@SVLDESCPROM,@SVLDESCNOTA,@SNUMCCF,@SNUMDAV,@SCODTOTPARCIMPR,    
                 @SNLOTE,@SVLBASEISS,@CODBARRA,@FLPREINDIG,@VLTOTBASEIPI,@VLTOTIPI,@VLBASEIPI, 
                 @CFOP,@CSTPIS,@PPIS,@CSTCOFINS,@PCONTSOC,
                 @ALIQIBPT, @VLIBPT, @VERSAOIBPT, @VLIOFSEG, @ITPEDITEM, @CODAUTDESCPDV
while (@@FETCH_STATUS <> -1)    
begin    
    -- SA_IMPL_2230_0 - Anderson Vieira - 25/06/2009 - Inicio
    --pfernandes - 145778 - retirada essa validação, pois o SAT e NFCE não possuem NUMCCF
    -- if @SNUMCCF is not null 
    --  select @HVERSAOPDV = '30'
        
    select @GFLKITPRECODIF = 'S' -- forca gravar sempre item a item na MOV_ITSAIDA, sem agrupar por CODITPROD, em qualquer situacao
    -- SA_IMPL_2230_0 - Anderson Vieira - 25/06/2009 - Final
    if isnull(@HONLINE,'S') = 'S'    
    begin    
        if @GFLCONVERSAOSAIDA = 'S'    
            set @HCONVERSAO = isnull(@SCONVERSAO,isnull(@SQTEMB,1))    
        else    
            set @HCONVERSAO = isnull(@SQTEMB,1)    

        select @DLOCAL = COM.LOCAL, @DTPDEPOS = COM.TPDEPOS, @FFLENDERALEATORIO = isnull(FIL.FLENDERALEATORIO,'N'),    
               @FFLNFESERVICOS = COM.FLNFESERVICOS, @PIISS = FIL.ISS, @SFLGERAEXTRATOPROD = isnull(COM.FLGERAEXTRATOPROD,'N')
          from CAD_FILIAL_COMPL COM, CAD_FILIAL FIL    
         where 1 = 1    
           and FIL.CODFIL = COM.CODFIL    
           and FIL.CODFIL = isnull(@SFILIAL,@HCODFIL)    
        select @PCUBAGEM = case when (isnull((PRO.ALTURA * PRO.LARGURA * PRO.COMP)/1000000,0)) > 9999.9999 then 9999.9999 else isnull((PRO.ALTURA * PRO.LARGURA * PRO.COMP)/1000000,0) end,    
               @PFLNATOPDIF = PRO.FLNATOPDIF,    
               @PPPIS = PRO.PPIS,    
               @PPCONTSOC = PRO.PCONTSOC,    
               @PCODPROD = PRO.CODPROD,    
               @PPESOUNIT = PRO.PESOUNIT,    
               @PPESOLIQ = PRO.PESOLIQ,    
               @PESPECIAL = PRO.ESPECIAL,    
               @PFLBASEICMSBRUTA = PRO.FLBASEICMSBRUTA,    
               @PFLIPI = PRO.FLIPI,    
               @PDIFER = PRO.DIFER,    
               @PFLESTDIR = isnull(PRO.FLESTDIR,'S'),    
               @PSTATUS = PRO.STATUS    
          from CAD_PROD PRO, CAD_ITPROD ITP    
         where ITP.CODPROD = PRO.CODPROD    
           and ITP.CODITPROD = @SCODPROD    
     
        select @LRUA = LOC.RUA, @LAPTO = LOC.APTO, @LBLOCO = LOC.BLOCO    
          from CAD_PRODLOC LOC    
         where 1 = 1    
           and LOC.CODFIL = isnull(@SFILIAL,@HCODFIL)    
           and LOC.TPDEPOS = @DTPDEPOS    
           and LOC.CODITPROD = @SCODPROD    
     
        select @TNATOP = TPN.NATOP,    
               @TNATOPCOMPL = TPN.NATOPCOMPL,    
               @TNATOPDIF = TPN.NATOPDIF,    
               @TNATOPDIFCOMPL = TPN.NATOPDIFCOMPL,    
               @TFLESTDIR = TPN.FLESTDIR    
          from CAD_TPNOTA TPN    
         where 1 = 1    
           and TPNOTA = @STPNOTA    

        -- Para Parametros    
        select @HFILIAL = isnull(@SFILIAL,@HCODFIL)    
        --- GNET    
        if isnull(@SFLBUSCATRIBUT,'N') = 'S'    
        begin    
            -- as var sem f nao tem na itens    
            exec SP_TRIBUTGNETA @HFILIAL,@STPNOTA,@SNUMNOTA,@SSERIE,@SDTNOTA,@SCODPROD,@SCODCLI,    
                                @SVLFRETERAT,@SVLSEGURO,@SVLOUTDESP,@SVLDESPFIN,@PESPECIAL,@SVLDESCITEM,    
                                @SDPI output,@SPRECOUNIT,@SQTCOMP,@PFLBASEICMSBRUTA,@SVLSUPINF,@SVLDESCITEMRAT,    
                                @SVLTOTITEM, @SVLIPI, @SVLTOTIPI, @SALIQICMRED, @SCTF, @SALIQICM, @SALIQICMSUB,    
                                @PFLIPI,@SVLOUTRASF output, @SVLISENTOF output, @SVLBASEICMSF output,    
                                @SVLICMF output, @SVLNTRIBUTF output, @SVLBASEICMSSUBF output,    
                                @SVLICMRETF output, @SALIQICMSUBUF, @HVLICMSFRETE output, @HVLBASEICMS output    
        end    
        ---    
        select @HCODNATOP = convert(numeric,'5'+right('00'+ltrim(str(@TNATOP)),2)),    
               @HCODNATOPCOMPL = @TNATOPCOMPL,    
               @HCODNATOPDIF = case when isnull(@PFLNATOPDIF,'N') = 'S' then convert(numeric,'5'+convert(varchar,@TNATOPDIF)) else NULL end,    
               @HCODNATOPDIFCOMPL = case when isnull(@PFLNATOPDIF,'N') = 'S' then @TNATOPDIFCOMPL else null end    
     
        exec ECF_CALCCUSTO @HFILIAL,@SCODPROD, @SCMUP output, @SMEDGER output, @HCMUPI output, @HCUE output, @HPADM output, @HCUSTOGER output    
     
        if @SQTEMB is null or @SQTEMB = 0    
            select @SQTEMB = 1    

        -- NF Eletronica    
        select @PICODPRESTSERV = null, @PIDESCPRESTSERV = null--, @PIISS = null

        if @PDIFER = 8 and isnull(@FFLNFESERVICOS, 'N') = 'S'    
        begin    
            select @PICODPRESTSERV = CODPRESTSERV, @PIDESCPRESTSERV = DESCPRESTSERV--, @PIISS = ISS
              from CAD_PROD_ISS    
             where CODFIL = isnull(@SFILIAL,@HCODFIL)    
               and CODPROD = @PCODPROD    
        end    
        else    
            select @PICODPRESTSERV = null, @PIDESCPRESTSERV = null--, @PIISS = null
     
        if isnull(@SNUMPEDVEN,999999) not in (0, 999999)
            set @SCAMPOS = 'FISICO, RESFIS'
        else
            set @SCAMPOS = 'FISICO'

        if @SSTATUS <> 6
        begin
            if @PDIFER = 5 and isnull(@PFLESTDIR,'S') = 'N'    
            begin    
                declare @YCODITPROD numeric(10)    
                declare @YQTDETRANS numeric(9,3)    
                declare @YQTDEINSU numeric(9,3)    
                set @HQTDEINSU = null    
                declare TRANSFORM cursor for    
                 select CODITPRODINSU,QTDETRANS, QTDEINSU    
                   from CAD_PROD PRO, CAD_ITPROD ITP, CAD_TRANSFORMADO TRA    
                  where PRO.CODPROD = ITP.CODPROD    
                    and ITP.CODITPROD = TRA.CODITPRODINSU    
                    and TRA.CODITPRODTRANS = @SCODPROD
                    
                open TRANSFORM    
                fetch TRANSFORM into @YCODITPROD,@YQTDETRANS,@YQTDEINSU    
                while (@@FETCH_STATUS <> -1)    
                begin    
                    if @SFLGERAEXTRATOPROD = 'S' --#3462
                        select @NFISICO=FISICO, @NRESFIS=RESFIS from CAD_PRODLOC where CODFIL = isnull(@SFILIAL,@HCODFIL) and TPDEPOS = @DTPDEPOS and CODITPROD = @YCODITPROD

                    if isnull(@SNUMPEDVEN,999999) not in (0, 999999)
                        update CAD_PRODLOC with (readcommitted)
                           set FISICO = FISICO - (@YQTDEINSU / @YQTDETRANS) * (@SQTCOMP * @HCONVERSAO),
                               RESFIS = RESFIS - (@YQTDEINSU / @YQTDETRANS) * (@SQTCOMP * @HCONVERSAO)
                         where 1 = 1
                           and CODFIL = isnull(@SFILIAL,@HCODFIL)
                           and TPDEPOS = @DTPDEPOS
                           and CODITPROD = @YCODITPROD
                    else
                        update CAD_PRODLOC with (readcommitted)    
                           set FISICO = FISICO - (@YQTDEINSU / @YQTDETRANS) * (@SQTCOMP * @HCONVERSAO)    
                         where 1 = 1    
                           and CODFIL = isnull(@SFILIAL,@HCODFIL)    
                           and TPDEPOS = @DTPDEPOS    
                           and CODITPROD = @YCODITPROD    
                    
                    set @HQTDEINSU = isnull(@HQTDEINSU,0) + @YQTDEINSU
                    
                    if @SFLGERAEXTRATOPROD = 'S'  --#3462
                    begin		    		  
                        set @SFLERRO = 'N'
                        select @NFISICOPOS=FISICO, @NRESFISPOS=RESFIS from CAD_PRODLOC where CODFIL = isnull(@SFILIAL,@HCODFIL) and TPDEPOS = @DTPDEPOS and CODITPROD = @YCODITPROD
                        if @NFISICOPOS < 0 or @NRESFISPOS < 0
                            set @SFLERRO = 'S'

                        insert into MOV_EXTRATOPROD (CODFIL, NUMPED, NUMNOTA, DATAHORAID, TPNOTA, TIPOMOV, MODULO, CODITPROD , FISICO, RESFIS,
                                                    QTDEATUALIZADO, CAMPOSATUALIZADO, FLERRO, FISICOPOS, RESFISPOS, CODFILLOG, DTPROC, ROTINA, COMANDOSQL, IDENTPROC )
                        values (isnull(@SFILIAL,@HCODFIL), @SNUMPEDVEN, @SNUMNOTA, GETDATE(), @STPNOTA, 'S', 10, @YCODITPROD, @NFISICO, @NRESFIS,
                               (@YQTDEINSU / @YQTDETRANS) * (@SQTCOMP * @HCONVERSAO), @SCAMPOS, @SFLERRO, @NFISICOPOS, @NRESFISPOS, isnull(@SFILIAL,@HCODFIL),
                               @SDTNOTA, 'ITENS_NF_SAIDA_TR_INS', 'difer = 5 - transformado', 'SMART ECF')
                    end
                    
                    fetch TRANSFORM into @YCODITPROD,@YQTDETRANS,@YQTDEINSU
                    continue
                end
                close TRANSFORM    
                deallocate TRANSFORM    
            end --end do difer = 5
            else -- se nao for transformado
            begin
                if @PDIFER = -7 and @PSTATUS = 4    
                begin    
                    select @VCODITPRODPRINC = CODITPRODPRINC    
                      from CAD_ITVOLUME    
                     where 1 = 1    
                       and CODITPRODVOLUME = @SCODPROD    

                    if @SFLGERAEXTRATOPROD = 'S' --#3462
                        select @NFISICO=FISICO, @NRESFIS=RESFIS from CAD_PRODLOC where CODFIL = isnull(@SFILIAL,@HCODFIL) and TPDEPOS = @DTPDEPOS and CODITPROD = @VCODITPRODPRINC

                    update CAD_PRODLOC with (readcommitted)    
                       set FISICO = isnull(FISICO,0) - (@SQTCOMP * @HCONVERSAO)    
                     where 1 = 1    
                       and CODFIL = isnull(@SFILIAL,@HCODFIL)    
                       and TPDEPOS = @DTPDEPOS    
                       and CODITPROD = @VCODITPRODPRINC
                   
                    if @SFLGERAEXTRATOPROD = 'S'  --#3462
                    begin		    		  
                        set @SFLERRO = 'N'
                        select @NFISICOPOS=FISICO, @NRESFISPOS=RESFIS from CAD_PRODLOC where CODFIL = isnull(@SFILIAL,@HCODFIL) and TPDEPOS = @DTPDEPOS and CODITPROD = @VCODITPRODPRINC
                        if @NFISICOPOS < 0 or @NRESFISPOS < 0
                            set @SFLERRO = 'S'
                        insert into MOV_EXTRATOPROD (CODFIL, NUMPED, NUMNOTA, DATAHORAID, TPNOTA, TIPOMOV, MODULO, CODITPROD , FISICO, RESFIS
                          , QTDEATUALIZADO, CAMPOSATUALIZADO, FLERRO, FISICOPOS, RESFISPOS, CODFILLOG, DTPROC, ROTINA, COMANDOSQL, IDENTPROC )
                        values 
                        (isnull(@SFILIAL,@HCODFIL), @SNUMPEDVEN, @SNUMNOTA, GETDATE(), @STPNOTA, 'S', 10, @VCODITPRODPRINC, @NFISICO, @NRESFIS,
                        (@SQTCOMP * @HCONVERSAO), @SCAMPOS, @SFLERRO, @NFISICOPOS, @NRESFISPOS, isnull(@SFILIAL,@HCODFIL),
                         @SDTNOTA, 'ITENS_NF_SAIDA_TR_INS', 'difer -7', 'SMART ECF')
                    end     
                end    
                else -- difer normal
                    if isnull(@TFLESTDIR,'S') = 'S' and isnull(@PFLESTDIR,'S') = 'S' --OC 125876  
                    begin
                        if @SFLGERAEXTRATOPROD = 'S' --#3462
                            select @NFISICO=FISICO, @NRESFIS=RESFIS from CAD_PRODLOC where CODFIL = isnull(@SFILIAL,@HCODFIL) and TPDEPOS = @DTPDEPOS and CODITPROD = @SCODPROD

                        if isnull(@SNUMPEDVEN,999999) not in (0, 999999)
                            update CAD_PRODLOC with (readcommitted)    
                               set RESFIS = RESFIS - round((@SQTCOMP * @HCONVERSAO),3,2), --(@SQTCOMP * @HCONVERSAO),  --PFERNANDES -OC. 143584 - CAMPO DE ESTOQUE SÓ ACEITA 3 CASAS  
                                   FISICO = FISICO - round((@SQTCOMP * @HCONVERSAO),3,2) --(@SQTCOMP * @HCONVERSAO) --PFERNANDES -OC. 143584 - CAMPO DE ESTOQUE SÓ ACEITA 3 CASAS
                             where 1 = 1    
                               and CODFIL = isnull(@SFILIAL,@HCODFIL)    
                               and TPDEPOS = @DTPDEPOS    
                               and CODITPROD = @SCODPROD
                        else    
                            update CAD_PRODLOC with (readcommitted)    
                               set FISICO = FISICO - round((@SQTCOMP * @HCONVERSAO),3,2) --(@SQTCOMP * @HCONVERSAO)    --PFERNANDES -OC. 143584 - CAMPO DE ESTOQUE SÓ ACEITA 3 CASAS
                             where 1 = 1    
                               and CODFIL = isnull(@SFILIAL,@HCODFIL)    
                               and TPDEPOS = @DTPDEPOS    
                               and CODITPROD = @SCODPROD    
             
                        if @SFLGERAEXTRATOPROD = 'S'  --#3462
                        begin		    		  
                            set @SFLERRO = 'N'
                            select @NFISICOPOS=FISICO, @NRESFISPOS=RESFIS from CAD_PRODLOC where CODFIL = isnull(@SFILIAL,@HCODFIL) and TPDEPOS = @DTPDEPOS and CODITPROD = @SCODPROD
                            if @NFISICOPOS < 0 or @NRESFISPOS < 0
                                set @SFLERRO = 'S'
                            
                            insert into MOV_EXTRATOPROD (CODFIL, NUMPED, NUMNOTA, DATAHORAID, TPNOTA, TIPOMOV, MODULO, CODITPROD , FISICO, RESFIS,
                                                        QTDEATUALIZADO, CAMPOSATUALIZADO, FLERRO, FISICOPOS, RESFISPOS, CODFILLOG, DTPROC, ROTINA, COMANDOSQL, IDENTPROC )
                            values (isnull(@SFILIAL,@HCODFIL), @SNUMPEDVEN, @SNUMNOTA, GETDATE(), @STPNOTA, 'S', 10, @SCODPROD, @NFISICO, @NRESFIS,
                                   round((@SQTCOMP * @HCONVERSAO),3,2), @SCAMPOS, @SFLERRO, @NFISICOPOS, @NRESFISPOS, isnull(@SFILIAL,@HCODFIL),
                                   @SDTNOTA, 'ITENS_NF_SAIDA_TR_INS', 'difer normal', 'SMART ECF')
                        end     
                    end
            end    

            -- ESTOQUE DA CAD_ENDPROD    
            if @FFLENDERALEATORIO = 'S' and isnull(@SNUMPEDVEN,999999) not in (0, 999999)
            begin    
                declare @HPCODFIL numeric(5)    
                set @HPCODFIL = isnull(@SFILIAL,@HCODFIL)    
                exec SPU_SMARTECF_ENDPRODA @HPCODFIL,@STIPOPED,@SNUMPEDVEN,@SCODPROD    
            end    
        end --STAUTS <> 6
        
        select @SFLMULTIREC = FLMULTIREC,
               @PVLJUROS = ISNULL(VLJUROS, 0),
               @PVLJUROSFIN = ISNULL(VLJUROSFIN, 0),
               @PVLTOTAL = ISNULL(VLTOTAL, 0)
          from NF_SAIDA     
         where 1 = 1    
           and TPNOTA = @STPNOTA    
           and NUMNOTA = @SNUMNOTA    
           and SERIE = @SSERIE    
           and DTNOTA = @SDTNOTA    
           and FILIAL = isnull(@SFILIAL,@HCODFIL)    

        if @SITEM = 1 or @GFLKITPRECODIF = 'S' or isnull(@SFLMULTIREC,'N') = 'S'    
        begin    
            if @SCODCLI is null    
                select @SCODCLI = CODCLI    
                  from NF_SAIDA     
                 where 1 = 1    
                   and TPNOTA = @STPNOTA    
                   and NUMNOTA = @SNUMNOTA    
                   and SERIE = @SSERIE    
                   and DTNOTA = @SDTNOTA    
                   and FILIAL = isnull(@SFILIAL,@HCODFIL)    

            if @SCODVENDR is null    
                select @SCODVENDR = CODVENDR    
                  from NF_SAIDA     
                 where 1 = 1    
                   and TPNOTA = @STPNOTA    
                   and NUMNOTA = @SNUMNOTA    
                   and SERIE = @SSERIE    
                   and DTNOTA = @SDTNOTA    
                   and FILIAL = isnull(@SFILIAL,@HCODFIL)    
             
            if @SCODSITPROD is null    
                select @SCODSITPROD = CODSITPROD    
                  from CAD_PRECO    
                 where 1 = 1    
                   and CODFIL = isnull(@SFILPED,isnull(@SFILIAL,@HCODFIL))    
                   and CODITPROD = @SCODPROD    
                   and CODEMBAL = @SCODEMBAL    
             
            if @HVLTOTITEM is null    
                select @HVLTOTITEM = round(@SPRECOUNIT * (1 - isnull(@SDPI,0)/100) * @SQTCOMP, 2, 2) --Roberto Cesar - 134859 - Alterado o convert para round(999, 2, 2) para truncar o VLTOTITEM, pois o convert estava arredondando.

            --Roberto Cesar - 135549 - InÝcio
            set @PPROPORCIONALITEM = (isnull(@SVLTOTITEM,isnull(@HVLTOTITEM,0)) - isnull(@SVLDESCITEMRAT,0)) / @PVLTOTAL
            if @PPROPORCIONALITEM = 0 set @PPROPORCIONALITEM = 1
            if @SVLJUROS = 0 set @SVLJUROS = null
            if @PVLJUROS > 0 set @PVLJUROS = @PVLJUROS * @PPROPORCIONALITEM
            if @SVLJUROSFIN = 0 set @SVLJUROSFIN = null
            if @PVLJUROSFIN > 0 set @PVLJUROSFIN = @PVLJUROSFIN * @PPROPORCIONALITEM
            --Roberto Cesar - 135549 - Fim

            --pfernandes - 145778 - retirada essa validação, pois o SAT e NFCE não possuem NUMCCF
            select @HITEM = @SITEM

            insert into MOV_ITSAIDA    
                   (CODFIL,TPNOTA,NUMNOTA,DTNOTA,SERIE,CODITPROD,ITEM,QTCOMP,PRECOUNIT,ALIQICM,    
                    ALIQICMSUB,ALIQICMRED,VLIPI,PORCIPI,CODEMBAL,DPI,DESCCOMPLE,STATUS,    
                    NUMPEDVEN,CODCLI,PRECJUR,QTDEVOL,PRECOUNITLIQ,VLSUPINF,CMUP,MEDGER,    
                    HRHORA,CODSITPROD,ALIQICMSUBUF,QTESTOQUE,VLDESCITEM,VLDESCITEMRAT,CODPROM,    
                    QTEMB,VLBASEICMSF,VLISENTOF,VLNTRIBUTF,VLOUTRASF,VLICMF,VLBASEICMSSUBF,    
                    VLICMRETF,VLDESPACES,VLOUTDESP,CODITPRODKIT,CODVENDR,VLISS,CTF,    
                    FILPED,FILORIG,VLMONTAGEM,CODDESPMONTAG,    
                    VLBASEICMS,VLISENTO,VLNTRIBUT,VLOUTRAS,VLICM,VLICMRET,VLBASEICMSSUB,    
                    LOCAL,TPDEPOS,CUBAGEM,RUA,BLOCO,APTO,CMUPI,    
                    CODNATOP,CODNATOPCOMPL,CODNATOPDIF,CODNATOPDIFCOMPL,QTCONSIG,CUE,VLTOTITEM,VLTOTAL,    
                    TPPROG,VLDESPFIN,VLICMSFRETE,VLJUROS,VLJUROSFIN,VLFRETERAT,PRECOORIG,CODJUST,QTDEINSU,CONVERSAO,    
                    QTVENDAKIT,VLFRETE,VLDESCFRETE,VLBASEICMORIGREPI, VLICMORIGREPI, VLICMREPI,     
                    CRM,PRECOLISTA,NUMGARANTIA,VLTAC,CODPRESTSERV,ALIQISS,DESCPRESTSERV,VLDESCPROM,    
                    VLDESCNOTA,CUSTOGER,NUMCCF,NUMDAV,CODTOTPARCIMPR,
                    NLOTE,VLBASEISS,CODBARRA,FLPREINDIG,VLTOTBASEIPI,VLTOTIPI,VLBASEIPI,
                    CFOP,CSTPIS,PPIS,CSTCOFINS,PCONTSOC,ALIQIBPT,VLIBPT,VERSAOIBPT,VLIOFSEG,ITPEDITEM, CODAUTDESCPDV)
            values (isnull(@SFILIAL,@HCODFIL),@STPNOTA,@SNUMNOTA,@SDTNOTA,@SSERIE,@SCODPROD,@HITEM,@SQTCOMP,@SPRECOUNIT,isnull(@SALIQICM,0),
                    isnull(@SALIQICMSUB,0),isnull(@SALIQICMRED,0),isnull(@SVLIPI,0),@SPORCIPI,@SCODEMBAL,isnull(@SDPI,0),@SDESCCOMPLE,@SSTATUS,    
                    isnull(@SNUMPEDVEN,999999),isnull(@SCODCLI,0),isnull(@SPRECJUR,0),@SQTDEVOL,    
                    ((@SPRECOUNIT * (1 - isnull(@SDPI,0)/100) * (1 - (isnull(@PPPIS,0) + isnull(@PPCONTSOC,0) + isnull(@HPADM,0))/100)) - isnull(@SVLICMF,0)),    
                    isnull(@SVLSUPINF,0),@SCMUP * @HCONVERSAO,@SMEDGER * @HCONVERSAO,    
                    @SHRHORA,@SCODSITPROD,isnull(@SALIQICMSUBUF,0),@SQTESTOQUE,isnull(@SVLDESCITEM,(@SQTCOMP * (isnull(@SDPI,0) * @SPRECOUNIT)/100)),isnull(@SVLDESCITEMRAT,0),@SCODPROM,    
                    @SQTEMB,isnull(@SVLBASEICMSF,0),isnull(@SVLISENTOF,0),isnull(@SVLNTRIBUTF,0),isnull(@SVLOUTRASF,0),isnull(@SVLICMF,0),isnull(@SVLBASEICMSSUBF,0),    
                    isnull(@SVLICMRETF,0),isnull(@SVLDESPACES,0),isnull(@SVLOUTDESP,0),@SCODITPRODKIT,@SCODVENDR,isnull(@SVLISS,0),@SCTF,    
                    isnull(@SFILPED,@HCODFIL),isnull(@SFILORIG,@HCODFIL),isnull(@SVLMONTAGEM,0),isnull(@SCODDESPMONTAG,0),    
                    round(isnull(@SVLBASEICMSF,0) * @SQTCOMP,2,2), round(isnull(@SVLISENTOF,0) * @SQTCOMP,2,2), round(isnull(@SVLNTRIBUTF,0) * @SQTCOMP,2,2),
                    round(isnull(@SVLOUTRASF,0) * @SQTCOMP,2,2), round(isnull(@SVLICMF,0) * @SQTCOMP,2,2),
                    round(isnull(@SVLICMRETF,0) * @SQTCOMP,2,2),
                    round(isnull(@SVLBASEICMSSUBF,0) * @SQTCOMP,2,2), @DLOCAL,@DTPDEPOS,convert(numeric(8,4),@PCUBAGEM),@LRUA,@LBLOCO,@LAPTO,isnull(@HCMUPI,0) * @HCONVERSAO,    
                    @HCODNATOP,@HCODNATOPCOMPL,@HCODNATOPDIF,@HCODNATOPDIFCOMPL,0,isnull(@HCUE,0) * @HCONVERSAO,isnull(@SVLTOTITEM,isnull(@HVLTOTITEM,0)),(isnull(@SVLTOTITEM,isnull(@HVLTOTITEM,0)) - isnull(@SVLDESCITEMRAT,0)),
                    'S',0,isnull(@HVLICMSFRETE,0),isnull(@SVLJUROS, @PVLJUROS),isnull(@SVLJUROSFIN, @PVLJUROSFIN),@SVLFRETERAT,@SPRECOORIG,@SCODJUST,@HQTDEINSU,@SCONVERSAO,    
                    @SQTVENDAKIT,@SVLFRETE,@SVLDESCFRETE,@SVLBASEICMORIGREPI,@SVLICMORIGREPI,@SVLICMREPI,     
                    @SCRM,@SPRECOLISTA,@SNUMGARANTIA,@SVLTAC,@PICODPRESTSERV,@PIISS,@PIDESCPRESTSERV,@SVLDESCPROM,    
                    @SVLDESCNOTA,@HCUSTOGER,@SNUMCCF,@SNUMDAV,@SCODTOTPARCIMPR,
                    @SNLOTE,@SVLBASEISS,@CODBARRA,@FLPREINDIG,@VLTOTBASEIPI,@VLTOTIPI,@VLBASEIPI,
                    @CFOP,@CSTPIS,@PPIS,@CSTCOFINS,@PCONTSOC,@ALIQIBPT,@VLIBPT,@VERSAOIBPT,@VLIOFSEG,@ITPEDITEM, @CODAUTDESCPDV)

            --Roberto Cesar - 134859 - Alterado o mÚtodo de truncar de convert(numeric(15,2), ...) para round(..., 2,2), pois o convert estava arredondando.
            update MOV_SAIDA with (readcommitted)
               set VLICM = isnull(VLICM,0) + round(isnull(@SVLICMF,0) * @SQTCOMP,2,2),
                   VLBASEICMS = isnull(VLBASEICMS,0) + round(isnull(@SVLBASEICMSF,0) * @SQTCOMP,2,2),
                   VLISENTO = isnull(VLISENTO,0) + round(isnull(@SVLISENTOF,0) * @SQTCOMP,2,2),
                   VLBASEICMSSUB = isnull(VLBASEICMSSUB,0) + round(isnull(@SVLBASEICMSSUBF,0) * @SQTCOMP,2,2),
                   VLICMRET = isnull(VLICMRET,0) + round(isnull(@SVLICMRETF,0) * @SQTCOMP,2,2),
                   VLOUTRAS = isnull(VLOUTRAS,0) + round(isnull(@SVLOUTRASF,0) * @SQTCOMP,2,2),
                   PESO = isnull(PESO,0) + convert(numeric(8,3),@PPESOUNIT * @SQTCOMP * @HCONVERSAO),
                   PESOLIQ = isnull(PESOLIQ,0) + convert(numeric(8,3),@PPESOLIQ * @SQTCOMP * @HCONVERSAO),
                   VLBASEICMORIGREPI = isnull(VLBASEICMORIGREPI,0) + convert(numeric(15,2),@SVLBASEICMORIGREPI),
                   VLICMORIGREPI = isnull(VLICMORIGREPI,0) + convert(numeric(15,2),@SVLICMORIGREPI),
                   VLICMREPI = isnull(VLICMREPI,0) + convert(numeric(15,2),@SVLICMREPI),
                   VLDESCNOTA = isnull(VLDESCNOTA,0) + convert(numeric(15,2),@SVLDESCNOTA)
             where 1 = 1
               and CODFIL = isnull(@SFILIAL,@HCODFIL)
               and TPNOTA = @STPNOTA
               and NUMNOTA = @SNUMNOTA
               and DTNOTA = @SDTNOTA
               and SERIE = @SSERIE
        end    
        else    
        begin    
            declare @INFCODFIL numeric(5)    
            declare @INFTPNOTA numeric(3)    
            declare @INFNUMNOTA numeric(6)    
            declare @INFSERIE varchar(3)    
            declare @INFDTNOTA datetime    
            declare @INFCODITPROD numeric(10)    
            declare @INFQTCOMP numeric(17,4)    
            declare @INFPRECOUNIT numeric(17,4)    
            declare @INFPRECOUNITLIQ numeric(17,4)    
            declare @INFDPI numeric(11,9)    
            declare @INFVLBASEICMS numeric(15,4)    
            declare @INFVLISENTO numeric(15,4)    
            declare @INFVLNTRIBUT numeric(15,4)    
            declare @INFVLOUTRAS numeric(15,4)    
            declare @INFVLICM numeric(15,4)    
            declare @INFVLBASEICMSSUB numeric(15,4)    
            declare @INFVLICMRET numeric(15,4)    
            declare @INFVLBASEICMSF numeric(20,9)    
            declare @INFVLISENTOF numeric(20,9)    
            declare @INFVLNTRIBUTF numeric(20,9)    
            declare @INFVLOUTRASF numeric(20,9)    
            declare @INFVLICMF numeric(20,9)    
            declare @INFVLBASEICMSSUBF numeric(20,9)    
            declare @INFVLICMRETF numeric(20,9)    
            declare @INFVLDESCITEMRAT numeric(15,4)    
            declare @INFVLTOTITEM numeric(15,2)    
            declare @INFVLDESCITEM numeric(15,4)    
            declare @INFVLTOTAL numeric(15,2)    
            declare @INFCODEMBAL numeric(1)    
            declare @INFQTEMB numeric(4)    
            declare @INFVLICMSFRETE numeric(15,4)    
            declare @HQTCOMPOLD numeric(17,4)    
            declare @HQTCOMP numeric(17,4)    
            declare @HPRECOUNIT numeric(17,4)    
            declare @HQTEMB numeric(4)    
            declare @INFVLFRETERAT numeric(15,4)    
            declare @INFVLFRETE numeric(15,4)    
            declare @INFVLDESCFRETE numeric(15,4)    
            declare @INFCMUP numeric(15,4)    
            declare @INFMEDGER numeric(15,4)    
            declare @INFCMUPI numeric(15,4)    
            declare @INFCUE numeric(15,4)    
            declare @INFCONVERSAO numeric(11,6)    
            declare @INFVLBASEICMORIGREPI numeric(15,2)    
            declare @INFVLICMORIGREPI numeric(15,2)    
            declare @INFVLICMREPI numeric(15,2)    
            declare @VCODBARRA numeric(14)
             
            declare @HINFCONVERSAO numeric(11,6)    
            declare @HINFQTCOMP numeric(17,4)    

            select @INFCODFIL = CODFIL,@INFTPNOTA = TPNOTA,@INFNUMNOTA = NUMNOTA,@INFSERIE = SERIE,@INFDTNOTA = DTNOTA,@INFCODITPROD = CODITPROD,    
                   @INFQTCOMP = QTCOMP,@INFPRECOUNIT = isnull(PRECOUNIT,0),@INFPRECOUNITLIQ = (PRECOUNIT * (1 - isnull(DPI,0)/100) * (1 - (isnull(@PPPIS,0) + isnull(@PPCONTSOC,0) + isnull(@HPADM,0))/100) - isnull(VLICMF,0)),    
                   @INFDPI = isnull(DPI,0),@INFVLBASEICMS = isnull(VLBASEICMS,0),@INFVLISENTO = isnull(VLISENTO,0),    
                   @INFVLNTRIBUT = isnull(VLNTRIBUT,0),@INFVLOUTRAS = isnull(VLOUTRAS,0),@INFVLICM = isnull(VLICM,0),    
                   @INFVLBASEICMSSUB = isnull(VLBASEICMSSUB,0),@INFVLICMRET = isnull(VLICMRET,0),@INFVLBASEICMSF = isnull(VLBASEICMSF,0),@INFVLISENTOF = isnull(VLISENTOF,0),    
                   @INFVLNTRIBUTF = isnull(VLNTRIBUTF,0),@INFVLOUTRASF = isnull(VLOUTRASF,0),@INFVLICMF = isnull(VLICMF,0),@INFVLBASEICMSSUBF = isnull(VLBASEICMSSUBF,0),    
                   @INFVLICMRETF = isnull(VLICMRETF,0),@INFVLDESCITEMRAT = isnull(VLDESCITEMRAT,0),@INFVLTOTITEM = isnull(VLTOTITEM,0),    
                   @INFVLDESCITEM = isnull(VLDESCITEM,0),@INFVLTOTAL = isnull(VLTOTAL,0),@INFCODEMBAL = isnull(CODEMBAL,0),    
                   @INFQTEMB = case when isnull(QTEMB,1) = 0 then 1 else isnull(QTEMB,1) end,@INFVLICMSFRETE = isnull(VLICMSFRETE,0),    
                   @INFVLFRETERAT = isnull(VLFRETERAT,0),@INFVLFRETE = isnull(VLFRETE,0),@INFVLDESCFRETE = isnull(VLDESCFRETE,0),    
                   @INFCMUP = isnull(CMUP,0),@INFMEDGER = isnull(MEDGER,0),@INFCMUPI = isnull(CMUPI,0),@INFCUE = isnull(CUE,0),    
                   @INFCONVERSAO = case when isnull(CONVERSAO,1) = 0 then 1 else isnull(CONVERSAO,1) end,    
                   @INFVLBASEICMORIGREPI = isnull(VLBASEICMORIGREPI,0),    
                   @INFVLICMORIGREPI = isnull(VLICMORIGREPI,0),    
                   @INFVLICMREPI = isnull(VLICMREPI,0)    
              from MOV_ITSAIDA    
             where 1 = 1    
               and CODFIL = isnull(@SFILIAL,@HCODFIL)    
               and TPNOTA = @STPNOTA    
               and NUMNOTA = @SNUMNOTA    
               and SERIE = @SSERIE    
               and DTNOTA = @SDTNOTA    
               and CODITPROD = @SCODPROD    
          
            begin    
                if @GFLCONVERSAOSAIDA = 'S'    
                    set @HINFCONVERSAO = @INFCONVERSAO    
                else    
                    set @HINFCONVERSAO = @INFQTEMB     

                if @HINFCONVERSAO > @HCONVERSAO    
                begin    
                    set @HQTEMBMENOR = @HCONVERSAO    
                    set @HCODEMBALMENOR = @SCODEMBAL    
                end    
                else    
                begin    
                    set @HQTEMBMENOR = @HINFCONVERSAO    
                    set @HCODEMBALMENOR = @INFCODEMBAL    
                end      

                set @HINFQTCOMP = @INFQTCOMP    
                set @INFQTCOMP = ((@INFQTCOMP * @HINFCONVERSAO) + (@SQTCOMP * @HCONVERSAO)) / @HQTEMBMENOR    
                set @INFPRECOUNIT = (((@INFQTCOMP * @INFPRECOUNIT) + (@SQTCOMP * @SPRECOUNIT)) / ((@INFQTCOMP * @HINFCONVERSAO) + (@SQTCOMP * @HCONVERSAO))) * @HQTEMBMENOR    
                      
                set @INFVLBASEICMSF = (((@HINFQTCOMP * isnull(@INFVLBASEICMSF,0)) + (@SQTCOMP * isnull(@SVLBASEICMSF,0))) / ((@HINFQTCOMP * @HINFCONVERSAO) + (@SQTCOMP * @HCONVERSAO))) * @HQTEMBMENOR    
                set @INFVLBASEICMS = @INFVLBASEICMSF * @INFQTCOMP    
                set @INFVLISENTOF = (((@HINFQTCOMP * isnull(@INFVLISENTOF,0)) + (@SQTCOMP * isnull(@SVLISENTOF,0))) / ((@HINFQTCOMP * @HINFCONVERSAO) + (@SQTCOMP * @HCONVERSAO))) * @HQTEMBMENOR    
                set @INFVLISENTO = @INFVLISENTOF * @INFQTCOMP    
                set @INFVLNTRIBUTF = (((@HINFQTCOMP * isnull(@INFVLNTRIBUTF,0)) + (@SQTCOMP * isnull(@SVLNTRIBUTF,0))) / ((@HINFQTCOMP * @HINFCONVERSAO) + (@SQTCOMP * @HCONVERSAO))) * @HQTEMBMENOR    
                set @INFVLNTRIBUT = @INFVLNTRIBUTF * @INFQTCOMP    
                set @INFVLOUTRASF = (((@HINFQTCOMP * isnull(@INFVLOUTRASF,0)) + (@SQTCOMP * isnull(@SVLOUTRASF,0))) / ((@HINFQTCOMP * @HINFCONVERSAO) + (@SQTCOMP * @HCONVERSAO))) * @HQTEMBMENOR    
                set @INFVLOUTRAS = @INFVLOUTRASF * @INFQTCOMP   
                set @INFVLICMF = (((@HINFQTCOMP * isnull(@INFVLICMF,0)) + (@SQTCOMP * isnull(@SVLICMF,0))) / ((@HINFQTCOMP * @HINFCONVERSAO) + (@SQTCOMP * @HCONVERSAO))) * @HQTEMBMENOR    
                set @INFVLICM = @INFVLICMF * @INFQTCOMP    
                set @INFVLBASEICMSSUBF = (((@HINFQTCOMP * isnull(@INFVLBASEICMSSUBF,0)) + (@SQTCOMP * isnull(@SVLBASEICMSSUBF,0))) / ((@HINFQTCOMP * @HINFCONVERSAO) + (@SQTCOMP * @HCONVERSAO))) * @HQTEMBMENOR    
                set @INFVLBASEICMSSUB = @INFVLBASEICMSSUBF * @INFQTCOMP    
                set @INFVLICMRETF = (((@HINFQTCOMP * isnull(@INFVLICMRETF,0)) + (@SQTCOMP * isnull(@SVLICMRETF,0))) / ((@HINFQTCOMP * @HINFCONVERSAO) + (@SQTCOMP * @HCONVERSAO))) * @HQTEMBMENOR    
                set @INFVLICMRET = @INFVLICMRETF * @INFQTCOMP    
                set @INFVLDESCITEMRAT = (isnull(@INFVLDESCITEMRAT,0) + isnull(@SVLDESCITEMRAT,0))    
                set @INFVLFRETERAT = (isnull(@INFVLFRETERAT,0) + isnull(@SVLFRETERAT,0))    
                set @INFVLFRETE = (isnull(@INFVLFRETE,0) + isnull(@SVLFRETE,0))    
                set @INFVLDESCFRETE = (isnull(@INFVLDESCFRETE,0) + isnull(@SVLDESCFRETE,0))    
                set @INFVLDESCITEM = convert(numeric(15,5),isnull(@INFVLDESCITEM,0) + (@SQTCOMP * (isnull(@SDPI,0) * @SPRECOUNIT)/100))    
                set @INFDPI = convert(numeric(11,9),(@INFVLDESCITEM / ((@INFPRECOUNIT * @INFQTCOMP) + (@SPRECOUNIT * @SQTCOMP))) * 100)    

                set @INFVLTOTITEM = @INFVLTOTITEM + isnull(@SVLTOTITEM, round(@SPRECOUNIT * (1 - isnull(@SDPI,0)/100) * @SQTCOMP,2,2)) --Roberto Cesar - 134859 - Alterado o convert para round(999, 2, 2) para truncar o VLTOTITEM, pois o convert estava arredondando.

                set @INFVLTOTAL = @INFVLTOTITEM - isnull(@INFVLDESCITEMRAT,0)   

                set @INFVLBASEICMORIGREPI = (((@HINFQTCOMP * isnull(@INFVLBASEICMORIGREPI,0)) + (@SQTCOMP * isnull(@SVLBASEICMORIGREPI,0))) / ((@HINFQTCOMP * @HINFCONVERSAO) + (@SQTCOMP * @HCONVERSAO))) * @HQTEMBMENOR    
                set @INFVLICMORIGREPI = (((@HINFQTCOMP * isnull(@INFVLICMORIGREPI,0)) + (@SQTCOMP * isnull(@SVLICMORIGREPI,0))) / ((@HINFQTCOMP * @HINFCONVERSAO) + (@SQTCOMP * @HCONVERSAO))) * @HQTEMBMENOR    
                set @INFVLICMREPI = (((@HINFQTCOMP * isnull(@INFVLICMREPI,0)) + (@SQTCOMP * isnull(@SVLICMREPI,0))) / ((@HINFQTCOMP * @HINFCONVERSAO) + (@SQTCOMP * @HCONVERSAO))) * @HQTEMBMENOR    

                set @INFPRECOUNITLIQ = @INFPRECOUNIT * (1 - isnull(@SDPI,0)/100) * (1 - (isnull(@PPPIS,0) + isnull(@PPCONTSOC,0) + isnull(@HPADM,0))/100) - @INFVLICMF    

                set @HELPCMUP = (((@INFCMUP / @HINFCONVERSAO) + (@SCMUP)) / 2) * @HQTEMBMENOR    
                set @HELPMEDGER = (((@INFMEDGER / @HINFCONVERSAO) + (@SMEDGER)) / 2) * @HQTEMBMENOR    
                set @HELPCMUPI = (((@INFCMUPI / @HINFCONVERSAO) + (@HCMUPI)) / 2) * @HQTEMBMENOR    
                set @HELPCUE = (((@INFCUE / @HINFCONVERSAO) + (@HCUE)) / 2) * @HQTEMBMENOR    

                update MOV_ITSAIDA with (readcommitted)    
                   set QTCOMP = @INFQTCOMP,    
                       PRECOUNIT = @INFPRECOUNIT,    
                       PRECOUNITLIQ = @INFPRECOUNITLIQ,    
                       VLBASEICMS = @INFVLBASEICMS,    
                       VLISENTO = @INFVLISENTO,    
                       VLNTRIBUT = @INFVLNTRIBUT,    
                       VLOUTRAS = @INFVLOUTRAS,    
                       VLICM = @INFVLICM,    
                       VLBASEICMSSUB = @INFVLBASEICMSSUB,    
                       VLICMRET = @INFVLICMRET,    
                       VLBASEICMSF = @INFVLBASEICMSF,    
                       VLISENTOF = @INFVLISENTOF,    
                       VLNTRIBUTF = @INFVLNTRIBUTF,    
                       VLOUTRASF = @INFVLOUTRASF,    
                       VLICMF = @INFVLICMF,    
                       VLBASEICMSSUBF = @INFVLBASEICMSSUBF,    
                       VLICMRETF = @INFVLICMRETF,    
                       VLDESCITEMRAT = @INFVLDESCITEMRAT,    
                       VLDESCITEM = @INFVLDESCITEM,    
                       DPI = @INFDPI,    
                       VLTOTAL = @INFVLTOTAL,    
                       VLTOTITEM = @INFVLTOTITEM,    
                       CODEMBAL = @HCODEMBALMENOR,    
                       QTEMB = @HQTEMBMENOR,    
                       VLFRETERAT = @INFVLFRETERAT,    
                       VLFRETE = @INFVLFRETE,    
                       VLDESCFRETE = @INFVLDESCFRETE,    
                       CMUP = @HELPCMUP,    
                       MEDGER = @HELPMEDGER,    
                       CMUPI = @HELPCMUPI,    
                       CUE = @HELPCUE,    
                       CONVERSAO = @HINFCONVERSAO,    
                       VLBASEICMORIGREPI = @INFVLBASEICMORIGREPI,    
                       VLICMORIGREPI = @INFVLICMORIGREPI,    
                       VLICMREPI = @INFVLICMREPI, 
                       CODBARRA = @VCODBARRA  
                 where 1 = 1    
                   and CODFIL = @INFCODFIL    
                   and TPNOTA = @INFTPNOTA    
                   and NUMNOTA = @INFNUMNOTA    
                   and SERIE = @INFSERIE    
                   and DTNOTA = @INFDTNOTA    
                   and CODITPROD = @INFCODITPROD    

                --Roberto Cesar - 134859 - Alterado o mÚtodo de truncar de convert(numeric(15,2), ...) para round(..., 2,2), pois o convert estava arredondando.
                update MOV_SAIDA with (readcommitted)
                   set VLICM = isnull(VLICM,0) + round(isnull(@SVLICMF,0) * @SQTCOMP,2,2),--SA_IMPL_3308_0 - EVERSON KARL VIEBRANTZ - 25/11/2009
                       VLBASEICMS = isnull(VLBASEICMS,0) + round(isnull(@SVLBASEICMSF,0) * @SQTCOMP,2,2),
                       VLISENTO = isnull(VLISENTO,0) + round(isnull(@SVLISENTOF,0) * @SQTCOMP,2,2),
                       VLBASEICMSSUB = isnull(VLBASEICMSSUB,0) + round(isnull(@SVLBASEICMSSUBF,0) * @SQTCOMP,2,2),
                       VLICMRET = isnull(VLICMRET,0) + round(isnull(@SVLICMRETF,0) * @SQTCOMP,2,2),
                       VLOUTRAS = isnull(VLOUTRAS,0) + round(isnull(@SVLOUTRASF,0) * @SQTCOMP,2,2),    
                       PESO = isnull(PESO,0) + convert(numeric(8,3),@PPESOUNIT * @SQTCOMP * @HCONVERSAO),    
                       PESOLIQ = isnull(PESOLIQ,0) + convert(numeric(8,3),@PPESOLIQ * @SQTCOMP * @HCONVERSAO),    
                       VLBASEICMORIGREPI = isnull(VLBASEICMORIGREPI,0) + convert(numeric(15,2),@SVLBASEICMORIGREPI),    
                       VLICMORIGREPI = isnull(VLICMORIGREPI,0) + convert(numeric(15,2),@SVLICMORIGREPI),    
                       VLICMREPI = isnull(VLICMREPI,0) + convert(numeric(15,2),@SVLICMREPI),    
                       VLDESCNOTA = isnull(VLDESCNOTA,0) + convert(numeric(15,2),@SVLDESCNOTA)    
                 where 1 = 1    
                   and CODFIL = isnull(@SFILIAL,@HCODFIL)    
                   and TPNOTA = @STPNOTA    
                   and NUMNOTA = @SNUMNOTA    
                   and DTNOTA = @SDTNOTA    
                   and SERIE = @SSERIE    
            end    
        end    

        if @GFLFATPARCIAL = 'S' and isnull(@SNUMPEDVEN,999999) not in (0, 999999) and @SSTATUS <> 6
        begin
            --p.fdantas - OC. 125816 - IN-CIO    
            --exec SPU_STATUSPEDIDOPARCA @SFILPED,@SNUMPEDVEN,0,@SCODPROD,@SITPEDITEM,@SQTCOMP    
            exec SPU_STATUSPEDIDOPARCC @SFILPED,@SNUMPEDVEN,0,@SCODPROD,@SITPEDITEM,@SQTCOMP,@SNLOTE    
            --p.fdantas - OC. 125816 - FIM
        end    
    end      
    fetch SMART into @STPNOTA,@SNUMNOTA,@SDTNOTA,@SSERIE,@SCODPROD,@SITEM,@SQTCOMP,@SPRECOUNIT,@SALIQICM,    
                  @SALIQICMSUB,@SALIQICMRED,@SVLIPI,@SPORCIPI,@SCODEMBAL,@SDPI,@SDESCCOMPLE,@SSTATUS,    
                  @SNUMPEDVEN,@SCODCLI,@SPRECJUR,@SQTDEVOL,@SPRECOUNITLIQ,@SVLSUPINF,@SCMUP,@SMEDGER,    
                  @SHRHORA,@SCODSITPROD,@SALIQICMSUBUF,@SQTESTOQUE,@SVLDESCITEM,@SVLDESCITEMRAT,@SCODPROM,    
                  @SQTEMB,@SVLBASEICMSF,@SVLISENTOF,@SVLNTRIBUTF,@SVLOUTRASF,@SVLICMF,@SVLBASEICMSSUBF,    
                  @SVLICMRETF,@SVLDESPACES,@SVLOUTDESP,@SCODITPRODKIT,@SCODVENDR,@SVLISS,@SCTF,    
                  @SFILPED,@SFILORIG,@SVLMONTAGEM,@SCODDESPMONTAG,@SFILIAL,@SVLTOTITEM,@SFLBUSCATRIBUT,    
                  @SVLFRETERAT,@SVLSEGURO,@SVLOUTDESP,@SVLDESPFIN,@SVLJUROS,@SVLJUROSFIN,@SPRECOORIG,    
                  @SCODJUST,@STIPOPED,@SITPEDITEM, @SCONVERSAO,@SQTVENDAKIT,@SVLFRETE,@SVLDESCFRETE,    
                  @SVLBASEICMORIGREPI, @SVLICMORIGREPI, @SVLICMREPI, @SCRM,@SPRECOLISTA,@SNUMGARANTIA,    
                  @SVLTAC,@SVLDESCPROM,@SVLDESCNOTA,@SNUMCCF,@SNUMDAV,@SCODTOTPARCIMPR, 
                  @SNLOTE, @SVLBASEISS,@CODBARRA,@FLPREINDIG, --p.fdantas - OC. 125816   
                  @VLTOTBASEIPI,@VLTOTIPI,@VLBASEIPI, 
                  @CFOP,@CSTPIS,@PPIS,@CSTCOFINS,@PCONTSOC,@ALIQIBPT,@VLIBPT,@VERSAOIBPT,@VLIOFSEG,@ITPEDITEM, @CODAUTDESCPDV
    continue    
end    
close SMART    
deallocate SMART
GO


