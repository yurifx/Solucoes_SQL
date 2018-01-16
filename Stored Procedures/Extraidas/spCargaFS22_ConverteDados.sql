--------------------------------------------------------------------------------
-- spCargaFS22_ConverteDados.sql
-- Data   : __/08/2013
-- Autor  : ___
-- Stored procedure de carga inicial de arquivos FS22 
-- Apenas converte os dados de uma linha
--------------------------------------------------------------------------------

USE ArquivosAvon
GO

Alter Procedure CargaFS22_ConverteDados
(
  @pCargaInicialFS22_ID Int
)
AS

Set NoCount ON

Insert Into ConversaoFS22 ( IDDEVEDOR,
                            DEVNOME,
                            DEVENDERECO,
                            DEVCOMPL,
                            DEVBAIRRO,
                            DEVCIDADE,
                            DEVUF,
                            DEVCEP,
                            CODIGOBANCO,
                            NOMEBANCO,
                            LINHADIGITAVEL,
                            LOCALPAGAMENTO,
                            PARCELA,
                            VENCIMENTO,
                            CEDENTE,
                            AGENCIACODIGOCEDENTE,
                            CAMPANHA,
                            AVISO_DEBITO,
                            DATADOCUMENTO,
                            NUMERODOCUMENTO,
                            ESPECIEDOCUMENTO,
                            ACEITE,
                            DATAPROCESSAMENTO,
                            NOSSONUMERO,
                            USOBANCO,
                            CARTEIRA,
                            MOEDA,
                            QUANTIDADE,
                            VALOR,
                            VALORDOCUMENTO,
                            CIP,
                            BONIFICACAO,
                            COMISSAO,
                            INSTRUCAO01,
                            INSTRUCAO02,
                            INSTRUCAO03,
                            INSTRUCAO04,
                            INSTRUCAO05,
                            INSTRUCAO06,
                            INSTRUCAO07,
                            INSTRUCAO08,
                            INSTRUCAO09,
                            CODIGOBARRAS )
                            
                     Select Convert(Int, IDDEVEDOR),
                            DEVNOME,
                            DEVENDERECO,
                            
                            Case 
                              When Len(DEVCOMPL) = 0    Then Null
                              Else                           DEVCOMPL
                            End,
                            Case 
                              When Len(DEVBAIRRO) = 0   Then Null
                              Else                           DEVBAIRRO
                            End,

                            DEVCIDADE,
                            DEVUF,
                            DEVCEP,
                            Convert(SmallInt, CODIGOBANCO),
                            NOMEBANCO,
                            LINHADIGITAVEL,
                            LOCALPAGAMENTO,

                            Case 
                              When Len(PARCELA) = 0     Then Null
                              Else                           PARCELA
                            End,
                            
                            Convert(SmallDateTime, Stuff(Stuff(VENCIMENTO, 5,0,'/'),3,0,'/'), 103), -- ddmmyyyy -> dd/mm/yyyy

                            CEDENTE,
                            AGENCIACODIGOCEDENTE,
                            
                            Convert(TinyInt, CAMPANHA),
                            Convert(Int,     AVISO_DEBITO),
                            
                            Convert(SmallDateTime, DATADOCUMENTO, 103), -- dd/mm/yyyy

                            NUMERODOCUMENTO,

                            Case 
                              When Len(ESPECIEDOCUMENTO) = 0  Then Null
                              Else                                 ESPECIEDOCUMENTO
                            End,
                            
                            Case 
                              When Len(ACEITE) = 0            Then Null
                              Else                                 ACEITE
                            End,
                            
                            Convert(SmallDateTime, DATAPROCESSAMENTO, 103), -- dd/mm/yyyy
                            
                            NOSSONUMERO,

                            Case 
                              When Len(USOBANCO) = 0          Then Null
                              Else                                 USOBANCO
                            End,

                            CARTEIRA,
                            MOEDA,

                            Case 
                              When Len(QUANTIDADE) = 0        Then Null
                              Else                                 QUANTIDADE
                            End,
                            
                            Convert(Money,  Replace(Replace(VALOR,         '.', ''), ',', '.') ),
                            Convert(Money,  Replace(Replace(VALORDOCUMENTO,'.', ''), ',', '.') ),
                            
                            Convert(SmallInt, CIP),
                            
                            Convert(Money,  Replace(Replace(BONIFICACAO,    '.', ''), ',', '.') ),
                            Convert(Money,  Replace(Replace(COMISSAO,       '.', ''), ',', '.') ),
                            
                            Case 
                              When Len(INSTRUCAO01) = 0 Then Null
                              Else                           INSTRUCAO01
                            End,
                            Case 
                              When Len(INSTRUCAO02) = 0 Then Null
                              Else                           INSTRUCAO02
                            End,
                            Case 
                              When Len(INSTRUCAO03) = 0 Then Null
                              Else                           INSTRUCAO03
                            End,
                            Case 
                              When Len(INSTRUCAO04) = 0 Then Null
                              Else                           INSTRUCAO04
                            End,
                            Case 
                              When Len(INSTRUCAO05) = 0 Then Null
                              Else                           INSTRUCAO05
                            End,
                            Case 
                              When Len(INSTRUCAO06) = 0 Then Null
                              Else                           INSTRUCAO06
                            End,
                            Case 
                              When Len(INSTRUCAO07) = 0 Then Null
                              Else                           INSTRUCAO07
                            End,
                            Case 
                              When Len(INSTRUCAO08) = 0 Then Null
                              Else                           INSTRUCAO08
                            End,
                            Case 
                              When Len(INSTRUCAO09) = 0 Then Null
                              Else                           INSTRUCAO09
                            End,

                            CODIGOBARRAS

From CargaInicialFS22 (nolock)
Where  CargaInicialFS22_ID = @pCargaInicialFS22_ID

-- FIM
