--------------------------------------------------------------------------------
-- spCargaFS3_ConverteDados.sql
-- Data   : __/08/2013
-- Autor  : ___
-- Stored procedure de carga inicial de arquivos FS3 
-- Apenas converte os dados de uma linha
--------------------------------------------------------------------------------

USE ArquivosAvon
GO

Alter Procedure CargaFS3_ConverteDados
(
  @pCargaInicialFS3_ID Int
)
AS

Set NoCount ON

Insert Into ConversaoFS3 ( CodigoRevendedoraAsc, 
                            OrderId, 
                            CampanhaFaturamento, 
                            AnoCampanhaFaturamento, 
                            ValorDebito, 
                            ValorPagamento, 
                            DataBaixa, 
                            DataEnvio, 
                            TipoBaixa )
                             
                     Select Convert(Int, CodigoRevendedoraAsc),
                            Convert(Int, OrderId),
                            Convert(TinyInt, CampanhaFaturamento), 
                            Convert(SmallInt, AnoCampanhaFaturamento), 
                            Convert(Money,  ValorDebito)    / 100, 
                            Convert(Money,  ValorPagamento) / 100,                            
                            Convert(SmallDateTime, Stuff(Stuff(DataBaixa, 5,0,'/'),3,0,'/'), 103), -- ddmmyyyy -> dd/mm/yyyy
                            Convert(SmallDateTime, Stuff(Stuff(DataEnvio, 5,0,'/'),3,0,'/'), 103), -- ddmmyyyy -> dd/mm/yyyy
                            TipoBaixa 
                             
From CargaInicialFS3 (nolock)
Where  CargaInicialFS3_ID = @pCargaInicialFS3_ID

-- FIM
