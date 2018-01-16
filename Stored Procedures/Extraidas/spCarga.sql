--------------------------------------------------------------------------------
-- spCarga.sql
-- Data   : 14/08/2013
-- Autor  : Amauri
-- Stored procedure inicial, que aciona as outras
--------------------------------------------------------------------------------

USE ArquivosAvon
GO

Set NoCount ON

Declare @RetornoProcedure Int

-- Carrega os parâmetros da tabela de configuração
Declare @PastaCS28          Varchar(512),
        @PastaCS48          Varchar(512),
        @PastaCS13          Varchar(512),
        @PastaFS1           Varchar(512),
        @PastaFS22          Varchar(512),
        @PastaFS23          Varchar(512),
        @PastaFS3           Varchar(512),
        @PastaPP28          Varchar(512),
        @PastaPP37_Carga    Varchar(512),
        @PastaPP37_Cadastro Varchar(512),
        @PastaBA01          Varchar(512),
        @CaminhoArqFmt      Varchar(512),
        @PastaArqsLidos     Varchar(512),
        @PastaArqsErros     Varchar(512),
        @MaxLinhasErros     Int
        -- @Servidor        Varchar(30),  -- Precisaremos ?
        -- @UserId          Varchar(30),  -- Precisaremos ?
        -- @Password        Varchar(30)   -- Precisaremos ?

Select  @PastaCS28            = LTrim(RTrim(PastaCS28))
     ,  @PastaCS48            = LTrim(RTrim(PastaCS48))
     ,  @PastaCS13            = LTrim(RTrim(PastaCS13))
     ,  @PastaFS1             = LTrim(RTrim(PastaBR67_FS1))
     ,  @PastaFS22            = LTrim(RTrim(PastaBR66_FS22))
     ,  @PastaFS23            = LTrim(RTrim(PastaBR66_FS23))
     ,  @PastaFS3             = LTrim(RTrim(PastaBR67_FS3))
     ,  @PastaPP28            = LTrim(RTrim(PastaPP28))
     ,  @PastaPP37_Carga      = LTrim(RTrim(PastaPP37_Carga))
     ,  @PastaPP37_Cadastro   = LTrim(RTrim(PastaPP37_Cadastro))
     ,  @PastaBA01            = LTrim(RTrim(PastaBA01))
     ,  @PastaArqsLidos       = LTrim(RTrim(PastaArqsLidos))  
     ,  @PastaArqsErros       = LTrim(RTrim(PastaArqsErros)) 
     ,  @CaminhoArqFmt        = LTrim(RTrim(CaminhoArqFmt)) 
     ,  @MaxLinhasErros       = MaxLinhasErros
     
      
     -- ,  @Servidor        = Servidor                      -- Precisaremos ?
     -- ,  @UserId          = UserId                        -- Precisaremos ?
     -- ,  @Password        = Password                      -- Precisaremos ?
        
From    Config 

