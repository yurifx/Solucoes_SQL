--------------------------------------------------------------------------------
-- spCargaCS13_ConverteDados.sql
-- Data   : __/08/2013
-- Autor  : ___
-- Stored procedure de carga inicial de arquivos CS13 
-- Apenas converte os dados de uma linha
--------------------------------------------------------------------------------

USE ArquivosAvon
GO

Alter Procedure CargaCS13_ConverteDados
(
  @pCargaInicialCS13_ID Int
)
AS

Set NoCount ON

Insert Into ConversaoCS13 ( ModeloLayout, 
                            TRANSACAO, 
                            RECIBO, 
                            REGISTRO_ASC, 
                            DATA_TRANSACAO, 
                            SETOR, 
                            VALOR, 
                            USUARIO, 
                            HISTORICO, 
                            TIPO_AGENCIA, 
                            DATA_TRANSFERENCIA, 
                            AGENCIA, 
                            VALOR_PRINCIPAL, 
                            JUROS, 
                            TIMESTAMP, 
                            SETOR_REV_COBRANCA, 
                            Program_ID, 
                            Campanha, 
                            AnoCampanha, 
                            AvisoDebito, 
                            DataFaturamento ) 
                             
                     Select ModeloLayout, 
                            Convert(SmallInt, TRANSACAO), 
                            Convert(Int,      RECIBO), 
                            Convert(Int,      REGISTRO_ASC),                              
                            Convert(SmallDateTime, Stuff(Stuff(DATA_TRANSACAO, 5,0,'/'),3,0,'/'), 103), -- ddmmyyyy -> dd/mm/yyyy
                            Convert(SmallInt, SETOR), 
                            Convert(Money,    VALOR) / 100, 
                            USUARIO, 
                            HISTORICO, 
                            TIPO_AGENCIA, 
                            Convert(SmallDateTime, Replace(DATA_TRANSFERENCIA, '-', ''), 112), -- yyyy-mm-dd -> yyyymmdd
                            Convert(SmallInt, AGENCIA), 
                            Convert(Money,    VALOR_PRINCIPAL) / 100, 
                            Convert(Money,    JUROS) / 100,
                            Convert(DateTime, Stuff( Replace(Left(TIMESTAMP,19), '.', ':'), 11,1,' '), 120), -- yyyy-mm-dd.hh.mi.ss.mmmmmm -> yyyy-mm-dd hh:mi:ss 
                            
                            Case 
                              When SETOR_REV_COBRANCA Is Not Null  Then  Convert(SmallInt, SETOR_REV_COBRANCA)
                              Else                                       Null
                            End,
                              
                            Program_ID, 

                            Case 
                              When Campanha Is Not Null            Then  Convert(TinyInt,  Campanha)
                              Else                                       Null
                            End,
                             
                            Case 
                              When AnoCampanha Is Not Null         Then  Convert(SmallInt, AnoCampanha)
                              Else                                       Null
                            End,
                             
                            Case 
                              When AvisoDebito Is Not Null         Then  Convert(Int,      AvisoDebito)
                              Else                                       Null
                            End,
                            
                            Case 
                              When DataFaturamento Is Not Null     Then  Convert(SmallDateTime, Replace(DataFaturamento, '-', ''), 112) -- yyyy-mm-dd -> yyyymmdd
                              Else                                       Null
                            End                            
                             
From CargaInicialCS13 (nolock)
Where  CargaInicialCS13_ID = @pCargaInicialCS13_ID

-- FIM
