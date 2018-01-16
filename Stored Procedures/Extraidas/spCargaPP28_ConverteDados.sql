--------------------------------------------------------------------------------
-- spCargaPP28_ConverteDados.sql
-- Data   : 20/08/2013
-- Autor  : Amauri
-- Stored procedure de carga inicial de arquivos PP28 
-- Apenas converte os dados de uma linha
--------------------------------------------------------------------------------

USE ArquivosAvon
GO

Alter Procedure CargaPP28_ConverteDados
(
  @pCargaInicialPP28_ID Int
)
AS

Set NoCount ON

Insert Into ConversaoPP28 ( Setor, 
                            RegAsc, 
                            Nome_Ra, 
                            Dt_Lacto, 
                            AD, 
                            Vlr_Deb, 
                            Ano_Cp, 
                            Cp, 
                            Vlr_Saldo ) 
                             
                     Select Convert(SmallInt,      Setor), 
                            Convert(Int,           RegAsc), 
                            Nome_Ra, 
                            Convert(SmallDateTime, Dt_Lacto, 103), -- dd/mm/yyyy
                            Convert(Int,           AD), 
                            Convert(Money,         Vlr_Deb), 
                            Convert(SmallInt,      Ano_Cp), 
                            Convert(TinyInt,       Cp), 
                            Convert(Money,         Vlr_Saldo)
                             
From CargaInicialPP28 (nolock)
Where  CargaInicialPP28_ID = @pCargaInicialPP28_ID

-- FIM
