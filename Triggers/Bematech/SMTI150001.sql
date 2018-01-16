PRINT ' '
PRINT ' '
PRINT ' '
PRINT ' -- **************************************'
PRINT ' -- **            SMTI150001.sql ' 
PRINT ' -- **************************************'


 -- Atualiza tabela de controle de scripts executados
insert into gemco_scripts_executados (script, dthrexecucao) select 'SMTI150001.sql', getdate()
go

if exists (select '' from SYSOBJECTS where NAME = 'NF_SAIDA_TR_INS')
  drop trigger dbo.NF_SAIDA_TR_INS
go

CREATE TRIGGER [dbo].[NF_SAIDA_TR_INS]
ON [dbo].[NF_SAIDA]
FOR INSERT
AS
  --*****************************************************************************
  --* Faz insert na tabela MOV_SAIDA, a partir dos dados da NF_SAIDA.           *
  --* Fev 16, 2005 - Cristina Co - D007856 - Versao 35 - Acrescentar gravacao   *
  --*  das colunas CODNATOPDIF, CODNATOPCOMPL e CODNATOPDIFCOMPL (RRodrigues) e *
  --*  das colunas VLBASEICMORIGREPI, VLICMORIGREPI e VLICMREPI. (FCampos).     *
  --* Abr 06, 2005 - Cristina Co - D008033 - Versao 36 - Alterar clausula WHERE *
  --*  do select da CAD_CONDPG. (FCampos).                                      *
  --* Ago 31, 2005 - Patricia Bernini -                - Acrescentar gravacao da*
  --*  coluna TOTCUPOMPROMOCIONAL (Marcelo Jose).                               *
  --* Set 22, 2005 - Cristina Co - D008560 - Versao 37 - Acertar FLSEGURO, para *
  --*  utilizar CAD_TPNOTA. (Shozo).                                            *
  --* Jan 27, 2006 - Patricia Bernini - D008734 - Versao 38 - Acrescentr colunas*
  --*  CARENCIA, VLTAC e VLTARBANCARIA. (Marcelo Jose).                         *
  --* Mar 15, 2006 - Cristina Co - D008814 - Versao 39 - Acrescentar a coluna   *
  --*  MODELONF. (RRodrigues).                                                  *
  --* Set 06, 2006 - Cristina Co - D009237 - Versao 40 - Acrescentar gravacao da*
  --*  coluna DIGCONTRAFIN na MOV_SAIDA. (MJ).                                  *
  --* Nov 27, 2006 - Patricia Bernini - D009350 - Versao 41 - Grava HRHORA      *
  --*  passado no insert.(GLabone).                                             *
  --* Jun 11, 2007 - Cristina Co - D009493 - Versao 42 - Acrescentar gravacao da*
  --*  coluna CGCCPF. (CCamargo).                                               *
  --* Dez 21, 2007 - Marcelo Canale - D009613 - Versao 43 - Acrescentar gravacao*
  --*  da coluna VLIOFSEG. (CMelo).                                             *
  --* Jan 07, 2008 - Eduardo Moratto - Acrescentado gravação do NUMCCF          *
  --* Jan 15, 2009 - ADEMIR_JB(SA_IMPL_876_0)-Acrescentado gravação do NUMDAV   *
  --* Abr 16, 2009 - Eduardo Moratto - SA_IMPL_1142_0 -                         *
  --* DE: NUMLOTE(6) PARA NUMLOTE(12)                                           *
  --* Jul 13, 2010 - Andre Baptista - Acrescentar as colunas VERSAOPDV          *
  --* NOV 22, 2011 - Cesar Carmardo - Acrescentar as colunas NOMCLICUPOM        *
  --* e ENDCLICUPOM                                                             *
  --* Jun 26, 2012 - Vivian Martins - Oc. 122055 ticket #3111 (Roberto Cesar)   *
  --* Gravar na tabela MOV_SAIDA o campo VLBASEIPI                              *
  --* ABR 17, 2014 - Priscilla - Acrescentar as colunas STATUSNFE, VERSAONFE,   *
  --*                       DIGNFE, DTAUTORIZACAONFE, NUMNFE, CHAVENFE          *
  --* SET 19, 2014 - Marilu Santos - Acrescentar coluna FLOFFLINE               *
  --* SET 29, 2014 - Marilu Santos - VLPRC passa a sempre gravar 0 (TFS: 391)
  --* DEZ 17, 2014 - Yuri Vasconcelos - Inclusão CODAUTDESCPDV				    *
  --* DEZ 18, 2014 - Marilu Santos - Inclusão NUMCOO                            *
  --*****************************************************************************
  SET TRANSACTION ISOLATION LEVEL READ uncommitted
  SET nocount ON

  DECLARE @STPNOTA NUMERIC(3)
  DECLARE @SNUMNOTA NUMERIC(9)
  DECLARE @SSERIE VARCHAR(3)
  DECLARE @SDTNOTA DATETIME
  DECLARE @SDTEMISSAO DATETIME
  DECLARE @SDTPEDIDO DATETIME
  DECLARE @SDTCANCEL DATETIME
  DECLARE @SDTENTREGA DATETIME
  DECLARE @SCONDPGTO VARCHAR(3)
  DECLARE @SESTADO CHAR(2)
  DECLARE @SCODNATOP NUMERIC(3)
  DECLARE @SNUMPEDVEN NUMERIC(12)
  DECLARE @SCODCLI NUMERIC(15)
  DECLARE @SCODVENDR NUMERIC(10)
  DECLARE @SNUMCXA NUMERIC(3)
  DECLARE @SLOCAL NUMERIC(2)
  DECLARE @SPESO NUMERIC(12, 3)
  DECLARE @SOBS VARCHAR(255)
  DECLARE @SVLDESCONTO NUMERIC(15, 2)
  DECLARE @SVLDESPFIN NUMERIC(15, 2)
  DECLARE @SVLMERCAD NUMERIC(15, 2)
  DECLARE @SVLSEGURO NUMERIC(15, 2)
  DECLARE @SSTATUS NUMERIC(1)
  DECLARE @SVLTOTAL NUMERIC(15, 2)
  DECLARE @SPESOLIQ NUMERIC(12, 3)
  DECLARE @SHRHORA DATETIME
  DECLARE @SHRDURACAO NUMERIC(6)
  DECLARE @SVLJUROSFIN NUMERIC(15, 2)
  DECLARE @SPJUROS NUMERIC(12, 9)
  DECLARE @SDTATUEST DATETIME
  DECLARE @SFLATUEST CHAR(1)
  DECLARE @SDTNOTAPDV DATETIME
  DECLARE @SFLNOTAPDV CHAR(1)
  DECLARE @SNUMNOTAPDV NUMERIC(9)
  DECLARE @SNUMPDV NUMERIC(3)
  DECLARE @SSERIEPDV VARCHAR(3)
  DECLARE @STPNOTAPDV NUMERIC(3)
  DECLARE @SQTPRC NUMERIC(2)
  DECLARE @SVLPRC NUMERIC(15, 2)
  DECLARE @SOBSFISCAL VARCHAR(150)
  DECLARE @SDTLIBPED DATETIME
  DECLARE @SDTEXPORTACAO DATETIME
  DECLARE @SFLCUPOM CHAR(1)
  DECLARE @SVLBASEICMS NUMERIC(15, 2)
  DECLARE @SVLICMS NUMERIC(15, 2)
  DECLARE @SVLBASEICMSSUB NUMERIC(15, 2)
  DECLARE @SVLICMSSUB NUMERIC(15, 2)
  DECLARE @SVLFRETE NUMERIC(15, 2)
  DECLARE @SVLOUTDESP NUMERIC(15, 2)
  DECLARE @SVLIPI NUMERIC(15, 2)
  DECLARE @SFLNFMANUAL CHAR(1)
  DECLARE @STIPOPED NUMERIC(1)
  DECLARE @SENDCOB NUMERIC(3)
  DECLARE @SENDENT NUMERIC(3)
  DECLARE @SPRACA NUMERIC(5)
  DECLARE @SFILPED NUMERIC(3)
  DECLARE @SIDENTPROC VARCHAR(250)
  DECLARE @SVLMONTAGEM NUMERIC(15, 2)
  DECLARE @SFILIAL NUMERIC(5)
  DECLARE @SNRSERIEECF VARCHAR(20)
  DECLARE @SNUMPEDPRINC NUMERIC(12)
  DECLARE @SCODFUNC NUMERIC(11)
  DECLARE @SCODCONVENIO NUMERIC(6)
  DECLARE @SFLMULTIREC CHAR(1)
  DECLARE @SVLISS NUMERIC(15, 2)
  DECLARE @SFLSEGURO CHAR(1)
  DECLARE @SVLENTRADA NUMERIC(15, 2)
  DECLARE @SCODSUPCANCEL NUMERIC(4)
  DECLARE @SNUMCONTRAFIN NUMERIC(9)
  DECLARE @SCODOPER NUMERIC(4)
  DECLARE @SCODNATOPDIF NUMERIC(3)
  DECLARE @SCODNATOPCOMPL NUMERIC(2)
  DECLARE @SCODNATOPDIFCOMPL NUMERIC(2)
  DECLARE @SVLBASEICMORIGREPI NUMERIC(15, 2)
  DECLARE @SVLICMORIGREPI NUMERIC(15, 2)
  DECLARE @SVLICMREPI NUMERIC(15, 2)
  DECLARE @STOTCUPOMPROMOCIONAL NUMERIC(3)
  DECLARE @SCARENCIA NUMERIC (5)
  DECLARE @SVLTAC NUMERIC(15, 2)
  DECLARE @SVLTARBANCARIA NUMERIC(15, 2)
  DECLARE @SMODELONF NUMERIC(2)
  DECLARE @SCGCCPF NUMERIC(15)
  DECLARE @SVLIOFSEG NUMERIC(15, 2)
  DECLARE @SNUMCCF NUMERIC(6)
  DECLARE @SNUMDAV NUMERIC(13, 0)
  DECLARE @SVERSAOPDV VARCHAR(30)
  DECLARE @SNOMCLICUPOM VARCHAR(40)
  DECLARE @SENDCLICUPOM VARCHAR(60)
  DECLARE @NUMLOTE NUMERIC(12) --SA_IMPL_1142_0
  DECLARE @PTPPED CHAR(1)
  DECLARE @PDTPEDIDO DATETIME

  DECLARE @PVLJUROSFIN NUMERIC(15, 2)

  --Roberto Cesar - 135549 - Início
  DECLARE @PVLJUROS NUMERIC(15, 2) 
  DECLARE @PVLTOTALPEDIDO NUMERIC (15,4)
  DECLARE @PPROPORCIONALNOTA NUMERIC (15,4)
  --Roberto Cesar - 135549 - Fim

  DECLARE @POBS VARCHAR(255)
  DECLARE @PVLPRC NUMERIC(15, 2)
  DECLARE @PVLENTRADA NUMERIC(15, 2)
  DECLARE @PENDCOB NUMERIC(3)
  DECLARE @PENDENT NUMERIC(3)
  DECLARE @PPJUROS NUMERIC(12, 9)
  DECLARE @PDIGCONTRAFIN NUMERIC(1)
  DECLARE @DCOUNT NUMERIC(5)
  DECLARE @HLOTE CHAR(1)
  DECLARE @HCODFIL NUMERIC(5)
  DECLARE @HONLINE CHAR(1)
  DECLARE @CPJUROS NUMERIC(12, 9)
  DECLARE @HPJUROS NUMERIC(12, 9)
  DECLARE @TTIPOPED NUMERIC(1)
  DECLARE @SVLJUROS NUMERIC(15, 2)
  DECLARE @GFLFATPARCIAL CHAR(1)
  DECLARE @TFLSEGURO CHAR(1)
  DECLARE @VLBASEIPI NUMERIC(15,2)	
  DECLARE @ALIQIBPT NUMERIC(4,2)
  DECLARE @VLIBPT NUMERIC(15,2)
  DECLARE @STATUSNFE NUMERIC(1,0)   
  DECLARE @VERSAONFE CHAR(1) 
  DECLARE @DIGNFE NUMERIC(1)  
  DECLARE @DTAUTORIZACAONFE DATETIME 
  DECLARE @DTCANCELAMENTONFE DATETIME
  DECLARE @NUMNFE NUMERIC(9)
  DECLARE @CHAVENFE VARCHAR(44)
  DECLARE @FLCONTINGENCIA CHAR(1)
  DECLARE @TPAMBNFE NUMERIC(1,0)
  DECLARE @FLNOTAMANUALPDV CHAR(1)
  DECLARE @FLOFFLINE CHAR(1)
  DECLARE @CODAUTDESCPDV NUMERIC (5,0)
  DECLARE @NUMCOO NUMERIC (9,0)

  declare @GFLVDASEGAVISTA char(1) --Roberto Cesar - 239

  DECLARE smart CURSOR FOR
    SELECT tpnota,
           numnota,
           serie,
           dtnota,
           dtemissao,
           dtpedido,
           dtcancel,
           dtentrega,
           condpgto,
           estado,
           codnatop,
           numpedven,
           codcli,
           codvendr,
           numcxa,
           LOCAL,
           peso,
           obs,
           vldesconto,
           vldespfin,
           vlmercad,
           vlseguro,
           status,
           vltotal,
           pesoliq,
           hrhora,
           hrduracao,
           vljurosfin,
           pjuros,
           dtatuest,
           flatuest,
           dtnotapdv,
           flnotapdv,
           numnotapdv,
           numpdv,
           seriepdv,
           tpnotapdv,
           qtprc,
           vlprc,
           obsfiscal,
           dtlibped,
           vlbaseicms,
           vlbaseicmssub,
           vlfrete,
           vloutdesp,
           vlipi,
           flnfmanual,
           tipoped,
           endcob,
           endent,
           praca,
           filped,
           identproc,
           vlmontagem,
           vlicms,
           filial,
           nrserieecf,
           numpedprinc,
           codfunc,
           codconvenio,
           flmultirec,
           vljuros,
           vliss,
           flseguro,
           vlentrada,
           codsupcancel,
           numcontrafin,
           codoper,
           codnatopdif,
           codnatopcompl,
           codnatopdifcompl,
           vlbaseicmorigrepi,
           vlicmorigrepi,
           vlicmrepi,
           totcupompromocional,
           carencia,
           vltac,
           vltarbancaria,
           modelonf,
           cgccpf,
           vliofseg,
           numccf,
           numdav,
           versaopdv,
           nomclicupom,
           endclicupom,
           VLBASEIPI,
           ALIQIBPT,
           VLIBPT,
           STATUSNFE, 
           VERSAONFE, 
           DIGNFE, 
           DTAUTORIZACAONFE, 
           DTCANCELAMENTONFE,
           NUMNFE, 
           CHAVENFE,
		   FLCONTINGENCIA, 
		   TPAMBNFE, 
		   FLNOTAMANUALPDV,
		   FLOFFLINE,
		   CODAUTDESCPDV, 
		   NUMCOO
    FROM   inserted

  SELECT @HCODFIL = uc.codfil
  FROM   usuariobd_codfil uc
  WHERE  uc.usuario = system_user

  SELECT @HLOTE = NULL

  SELECT @HONLINE = flonline
  FROM   gemco

  SELECT @GFLFATPARCIAL = Isnull(flfatparcial, 'N'),
         @GFLVDASEGAVISTA = isnull(FLVDASEGAVISTA, 'N')
  FROM   ger_empresa_compl
  WHERE  1 = 1
         AND chave = 1

  OPEN smart

  FETCH smart INTO @STPNOTA, @SNUMNOTA, @SSERIE, @SDTNOTA, @SDTEMISSAO,
  @SDTPEDIDO, @SDTCANCEL, @SDTENTREGA, @SCONDPGTO, @SESTADO, @SCODNATOP,
  @SNUMPEDVEN, @SCODCLI, @SCODVENDR, @SNUMCXA, @SLOCAL, @SPESO, @SOBS,
  @SVLDESCONTO, @SVLDESPFIN, @SVLMERCAD, @SVLSEGURO, @SSTATUS, @SVLTOTAL,
  @SPESOLIQ, @SHRHORA, @SHRDURACAO, @SVLJUROSFIN, @SPJUROS, @SDTATUEST,
  @SFLATUEST, @SDTNOTAPDV, @SFLNOTAPDV, @SNUMNOTAPDV, @SNUMPDV, @SSERIEPDV,
  @STPNOTAPDV, @SQTPRC, @SVLPRC, @SOBSFISCAL, @SDTLIBPED, @SVLBASEICMS,
  @SVLBASEICMSSUB, @SVLFRETE, @SVLOUTDESP, @SVLIPI, @SFLNFMANUAL, @STIPOPED,
  @SENDCOB, @SENDENT, @SPRACA, @SFILPED, @SIDENTPROC, @SVLMONTAGEM, @SVLICMS,
  @SFILIAL, @SNRSERIEECF, @SNUMPEDPRINC, @SCODFUNC, @SCODCONVENIO, @SFLMULTIREC,
  @SVLJUROS, @SVLISS, @SFLSEGURO, @SVLENTRADA, @SCODSUPCANCEL, @SNUMCONTRAFIN,
  @SCODOPER, @SCODNATOPDIF, @SCODNATOPCOMPL, @SCODNATOPDIFCOMPL,
  @SVLBASEICMORIGREPI, @SVLICMORIGREPI, @SVLICMREPI, @STOTCUPOMPROMOCIONAL,
  @SCARENCIA, @SVLTAC, @SVLTARBANCARIA, @SMODELONF, @SCGCCPF, @SVLIOFSEG,
  @SNUMCCF, @SNUMDAV, @SVERSAOPDV, @SNOMCLICUPOM, @SENDCLICUPOM,@VLBASEIPI,
  @ALIQIBPT, @VLIBPT, @STATUSNFE, @VERSAONFE, @DIGNFE, @DTAUTORIZACAONFE,
  @DTCANCELAMENTONFE, @NUMNFE, @CHAVENFE, @FLCONTINGENCIA, @TPAMBNFE, @FLNOTAMANUALPDV, 
  @FLOFFLINE, @CODAUTDESCPDV, @NUMCOO

  WHILE ( @@FETCH_STATUS <> -1 )
    BEGIN
        --Roberto Cesar - 135549 - Início
        SET @PPROPORCIONALNOTA = 1
        SET @PVLJUROS = 0
        SET @PVLJUROSFIN = 0

        IF Isnull(@SNUMPEDVEN, 999999) NOT IN ( 0, 999999 )
        BEGIN
           IF @SVLJUROS = 0 SET @SVLJUROS = NULL
           IF @SVLJUROSFIN = 0 SET @SVLJUROSFIN = NULL
        END
        IF @SNUMPEDVEN IS NULL OR @SNUMPEDVEN = 999999
           SELECT @STIPOPED = 1
        ELSE
        BEGIN
           SELECT @TTIPOPED = Isnull(tipoped, 0),
                  @TFLSEGURO = Isnull(flseguro, 'N')
           FROM   cad_tpnota
           WHERE  1 = 1
             AND  tpnota = @STPNOTA

            IF @TTIPOPED = 0
              SELECT @STIPOPED = 0,
                     @SFLNOTAPDV = 'P'
            ELSE
              SELECT @STIPOPED = @TTIPOPED
        END
        --Roberto Cesar - 135549 - Fim

        IF Isnull(@HONLINE, 'S') = 'S'
          BEGIN
              IF @SFILIAL IS NULL
                UPDATE nf_saida WITH (readcommitted)
                SET    filial = @HCODFIL
                WHERE  1 = 1
                       AND tpnota = @STPNOTA
                       AND numnota = @SNUMNOTA
                       AND serie = @SSERIE
                       AND dtnota = @SDTNOTA

              IF @SPRACA IS NULL
                SELECT @SPRACA = praca
                FROM   cad_endcli
                WHERE  1 = 1
                       AND codend = @SENDENT
                       AND codcli = @SCODCLI

              IF Isnull(@SPJUROS, 0) = 0
                BEGIN
                    SELECT @CPJUROS = pjuros
                    FROM   cad_condpg
                    WHERE  1 = 1
                           AND codfil = Isnull(@SFILPED, Isnull(@SFILIAL,
                                         @HCODFIL
                                                         ))
                           AND condpgto = @SCONDPGTO
                END

