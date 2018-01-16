--------------------------------------------------------------------------------
-- spCargaBA01_ConverteDados.sql
-- Data   : __/08/2013
-- Autor  : ___
-- Stored procedure de carga inicial de arquivos BA01 
-- Apenas converte os dados de uma linha
--------------------------------------------------------------------------------

USE ArquivosAvon
GO

Alter Procedure CargaBA01_ConverteDados
(
  @pCargaInicialBA01_ID Int
)
AS

Set NoCount ON

Insert Into ConversaoBA01 ( ModeloLayout, 
                            DebCred, 
                            Setor, 
                            RegAsc, 
                            CampanhaNro, 
                            CampanhaAno, 
                            NroDocumento, 
                            Transacao, 
                            SubTransacao, 
                            Debito, 
                            Credito )
                             
                     Select ModeloLayout, 
                     
                            Case
                              When Len(DebCred) > 0  Then  DebCred
                              Else                         Null
                            End, 
                            
                            Convert(SmallInt,   Setor), 
                            Convert(Int,        RegAsc), 
                            Convert(TinyInt,    CampanhaNro), 
                            Convert(SmallInt,   CampanhaAno), 
                            NroDocumento, 
                            Convert(SmallInt,   Transacao),
                            
                            Case
                              When Len(SubTransacao) > 0  Then  Convert(SmallInt, SubTransacao)
                              Else                              Null
                            End,
                             
                            Case
                              When Len(Debito) > 0   Then  Convert(Money, Replace(Replace(Debito,  '.', ''), ',', '')) / 100
                              Else                         Null
                            End,
                            
                            Case
                              When Len(Credito) > 0  Then  Convert(Money, Replace(Replace(Credito, '.', ''), ',', '')) / 100
                              Else                         Null
                            End
                            
From CargaInicialBA01 (nolock)
Where  CargaInicialBA01_ID = @pCargaInicialBA01_ID

-- FIM
