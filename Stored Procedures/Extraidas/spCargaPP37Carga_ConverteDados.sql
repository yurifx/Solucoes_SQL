--------------------------------------------------------------------------------
-- spCargaPP37Carga_ConverteDados.sql
-- Data   : 20/08/2013
-- Autor  : Amauri
-- Stored procedure de carga inicial de arquivos PP37 de carga 
-- Apenas converte os dados de uma linha
--------------------------------------------------------------------------------

USE ArquivosAvon
GO

Alter Procedure CargaPP37Carga_ConverteDados
(
  @pCargaInicialPP37_Carga_ID Int
)
AS

Set NoCount ON

Insert Into ConversaoPP37_Carga ( Tipo_Pend,
                                  Status,
                                  Classificacao,
                                  Nome_Regiao,
                                  Nome_Divisao,
                                  Cod_Banco,
                                  Setor,
                                  RegAsc,
                                  Nome_Ra,
                                  Los,
                                  Order_ID,
                                  Cp_Cobr,
                                  Ano_Cp,
                                  Dt_Fat,
                                  Dt_Venc,
                                  Dt_Validade,
                                  Vlr_Fat,
                                  Vlr_Deb,
                                  Vlr_Parcial,
                                  Vlr_Saldo,
                                  Vlr_Misc,
                                  Last_Cp,
                                  Last_Ad,
                                  Next_Cp,
                                  Next_Ad,
                                  Tat,
                                  Carta_Cobr,
                                  Dt_Marc_Remessa,
                                  N_Doc,
                                  Fator_Bloqueio,
                                  Spur_Id,
                                  Instant_Delivery,
                                  Carrier_Code,
                                  Cod_Tr,
                                  Cod_GSV,
                                  Nome_Transp,
                                  Rota,
                                  Dt_Tran,
                                  Equipe,
                                  Boleto,
                                  Digito_DI )
                             
                           Select Convert(TinyInt,  Tipo_Pend),
                                  Case 
                                    When Len(Status) = 0        Then Null
                                    Else                             Status
                                  End,

                                  Case 
                                    When Len(Classificacao) = 0 Then Null
                                    Else                             Classificacao
                                  End,

                                  Nome_Regiao,
                                  Nome_Divisao,
                                  Convert(SmallInt, Cod_Banco),
                                  Convert(SmallInt, Setor),
                                  Convert(Int,      RegAsc),
                                  Nome_Ra,
                                  Convert(SmallInt, Los),
                                  Convert(Int,      Order_ID),
                                  Convert(TinyInt,  Cp_Cobr),
                                  Convert(SmallInt, Ano_Cp),
                                  Convert(SmallDateTime, Stuff(Stuff(Dt_Fat,      5,0,'/'),3,0,'/'), 103), -- ddmmyyyy -> dd/mm/yyyy
                                  Convert(SmallDateTime, Stuff(Stuff(Dt_Venc,     5,0,'/'),3,0,'/'), 103), -- ddmmyyyy -> dd/mm/yyyy
                                  Convert(SmallDateTime, Stuff(Stuff(Dt_Validade, 5,0,'/'),3,0,'/'), 103), -- ddmmyyyy -> dd/mm/yyyy
                                  Convert(Money,    Vlr_Fat) / 100,
                                  Convert(Money,    Vlr_Deb) / 100,
                                  Convert(Money,    Vlr_Parcial) / 100,
                                  Convert(Money,    Vlr_Saldo) / 100,
                                  Convert(Money,    Vlr_Misc) / 100,
                                  
                                  Case 
                                    When Len(Last_Cp) = 0          Then Null
                                    When Last_Cp = '00'            Then Null
                                    Else                                Convert(TinyInt, Last_Cp)
                                  End,

                                  Case 
                                    When Len(Last_Ad) = 0          Then Null
                                    When Last_Ad = '000000'        Then Null
                                    Else                                Convert(Int, Last_Ad)
                                  End,

                                  Convert(TinyInt,  Next_Cp),
                                  Convert(Int,      Next_Ad),
                                  Tat,
                                  Convert(TinyInt,  Carta_Cobr),
                                  null, -- Dt_Marc_Remessa,
                                  
                                  Case 
                                    When Len(N_Doc) = 0            Then Null
                                    When N_Doc = '000000'          Then Null
                                    Else                                Convert(Int, N_Doc)
                                  End,
                                  
                                  Case 
                                    When Len(Fator_Bloqueio) = 0   Then Null
                                    Else                                Fator_Bloqueio
                                  End,

                                  Case 
                                    When Len(Spur_Id) = 0          Then Null
                                    When Spur_Id = '0'             Then Null
                                    Else                                Convert(TinyInt,  Spur_Id)
                                  End,

                                  Case 
                                    When Len(Instant_Delivery) = 0 Then Null
                                    Else                                Instant_Delivery
                                  End,

                                  Carrier_Code,
                                  Convert(SmallInt, Cod_Tr),

                                  Case 
                                    When Len(Cod_GSV) = 0          Then Null
                                    Else                                Cod_GSV
                                  End,

                                  Nome_Transp,
                                  Convert(Int,      Rota),
                                  null, -- Dt_Tran,
                                  Convert(SmallInt, Equipe),
                                  Boleto,
                                  Digito_DI
                             
From CargaInicialPP37_Carga (nolock)
Where  CargaInicialPP37_Carga_ID = @pCargaInicialPP37_Carga_ID

-- FIM