--               IF @SNUMPEDVEN IS NULL
--                   OR @SNUMPEDVEN = 999999
--                 SELECT @STIPOPED = 1
--               ELSE
--                 BEGIN
--                     SELECT @TTIPOPED = Isnull(tipoped, 0),
--                            @TFLSEGURO = Isnull(flseguro, 'N')
--                     FROM   cad_tpnota
--                     WHERE  1 = 1
--                            AND tpnota = @STPNOTA
-- 
--                     IF @TTIPOPED = 0
--                       SELECT @STIPOPED = 0,
--                              @SFLNOTAPDV = 'P'
--                     ELSE
--                       SELECT @STIPOPED = @TTIPOPED
--                 END

              IF @SESTADO IS NULL
                SELECT @SESTADO = estado
                FROM   cad_filial
                WHERE  1 = 1
                       AND codfil = Isnull(@SFILIAL, @HCODFIL)

              IF Isnull(@SNUMPEDVEN, 999999) NOT IN ( 0, 999999 )
                BEGIN
                    SELECT @NUMLOTE = numlote,
                           @PTPPED = tpped,
                           @PDTPEDIDO = dtpedido,
                           --Roberto Cesar - 135549 - Início
                           @PVLJUROSFIN = vljurosfin,
                           @PVLJUROS = vljuros, 
                           @PVLTOTALPEDIDO = vltotal,
                           --Roberto Cesar - 135549 - Fim
                           @POBS = obs,
                           @PVLPRC = vlprc,
                           @PVLENTRADA = vlentrada,
                           @PENDCOB = endcob,
                           @PENDENT = endent,
                           @PPJUROS = pjuros,
                           @PDIGCONTRAFIN = digcontrafin
                    FROM   mov_pedido
                    WHERE  1 = 1
                           AND codfil = Isnull(@SFILPED, Isnull(@SFILIAL,
                                                         @HCODFIL
                                                         ))
                           AND tipoped = @STIPOPED
                           AND numpedven = @SNUMPEDVEN

                    SELECT @SDTPEDIDO = @PDTPEDIDO

                    --Roberto Cesar - 239 - Início
                    if (@TFLSEGURO = 'S' AND @GFLVDASEGAVISTA = 'S')
                    BEGIN
                       SET @PVLJUROS = 0
                       SET @PVLJUROSFIN = 0
                    END
                    --Roberto Cesar - 239 - Fim
                    ELSE
                    BEGIN
                       SET @PPROPORCIONALNOTA = @SVLTOTAL / @PVLTOTALPEDIDO
                       IF isnull(@PPROPORCIONALNOTA, 0) = 0 
                          SET @PPROPORCIONALNOTA = 1

                       SET @PVLJUROS = @PVLJUROS * @PPROPORCIONALNOTA
                       SET @PVLJUROSFIN = @PVLJUROSFIN * @PPROPORCIONALNOTA
                    END
                END

              SELECT @HPJUROS = CASE
                                  WHEN Isnull(@SPJUROS, 0) = 0
                                       AND @STIPOPED = 1 THEN @CPJUROS
                                  WHEN Isnull(@SPJUROS, 0) > 0
                                       AND @STIPOPED = 1 THEN @SPJUROS
                                  WHEN Isnull(@SPJUROS, 0) = 0
                                       AND @STIPOPED = 0 THEN @PPJUROS
                                  WHEN Isnull(@SPJUROS, 0) > 0
                                       AND @STIPOPED = 0 THEN @SPJUROS
                                  ELSE @SPJUROS
                                END

              INSERT INTO mov_saida
                          (codfil,
                           tpnota,
                           numnota,
                           serie,
                           dtnota,
                           dtemissao,
                           dtpedido,
                           dtcancel,
                           dtentrega,
                           condpgto,
                           estado,
                           codnatop,
                           numpedven,
                           codcli,
                           codvendr,
                           numcxa,
                           LOCAL,
                           peso,
                           obs,
                           vldesconto,
                           vldespfin,
                           vlmercad,
                           vlseguro,
                           status,
                           vltotal,
                           pesoliq,
                           hrduracao,
                           vljurosfin,
                           pjuros,
                           dtatuest,
                           flatuest,
                           dtnotapdv,
                           flnotapdv,
                           numnotapdv,
                           numpdv,
                           seriepdv,
                           tpnotapdv,
                           qtprc,
                           vlprc,
                           obsfiscal,
                           dtlibped,
                           vlbaseicms,
                           vlbaseicmssub,
                           vlfrete,
                           vloutdesp,
                           vlipi,
                           flnfmanual,
                           tipoped,
                           endcob,
                           endent,
                           praca,
                           filped,
                           identproc,
                           vlmontagem,
                           vlentrada,
                           cubagnf,
                           vlvdliq,
                           lote,
                           hrhora,
                           vlicm,
                           vlisento,
                           vlredicms,
                           flmovtoonline,
                           nrserieecf,
                           vldespaces,
                           vlicmret,
                           vloutras,
                           vlirrf,
                           numpedprinc,
                           codfunc,
                           codconvenio,
                           flmultirec,
                           vljuros,
                           vliss,
                           flseguro,
                           codsupcancel,
                           numcontrafin,
  codoper,
                           codnatopdif,
                           codnatopcompl,
                           codnatopdifcompl,
                           vlbaseicmorigrepi,
                           vlicmorigrepi,
                           vlicmrepi,
                           totcupompromocional,
                           carencia,
                           vltac,
                           vltarbancaria,
                           modelonf,
                           digcontrafin,
                       cgccpf,
                           vliofseg,
                           numccf,
                           numdav,
                           versaopdv,
                           nomclicupom,
                           endclicupom,
                           VLBASEIPI,
                           ALIQIBPT,
                           VLIBPT,
                           STATUSNFE, 
                           VERSAONFE, 
                           DIGNFE, 
                           DTAUTORIZACAONFE, 
                           DTCANCELAMENTONFE,
                           NUMNFE, 
                           CHAVENFE,
						   FLCONTINGENCIA, 
						   TPAMBNFE, 
						   FLNOTAMANUALPDV, 
						   FLOFFLINE,
						   CODAUTDESCPDV, 
						   NUMCOO)
              VALUES      (Isnull(@SFILIAL, @HCODFIL),
                           @STPNOTA,
                           @SNUMNOTA,
                           @SSERIE,
                           @SDTNOTA,
                           @SDTEMISSAO,
                           @SDTPEDIDO,
                           @SDTCANCEL,
                           @SDTENTREGA,
                           @SCONDPGTO,
                           @SESTADO,
                           @SCODNATOP,
                           Isnull(@SNUMPEDVEN, 999999),
                           @SCODCLI,
                           @SCODVENDR,
                           @SNUMCXA,
                           @SLOCAL,
                           @SPESO,
                           Isnull(@SOBS, @POBS),
                           Isnull(@SVLDESCONTO, 0),
                           Isnull(@SVLDESPFIN, 0),
                           Isnull(@SVLMERCAD, 0),
                           Isnull(@SVLSEGURO, 0),
                           @SSTATUS,
                           Isnull(@SVLTOTAL, 0),
                           @SPESOLIQ,
                           @SHRDURACAO,
                           Isnull(@SVLJUROSFIN, Isnull(@PVLJUROSFIN, 0)),
                           Isnull(@HPJUROS, 0),
                           Getdate(),
                           Isnull(@SFLATUEST, 'S'),
                           @SDTNOTAPDV,
                           @SFLNOTAPDV,
                           @SNUMNOTAPDV,
                           @SNUMPDV,
                           @SSERIEPDV,
                           @STPNOTAPDV,
                           @SQTPRC,
                           0, --Isnull(@SVLPRC, Isnull(@PVLPRC, 0)),
                           @SOBSFISCAL,
                           @SDTLIBPED,
                           Isnull(@SVLBASEICMS, 0),
                           Isnull(@SVLBASEICMSSUB, 0),
                           Isnull(@SVLFRETE, 0),
                           Isnull(@SVLOUTDESP, 0),
                           Isnull(@SVLIPI, 0),
                           @SFLNFMANUAL,
                           @STIPOPED,
                           Isnull(@PENDCOB, Isnull(@SENDCOB, 0)),
                           Isnull(@PENDENT, Isnull(@SENDENT, 0)),
                           @SPRACA,
                           Isnull(@SFILPED, Isnull(@SFILIAL, @HCODFIL)),
                           Isnull(@SIDENTPROC, 'SMART ECF'),
                           Isnull(@SVLMONTAGEM, 0),
                           Isnull(@SVLENTRADA, Isnull(@PVLENTRADA, 0)),
                           0,
                           0,
                           @NUMLOTE,
                           CONVERT(VARCHAR, @SHRHORA, 108),
               Isnull(@SVLICMS, 0),
                           0,
                           0,
                           'S',
                           @SNRSERIEECF,
                           0,
                           0,
                           0,
                           0,
                           @SNUMPEDPRINC,
                           @SCODFUNC,
                           @SCODCONVENIO,
                           @SFLMULTIREC,
                           Isnull(@SVLJUROS, Isnull(@PVLJUROS, 0)), --Roberto Cesar - 135549
                           Isnull(@SVLISS, 0),
                           @SFLSEGURO,
                           @SCODSUPCANCEL,
                           @SNUMCONTRAFIN,
                           @SCODOPER,
                           @SCODNATOPDIF,
                           @SCODNATOPCOMPL,
                           @SCODNATOPDIFCOMPL,
                           @SVLBASEICMORIGREPI,
                           @SVLICMORIGREPI,
                           @SVLICMREPI,
                           @STOTCUPOMPROMOCIONAL,
                           @SCARENCIA,
                           @SVLTAC,
                           @SVLTARBANCARIA,
                           @SMODELONF,
                           @PDIGCONTRAFIN,
                           @SCGCCPF,
                           @SVLIOFSEG,
                           @SNUMCCF,
                           @SNUMDAV,
                           @SVERSAOPDV,
                           @SNOMCLICUPOM,
                           @SENDCLICUPOM,
                           @VLBASEIPI,
                           @ALIQIBPT,
                           @VLIBPT,
                           @STATUSNFE, 
                           @VERSAONFE, 
                           @DIGNFE, 
                           @DTAUTORIZACAONFE, 
                           @DTCANCELAMENTONFE,
                           @NUMNFE, 
                           @CHAVENFE,
						   @FLCONTINGENCIA,
						   @TPAMBNFE, 
						   @FLNOTAMANUALPDV, 
						   @FLOFFLINE,
						   @CODAUTDESCPDV, 
						   @NUMCOO)

              IF Isnull(@SNUMPEDVEN, 999999) NOT IN ( 0, 999999 )
                 and @GFLFATPARCIAL != 'S'
                 and @SSTATUS <> 6
                BEGIN
                    IF EXISTS (SELECT ''
                               FROM   mov_pedido
                               WHERE  1 = 1
                                      AND codfil = Isnull(@SFILPED, Isnull(
                                                   @SFILIAL,
                                                                    @HCODFIL)
                                                   )
                                      AND tipoped = @STIPOPED
                                      AND numpedven = @SNUMPEDVEN
                                      AND Isnull(sitcarga, 9) <> 0)
                      BEGIN
                          SELECT @HLOTE = 'S'

                          UPDATE dis_itlote WITH (readcommitted)
                          SET    status = 3
                          WHERE  1 = 1
                                 AND codfil = Isnull(@SFILIAL, @HCODFIL)
                                 AND nlote = @NUMLOTE
                                 AND numpedven = @SNUMPEDVEN

                          SELECT @DCOUNT = COUNT(*)
                          FROM   dis_itlote
                          WHERE  1 = 1
                                 AND codfil = Isnull(@SFILIAL, @HCODFIL)
                                 AND nlote = @NUMLOTE

                          IF (SELECT COUNT(*)
                              FROM   dis_itlote
                              WHERE  1 = 1
                                     AND codfil = Isnull(@SFILIAL, @HCODFIL)
                                     AND nlote = @NUMLOTE
                                     AND status = 3) = Isnull(@DCOUNT, 0)
                            UPDATE dis_lote WITH (readcommitted)
                            SET    status = 3
                            WHERE  1 = 1
                                   AND codfil = Isnull(@SFILIAL, @HCODFIL)
                                   AND nlote = @NUMLOTE
                          ELSE
                            UPDATE dis_lote WITH (readcommitted)
                            SET    status = 2
                            WHERE  1 = 1
                                   AND codfil = Isnull(@SFILIAL, @HCODFIL)
                                   AND nlote = @NUMLOTE
                      END

                    IF Isnull(@TFLSEGURO, 'N') != 'S'
                      BEGIN
                          IF Isnull(@HLOTE, 'N') = 'S'
                            BEGIN
                                UPDATE mov_pedido WITH (readcommitted)
                                SET    status = 6,
                                       sitcarga = 3,
                                       numcxa = @SNUMCXA,
                                       flutilpedido = 'N'
                                WHERE  1 = 1
                                       AND codfil = Isnull(@SFILPED,
                                                    Isnull(@SFILIAL,
                                                    @HCODFIL
                                                    ))
                                       AND tipoped = @STIPOPED
                                       AND numpedven = @SNUMPEDVEN

                                UPDATE mov_itped WITH (readcommitted)
                                SET    status = 6,
                                       sitcarga = 3,
                                       tpnota = @STPNOTA,
                                       numnota = @SNUMNOTA,
                                       dtnota = @SDTNOTA
                                WHERE  1 = 1
                                       AND codfil = Isnull(@SFILPED,
                                                    Isnull(@SFILIAL,
                                                    @HCODFIL
                                                    ))
                                       AND tipoped = @STIPOPED
                                       AND numpedven = @SNUMPEDVEN
                            END
                          ELSE
                            BEGIN
                                UPDATE mov_pedido WITH (readcommitted)
                                SET    status = 6,
                                       numcxa = @SNUMCXA,
                                       flutilpedido = 'N'
                                WHERE  1 = 1
                                       AND codfil = Isnull(@SFILPED,
                                                    Isnull(@SFILIAL,
                                                    @HCODFIL
                                                    ))
                                       AND tipoped = @STIPOPED
                                       AND numpedven = @SNUMPEDVEN

                                UPDATE mov_itped WITH (readcommitted)
                                SET    status = 6,
                                       tpnota = @STPNOTA,
                                       numnota = @SNUMNOTA,
                                       dtnota = @SDTNOTA
                                WHERE  1 = 1
                                       AND codfil = Isnull(@SFILPED,
                                                    Isnull(@SFILIAL,
                                                    @HCODFIL
                                                    ))
                                       AND tipoped = @STIPOPED
                                       AND numpedven = @SNUMPEDVEN
                            END
                      END
                END

              UPDATE nf_saida WITH (readcommitted)
              SET    dtexportacao = Getdate()
              WHERE  1 = 1
                     AND filial = @SFILIAL
                     AND tpnota = @STPNOTA
                     AND numnota = @SNUMNOTA
                     AND serie = @SSERIE
                     AND dtnota = @SDTNOTA
       END
       ELSE
       BEGIN --Roberto Cesar - 135549
          IF @SFILIAL IS NULL
            UPDATE nf_saida WITH (readcommitted)
            SET    filial = @HCODFIL
            WHERE  1 = 1
                   AND tpnota = @STPNOTA
                   AND numnota = @SNUMNOTA
                   AND serie = @SSERIE
                   AND dtnota = @SDTNOTA

           --Roberto Cesar - 135549 - Início
           IF Isnull(@SNUMPEDVEN, 999999) NOT IN ( 0, 999999 )
           BEGIN
                 --Roberto Cesar - 239 - Início
                 if (@TFLSEGURO = 'S' AND @GFLVDASEGAVISTA = 'S')
                 BEGIN
	                 SET @PVLJUROS = 0
	                 SET @PVLJUROSFIN = 0
                 END
                 --Roberto Cesar - 239 - Fim
                 ELSE
                 BEGIN
	                 SELECT @PVLJUROSFIN = vljurosfin,
	                        @PVLJUROS = vljuros,
	                        @PVLTOTALPEDIDO = vltotal
	                 FROM   mov_pedido
	                 WHERE  1 = 1
	                    AND codfil = Isnull(@SFILPED, Isnull(@SFILIAL,
	                                                         @HCODFIL))
	                    AND tipoped = @STIPOPED
	                    AND numpedven = @SNUMPEDVEN
	
	                 SET @PPROPORCIONALNOTA = @SVLTOTAL / @PVLTOTALPEDIDO
	                 IF isnull(@PPROPORCIONALNOTA, 0) = 0 
	                    SET @PPROPORCIONALNOTA = 1
	
	                 SET @PVLJUROS = @PVLJUROS * @PPROPORCIONALNOTA
	                 SET @PVLJUROSFIN = @PVLJUROSFIN * @PPROPORCIONALNOTA
                 END
           END
        END --Roberto Cesar - 135549 - Fim 

        --Roberto Cesar - 135549 - Início
        UPDATE nf_saida WITH (readcommitted)
           SET VLJUROS = CASE WHEN ISNULL(@SVLJUROS,0) = 0 THEN ISNULL(@PVLJUROS, 0) ELSE ISNULL(@SVLJUROS, 0)END,
               VLJUROSFIN = CASE WHEN ISNULL(@SVLJUROSFIN, 0) = 0 THEN ISNULL(@PVLJUROSFIN, 0) ELSE ISNULL(@SVLJUROSFIN, 0)END
        WHERE  1 = 1
           AND filial = @SFILIAL
           AND tpnota = @STPNOTA
           AND numnota = @SNUMNOTA
           AND serie = @SSERIE
           AND dtnota = @SDTNOTA
        --Roberto Cesar - 135549 - Fim

        FETCH smart INTO @STPNOTA, @SNUMNOTA, @SSERIE, @SDTNOTA, @SDTEMISSAO,
        @SDTPEDIDO, @SDTCANCEL, @SDTENTREGA, @SCONDPGTO, @SESTADO, @SCODNATOP,
        @SNUMPEDVEN, @SCODCLI, @SCODVENDR, @SNUMCXA, @SLOCAL, @SPESO, @SOBS,
        @SVLDESCONTO, @SVLDESPFIN, @SVLMERCAD, @SVLSEGURO, @SSTATUS, @SVLTOTAL,
        @SPESOLIQ, @SHRHORA, @SHRDURACAO, @SVLJUROSFIN, @SPJUROS, @SDTATUEST,
        @SFLATUEST, @SDTNOTAPDV, @SFLNOTAPDV, @SNUMNOTAPDV, @SNUMPDV, @SSERIEPDV,
        @STPNOTAPDV, @SQTPRC, @SVLPRC, @SOBSFISCAL, @SDTLIBPED, @SVLBASEICMS,
        @SVLBASEICMSSUB, @SVLFRETE, @SVLOUTDESP, @SVLIPI, @SFLNFMANUAL, @STIPOPED,
        @SENDCOB, @SENDENT, @SPRACA, @SFILPED, @SIDENTPROC, @SVLMONTAGEM, @SVLICMS,
        @SFILIAL, @SNRSERIEECF, @SNUMPEDPRINC, @SCODFUNC, @SCODCONVENIO,
        @SFLMULTIREC, @SVLJUROS, @SVLISS, @SFLSEGURO, @SVLENTRADA, @SCODSUPCANCEL,
        @SNUMCONTRAFIN, @SCODOPER, @SCODNATOPDIF, @SCODNATOPCOMPL,
        @SCODNATOPDIFCOMPL, @SVLBASEICMORIGREPI, @SVLICMORIGREPI, @SVLICMREPI,
        @STOTCUPOMPROMOCIONAL, @SCARENCIA, @SVLTAC, @SVLTARBANCARIA, @SMODELONF,
        @SCGCCPF, @SVLIOFSEG, @SNUMCCF, @SNUMDAV, @SVERSAOPDV, @SNOMCLICUPOM,
        @SENDCLICUPOM, @VLBASEIPI, @ALIQIBPT, @VLIBPT, @STATUSNFE, @VERSAONFE, 
        @DIGNFE, @DTAUTORIZACAONFE, @DTCANCELAMENTONFE, @NUMNFE, @CHAVENFE, 
		@FLCONTINGENCIA, @TPAMBNFE, @FLNOTAMANUALPDV, @FLOFFLINE, @CODAUTDESCPDV, 
		@NUMCOO

        CONTINUE
    END

  CLOSE smart
  DEALLOCATE smart
GO





