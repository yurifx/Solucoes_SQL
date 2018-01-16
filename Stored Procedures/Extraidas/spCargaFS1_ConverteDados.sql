--------------------------------------------------------------------------------
-- spCargaFS1_ConverteDados.sql
-- Data   : __/08/2013
-- Autor  : ___
-- Stored procedure de carga inicial de arquivos FS1 
-- Apenas converte os dados de uma linha
--------------------------------------------------------------------------------

USE ArquivosAvon
GO

Alter Procedure CargaFS1_ConverteDados
(
  @pCargaInicialFS1_ID Int
)
AS

Set NoCount ON

Insert Into ConversaoFS1 ( CodigoRevendedoraAsc,
                           NomeRevendedora,
                           Sexo,
                           EnderecoRevendedora,
                           Numero,
                           Complemento,
                           Bairro,
                           Cidade,
                           UF,
                           CEP,
                           DDDResidencial,
                           TelefoneResidencial,
                           DDDComercial,
                           TelefoneComercial,
                           RamalComercial,
                           DDDRecados,
                           TelefoneRecados,
                           DDDCelular,
                           TelefoneCelular,
                           CPF,
                           RG,
                           OrgaoEmissor,
                           DataNascimento,
                           DataEstabelecimento,
                           EstadoCivil,
                           NomePai,
                           NomeMae,
                           Email,
                           NomeConjuge,
                           OrderId,
                           CampanhaFaturamento,
                           AnoCampanhaFaturamento,
                           ValorDebito,
                           DataFaturamento,
                           DataVencimento,
                           DataExpiracaoBoleto,
                           DataEnvio,
                           Setor )

                    Select Convert(Int, CodigoRevendedoraAsc),
                           NomeRevendedora,
                           Sexo,
                           EnderecoRevendedora,
                           
                           Case 
                             When Len(Numero) = 0      Then Null
                             Else                           Numero
                           End,
                           Case 
                             When Len(Complemento) = 0 Then Null
                             Else                           Complemento
                           End,
                           Case 
                             When Len(Bairro) = 0 Then Null
                             Else                           Bairro
                           End,
                           
                           Cidade,
                           UF,
                           CEP,
                           
                           Case DDDResidencial
                             When '000'      Then Null
                             Else                 DDDResidencial
                           End,  
                           Case TelefoneResidencial
                             When '00000000' Then Null
                             Else                 TelefoneResidencial
                           End,
                             
                           Case DDDComercial
                             When '000'      Then Null
                             Else                 DDDComercial
                           End,  
                           Case TelefoneComercial
                             When '00000000' Then Null
                             Else                 TelefoneComercial
                           End,
                           Case RamalComercial
                             When '00000'    Then Null
                             Else                 RamalComercial
                           End,

                           Case DDDRecados
                             When '000'      Then Null
                             Else                 DDDRecados
                           End,  
                           Case TelefoneRecados
                             When '00000000' Then Null
                             Else                 TelefoneRecados
                           End,

                           Case DDDCelular
                             When '000'      Then Null
                             Else                 DDDCelular
                           End,  
                           Case TelefoneCelular
                             When '00000000' Then Null
                             Else                 TelefoneCelular
                           End,

                           CPF,
                           
                           Case 
                             When Len(RG) = 0           Then Null
                             Else                            RG
                           End,
                           Case 
                             When Len(OrgaoEmissor) = 0 Then Null
                             Else                            OrgaoEmissor
                           End,
                           
                           Convert(SmallDateTime, Stuff(Stuff(DataNascimento,      5,0,'/'),3,0,'/'), 103), -- ddmmyyyy -> dd/mm/yyyy
                           Convert(SmallDateTime, Stuff(Stuff(DataEstabelecimento, 5,0,'/'),3,0,'/'), 103), -- ddmmyyyy -> dd/mm/yyyy

                           Case 
                             When Len(EstadoCivil) = 0  Then Null
                             Else                            EstadoCivil
                           End,


                           Case 
                             When Len(NomePai) = 0      Then Null
                             Else                            NomePai
                           End,
                           Case 
                             When Len(NomeMae) = 0      Then Null
                             Else                            NomeMae
                           End,
                           Case 
                             When Len(Email) = 0        Then Null
                             Else                            Email
                           End,
                           Case 
                             When Len(NomeConjuge) = 0  Then Null
                             Else                            NomeConjuge
                           End,
                           
                           Convert(Int,      OrderId),
                           Convert(TinyInt,  CampanhaFaturamento),
                           Convert(SmallInt, AnoCampanhaFaturamento),
                           
                           Convert(Money, ValorDebito) / 100,
                           
                           Convert(SmallDateTime, Stuff(Stuff(DataFaturamento,     5,0,'/'),3,0,'/'), 103), -- ddmmyyyy -> dd/mm/yyyy
                           Convert(SmallDateTime, Stuff(Stuff(DataVencimento,      5,0,'/'),3,0,'/'), 103), -- ddmmyyyy -> dd/mm/yyyy
                           Convert(SmallDateTime, Stuff(Stuff(DataExpiracaoBoleto, 5,0,'/'),3,0,'/'), 103), -- ddmmyyyy -> dd/mm/yyyy
                           Convert(SmallDateTime, Stuff(Stuff(DataEnvio,           5,0,'/'),3,0,'/'), 103), -- ddmmyyyy -> dd/mm/yyyy
                           
                           Convert(SmallInt, Setor)                           
                             
                             
From CargaInicialFS1 (nolock)
Where  CargaInicialFS1_ID = @pCargaInicialFS1_ID

-- FIM
