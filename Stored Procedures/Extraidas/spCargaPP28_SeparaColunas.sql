--------------------------------------------------------------------------------
-- spCargaPP28_SeparaColunas.sql
-- Data   : 20/08/2013
-- Autor  : Amauri
-- Stored procedure de carga inicial de arquivos PP28 
-- Apenas separa as colunas de uma linha
--------------------------------------------------------------------------------

USE ArquivosAvon
GO

Alter Procedure CargaPP28_SeparaColunas
(
  @pCargaInicial_ID   Int
)
AS

Set NoCount ON

Insert Into CargaInicialPP28 ( Setor,
                               RegAsc,
                               Nome_Ra,
                               Dt_Lacto,
                               AD,
                               Vlr_Deb,
                               Ano_Cp,
                               Cp,
                               Vlr_Saldo )   
Select LTrim(RTrim(Substring(Dados,  1,  4)))  as Setor,
       LTrim(RTrim(Substring(Dados,  5,  8)))  as RegAsc,
       LTrim(RTrim(Substring(Dados, 13, 50)))  as Nome_Ra,
       LTrim(RTrim(Substring(Dados, 63, 10)))  as Dt_Lacto,
       LTrim(RTrim(Substring(Dados, 73,  6)))  as AD,
       LTrim(RTrim(Substring(Dados, 79, 12)))  as Vlr_Deb,
       LTrim(RTrim(Substring(Dados, 91,  4)))  as Ano_Cp,
       LTrim(RTrim(Substring(Dados, 95,  2)))  as Cp,
       LTrim(RTrim(Substring(Dados, 97, 12)))  as Vlr_Saldo
                               
From   CargaInicial (nolock)
Where  CargaInicial_ID = @pCargaInicial_ID

-- FIM
