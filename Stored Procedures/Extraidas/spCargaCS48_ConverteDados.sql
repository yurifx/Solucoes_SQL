--------------------------------------------------------------------------------
-- spCargaCS48_ConverteDados.sql
-- Data   : __/08/2013
-- Autor  : ___
-- Stored procedure de carga inicial de arquivos CS28 
-- Apenas converte os dados de uma linha
--------------------------------------------------------------------------------

USE ArquivosAvon
GO

Alter Procedure CargaCS48_ConverteDados
(
  @pCargaInicialCS48_ID Int
)
AS

Set NoCount ON

Insert Into ConversaoCS48 ( REGASC,
                            Nome,
                            Sexo,
                            Endereco,
                            Numero,
                            Comp,
                            Bairro,
                            Cidade,
                            UF,
                            CEP,
                            DDD,
                            TEL,
                            DDD_COM,
                            TEL_COM,
                            RAMAL,
                            DDD_REC,
                            TEL_REC,
                            DDD_CEL,
                            TEL_CEL,
                            CPF_RA,
                            RG_RA,
                            ORGAO_EMISSOR,
                            DT_NASCIMENTO,
                            DT_ESTABELECIMENTO,
                            ESTADO_CIVIL,
                            NOME_DO_PAI,
                            NOME_DA_MAE,
                            EMAIL,
                            CONJUGE,
                            ORDER_ID,
                            CAMPANHA,
                            ANO_CAMPANHA,
                            VALOR_PENDENCIA,
                            DT_FATURAMENTO,
                            DT_VENCIMENTO,
                            DT_EXPIRACAO,
                            DATA_ENVIO,
                            SETOR,
                            COMISSAO,
                            JUROS,
                            NUMERO_DI )
                            
                     Select Convert(Int, REGASC),
                            Nome,
                            Sexo,
                            Endereco,
                            
                            Case 
                              When Len(Numero) = 0 Then Null
                              Else                      dbo.RemoveZeros(Numero)
                            End,
                            
                            Case 
                              When Len(Comp) = 0   Then Null
                              Else                      Comp
                            End,
                            
                            Case 
                              When Len(Bairro) = 0 Then Null
                              Else                      Bairro
                            End,
                            
                            Cidade,
                            UF,
                            CEP,
                            
                            Case DDD
                              When '000'      Then Null
                              Else                 DDD
                            End,  
                            Case TEL
                              When '00000000' Then Null
                              Else                 TEL
                            End,
                              
                            Case DDD_COM
                              When '000'      Then Null
                              Else                 DDD_COM
                            End,  
                            Case TEL_COM
                              When '00000000' Then Null
                              Else                 TEL_COM
                            End,                              
                            Case RAMAL
                              When '00000'    Then Null
                              Else                 RAMAL
                            End,  
                            
                            Case DDD_REC
                              When '000'      Then Null
                              Else                 DDD_REC
                            End,  
                            Case TEL_REC
                              When '00000000' Then Null
                              Else                 TEL_REC
                            End,  
                            
                            Case DDD_CEL
                              When '000'      Then Null
                              Else                 DDD_CEL
                            End,  
                            Case TEL_CEL
                              When '00000000' Then Null
                              Else                 TEL_CEL
                            End,  
                            
                            CPF_RA,
                            
                            Case 
                              When Len(RG_RA) = 0              Then Null
                              When RG_RA = '000000000'         Then Null
                              When RG_RA = '00000000000'       Then Null
                              Else                                  RG_RA
                            End,
                              
                            Case 
                              When Len(ORGAO_EMISSOR) = 0      Then Null
                              When ORGAO_EMISSOR = '000000000' Then Null
                              Else                                  ORGAO_EMISSOR
                            End,
                            
                            Convert(SmallDateTime, Stuff(Stuff(DT_NASCIMENTO,      5,0,'/'),3,0,'/'), 103), -- ddmmyyyy -> dd/mm/yyyy
                            Convert(SmallDateTime, Stuff(Stuff(DT_ESTABELECIMENTO, 5,0,'/'),3,0,'/'), 103), -- ddmmyyyy -> dd/mm/yyyy
                            
                            Case 
                              When Len(ESTADO_CIVIL) = 0       Then Null
                              When ESTADO_CIVIL = '000000000'  Then Null
                              Else                                  ESTADO_CIVIL
                            End,

                            Case 
                              When Len(NOME_DO_PAI) = 0        Then Null
                              When NOME_DO_PAI = '000000000'   Then Null
                              Else                                  NOME_DO_PAI
                            End,

                            Case 
                              When Len(NOME_DA_MAE) = 0        Then Null
                              When NOME_DA_MAE = '000000000'   Then Null
                              Else                                  NOME_DA_MAE
                            End,

                            Case 
                              When Len(EMAIL) = 0              Then Null
                              When EMAIL = '000000000'         Then Null
                              Else                                  EMAIL
                            End,

                            Case 
                              When Len(CONJUGE) = 0            Then Null
                              Else                                  CONJUGE
                            End,
                            
                            Convert(Int,      ORDER_ID),
                            Convert(TinyInt,  CAMPANHA),
                            Convert(SmallInt, ANO_CAMPANHA),
                            Convert(Money,    VALOR_PENDENCIA) / 100,
                            
                            Convert(SmallDateTime, Stuff(Stuff(DT_FATURAMENTO, 5,0,'/'),3,0,'/'), 103), -- ddmmyyyy -> dd/mm/yyyy
                            Convert(SmallDateTime, Stuff(Stuff(DT_VENCIMENTO,  5,0,'/'),3,0,'/'), 103), -- ddmmyyyy -> dd/mm/yyyy
                            Convert(SmallDateTime, Stuff(Stuff(DT_EXPIRACAO,   5,0,'/'),3,0,'/'), 103), -- ddmmyyyy -> dd/mm/yyyy
                            Convert(SmallDateTime, Stuff(Stuff(DATA_ENVIO,     5,0,'/'),3,0,'/'), 103), -- ddmmyyyy -> dd/mm/yyyy
                            
                            Convert(SmallInt, SETOR),
                            Convert(Money,    COMISSAO) / 100,
                            Convert(Money,    JUROS) / 100,
                            
                            Case 
                              When Len(NUMERO_DI) = 0   Then Null
                              Else                           NUMERO_DI
                            End
                            
From CargaInicialCS48 (nolock)
Where  CargaInicialCS48_ID = @pCargaInicialCS48_ID
                            
                            
-- FIM                      
                            