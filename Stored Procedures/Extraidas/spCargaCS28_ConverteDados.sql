--------------------------------------------------------------------------------
-- spCargaCS28_ConverteDados.sql
-- Data   : __/08/2013
-- Autor  : ___
-- Stored procedure de carga inicial de arquivos CS28 
-- Apenas converte os dados de uma linha
--------------------------------------------------------------------------------

USE ArquivosAvon
GO

Alter Procedure CargaCS28_ConverteDados
(
  @pCargaInicialCS28_ID Int
)
AS

Set NoCount ON

Insert Into ConversaoCS28 ( AVISO_DEBITO, 
                            NOME, 
                            SETOR, 
                            REGASC, 
                            DT_NASCIMENTO, 
                            RG_RA, 
                            CPF_RA, 
                            DDD_TEL, 
                            ENDERECO, 
                            NUMERO, 
                            COMP, 
                            BAIRRO, 
                            CEP, 
                            CIDADE, 
                            UF, 
                            DT_ESTABELECIMENTO, 
                            EQUIPE, 
                            LOS, 
                            AGENCIA, 
                            NF, 
                            DT_NF, 
                            CAMPANHA, 
                            CAMPANHA_ANO,
                            DT_ENVIO_RA_COB, 
                            DT_DEVOLUCAO, 
                            N_AGENCIA, 
                            NOME_RA_INDICA, 
                            END_RA_INDICA, 
                            NUEMERO_RA_INDICA, 
                            COMP_RA_INDICA, 
                            BAIRRO_RA_INDICA, 
                            CEP_RA_INDICA, 
                            CIDADE_RA_INDICA, 
                            UF_RA_INDICA, 
                            REGASC_RA_INDICA, 
                            VALOR_DEBITO )
                            
                     Select Convert(Int,           AVISO_DEBITO), 
                            NOME, 
                            Convert(SmallInt,      SETOR), 
                            Convert(Int,           REGASC),
                            Convert(SmallDateTime, DT_NASCIMENTO, 103), -- dd/mm/yyyy 
                            
                            Case 
                              When Len(RG_RA) = 0              Then Null
                              Else                                  RG_RA
                            End,
 
                            CPF_RA,
                            
                            Case
                               When Len(DDD_TEL) = 0              Then Null
                               When DDD_TEL = '(0000)  0000-0000' Then Null
                               Else                                    DDD_TEL
                            End,
                            
                            ENDERECO, 
                            
                            Case 
                              When Len(NUMERO) = 0 Then Null
                              Else                      dbo.RemoveZeros(NUMERO)
                            End,
                            
                            Case 
                              When Len(COMP) = 0   Then Null
                              Else                      COMP
                            End,
                            
                            Case 
                              When Len(BAIRRO) = 0 Then Null
                              Else                      BAIRRO
                            End,
                            
                            CEP, 
                            CIDADE, 
                            UF,
                            
                            Convert(SmallDateTime, DT_ESTABELECIMENTO, 103), -- dd/mm/yyyy 
                            Convert(SmallInt,      EQUIPE), 
                            Convert(SmallInt,      LOS), 
                            AGENCIA, 
                            Convert(Int,           NF), 
                            Convert(SmallDateTime, Stuff(Stuff(DT_NF,          5,0,'/'),3,0,'/'), 103), -- ddmmyyyy -> dd/mm/yyyy
                            
                            Convert(TinyInt,       CAMPANHA),
                            Convert(SmallInt,      CAMPANHA_ANO),
                            
                            Convert(SmallDateTime, Stuff(Stuff(DT_ENVIO_RA_COB,5,0,'/'),3,0,'/'), 103), -- ddmmyyyy -> dd/mm/yyyy
                            Convert(SmallDateTime, Stuff(Stuff(DT_DEVOLUCAO,   5,0,'/'),3,0,'/'), 103), -- ddmmyyyy -> dd/mm/yyyy
                            Convert(SmallInt,      N_AGENCIA), 
                            
                            Case 
                              When Len(NOME_RA_INDICA) = 0      Then Null
                              Else                                   NOME_RA_INDICA
                            End,
                            
                            Case 
                              When Len(END_RA_INDICA) = 0       Then Null
                              Else                                   END_RA_INDICA
                            End,

                            Case  
                              When Len(NUEMERO_RA_INDICA) = 0   Then Null
                              When NUEMERO_RA_INDICA = '00000'  Then Null
                              Else                                   NUEMERO_RA_INDICA
                            End,
                            
                            Case
                              When Len(COMP_RA_INDICA) = 0      Then Null
                              Else                                   COMP_RA_INDICA
                            End,

                            Case
                              When Len(BAIRRO_RA_INDICA) = 0    Then Null
                              Else                                   BAIRRO_RA_INDICA
                            End,

                            Case  
                              When Len(CEP_RA_INDICA) = 0       Then Null
                              When CEP_RA_INDICA = '00000000'   Then Null
                              Else                                   CEP_RA_INDICA
                            End,
                            
                            Case
                              When Len(CIDADE_RA_INDICA) = 0    Then Null
                              Else                                   CIDADE_RA_INDICA
                            End,
                            
                            Case
                              When Len(UF_RA_INDICA) = 0        Then Null
                              Else                                   UF_RA_INDICA
                            End,
                            
                            Case
                              When Len(REGASC_RA_INDICA) = 0    Then Null
                              Else                                   Convert(Int, REGASC_RA_INDICA)
                            End,

                            Convert(Money, VALOR_DEBITO)
                            
From CargaInicialCS28 (nolock)
Where  CargaInicialCS28_ID = @pCargaInicialCS28_ID

-- FIM
