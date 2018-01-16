--------------------------------------------------------------------------------
-- spCargaCS28_SeparaColunas.sql
-- Data   : 15/08/2013
-- Autor  : Christiane e Amauri
-- Stored procedure de carga inicial de arquivos CS28 
-- Apenas separa as colunas de uma linha
--------------------------------------------------------------------------------

USE ArquivosAvon
GO

Alter Procedure CargaCS28_SeparaColunas
(
  @pCargaInicial_ID   Int
)
AS

Set NoCount ON

Insert Into CargaInicialCS28 ( AVISO_DEBITO, 
                               NOME, 
                               SETOR, 
                               REGASC, 
                               DT_NASCIMENTO, 
                               RG_RA, 
                               CPF_RA, 
                               DDD_TEL, 
                               ENDERECO, 
                               NUMERO, 
                               COMP, 
                               BAIRRO, 
                               CEP, 
                               CIDADE, 
                               UF, 
                               DT_ESTABELECIMENTO, 
                               EQUIPE, 
                               LOS, 
                               AGENCIA, 
                               NF, 
                               DT_NF, 
                               CAMPANHA, 
                               DT_ENVIO_RA_COB, 
                               DT_DEVOLUCAO, 
                               N_AGENCIA, 
                               NOME_RA_INDICA, 
                               END_RA_INDICA, 
                               NUEMERO_RA_INDICA, 
                               COMP_RA_INDICA, 
                               BAIRRO_RA_INDICA, 
                               CEP_RA_INDICA, 
                               CIDADE_RA_INDICA, 
                               UF_RA_INDICA, 
                               REGASC_RA_INDICA, 
                               VALOR_DEBITO,
                               CAMPANHA_ANO )
                               
Select LTrim(RTrim(Substring(Dados,  1,7)))  as AVISO_DEBITO,
       LTrim(RTrim(Substring(Dados,  8,50))) as NOME,
       LTrim(RTrim(Substring(Dados, 58,3)))  as SETOR,
       LTrim(RTrim(Substring(Dados, 61,8)))  as REGASC,
       LTrim(RTrim(Substring(Dados, 74,10))) as DT_NASCIMENTO,
       LTrim(RTrim(Substring(Dados, 84,13))) as RG_RA,
       LTrim(RTrim(Substring(Dados, 97,14))) as CPF_RA,
       LTrim(RTrim(Substring(Dados,111,17))) as DDD_TEL,
       LTrim(RTrim(Substring(Dados,128,60))) as ENDERECO,
       LTrim(RTrim(Substring(Dados,188,5)))  as NUMERO,
       LTrim(RTrim(Substring(Dados,193,20))) as COMP,
       LTrim(RTrim(Substring(Dados,213,30))) as BAIRRO,
       LTrim(RTrim(Substring(Dados,243,8)))  as CEP,
       LTrim(RTrim(Substring(Dados,251,20))) as CIDADE,
       LTrim(RTrim(Substring(Dados,271,2)))  as UF,
       LTrim(RTrim(Substring(Dados,333,10))) as DT_ESTABELECIMENTO,
       LTrim(RTrim(Substring(Dados,469,3)))  as EQUIPE,
       LTrim(RTrim(Substring(Dados,473,3)))  as LOS,
       LTrim(RTrim(Substring(Dados,476,33))) as AGENCIA,
       LTrim(RTrim(Substring(Dados,512,7)))  as NF,
       LTrim(RTrim(Substring(Dados,519,8)))  as DT_NF,
       LTrim(RTrim(Substring(Dados,527,2)))  as CAMPANHA,
       LTrim(RTrim(Substring(Dados,538,8)))  as DT_ENVIO_RA_COB,
       LTrim(RTrim(Substring(Dados,546,8)))  as DT_DEVOLUCAO,
       LTrim(RTrim(Substring(Dados,554,3)))  as N_AGENCIA,
       LTrim(RTrim(Substring(Dados,762,50))) as NOME_RA_INDICA,
       LTrim(RTrim(Substring(Dados,812,60))) as END_RA_INDICA,
       LTrim(RTrim(Substring(Dados,872,5)))  as NUEMERO_RA_INDICA,
       LTrim(RTrim(Substring(Dados,877,20))) as COMP_RA_INDICA,
       LTrim(RTrim(Substring(Dados,897,30))) as BAIRRO_RA_INDICA,
       LTrim(RTrim(Substring(Dados,927,8)))  as CEP_RA_INDICA,
       LTrim(RTrim(Substring(Dados,935,20))) as CIDADE_RA_INDICA,
       LTrim(RTrim(Substring(Dados,955,2)))  as UF_RA_INDICA,
       LTrim(RTrim(Substring(Dados,967,8)))  as REGASC_RA_INDICA,
       LTrim(RTrim(Substring(Dados,1144,11))) as VALOR_DEBITO,
       LTrim(RTrim(Substring(Dados,2003,4))) as CAMPANHA_ANO
       
From   CargaInicial (nolock)
Where  CargaInicial_ID = @pCargaInicial_ID

-- FIM
