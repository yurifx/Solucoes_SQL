--------------------------------------------------------------------------------
-- spCargaFS1_SeparaColunas.sql
-- Data   : 19/08/2013
-- Autor  : Amauri
-- Stored procedure de carga inicial de arquivos FS1 
-- Apenas separa as colunas de uma linha
--------------------------------------------------------------------------------

USE ArquivosAvon
GO

Alter Procedure CargaFS1_SeparaColunas
(
  @pCargaInicial_ID   Int
)
AS

Set NoCount ON

Insert Into CargaInicialFS1 ( CodigoRevendedoraAsc,
                              NomeRevendedora,
                              Sexo,
                              EnderecoRevendedora,
                              Numero,
                              Complemento,
                              Bairro,
                              Cidade,
                              UF,
                              CEP,
                              DDDResidencial,
                              TelefoneResidencial,
                              DDDComercial,
                              TelefoneComercial,
                              RamalComercial,
                              DDDRecados,
                              TelefoneRecados,
                              DDDCelular,
                              TelefoneCelular,
                              CPF,
                              RG,
                              OrgaoEmissor,
                              DataNascimento,
                              DataEstabelecimento,
                              EstadoCivil,
                              NomePai,
                              NomeMae,
                              Email,
                              NomeConjuge,
                              OrderId,
                              CampanhaFaturamento,
                              AnoCampanhaFaturamento,
                              ValorDebito,
                              DataFaturamento,
                              DataVencimento,
                              DataExpiracaoBoleto,
                              DataEnvio,
                              Setor )

Select LTrim(RTrim(Substring(Dados,   2,  8)))  as CodigoRevendedoraAsc,
       LTrim(RTrim(Substring(Dados,  10, 50)))  as NomeRevendedora,
       LTrim(RTrim(Substring(Dados,  60,  1)))  as Sexo,
       LTrim(RTrim(Substring(Dados,  61, 60)))  as EnderecoRevendedora,
       LTrim(RTrim(Substring(Dados, 121,  5)))  as Numero,
       LTrim(RTrim(Substring(Dados, 126, 20)))  as Complemento,
       LTrim(RTrim(Substring(Dados, 146, 30)))  as Bairro,
       LTrim(RTrim(Substring(Dados, 176, 20)))  as Cidade,
       LTrim(RTrim(Substring(Dados, 196,  2)))  as UF,
       LTrim(RTrim(Substring(Dados, 198,  8)))  as CEP,
       LTrim(RTrim(Substring(Dados, 206,  3)))  as DDDResidencial,
       LTrim(RTrim(Substring(Dados, 209,  8)))  as TelefoneResidencial,
       LTrim(RTrim(Substring(Dados, 217,  3)))  as DDDComercial,
       LTrim(RTrim(Substring(Dados, 220,  8)))  as TelefoneComercial,
       LTrim(RTrim(Substring(Dados, 228,  5)))  as RamalComercial,
       LTrim(RTrim(Substring(Dados, 233,  3)))  as DDDRecados,
       LTrim(RTrim(Substring(Dados, 236,  8)))  as TelefoneRecados,
       LTrim(RTrim(Substring(Dados, 244,  3)))  as DDDCelular,
       LTrim(RTrim(Substring(Dados, 247,  8)))  as TelefoneCelular,
       LTrim(RTrim(Substring(Dados, 255, 11)))  as CPF,
       LTrim(RTrim(Substring(Dados, 266, 11)))  as RG,
       LTrim(RTrim(Substring(Dados, 277,  5)))  as OrgaoEmissor,
       LTrim(RTrim(Substring(Dados, 282,  8)))  as DataNascimento,
       LTrim(RTrim(Substring(Dados, 290,  8)))  as DataEstabelecimento,
       LTrim(RTrim(Substring(Dados, 298,  1)))  as EstadoCivil,
       LTrim(RTrim(Substring(Dados, 299, 50)))  as NomePai,
       LTrim(RTrim(Substring(Dados, 349, 50)))  as NomeMae,
       LTrim(RTrim(Substring(Dados, 399, 50)))  as Email,
       LTrim(RTrim(Substring(Dados, 449, 50)))  as NomeConjuge,
       LTrim(RTrim(Substring(Dados, 499,  8)))  as OrderId,
       LTrim(RTrim(Substring(Dados, 507,  2)))  as CampanhaFaturamento,
       LTrim(RTrim(Substring(Dados, 509,  4)))  as AnoCampanhaFaturamento,
       LTrim(RTrim(Substring(Dados, 513, 13)))  as ValorDebito,
       LTrim(RTrim(Substring(Dados, 526,  8)))  as DataFaturamento,
       LTrim(RTrim(Substring(Dados, 534,  8)))  as DataVencimento,
       LTrim(RTrim(Substring(Dados, 542,  8)))  as DataExpiracaoBoleto,
       LTrim(RTrim(Substring(Dados, 550,  8)))  as DataEnvio,
       LTrim(RTrim(Substring(Dados, 558,  4)))  as Setor
       
From   CargaInicial (nolock)
Where  CargaInicial_ID = @pCargaInicial_ID

-- FIM
