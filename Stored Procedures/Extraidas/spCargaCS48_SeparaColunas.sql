--------------------------------------------------------------------------------
-- spCargaCS48_SeparaColunas.sql
-- Data   : __/08/2013
-- Autor  : Christiane e Amauri
-- Stored procedure de carga inicial de arquivos CS48 
-- Apenas separa as colunas de uma linha
--------------------------------------------------------------------------------

USE ArquivosAvon
GO

Alter Procedure CargaCS48_SeparaColunas
(
  @pCargaInicial_ID   Int
)
AS

Set NoCount ON

Insert Into CargaInicialCS48 ( REGASC,
                               Nome,
                               Sexo,
                               Endereco,
                               Numero,
                               Comp,
                               Bairro,
                               Cidade,
                               UF,
                               CEP,
                               DDD,
                               TEL,
                               DDD_COM,
                               TEL_COM,
                               RAMAL,
                               DDD_REC,
                               TEL_REC,
                               DDD_CEL,
                               TEL_CEL,
                               CPF_RA,
                               RG_RA,
                               ORGAO_EMISSOR,
                               DT_NASCIMENTO,
                               DT_ESTABELECIMENTO,
                               ESTADO_CIVIL,
                               NOME_DO_PAI,
                               NOME_DA_MAE,
                               EMAIL,
                               CONJUGE,
                               ORDER_ID,
                               CAMPANHA,
                               ANO_CAMPANHA,
                               VALOR_PENDENCIA,
                               DT_FATURAMENTO,
                               DT_VENCIMENTO,
                               DT_EXPIRACAO,
                               DATA_ENVIO,
                               SETOR,
                               COMISSAO,
                               JUROS,
                               NUMERO_DI )
                                      
Select LTrim(RTrim(Substring(Dados,   2,  8))) as REGASC,
       LTrim(RTrim(Substring(Dados,  10, 50))) as Nome,
       LTrim(RTrim(Substring(Dados,  60,  1))) as Sexo,
       LTrim(RTrim(Substring(Dados,  61, 60))) as Endereco,
       LTrim(RTrim(Substring(Dados, 121,  5))) as Numero,
       LTrim(RTrim(Substring(Dados, 126, 20))) as Comp,
       LTrim(RTrim(Substring(Dados, 146, 30))) as bairro,
       LTrim(RTrim(Substring(Dados, 176, 20))) as cidade,
       LTrim(RTrim(Substring(Dados, 196,  2))) as UF,
       LTrim(RTrim(Substring(Dados, 198,  8))) as CEP,
       LTrim(RTrim(Substring(Dados, 206,  3))) as DDD,
       LTrim(RTrim(Substring(Dados, 209,  8))) as TEL,
       LTrim(RTrim(Substring(Dados, 217,  3))) as DDD_COM,
       LTrim(RTrim(Substring(Dados, 217,  8))) as TEL_COM,
       LTrim(RTrim(Substring(Dados, 228,  5))) as RAMAL,
       LTrim(RTrim(Substring(Dados, 233,  3))) as DDD_REC,
       LTrim(RTrim(Substring(Dados, 233,  8))) as TEL_REC,
       LTrim(RTrim(Substring(Dados, 244,  3))) as DDD_CEL,
       LTrim(RTrim(Substring(Dados, 244,  8))) as TEL_CEL,       
       LTrim(RTrim(Substring(Dados, 255, 11))) as CPF_RA,
       LTrim(RTrim(Substring(Dados, 266, 11))) as RG_RA,
       LTrim(RTrim(Substring(Dados, 277,  5))) as ORGAO_EMISSOR,
       LTrim(RTrim(Substring(Dados, 282,  8))) as DT_NASCIMENTO,
       LTrim(RTrim(Substring(Dados, 290,  8))) as DT_ESTABELECIMENTO,
       LTrim(RTrim(Substring(Dados, 298,  1))) as ESTADO_CIVIL,
       LTrim(RTrim(Substring(Dados, 299, 50))) as NOME_DO_PAI,
       LTrim(RTrim(Substring(Dados, 349, 50))) as NOME_DA_MAE,
       LTrim(RTrim(Substring(Dados, 399, 50))) as EMAIL,
       LTrim(RTrim(Substring(Dados, 449, 50))) as CONJUGE,
       LTrim(RTrim(Substring(Dados, 499,  8))) as ORDER_ID,
       LTrim(RTrim(Substring(Dados, 507,  2))) as CAMPANHA,
       LTrim(RTrim(Substring(Dados, 509,  4))) as ANO_CAMPANHA,
       LTrim(RTrim(Substring(Dados, 513, 13))) as VALOR_PENDENCIA,
       LTrim(RTrim(Substring(Dados, 526,  8))) as DT_FATURAMENTO,
       LTrim(RTrim(Substring(Dados, 534,  8))) as DT_VENCIMENTO,
       LTrim(RTrim(Substring(Dados, 542,  8))) as DT_EXPIRACAO,
       LTrim(RTrim(Substring(Dados, 550,  8))) as DATA_ENVIO,
       LTrim(RTrim(Substring(Dados, 558,  4))) as SETOR,
       LTrim(RTrim(Substring(Dados, 562, 13))) as COMISSAO,
       LTrim(RTrim(Substring(Dados, 575, 13))) as JUROS,
       LTrim(RTrim(Substring(Dados, 588, 16))) as NUMERO_DI
       
From   CargaInicial (nolock)
Where  CargaInicial_ID = @pCargaInicial_ID

-- FIM
