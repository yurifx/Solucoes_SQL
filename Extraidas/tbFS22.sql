--------------------------------------------------------------------------------
-- tbFS22.sql
-- Data   : 29/08/2013
-- Autor  : Amauri
-- Criar a tabela de informações de arquivos FS22
--------------------------------------------------------------------------------

USE ArquivosAvon
GO

-- DROP Table FS22
Create Table FS22 (
  FS22_ID                     Int Identity(1,1) Primary Key,
  Arquivo_ID                  Int References Arquivo(Arquivo_ID),
  Revendedora_ID              Int References Revendedora(Revendedora_ID), -- Identificação da revendedora = RegASC
  Banco_ID                    Int References Banco(Banco_ID),  
  BoletoLocalPagto_ID         Int References BoletoLocalPagto(BoletoLocalPagto_ID),
  BoletoCedente_ID            Int References BoletoCedente(BoletoCedente_ID),
  BoletoAgenciaCodCedente_ID  Int References BoletoAgenciaCodCedente(BoletoAgenciaCodCedente_ID),
  BoletoInstrucao1_ID         Int References BoletoInstrucao(BoletoInstrucao_ID),
  BoletoInstrucao2_ID         Int References BoletoInstrucao(BoletoInstrucao_ID),
  BoletoInstrucao3_ID         Int References BoletoInstrucao(BoletoInstrucao_ID),
  BoletoInstrucao4_ID         Int References BoletoInstrucao(BoletoInstrucao_ID),
  BoletoInstrucao5_ID         Int References BoletoInstrucao(BoletoInstrucao_ID),
  BoletoInstrucao6_ID         Int References BoletoInstrucao(BoletoInstrucao_ID),
  BoletoInstrucao7_ID         Int References BoletoInstrucao(BoletoInstrucao_ID),
  BoletoInstrucao8_ID         Int References BoletoInstrucao(BoletoInstrucao_ID),
  BoletoInstrucao9_ID         Int References BoletoInstrucao(BoletoInstrucao_ID),
  LinhaDigitavel              Varchar(60),
  Parcela                     Varchar(7),
  Vencimento                  SmallDateTime,
  Campanha                    TinyInt,
  AvisoDebito                 Int,
  DataDocumento               SmallDateTime,
  NumeroDocumento             Varchar(10),
  EspecieDocumento            Varchar(2),
  Aceite                      Char(1),
  DataProcessamento           SmallDateTime,
  NossoNumero                 Varchar(21),
  UsoBanco                    Varchar(4),
  Carteira                    Varchar(3),
  Moeda                       Varchar(4),
  Quantidade                  Varchar(5),
  Valor                       Money,
  ValorDocumento              Money,
  Cip                         SmallInt,
  Bonificacao                 Money,
  Comissao                    Money,
  Codigobarras                Varchar(44)
);

GO
