--------------------------------------------------------------------------------
-- spCargaPP37Cadastro_SeparaColunas.sql
-- Data   : 20/08/2013
-- Autor  : Amauri
-- Stored procedure de carga inicial de arquivos PP37 de cadastro 
-- Apenas separa as colunas de uma linha
--------------------------------------------------------------------------------

USE ArquivosAvon
GO

Alter Procedure CargaPP37Cadastro_SeparaColunas
(
  @pCargaInicial_ID   Int
)
AS

Set NoCount ON

Insert Into CargaInicialPP37_Cadastro ( Setor,
                                        RegistroAsc,
                                        Classificacao,
                                        Valor_Misc,
                                        Nome,
                                        Endereco,
                                        Numero,
                                        Complemento,
                                        Bairro,
                                        Cidade,
                                        UF,
                                        Cep,
                                        DDD,
                                        Tel_Residencia,
                                        DDD1,
                                        Tel_Comercial,
                                        Ramal,
                                        DDD2,
                                        Tel_Recado,
                                        DDD3,
                                        Celular,
                                        Cpf,
                                        Rg,
                                        Orgao_Emissor,
                                        Data_Nasc,
                                        Data_Estab,
                                        Estado_Civil,
                                        Nome_Pai,
                                        Nome_Mae,
                                        Email,
                                        Nome_Conjuge )

Select LTrim(RTrim(Substring(Dados,   1,  4))) as  Setor,           
       LTrim(RTrim(Substring(Dados,   5,  8))) as  RegistroAsc,     
       LTrim(RTrim(Substring(Dados,  13,  1))) as  Classificacao, 

       Substring(Dados,  27, 1) + LTrim(RTrim(Substring(Dados, 14, 13))) as  Valor_Misc,  -- Muda a posição do sinal: 9999- -> -9999

       LTrim(RTrim(Substring(Dados,  28, 50))) as  Nome, 
       LTrim(RTrim(Substring(Dados,  78, 60))) as  Endereco, 
       LTrim(RTrim(Substring(Dados, 138,  5))) as  Numero, 
       LTrim(RTrim(Substring(Dados, 143, 20))) as  Complemento, 
       LTrim(RTrim(Substring(Dados, 163, 30))) as  Bairro, 
       LTrim(RTrim(Substring(Dados, 193, 20))) as  Cidade, 
       LTrim(RTrim(Substring(Dados, 213,  2))) as  UF, 
       LTrim(RTrim(Substring(Dados, 215,  8))) as  Cep, 
       LTrim(RTrim(Substring(Dados, 223,  3))) as  DDD, 
       LTrim(RTrim(Substring(Dados, 226,  8))) as  Tel_Residencia, 
       LTrim(RTrim(Substring(Dados, 234,  3))) as  DDD1, 
       LTrim(RTrim(Substring(Dados, 237,  8))) as  Tel_Comercial, 
       LTrim(RTrim(Substring(Dados, 245,  5))) as  Ramal, 
       LTrim(RTrim(Substring(Dados, 245,  3))) as  DDD2, 
       LTrim(RTrim(Substring(Dados, 253,  8))) as  Tel_Recado, 
       LTrim(RTrim(Substring(Dados, 261,  3))) as  DDD3, 
       LTrim(RTrim(Substring(Dados, 264,  8))) as  Celular, 
       LTrim(RTrim(Substring(Dados, 272, 11))) as  Cpf, 
       LTrim(RTrim(Substring(Dados, 283, 11))) as  Rg, 
       LTrim(RTrim(Substring(Dados, 294,  5))) as  Orgao_Emissor, 
       LTrim(RTrim(Substring(Dados, 299,  8))) as  Data_Nasc, 
       LTrim(RTrim(Substring(Dados, 307,  8))) as  Data_Estab, 
       LTrim(RTrim(Substring(Dados, 315,  1))) as  Estado_Civil, 
       LTrim(RTrim(Substring(Dados, 316, 50))) as  Nome_Pai, 
       LTrim(RTrim(Substring(Dados, 366, 50))) as  Nome_Mae, 
       LTrim(RTrim(Substring(Dados, 416, 50))) as  Email, 
       LTrim(RTrim(Substring(Dados, 466, 50))) as  Nome_Conjuge 

From   CargaInicial (nolock)
Where  CargaInicial_ID = @pCargaInicial_ID

-- FIM
