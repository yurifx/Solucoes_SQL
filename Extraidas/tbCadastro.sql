--------------------------------------------------------------------------------
-- tbCadastro.sql
-- Data   : 26/08/2013
-- Autor  : Amauri
-- Criar as tabelas de dados cadastrais das revendedoras
--------------------------------------------------------------------------------

USE ArquivosAvon
GO

-- Informações gerais de revendedoras
-- Drop Table Revendedora
Create Table Revendedora (
  Revendedora_ID     Int Primary Key,                             -- Identificação = RegASC
  Indicante_ID       Int References Revendedora(Revendedora_ID),  -- RegASC da indicante
  Municipio_ID       Int References Municipio(Municipio_ID),
  Bairro_ID          Int References Bairro(Bairro_ID),
  Regiao_ID          Int References Regiao(Regiao_ID),
  Divisao_ID         Int References Divisao(Divisao_ID),
  TipoRevendedora_ID Int References TipoRevendedora(TipoRevendedora_ID),
  Estrela_ID         Int References Estrela(Estrela_ID),
  Arquivo_ID         Int References Arquivo(Arquivo_ID),          -- Fonte de dados mais recente
  Setor              SmallInt,
  Equipe             TinyInt,
  LOS                SmallInt,
  Status             Char(1),
  FlagE              Char(1),
  Classificacao      Char(1),
  Nome               Varchar(50),
  Sexo               Char(1),
  CPF                Varchar(11),           -- Apenas números, sem pontos nem traço 111.222.333-44
  RGNumero           Varchar(13),
  RGOrgaoEmissor     Varchar(5),
  Email              Varchar(50),
  DtNascimento       SmallDateTime,
  DtEstabelecimento  SmallDateTime,
  EstCivil           Char(1),
  NomePai            Varchar(50),
  NomeMae            Varchar(50),
  Conjuge            Varchar(50),
  EndLogradouro      Varchar(65),
  EndNumero          Varchar(5),
  EndComplemento     Varchar(20),
  EndCep             Varchar(8) 
);
GO

-- Informações gerais de revendedoras
-- Drop Table Rev_Telefone
Create Table Rev_Telefone (
  Rev_Telefone_ID     Int Identity(1,1) Not Null Primary Key,
  Revendedora_ID      Int References  Revendedora(Revendedora_ID),
  Tipo                Char(1), -- P=Principal C=Comercial R=Recado M=Móvel (celular)
  DDD                 Varchar(4),
  Numero              Varchar(9),
  Ramal               Varchar(5)
);
GO

-- FIM