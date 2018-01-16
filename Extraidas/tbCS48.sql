--------------------------------------------------------------------------------
-- tbCS48.sql
-- Data   : 28/08/2013
-- Autor  : Amauri
-- Criar a tabela de informações de arquivos CS48
--------------------------------------------------------------------------------

USE ArquivosAvon
GO

-- DROP Table CS48
Create Table CS48 (
  CS48_ID            Int Identity(1,1) Primary Key,
  Arquivo_ID         Int References Arquivo(Arquivo_ID),
  Revendedora_ID     Int References Revendedora(Revendedora_ID), -- Identificação da revendedora = RegASC
  AvisoDebito        Int, 
  NumeroDI           Varchar(16), 
  CampanhaNro        TinyInt, 
  CampanhaAno        SmallInt, 
  DtFaturamento      SmallDateTime, 
  DtVencimento       SmallDateTime, 
  DtExpiracao        SmallDateTime, 
  DtEnvio            SmallDateTime, 
  ValorPendencia     Money, 
  Comissao           Money, 
  Juros              Money  
);

GO
