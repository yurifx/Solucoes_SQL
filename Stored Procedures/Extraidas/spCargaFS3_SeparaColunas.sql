--------------------------------------------------------------------------------
-- spCargaFS3_SeparaColunas.sql
-- Data   : 19/08/2013
-- Autor  : Christiane e Amauri
-- Stored procedure de carga inicial de arquivos FS3 
-- Apenas separa as colunas de uma linha
--------------------------------------------------------------------------------

USE ArquivosAvon
GO

Alter Procedure CargaFS3_SeparaColunas
(
  @pCargaInicial_ID   Int
)
AS

Set NoCount ON

Insert Into CargaInicialFS3 ( CodigoRevendedoraAsc,
                              OrderId,
                              CampanhaFaturamento,
                              AnoCampanhaFaturamento,
                              ValorDebito,
                              ValorPagamento,
                              DataBaixa,
                              DataEnvio,
                              TipoBaixa )

Select LTrim(RTrim(Substring(Dados, 2,  8)))  as CodigoRevendedoraAsc,  
       LTrim(RTrim(Substring(Dados,10,  8)))  as OrderId,               
       LTrim(RTrim(Substring(Dados,18,  2)))  as CampanhaFaturamento,   
       LTrim(RTrim(Substring(Dados,20,  4)))  as AnoCampanhaFaturamento,
       LTrim(RTrim(Substring(Dados,24, 11)))  as ValorDebito,           
       LTrim(RTrim(Substring(Dados,35, 11)))  as ValorPagamento,        
       LTrim(RTrim(Substring(Dados,46,  8)))  as DataBaixa,             
       LTrim(RTrim(Substring(Dados,54,  8)))  as DataEnvio,             
       LTrim(RTrim(Substring(Dados,62,  1)))  as TipoBaixa            
       
From   CargaInicial (nolock)
Where  CargaInicial_ID = @pCargaInicial_ID

-- FIM
