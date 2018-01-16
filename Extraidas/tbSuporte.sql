--------------------------------------------------------------------------------
-- tbSuporte.sql
-- Data   : 26/08/2013
-- Autor  : Amauri
-- Criar as tabelas de suporte
--------------------------------------------------------------------------------

USE ArquivosAvon
GO

-- Bairros
Create Table Bairro (
  Bairro_ID           Int Identity(1,1) Primary Key,
  Municipio_ID        Int References Municipio(Municipio_ID),
  Nome                Varchar(30) Not Null
);
GO

-- Regiões
Create Table Regiao (
  Regiao_ID           Int Identity(1,1) Primary Key,
  Nome                Varchar(50) Not Null
);
GO

-- Divisões
Create Table Divisao (
  Divisao_ID          Int Identity(1,1) Primary Key,
  Nome                Varchar(50) Not Null
);
GO

-- Tipos de revendedoras
Create Table TipoRevendedora (
  TipoRevendedora_ID  Int Identity(1,1) Primary Key,
  Nome                Varchar(22) Not Null
);
GO

-- Tipos de 'estrelas'
Create Table Estrela (
  Estrela_ID          Int Identity(1,1) Primary Key,
  Nome                Varchar(12) Not Null
);
GO

-- Transportadoras
Create Table Transportadora (
  Transportadora_ID   Int Not Null Primary Key,
  Nome                Varchar(60) Not Null
);
GO

-- Bancos
Create Table Banco (
  Banco_ID            Int Not Null Primary Key,
  Nome                Varchar(30) Not Null
);
GO

-- Agências de cobrança
Create Table Agencia (
  Agencia_ID          Int Not Null Primary Key, -- (CS28.N_AGENCIA)
  Nome                Varchar(50) Not Null
);
GO

-- Locais de pagamento de boletos
-- Drop Table BoletoLocalPagto
Create Table BoletoLocalPagto (
  BoletoLocalPagto_ID         Int Identity(1,1) Not Null Primary Key,
  Nome                        Varchar(84) Not Null
);
GO

-- Cedentes de boletos
-- Drop Table BoletoCedente
Create Table BoletoCedente (
  BoletoCedente_ID            Int Identity(1,1) Not Null Primary Key,
  Nome                        Varchar(84) Not Null
);
GO

-- Agência Cod Cedente de boletos
-- Drop Table BoletoAgenciaCodCedente
Create Table BoletoAgenciaCodCedente (
  BoletoAgenciaCodCedente_ID  Int Identity(1,1) Not Null Primary Key,
  Nome                        Varchar(19) Not Null
);
GO

-- Instruções de boletos
-- Drop Table BoletoInstrucao
Create Table BoletoInstrucao (
  BoletoInstrucao_ID          Int Identity(1,1) Not Null Primary Key,
  Nome                        Varchar(98) Not Null
);
GO

-- FIM
