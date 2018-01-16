--------------------------------------------------------------------------------
-- tbLog.sql
-- Data   : 14/08/2013
-- Autor  : Amauri
-- Criar a tabela de LOG
--------------------------------------------------------------------------------

USE ArquivosAvon
GO

-- Drop Table Log
Create Table Log (
  Log_ID              Int Identity Primary Key,
  DataHora            DateTime,
  Origem              Varchar(80),     -- Nome da stored procedure
  Tipo                Char(1),         -- E=Erro S=Status
  Mensagem            Varchar(100),    -- Mensagem de erro ou de sucesso
  Arquivo             Varchar(80),     -- Nome do arquivo
  Complemento         Varchar(4000)    -- Complemento da mensagem
);
  
GO

-- FIM
