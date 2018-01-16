--------------------------------------------------------------------------------
-- spCargaCS13_SeparaColunas.sql
-- Data   : 19/08/2013
-- Autor  : Christiane e Amauri
-- Stored procedure de carga inicial de arquivos CS13 
-- Apenas separa as colunas de uma linha
--------------------------------------------------------------------------------

USE ArquivosAvon
GO

Alter Procedure CargaCS13_SeparaColunas
(
  @pCargaInicial_ID   Int,
  @pLarguraLinha      Int
)
AS

Set NoCount ON

Insert Into CargaInicialCS13 ( ModeloLayout,
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
                               
Select Case 
         When @pLarguraLinha > 156  Then  '2'
         Else                             '1'
       End as ModeloLayout,
         
       LTrim(RTrim(Substring(Dados,   1, 3)))  as TRANSACAO,                 
       LTrim(RTrim(Substring(Dados,   4, 6)))  as RECIBO,                     
       LTrim(RTrim(Substring(Dados,  10, 8)))  as REGISTRO_ASC,              
       LTrim(RTrim(Substring(Dados,  18, 8)))  as DATA_TRANSACAO,                      
       LTrim(RTrim(Substring(Dados,  26, 4)))  as SETOR,                     
       LTrim(RTrim(Substring(Dados,  30,11)))  as VALOR,                     
       LTrim(RTrim(Substring(Dados,  41,10)))  as USUARIO,                   
       LTrim(RTrim(Substring(Dados,  51,30)))  as HISTORICO,                 
       LTrim(RTrim(Substring(Dados,  81,10)))  as TIPO_AGENCIA,              
       LTrim(RTrim(Substring(Dados,  91,10)))  as DATA_TRANSFERENCIA,        
       LTrim(RTrim(Substring(Dados, 101, 4)))  as AGENCIA,                   
       LTrim(RTrim(Substring(Dados, 105,11)))  as VALOR_PRINCIPAL,           
       LTrim(RTrim(Substring(Dados, 116,11)))  as JUROS,                     
       LTrim(RTrim(Substring(Dados, 127,26)))  as TIMESTAMP,      
       
       Case 
         When @pLarguraLinha > 156  Then  LTrim(RTrim(Substring(Dados, 153, 4)))
         Else                       Null
       End as SETOR_REV_COBRANCA,

       Case 
         When @pLarguraLinha > 156  Then  LTrim(RTrim(Substring(Dados, 160, 8)))  
         Else                       Null
       End as Program_ID,                

       Case 
         When @pLarguraLinha > 156  Then  LTrim(RTrim(Substring(Dados, 168, 2)))  
         Else                       Null
       End as Campanha,                  

       Case 
         When @pLarguraLinha > 156  Then  LTrim(RTrim(Substring(Dados, 170, 4)))  
         Else                       Null
       End as AnoCampanha,               

       Case 
         When @pLarguraLinha > 156  Then  LTrim(RTrim(Substring(Dados, 176, 6)))  
         Else                       Null
       End as AvisoDebito,               

       Case 
         When @pLarguraLinha > 156  Then  LTrim(RTrim(Substring(Dados, 182,10)))  
         Else                       Null
       End as DataFaturamento          

From   CargaInicial (nolock)
Where  CargaInicial_ID = @pCargaInicial_ID

-- FIM
