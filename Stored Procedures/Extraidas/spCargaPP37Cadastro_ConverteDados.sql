--------------------------------------------------------------------------------
-- spCargaPP37Cadastro_ConverteDados.sql
-- Data   : 20/08/2013
-- Autor  : Amauri
-- Stored procedure de carga inicial de arquivos PP37 de cadastro 
-- Apenas converte os dados de uma linha
--------------------------------------------------------------------------------

USE ArquivosAvon
GO

Alter Procedure CargaPP37Cadastro_ConverteDados
(
  @pCargaInicialPP37_Cadastro_ID Int
)
AS

Set NoCount ON

Insert Into ConversaoPP37_Cadastro ( Setor,
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
                             
                     Select          Convert(SmallInt, Setor),
                                     Convert(Int, RegistroAsc),
                                     Classificacao,
                                     Convert(Money, Valor_Misc) / 100,
                                     Nome,
                                     Endereco,
                                     
                                     Case 
                                       When Len(Numero)      = 0 Then Null
                                       Else                           Numero
                                     End,

                                     Case 
                                       When Len(Complemento) = 0 Then Null
                                       Else                           Complemento
                                     End,

                                     Case 
                                       When Len(Bairro)      = 0 Then Null
                                       Else                           Bairro
                                     End,

                                     Case 
                                       When Len(Cidade)      = 0 Then Null
                                       Else                           Cidade
                                     End,

                                     UF,
                                     Cep,
                                     
                                     Case
                                        When Len(DDD) = 0                Then Null
                                        When DDD = '000'                 Then Null
                                        Else                                  DDD
                                     End,
                                    
                                     Case
                                        When Len(Tel_Residencia) = 0     Then Null
                                        When Tel_Residencia = '00000000' Then Null
                                        Else                                  Tel_Residencia
                                     End,

                                     Case
                                        When Len(DDD1) = 0               Then Null
                                        When DDD1 = '000'                Then Null
                                        Else                                  DDD1
                                     End,

                                     Case
                                        When Len(Tel_Comercial) = 0      Then Null
                                        When Tel_Comercial = '00000000'  Then Null
                                        Else                                  Tel_Comercial
                                     End,

                                     Case
                                        When Len(Ramal) = 0              Then Null
                                        When Ramal = '00000'             Then Null
                                        Else                                  Ramal
                                     End,

                                     Case
                                        When Len(DDD2) = 0               Then Null
                                        When DDD2 = '000'                Then Null
                                        Else                                  DDD2
                                     End,

                                     Case
                                        When Len(Tel_Recado) = 0         Then Null
                                        When Tel_Recado = '00000000'     Then Null
                                        Else                                  Tel_Recado
                                     End,

                                     Case
                                        When Len(DDD3) = 0               Then Null
                                        When DDD3 = '000'                Then Null
                                        Else                                  DDD3
                                     End,

                                     Case
                                        When Len(Celular) = 0             Then Null
                                        When Celular = '00000000'         Then Null
                                        Else                                   Celular
                                     End,

                                     Cpf,
                                     
                                     Case
                                        When Len(Rg) = 0                  Then Null
                                        Else                                   Rg
                                     End,
                                     Case
                                        When Len(Orgao_Emissor) = 0       Then Null
                                        Else                                   Orgao_Emissor
                                     End,

                                     Convert(SmallDateTime, Stuff(Stuff(Data_Nasc,  5,0,'/'),3,0,'/'), 103), -- ddmmyyyy -> dd/mm/yyyy
                                     Convert(SmallDateTime, Stuff(Stuff(Data_Estab, 5,0,'/'),3,0,'/'), 103), -- ddmmyyyy -> dd/mm/yyyy
                                     
                                     Case
                                        When Len(Estado_Civil) = 0        Then Null
                                        Else                                   Estado_Civil
                                     End,
                                     Case
                                        When Len(Nome_Pai) = 0            Then Null
                                        Else                                   Nome_Pai
                                     End,
                                     Case
                                        When Len(Nome_Mae) = 0            Then Null
                                        Else                                   Nome_Mae
                                     End,
                                     Case
                                        When Len(Email) = 0               Then Null
                                        Else                                   Email
                                     End,
                                     Case
                                        When Len(Nome_Conjuge) = 0        Then Null
                                        Else                                   Nome_Conjuge
                                     End

From CargaInicialPP37_Cadastro (nolock)
Where  CargaInicialPP37_Cadastro_ID = @pCargaInicialPP37_Cadastro_ID

-- FIM
