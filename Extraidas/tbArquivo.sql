--------------------------------------------------------------------------------
-- tbAquivo.sql
-- Data   : 14/08/2013
-- Autor  : Amauri
-- Criar a tabela de controle de importação dos arquivos
--------------------------------------------------------------------------------

USE ArquivosAvon
GO

Create Table Arquivo (
  Arquivo_ID          Int Identity Primary Key,
  DataHora            DateTime,      -- Data e hora da importação
  Nome                Varchar(80),   -- Nome do arquivo (só o nome, sem o caminho)
  Tipo                Varchar(10),   -- 'CS28', 'BA01', etc.
  QtdLinhasLidas      Int,           -- Quantidade de linhas lidas do arquivo
  QtdLinhasGravadas   Int,           -- Quantidade de linhas gravadas
  ComErros            Bit            -- 1:Arquivo importado com erros  0:Importado sem erros
);
  
GO

-- FIM
