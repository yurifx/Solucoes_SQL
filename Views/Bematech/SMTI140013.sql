PRINT ' '
PRINT ' '
PRINT ' '
PRINT ' -- **************************************'
PRINT ' -- **            SMTI140013.sql ' 
PRINT ' -- **************************************'


 -- Atualiza tabela de controle de scripts executados
insert into gemco_scripts_executados (script, dthrexecucao) select 'SMTI140013.sql', getdate()
go

IF EXISTS (SELECT NAME FROM SYSOBJECTS WHERE NAME = 'PARAMETROS' and TYPE='V')
 DROP VIEW dbo.PARAMETROS
GO
create view dbo.PARAMETROS
(
 RAZSOC,FANTASIA,ENDERECO,NUMERO,COMPLEMENTO,CIDADE,ESTADO,CGCCPF,INSCRICAO,
 DTPROC,CODEVESALDOCXA,CONDPGTODEFAULT,CODEVEDEFAULT,LIMITESANGRIA,TIPOSISTEMA,
 MSGPROMPDV,CODFIL,FLABATECOMISSAO,FLVALIDAESTOQPDV,FLUTILIZACENTRAL,ISS,INSCMUNIC,
 BAIRRO, MSGTROCA
)
as
--**********************************************************************
--* View para listar PARAMETROS no SMARTECF.                           *
--* Limite Sangria e CODEVE estao zerados, pois nao existem correspon- *
--* dentes no gemco - Jorge Devitte                                    *
--* Set 12, 2002 - Cristina Co - D005311 - Versao 01                   *
--* Set 19, 2002 - Cristina Co -         - Versao 02 - Utilizar RAZSOC *
--*  da GER_EMPRESA e nao da CAD_FILIAL (Jhonson).                     *
--* Set 25, 2002 - Cristina Co -         - Versao 03 - Acrescenta colu-*
--*  na CODFIL.                                                        *
--* Mar 20, 2003 - Cristina Co - D005792 - Versao 04 - Acrescenta colu-*
--*  na FLABATECOMISSAO (fixo 'N') - Tango.                            *
--* Abr 04, 2003 - Cristina Co - D005814 - Versao 05 - Acrescenta colu-*
--*  na FLVALIDAESTOQPDV (fixo null) - FCampos.                        *
--* Mai 05, 2003 - Cristina Co - D005873 - Versao 06 - Acrescenta colu-*
--*  na FLUTILIZACENTRAL (fixo 'N') - Jhonson.                         *
--* Set 29, 2003 - Cristina Co - D006180 - Versao 07 - Acrescentar no  *
--*  join da GER_EMPRESA a clausula CHAVE = 1 (RRodrigues).            *
--* Abr 15, 2004 - Cristina Co - D006803 - Versao 08 - Acrescenta colu-*
--*  na CAD_FILIAL.ISS. (COkamoto).                                    *
--* Set 29, 2011 - Andre Baptista - D006803 - Acrescenta coluna        *
--*  na CAD_FILIAL.INSCMUNIC (Cesar Camargo).                          *
--* Abr 09, 2014 - Priscilla Fernandes - acrescentar o Bairro  
--* Set 04, 2014 - Yuri Vasconcelos - Adicionar campo MSGTROCA         *
--**********************************************************************
SELECT     EMP.RAZSOC, FIL.FANTASIA, FIL.ENDERECO, FIL.NUMERO, FIL.COMPLEMENTO, FIL.CIDADE, FIL.ESTADO, FIL.CGCCPF, FIL.INSCRICAO, FIL.DTPROC, 
           EMP.CODEVESALDOCXA, FIL.CONDPGDEF AS CONDPGTODEFAULT, 0 AS CODEVEDEFAULT, 0 AS LIMITESANGRIA, 1057 AS TIPOSISTEMA, ISNULL(MSG.DESCRICAO, 
           '') AS MSGPROMPDV, UC.CODFIL, 'N' AS FLABATECOMISSAO, NULL AS FLVALIDAESTOQPDV, 'N' AS FLUTILIZACENTRAL, FIL.ISS, FIL.INSCMUNIC, FIL.BAIRRO, 
           MSGTROCA.DESCRICAO AS MSGTROCA         
FROM dbo.GER_EMPRESA AS EMP
	INNER JOIN dbo.USUARIOBD_CODFIL AS UC ON UC.USUARIO = SYSTEM_USER
	INNER JOIN dbo.CAD_FILIAL AS FIL ON FIL.CODFIL = UC.CODFIL 
	LEFT OUTER JOIN dbo.CAD_FILIAL_compl AS FIC ON FIC.CODFIL = UC.CODFIL 
	LEFT OUTER JOIN dbo.CAD_MENSAG AS MSG ON MSG.CODMENSAG = FIL.CODMENSAG 
	LEFT OUTER JOIN dbo.CAD_MSGCUPOMTROCAPDV AS MSGTROCA ON MSGTROCA.codmsg = FIC.CODMSGTROCAPDV
WHERE     (EMP.CHAVE = 1)
go