--------------------------------------------------------------------------------
-- tbFS1.sql
-- Data   : 29/08/2013
-- Autor  : Amauri
-- Criar a tabela de informações de arquivos FS1
--------------------------------------------------------------------------------

USE ArquivosAvon
GO

-- DROP Table FS1
Create Table FS1 (
  FS1_ID             Int Identity(1,1) Primary Key,
  Arquivo_ID         Int References Arquivo(Arquivo_ID),
  Revendedora_ID     Int References Revendedora(Revendedora_ID), -- Identificação da revendedora = RegASC
  AvisoDebito        Int,
  CampanhaNro        TinyInt, 
  CampanhaAno        SmallInt, 
  DtFaturamento      SmallDateTime, 
  DtVencimento       SmallDateTime, 
  DtExpiracao        SmallDateTime, 
  DtEnvio            SmallDateTime, 
  ValorDebito        Money  
);

GO
