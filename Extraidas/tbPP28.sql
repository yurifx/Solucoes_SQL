--------------------------------------------------------------------------------
-- tbPP28.sql
-- Data   : 02/09/2013
-- Autor  : Amauri
-- Criar a tabela de informações de arquivos PP28
--------------------------------------------------------------------------------

USE ArquivosAvon
GO

-- DROP Table PP28
Create Table PP28 (
  PP28_ID            Int Identity(1,1) Primary Key,           
  Arquivo_ID         Int References Arquivo(Arquivo_ID),
  Revendedora_ID     Int References Revendedora(Revendedora_ID), -- Identificação da revendedora = RegASC
  AvisoDebito        Int, 
  DtLancamento       SmallDateTime,
  CampanhaNro        TinyInt,
  CampanhaAno        SmallInt,
  ValorDebito        Money,
  ValorSaldo         Money 
);

GO
