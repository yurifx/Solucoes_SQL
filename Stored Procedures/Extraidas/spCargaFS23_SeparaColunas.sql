--------------------------------------------------------------------------------
-- spCargaFS23_SeparaColunas.sql
-- Data   : 20/08/2013
-- Autor  : Christiane e Amauri
-- Stored procedure de carga inicial de arquivos FS23 
-- Apenas separa as colunas de uma linha
--------------------------------------------------------------------------------

USE ArquivosAvon
GO

Alter Procedure CargaFS23_SeparaColunas
(
  @pCargaInicial_ID   Int
)
AS

Set NoCount ON

Insert Into CargaInicialFS23 ( IDDEVEDOR,
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
                               CODIGOBARRAS,
                               Datadenascimento,
                               Sexo,
                               CPF,
                               Setor,
                               DatadeFaturamento,
                               NroCampanha,
                               AnoCampanha)


Select LTrim(RTrim(Substring(Dados,  3, 8)))   as IDDEVEDOR,
       LTrim(RTrim(Substring(Dados, 11, 50)))  as DEVNOME,
       LTrim(RTrim(Substring(Dados, 61, 65)))  as DEVENDERECO,                 
       LTrim(RTrim(Substring(Dados,126, 20)))  as DEVCOMPL,                    
       LTrim(RTrim(Substring(Dados,146, 30)))  as DEVBAIRRO,                   
       LTrim(RTrim(Substring(Dados,176, 20)))  as DEVCIDADE,                   
       LTrim(RTrim(Substring(Dados,196, 2)))   as DEVUF,                       
       LTrim(RTrim(Substring(Dados,198, 8)))   as DEVCEP,                      
       LTrim(RTrim(Substring(Dados,206, 4)))   as CODIGOBANCO,                 
       LTrim(RTrim(Substring(Dados,210, 30)))  as NOMEBANCO,                   
       LTrim(RTrim(Substring(Dados,240, 60)))  as LINHADIGITAVEL,              
       LTrim(RTrim(Substring(Dados,300, 84)))  as LOCALPAGAMENTO,              
       LTrim(RTrim(Substring(Dados,384, 7)))   as PARCELA,                     
       LTrim(RTrim(Substring(Dados,391, 8)))   as VENCIMENTO,                  
       LTrim(RTrim(Substring(Dados,399, 84)))  as CEDENTE,                     
       LTrim(RTrim(Substring(Dados,483, 19)))  as AGENCIACODIGOCEDENTE,        
       LTrim(RTrim(Substring(Dados,502, 10)))  as DATADOCUMENTO,                
       LTrim(RTrim(Substring(Dados,512, 10)))  as NUMERODOCUMENTO,             
       LTrim(RTrim(Substring(Dados,522, 2)))   as ESPECIEDOCUMENTO,            
       LTrim(RTrim(Substring(Dados,524, 1)))   as ACEITE,                      
       LTrim(RTrim(Substring(Dados,525, 10)))  as DATAPROCESSAMENTO,           
       LTrim(RTrim(Substring(Dados,535, 21)))  as NOSSONUMERO,                 
       LTrim(RTrim(Substring(Dados,556, 4)))   as USOBANCO,                    
       LTrim(RTrim(Substring(Dados,560, 3)))   as CARTEIRA,                    
       LTrim(RTrim(Substring(Dados,563, 4)))   as MOEDA,                       
       LTrim(RTrim(Substring(Dados,567, 5)))   as QUANTIDADE,                  
       LTrim(RTrim(Substring(Dados,572, 14)))  as VALOR,                       
       LTrim(RTrim(Substring(Dados,586, 14)))  as VALORDOCUMENTO,              
       LTrim(RTrim(Substring(Dados,600, 4)))   as CIP,                         
       LTrim(RTrim(Substring(Dados,603, 12)))  as BONIFICACAO,                 
       LTrim(RTrim(Substring(Dados,615, 12)))  as COMISSAO,                    
       LTrim(RTrim(Substring(Dados,627, 98)))  as INSTRUCAO01,                 
       LTrim(RTrim(Substring(Dados,725, 98)))  as INSTRUCAO02,                 
       LTrim(RTrim(Substring(Dados,823, 98)))  as INSTRUCAO03,                 
       LTrim(RTrim(Substring(Dados,921, 98)))  as INSTRUCAO04,                 
       LTrim(RTrim(Substring(Dados,1019,98)))  as INSTRUCAO05,                 
       LTrim(RTrim(Substring(Dados,1117,98)))  as INSTRUCAO06,                 
       LTrim(RTrim(Substring(Dados,1215,98)))  as INSTRUCAO07,                 
       LTrim(RTrim(Substring(Dados,1313,98)))  as INSTRUCAO08,                 
       LTrim(RTrim(Substring(Dados,1411,98)))  as INSTRUCAO09,                 
       LTrim(RTrim(Substring(Dados,1509,44)))  as CODIGOBARRAS,
       LTrim(RTrim(Substring(Dados,1553,10)))  as Datadenascimento,  
       LTrim(RTrim(Substring(Dados,1563, 1)))  as Sexo,              
       LTrim(RTrim(Substring(Dados,1564,14)))  as CPF,               
       LTrim(RTrim(Substring(Dados,1578, 5)))  as Setor,             
       LTrim(RTrim(Substring(Dados,1583,10)))  as DatadeFaturamento, 
       LTrim(RTrim(Substring(Dados,1593, 2)))  as NroCampanha,    
       LTrim(RTrim(Substring(Dados,1595, 4)))  as AnoCampanha    
       
From   CargaInicial (nolock)
Where  CargaInicial_ID = @pCargaInicial_ID

-- FIM
