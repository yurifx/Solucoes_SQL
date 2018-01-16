--------------------------------------------------------------------------------
-- spCargaPP37Carga_SeparaColunas.sql
-- Data   : 20/08/2013
-- Autor  : Amauri
-- Stored procedure de carga inicial de arquivos PP37 de carga 
-- Apenas separa as colunas de uma linha
--------------------------------------------------------------------------------

USE ArquivosAvon
GO

Alter Procedure CargaPP37Carga_SeparaColunas
(
  @pCargaInicial_ID   Int
)
AS

Set NoCount ON

Insert Into CargaInicialPP37_Carga ( Tipo_Pend,
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

Select LTrim(RTrim(Substring(Dados,   1,  2))) as Tipo_Pend,                
       LTrim(RTrim(Substring(Dados,   3,  1))) as Status,                   
       LTrim(RTrim(Substring(Dados,   4,  1))) as Classificacao,            
       LTrim(RTrim(Substring(Dados,   5, 50))) as Nome_Regiao,              
       LTrim(RTrim(Substring(Dados,  55, 50))) as Nome_Divisao,             
       LTrim(RTrim(Substring(Dados, 105,  3))) as Cod_Banco,                
       LTrim(RTrim(Substring(Dados, 108,  4))) as Setor,                    
       LTrim(RTrim(Substring(Dados, 112,  8))) as RegAsc,                   
       LTrim(RTrim(Substring(Dados, 120, 50))) as Nome_Ra,                  
       LTrim(RTrim(Substring(Dados, 170,  3))) as Los,                      
       LTrim(RTrim(Substring(Dados, 173,  6))) as Order_ID,                 
       LTrim(RTrim(Substring(Dados, 179,  2))) as Cp_Cobr,                  
       LTrim(RTrim(Substring(Dados, 181,  4))) as Ano_Cp,                   
       LTrim(RTrim(Substring(Dados, 185,  8))) as Dt_Fat,                   
       LTrim(RTrim(Substring(Dados, 193,  8))) as Dt_Venc,                  
       LTrim(RTrim(Substring(Dados, 201,  8))) as Dt_Validade,              
       LTrim(RTrim(Substring(Dados, 209, 11))) as Vlr_Fat,                  
       LTrim(RTrim(Substring(Dados, 220, 11))) as Vlr_Deb,                  
       LTrim(RTrim(Substring(Dados, 231, 11))) as Vlr_Parcial,              
       LTrim(RTrim(Substring(Dados, 242, 11))) as Vlr_Saldo,
       Substring(Dados,  264, 1) + LTrim(RTrim(Substring(Dados, 253, 11))) as  Valor_Misc,  -- Muda a posição do sinal: 9999- -> -9999
       LTrim(RTrim(Substring(Dados, 265,  2))) as Last_Cp,                  
       LTrim(RTrim(Substring(Dados, 267,  6))) as Last_Ad,                  
       LTrim(RTrim(Substring(Dados, 273,  2))) as Next_Cp,                  
       LTrim(RTrim(Substring(Dados, 275,  6))) as Next_Ad,                  
       LTrim(RTrim(Substring(Dados, 281,  1))) as Tat,                      
       LTrim(RTrim(Substring(Dados, 282,  1))) as Carta_Cobr,               
       LTrim(RTrim(Substring(Dados, 283,  8))) as Dt_Marc_Remessa,          
       LTrim(RTrim(Substring(Dados, 291,  6))) as N_Doc,                    
       LTrim(RTrim(Substring(Dados, 297,  1))) as Fator_Bloqueio,           
       LTrim(RTrim(Substring(Dados, 298,  1))) as Spur_Id,                  
       LTrim(RTrim(Substring(Dados, 299,  1))) as Instant_Delivery,         
       LTrim(RTrim(Substring(Dados, 300,  3))) as Carrier_Code,             
       LTrim(RTrim(Substring(Dados, 303,  3))) as Cod_Tr,                   
       LTrim(RTrim(Substring(Dados, 306, 10))) as Cod_GSV,                  
       LTrim(RTrim(Substring(Dados, 367, 60))) as Nome_Transp,              
       LTrim(RTrim(Substring(Dados, 427,  5))) as Rota,                     
       LTrim(RTrim(Substring(Dados, 432,  8))) as Dt_Tran,                  
       LTrim(RTrim(Substring(Dados, 440,  3))) as Equipe,                   
       LTrim(RTrim(Substring(Dados, 443, 15))) as Boleto,                   
       LTrim(RTrim(Substring(Dados, 458,  1))) as Digito_DI               

From   CargaInicial (nolock)
Where  CargaInicial_ID = @pCargaInicial_ID

-- FIM