-- Corrige e completa os caminhos
Set @PastaCS28 = Replace(@PastaCS28, '/', '\')
If  Left(Reverse(@PastaCS28),1) <> '\'
    Set @PastaCS28 = @PastaCS28 + '\' 

Set @PastaCS48 = Replace(@PastaCS48, '/', '\')
If  Left(Reverse(@PastaCS48),1) <> '\'
    Set @PastaCS48 = @PastaCS48 + '\' 

Set @PastaCS13 = Replace(@PastaCS13, '/', '\')
If  Left(Reverse(@PastaCS13),1) <> '\'
    Set @PastaCS13 = @PastaCS13 + '\' 

Set @PastaFS1 = Replace(@PastaFS1, '/', '\')
If  Left(Reverse(@PastaFS1),1) <> '\'
    Set @PastaFS1 = @PastaFS1 + '\' 
    
Set @PastaFS22 = Replace(@PastaFS22, '/', '\')
If  Left(Reverse(@PastaFS22),1) <> '\'
    Set @PastaFS22 = @PastaFS22 + '\' 

Set @PastaFS23 = Replace(@PastaFS23, '/', '\')
If  Left(Reverse(@PastaFS23),1) <> '\'
    Set @PastaFS23 = @PastaFS23 + '\' 
    
Set @PastaFS3 = Replace(@PastaFS3, '/', '\')
If  Left(Reverse(@PastaFS3),1) <> '\'
    Set @PastaFS3 = @PastaFS3 + '\' 

Set @PastaPP28 = Replace(@PastaPP28, '/', '\')
If  Left(Reverse(@PastaPP28),1) <> '\'
    Set @PastaPP28 = @PastaPP28 + '\' 
    
Set @PastaPP37_Carga = Replace(@PastaPP37_Carga, '/', '\')
If  Left(Reverse(@PastaPP37_Carga),1) <> '\'
    Set @PastaPP37_Carga = @PastaPP37_Carga + '\' 
    
Set @PastaPP37_Cadastro = Replace(@PastaPP37_Cadastro, '/', '\')
If  Left(Reverse(@PastaPP37_Cadastro),1) <> '\'
    Set @PastaPP37_Cadastro = @PastaPP37_Cadastro + '\' 

Set @PastaBA01 = Replace(@PastaBA01, '/', '\')
If  Left(Reverse(@PastaBA01),1) <> '\'
    Set @PastaBA01 = @PastaBA01 + '\' 
    
-- Cria a tabela temporária para receber os nomes dos arquivos
If Exists (Select * From tempdb.dbo.sysobjects Where name Like '#ArquivosTxt%')
Begin
       Drop Table #ArquivosTxt
End  
Create Table #ArquivosTxt (Arquivo Varchar(512))

-- Remove importações anteriores de arquivos com carga completa (ex. CS48)
EXEC CargaCompletaPrepara @PastaCS48, 'CS48', 'CS48'

--Set  @RetornoProcedure = null 
--Exec @RetornoProcedure = ???
--Print '@RetornoProcedure:' + Cast(@RetornoProcedure as varchar)

/*
-- Trata arquivos CS28
Set  @RetornoProcedure = null 
Exec @RetornoProcedure = CargaTxt @PastaCS28, @CaminhoArqFmt, @PastaArqsLidos, @PastaArqsErros, 'CS28', 'CS28', 2104, @MaxLinhasErros
Print '@RetornoProcedure:' + Cast(@RetornoProcedure as varchar)

-- Trata arquivos CS48
Set  @RetornoProcedure = null 
Exec @RetornoProcedure = CargaTxt @PastaCS48, @CaminhoArqFmt, @PastaArqsLidos, @PastaArqsErros, 'CS48', 'CS48', 603, @MaxLinhasErros
Print '@RetornoProcedure:' + Cast(@RetornoProcedure as varchar)
 
-- Trata arquivos CS13
Set  @RetornoProcedure = null 
Exec @RetornoProcedure = CargaTxt @PastaCS13, @CaminhoArqFmt, @PastaArqsLidos, @PastaArqsErros, 'CS13', 'CS13', 156, @MaxLinhasErros
Print '@RetornoProcedure:' + Cast(@RetornoProcedure as varchar)

-- Trata arquivos BR67 FS1
Set  @RetornoProcedure = null 
Exec @RetornoProcedure = CargaTxt @PastaFS1, @CaminhoArqFmt, @PastaArqsLidos, @PastaArqsErros, 'FS1', 'BR67', 581, @MaxLinhasErros
Print '@RetornoProcedure:' + Cast(@RetornoProcedure as varchar)
*/

-- Trata arquivos FS22
Set  @RetornoProcedure = null 
Exec @RetornoProcedure = CargaTxt @PastaFS22, @CaminhoArqFmt, @PastaArqsLidos, @PastaArqsErros, 'FS22', 'FS22', 1552, @MaxLinhasErros
Print '@RetornoProcedure:' + Cast(@RetornoProcedure as varchar)

/*
-- Trata arquivos FS23
Set  @RetornoProcedure = null 
Exec @RetornoProcedure = CargaTxt @PastaFS23, @CaminhoArqFmt, @PastaArqsLidos, @PastaArqsErros, 'FS23', 'FS23', 1598, @MaxLinhasErros
Print '@RetornoProcedure:' + Cast(@RetornoProcedure as varchar)

-- Trata arquivos FS3
Set  @RetornoProcedure = null 
Exec @RetornoProcedure = CargaTxt @PastaFS3, @CaminhoArqFmt, @PastaArqsLidos, @PastaArqsErros, 'FS3', 'BR67', 65, @MaxLinhasErros
Print '@RetornoProcedure:' + Cast(@RetornoProcedure as varchar)

/*
-- Trata arquivos PP28
Set  @RetornoProcedure = null 
Exec @RetornoProcedure = CargaTxt @PastaPP28, @CaminhoArqFmt, @PastaArqsLidos, @PastaArqsErros, 'PP28', 'PP28', 108, @MaxLinhasErros
Print '@RetornoProcedure:' + Cast(@RetornoProcedure as varchar)
*/

-- Trata arquivos PP37 de carga
Set  @RetornoProcedure = null 
Exec @RetornoProcedure = CargaTxt @PastaPP37_Carga, @CaminhoArqFmt, @PastaArqsLidos, @PastaArqsErros, 'PP37_Carga', 'PP37', 458, @MaxLinhasErros
Print '@RetornoProcedure:' + Cast(@RetornoProcedure as varchar)

-- Trata arquivos PP37 de cadastro
Set  @RetornoProcedure = null 
Exec @RetornoProcedure = CargaTxt @PastaPP37_Cadastro, @CaminhoArqFmt, @PastaArqsLidos, @PastaArqsErros, 'PP37_Cad', 'PP37', 518, @MaxLinhasErros
Print '@RetornoProcedure:' + Cast(@RetornoProcedure as varchar)

-- Trata arquivos BA01
Set  @RetornoProcedure = null 
Exec @RetornoProcedure = CargaTxt @PastaBA01, @CaminhoArqFmt, @PastaArqsLidos, @PastaArqsErros, 'BA01', 'BA01', 0, @MaxLinhasErros
Print '@RetornoProcedure:' + Cast(@RetornoProcedure as varchar)
*/
-- Remove a tabela temporária
If Exists (Select * From tempdb.dbo.sysobjects Where name Like '#ArquivosTxt%')
Begin
       Drop Table #ArquivosTxt
End  
-- FIM
