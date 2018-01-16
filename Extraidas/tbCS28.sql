--------------------------------------------------------------------------------
-- tbCS28.sql
-- Data   : 27/08/2013
-- Autor  : Amauri
-- Criar a tabela de informações de arquivos CS28
--------------------------------------------------------------------------------

USE ArquivosAvon
GO

-- DROP Table CS28
Create Table CS28 (
  CS28_ID            Int Identity(1,1) Primary Key,           
  Arquivo_ID         Int References Arquivo(Arquivo_ID),
  Revendedora_ID     Int References Revendedora(Revendedora_ID), -- Identificação da revendedora = RegASC
  Agencia_ID         Int References Agencia(Agencia_ID),
  AvisoDebito        Int,
  NF                 Int,
  DtNF               SmallDateTime,
  CampanhaNro        TinyInt,
  CampanhaAno        SmallInt,
  DtEnvioCobranca    SmallDateTime,
  DtDevolucao        SmallDateTime,
  ValorDebito        Money
);

GO
