--------------------------------------------------------------------------------
-- spCargaCompletaPrepara.sql
-- Data   : 21/08/2013
-- Autor  : Amauri
-- Stored procedure que remove dados de 'cargas completas' (ex. CS48)
--------------------------------------------------------------------------------

USE ArquivosAvon
GO

Alter Procedure CargaCompletaPrepara
(
  @pPasta             Varchar(512),
  @pTipo              Varchar(10),   -- Tipo de arquivo ('CS28', 'FS1', 'FS2', etc.)
  @pPrefixo           Varchar(10)    -- Prefixo do nome do arquivo ('CS28', 'CS13', etc.)
)
AS

Declare @QtdArquivos   Int
      , @Comando       Varchar(512)
      , @ErrorNumber   Int
      , @ErrorMessage  nVarchar(2048)

-- Registra no LOG
Insert Into Log ( DataHora, Origem, Tipo, Mensagem, Complemento )
         Values ( GetDate(),
                  'CargaTxt',
                  'S',
                  'A stored procedure CargaCompletaPrepara foi acionada',
                  @pTipo )

-- Carrega a lista de arquivos
Delete From #ArquivosTxt

Set @Comando ='Insert Into #ArquivosTxt Exec master.dbo.xp_cmdshell ''Dir ' + @pPasta + @pPrefixo + '*.txt /B /ON'''

BEGIN TRY
    Exec (@Comando)
END TRY
BEGIN CATCH

   -- Registra o erro no LOG
   Select @ErrorNumber = ERROR_NUMBER(), @ErrorMessage = ERROR_MESSAGE()

   Insert Into Log ( DataHora, Origem, Tipo, Mensagem, Complemento )
            Values ( GetDate(),
                     'CargaCompletaPrepara',
                     'E',
                     'Não conseguiu carregar as lista de arquivos de ' + @Comando,
                     'ErrorNumber:' + Cast(@ErrorNumber as Varchar) + ' ErrorMessage:' + @ErrorMessage )
   RETURN -1
END CATCH

--Contador de arquivos TXT
Select @QtdArquivos = Count(1)
From   #ArquivosTxt
Where  Arquivo Like @pPrefixo + '%'

If @QtdArquivos != 0
Begin
   -- Registra no LOG
   Insert Into Log ( DataHora, Origem, Tipo, Mensagem, Complemento )
            Values ( GetDate(),
                     'CargaCompletaPrepara',
                     'S',
                     'Encontrados ' + Cast(@QtdArquivos as Varchar) + ' arquivos',
                     @pTipo )

   BEGIN TRY
      If @pTipo = 'CS48' Begin
      
         -- Truncate Table <<<<< FALTA COMPLETAR
         
         Insert Into Log ( DataHora, Origem, Tipo, Mensagem, Complemento )
                  Values ( GetDate(),
                           'CargaCompletaPrepara',
                           'S',
                           'Esvaziou a tabela ... ',
                           @pTipo )
      End
   END TRY
   BEGIN CATCH

      -- Registra o erro no LOG
      Select @ErrorNumber = ERROR_NUMBER(), @ErrorMessage = ERROR_MESSAGE()

      Insert Into Log ( DataHora, Origem, Tipo, Mensagem, Complemento )
               Values ( GetDate(),
                        'CargaCompletaPrepara',
                        'E',
                        'Não conseguiu esvaziar tabela de ' + @pTipo,
                        'ErrorNumber:' + Cast(@ErrorNumber as Varchar) + ' ErrorMessage:' + @ErrorMessage )
   END CATCH
End

-- FIM
