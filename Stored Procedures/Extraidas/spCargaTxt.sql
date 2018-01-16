--------------------------------------------------------------------------------
-- spCargaTxt.sql
-- Data   : 14/08/2013
-- Autor  : Amauri
-- Stored procedure de carga inicial de arquivos TXT
-- Carrega as linhas dos arquivos, aciona as procedures que separam as colunas e que convertem os dados
--------------------------------------------------------------------------------

USE ArquivosAvon
GO

--Drop Procedure CargaTxt
Create Procedure CargaTxt
(
  @pPasta             Varchar(512),
  @pCaminhoArqFmt     Varchar(512),
  @pPastaArqsLidos    Varchar(512),
  @pPastaArqsErros    Varchar(512),
  @pTipo              Varchar(10),   -- Tipo de arquivo ('CS28', 'FS1', 'FS2', etc.)
  @pPrefixo           Varchar(10),   -- Prefixo do nome do arquivo ('CS28', 'CS13', etc.)
  @pLarguraEsperada   Int,
  @pMaxLinhasErros    Int            -- Quantidade máxima permitida de linhas com erros
)
AS


/*
------------ TESTES ANTES DE CRIAR A PROCEDURE - INICIO

Declare @pPasta             Varchar(512),
        @pCaminhoArqFmt     Varchar(512),
        @pPastaArqsLidos    Varchar(512),
        @pPastaArqsErros    Varchar(512),
        @pPrefixo           Varchar(10),   -- Prefixo do nome do arquivo ('CS28', 'CS13', etc.)
        @pTipo              Varchar(10),   -- Tipo de arquivo ('CS28', 'FS1', 'FS2', etc.)
        @pLarguraEsperada   Int,
        @pMaxLinhasErros    Int            -- Quantidade máxima permitida de linhas com erros

Set @pPasta           = 'C:\Tmp\ArqsAvon\CS13\'
Set @pCaminhoArqFmt   = 'C:\Tmp\ArqsAvon\Fmt\Formatacao.fmt'
Set @pPastaArqsLidos  = 'C:\Tmp\ArqsAvon\Lidos'
Set @pPastaArqsErros  = 'C:\Tmp\ArqsAvon\Erros'
Set @pPrefixo         = 'CS13'
Set @pTipo            = 'CS13'
Set @pLarguraEsperada = 0
Set @pMaxLinhasErros  = 10

-- Cria a tabela temporária para receber os nomes dos arquivos
If Exists (Select * From tempdb.dbo.sysobjects Where name Like '#ArquivosTxt%')
Begin
       Drop Table #ArquivosTxt
End
Create Table #ArquivosTxt (Arquivo Varchar(512))

------------ TESTES ANTES DE CRIAR A PROCEDURE - FIM
*/

-- Variáveis específicas para BA01
Declare @ModeloLayoutBA01      Int,
        @DataMovimentoBA01     SmallDateTime,
        @UltimaLinhaBA01       Bit,
        @LinhaComValoresBA01   Int

Set NoCount ON

Declare @QtdArquivos           Int
      , @QtdArquivosCarregados Int
      , @QtdLinhas             Int
      , @QtdLinhasComErros     Int
      , @QtdLinhasGravadas     Int
      , @NomeArquivo           Varchar(256)
      , @Bulk_Comando          Varchar(512)
      , @Caminho               Varchar(512)
      , @Comando               Varchar(512)
      , @Retorno               Int
      , @CargaInicial_ID       Int
      , @CargaInicialTxt_ID    Int
      , @LinhaArquivo          Varchar(4000)
      , @LarguraLinhaArquivo   Int
      -- , @HaErro                Int
      , @ErrorNumber           Int
      , @ErrorMessage          nVarchar(2048)
      , @ComErros              Bit
      , @PastaDestino          Varchar(512)

Set @QtdArquivosCarregados = 0

-- Registra no LOG
Insert Into Log ( DataHora, Origem, Tipo, Mensagem, Complemento )
         Values ( GetDate(),
                  'CargaTxt',
                  'S',
                  'A stored procedure CargaTxt foi acionada',
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
                     'CargaTxt',
                     'E',
                     'Não conseguiu carregar as lista de arquivos de ' + @Comando,
                     'ErrorNumber:' + Cast(@ErrorNumber as Varchar) + ' ErrorMessage:' + @ErrorMessage )
   RETURN -1
END CATCH

--Contador de arquivos TXT
Select @QtdArquivos = Count(1)
From   #ArquivosTxt
Where  Arquivo Like @pPrefixo + '%'

If @QtdArquivos !=0
Begin
   -- Registra no LOG
   Insert Into Log ( DataHora, Origem, Tipo, Mensagem )
            Values ( GetDate(),
                     'CargaTxt',
                     'S',
                     'Iniciando a carga de ' + Cast(@QtdArquivos as Varchar) + ' arquivos' )

   -- Percorre a lista de arquivos com um cursor
   Declare arquivosCursor Cursor Local Fast_Forward For

        Select ltrim(rtrim(Arquivo))
        From   #ArquivosTxt
        Where  Arquivo Is Not null and Len(LTrim(RTrim(Arquivo))) > 0
        Order by ltrim(rtrim(Arquivo))

   Open arquivosCursor
   Fetch arquivosCursor Into @NomeArquivo

   While @@fetch_status = 0
   Begin

       Set @PastaDestino = Null

       -- Verifica se o arquivo já foi importado
       If Exists ( Select 1 From Arquivo (nolock) Where Nome = @NomeArquivo )
       Begin
         Insert Into Log ( DataHora, Origem, Tipo, Mensagem, Arquivo )
                  Values ( GetDate(),
                           'CargaTxt',
                           'S',
                           'O arquivo já foi importado',
                           @NomeArquivo )
       End
       Else
       Begin

         -- Esvazia tabelas auxiliares
         -- Truncate Table CargaInicial
         EXEC Carga_Truncate

         -- Importa um arquico
         Set @Caminho ='''' + @pPasta + @NomeArquivo +''''

         Insert Into Log ( DataHora, Origem, Tipo, Mensagem, Arquivo )
                  Values ( GetDate(),
                           'CargaTxt',
                           'S',
                           'Iniciando a carga do arquivo',
                           @NomeArquivo )

         Set @Bulk_Comando = 'Bulk Insert ArquivosAvon.dbo.CargaInicial FROM ' + @Caminho + ' WITH (FORMATFILE=''' + @pCaminhoArqFmt + ''')'
         Exec(@Bulk_Comando)
         Set @ErrorNumber = @@Error

         If @ErrorNumber = 0   -- Se conseguiu carregar as linhas do arquivo ...
         Begin

           Select @QtdLinhas = Count(1) From CargaInicial (nolock)

           -- Registra no LOG
           Insert Into Log ( DataHora, Origem, Tipo, Mensagem, Arquivo )
                    Values ( GetDate(),
                             'CargaTxt',
                             'S',
                             'Carregou ' + Cast(@QtdLinhas as Varchar) + ' linhas do arquivo ',
                             @NomeArquivo )

           Set @QtdLinhas         = 0
           Set @QtdLinhasComErros = 0

           -- Percorre as linhas do arquivo com um cursor
           Declare linhasCursor Cursor Local Fast_Forward For

                Select CargaInicial_ID, ltrim(rtrim(Dados))
                From   CargaInicial (nolock)
                Order by CargaInicial_ID

           Open linhasCursor
           Fetch linhasCursor Into @CargaInicial_ID, @LinhaArquivo

           While @@fetch_status = 0 and @QtdLinhasComErros <= @pMaxLinhasErros
           Begin

             -- Inicia a pré-validação e a separação das colunas
             Set @LarguraLinhaArquivo = Len(@LinhaArquivo)

             If @LarguraLinhaArquivo < @pLarguraEsperada
             Begin
                Set @QtdLinhasComErros = @QtdLinhasComErros + 1

                -- Registra o erro no LOG
                Insert Into Log ( DataHora, Origem, Tipo, Mensagem, Arquivo, Complemento )
                         Values ( GetDate(),
                                  'CargaTxt',
                                  'E',
                                  'Linha ' + Cast(@CargaInicial_ID as Varchar) + ' inválida',
                                  @NomeArquivo,
                                  'Largura encontrada:' + Cast(@LarguraLinhaArquivo as Varchar) )
             End
             Else
             Begin
                BEGIN TRY
                   If @pTipo = 'CS28' Begin
                      Exec CargaCS28_SeparaColunas @CargaInicial_ID
                   End
                   Else If @pTipo = 'CS48' Begin
                      Exec CargaCS48_SeparaColunas @CargaInicial_ID
                   End
                   Else If @pTipo = 'CS13' Begin
                      Exec CargaCS13_SeparaColunas @CargaInicial_ID, @LarguraLinhaArquivo
                   End
                   Else If @pTipo = 'FS1' Begin
                      Exec CargaFS1_SeparaColunas @CargaInicial_ID
                   End
                   Else If @pTipo = 'FS22' Begin
                      Exec CargaFS22_SeparaColunas @CargaInicial_ID
                   End
                   Else If @pTipo = 'FS23' Begin
                      Exec CargaFS23_SeparaColunas @CargaInicial_ID
                   End
                   Else If @pTipo = 'FS3' Begin
                      Exec CargaFS3_SeparaColunas @CargaInicial_ID
                   End
                   Else If @pTipo = 'PP28' Begin
                      Exec CargaPP28_SeparaColunas @CargaInicial_ID
                   End
                   Else If @pTipo = 'PP37_Carga' Begin
                      Exec CargaPP37Carga_SeparaColunas @CargaInicial_ID
                   End
                   Else If @pTipo = 'PP37_Cad' Begin
                      Exec CargaPP37Cadastro_SeparaColunas @CargaInicial_ID
                   End
                   Else If @pTipo = 'BA01' Begin
                   
                      Set  @LinhaComValoresBA01 = 0
                      Exec @LinhaComValoresBA01 = CargaBA01_SeparaColunas @CargaInicial_ID, @ModeloLayoutBA01 OUTPUT, @DataMovimentoBA01 OUTPUT, @UltimaLinhaBA01 OUTPUT
                      
                      If @UltimaLinhaBA01 = 1 Begin
                         BREAK -- While @@fetch_status = 0 and @QtdLinhasComErros <= @pMaxLinhasErros
                      End                      
                   End
                   
                   Set @QtdLinhas = @QtdLinhas + 1
                END TRY
                BEGIN CATCH

                   Set @QtdLinhasComErros = @QtdLinhasComErros + 1

                   -- Registra o erro no LOG
                   Select @ErrorNumber = ERROR_NUMBER(), @ErrorMessage = ERROR_MESSAGE()

                   Insert Into Log ( DataHora, Origem, Tipo, Mensagem, Arquivo, Complemento )
                            Values ( GetDate(),
                                     'CargaTxt',
                                     'E',
                                     'Não conseguiu carregar a linha ' + Cast(@CargaInicial_ID as Varchar) + ' do arquivo ',
                                     @NomeArquivo,
                                     'ErrorNumber:' + Cast(@ErrorNumber as Varchar) + ' ErrorMessage:' + @ErrorMessage )
                END CATCH
             End

                -- Próxima linha do arquivo
             Fetch Next From linhasCursor Into @CargaInicial_ID, @LinhaArquivo
           End

           Close linhasCursor
           Deallocate linhasCursor

           -- Registra no LOG
           Insert Into Log ( DataHora, Origem, Tipo, Mensagem, Arquivo )
                    Values ( GetDate(),
                             'CargaTxt',
                             'S',
                             'Extraiu dados de ' + Cast(@QtdLinhas as Varchar) + ' linhas',
                             @NomeArquivo )
                             
           -- Se houver muitas linhas com erros ...
           If @QtdLinhasComErros > @pMaxLinhasErros
           Begin
                Insert Into Log ( DataHora, Origem, Tipo, Mensagem, Arquivo )
                         Values ( GetDate(),
                                  'CargaTxt',
                                  'E',
                                  'Quantidade excessiva de linhas com erros:' + Cast(@QtdLinhasComErros as Varchar),
                                  @NomeArquivo )

                Set @PastaDestino = @pPastaArqsErros
           End
           Else
           Begin
              -- Inicia conversão dos dados

              Set @QtdLinhas = 0
              -- Percorre as linhas do arquivo com um cursor
              If @pTipo = 'CS28' Begin

                 Declare linhasCursor Cursor Local Fast_Forward For

                      Select CargaInicialCS28_ID
                      From   CargaInicialCS28 (nolock)
                      Order by CargaInicialCS28_ID
              End
              Else If @pTipo = 'CS48' Begin

                 Declare linhasCursor Cursor Local Fast_Forward For

                      Select CargaInicialCS48_ID
                      From   CargaInicialCS48 (nolock)
                      Order by CargaInicialCS48_ID
              End
              Else If @pTipo = 'CS13' Begin

                 Declare linhasCursor Cursor Local Fast_Forward For

                      Select CargaInicialCS13_ID
                      From   CargaInicialCS13 (nolock)
                      Order by CargaInicialCS13_ID
              End
              Else If @pTipo = 'FS1' Begin

                 Declare linhasCursor Cursor Local Fast_Forward For

                      Select CargaInicialFS1_ID
                      From   CargaInicialFS1 (nolock)
                      Order by CargaInicialFS1_ID
              End
              Else If @pTipo = 'FS22' Begin

                 Declare linhasCursor Cursor Local Fast_Forward For

                      Select CargaInicialFS22_ID
                      From   CargaInicialFS22 (nolock)
                      Order by CargaInicialFS22_ID
              End
              Else If @pTipo = 'FS23' Begin

                 Declare linhasCursor Cursor Local Fast_Forward For

                      Select CargaInicialFS23_ID
                      From   CargaInicialFS23 (nolock)
                      Order by CargaInicialFS23_ID
              End
              Else If @pTipo = 'FS3' Begin

                 Declare linhasCursor Cursor Local Fast_Forward For

                      Select CargaInicialFS3_ID
                      From   CargaInicialFS3 (nolock)
                      Order by CargaInicialFS3_ID
              End
              Else If @pTipo = 'PP28' Begin

                 Declare linhasCursor Cursor Local Fast_Forward For

                      Select CargaInicialPP28_ID
                      From   CargaInicialPP28 (nolock)
                      Order by CargaInicialPP28_ID
              End
              Else If @pTipo = 'PP37_Carga' Begin

                 Declare linhasCursor Cursor Local Fast_Forward For

                      Select CargaInicialPP37_Carga_ID
                      From   CargaInicialPP37_Carga (nolock)
                      Order by CargaInicialPP37_Carga_ID
              End
              Else If @pTipo = 'PP37_Cad' Begin

                 Declare linhasCursor Cursor Local Fast_Forward For

                      Select CargaInicialPP37_Cadastro_ID
                      From   CargaInicialPP37_Cadastro (nolock)
                      Order by CargaInicialPP37_Cadastro_ID
              End
              Else If @pTipo = 'BA01' Begin

                 Declare linhasCursor Cursor Local Fast_Forward For

                      Select CargaInicialBA01_ID
                      From   CargaInicialBA01 (nolock)
                      Order by CargaInicialBA01_ID
              End

              Open linhasCursor
              Fetch linhasCursor Into @CargaInicialTxt_ID

              While @@fetch_status = 0 and @QtdLinhasComErros <= @pMaxLinhasErros
              Begin
                BEGIN TRY
                   If @pTipo = 'CS28' Begin
                      Exec CargaCS28_ConverteDados @CargaInicialTxt_ID
                   End
                   Else If @pTipo = 'CS48' Begin
                      Exec CargaCS48_ConverteDados @CargaInicialTxt_ID
                   End
                   Else If @pTipo = 'CS13' Begin
                      Exec CargaCS13_ConverteDados @CargaInicialTxt_ID
                   End
                   Else If @pTipo = 'FS1' Begin
                      Exec CargaFS1_ConverteDados @CargaInicialTxt_ID
                   End
                   Else If @pTipo = 'FS22' Begin
                      Exec CargaFS22_ConverteDados @CargaInicialTxt_ID
                   End
                   Else If @pTipo = 'FS23' Begin
                      Exec CargaFS23_ConverteDados @CargaInicialTxt_ID
                   End
                   Else If @pTipo = 'FS3' Begin
                      Exec CargaFS3_ConverteDados @CargaInicialTxt_ID
                   End
                   Else If @pTipo = 'PP28' Begin
                      Exec CargaPP28_ConverteDados @CargaInicialTxt_ID
                   End
                   Else If @pTipo = 'PP37_Carga' Begin
                      Exec CargaPP37Carga_ConverteDados @CargaInicialTxt_ID
                   End
                   Else If @pTipo = 'PP37_Cad' Begin
                      Exec CargaPP37Cadastro_ConverteDados @CargaInicialTxt_ID
                   End
                   Else If @pTipo = 'BA01' Begin
                      Exec CargaBA01_ConverteDados @CargaInicialTxt_ID
                   End
                   
                   Set @QtdLinhas = @QtdLinhas + 1
                   
                   -- Print '@QtdLinhas=' + Cast(@QtdLinhas as Varchar) + ' @CargaInicialTxt_ID=' + Cast(@CargaInicialTxt_ID as Varchar) + ' ' + @NomeArquivo
                END TRY
                BEGIN CATCH

                   Set @QtdLinhasComErros = @QtdLinhasComErros + 1

                   -- Registra o erro no LOG
                   Select @ErrorNumber = ERROR_NUMBER(), @ErrorMessage = ERROR_MESSAGE()

                   Insert Into Log ( DataHora, Origem, Tipo, Mensagem, Arquivo, Complemento )
                            Values ( GetDate(),
                                     'CargaTxt',
                                     'E',
                                     'Não conseguiu converter os dados da linha ' + Cast(@CargaInicialTxt_ID as Varchar) + ' do arquivo ',
                                     @NomeArquivo,
                                     'ErrorNumber:' + Cast(@ErrorNumber as Varchar) + ' ErrorMessage:' + @ErrorMessage )
                END CATCH

                -- Próxima linha da tabela
                Fetch Next From linhasCursor Into @CargaInicialTxt_ID
              End

              Close linhasCursor
              Deallocate linhasCursor

              -- Registra no LOG
              Insert Into Log ( DataHora, Origem, Tipo, Mensagem, Arquivo )
                       Values ( GetDate(),
                                'CargaTxt',
                                'S',
                                'Converteu dados de ' + Cast(@QtdLinhas as Varchar) + ' linhas',
                                @NomeArquivo )
                                
              -- Se houver muitas linhas com erros ...
              If @QtdLinhasComErros > @pMaxLinhasErros
              Begin
                   Insert Into Log ( DataHora, Origem, Tipo, Mensagem, Arquivo )
                            Values ( GetDate(),
                                     'CargaTxt',
                                     'E',
                                     'Quantidade excessiva de linhas com erros:' + Cast(@QtdLinhasComErros as Varchar),
                                     @NomeArquivo )

                   Set @PastaDestino = @pPastaArqsErros
              End
              Else
              Begin
                 -- Transporta os dados para as tabelas definitivas

                 If @QtdLinhasComErros > 0
                    Set @ComErros = 1
                 else
                    Set @ComErros = 0

                 Declare @Arquivo_ID Int

                 BEGIN TRY
                 
                    BEGIN TRANSACTION  -- Inicia uma transação para o arquivo inteiro
                    
                    Insert Into Arquivo ( DataHora,
                                          Nome,
                                          Tipo,
                                          QtdLinhasLidas,
                                          QtdLinhasGravadas,
                                          ComErros )
   
                                 Values ( GetDate(),
                                          @NomeArquivo,
                                          @pTipo,
                                          @QtdLinhas,
                                          @QtdLinhasGravadas,
                                          @ComErros )
   
                    Set @Arquivo_ID = SCOPE_IDENTITY()
   
                    -- >>>>> PAREI AQUI
                    
                    If @pTipo = 'CS28' Begin
                       EXEC CargaCS28 @Arquivo_ID
                    End
                    Else If @pTipo = 'CS48' Begin
                       EXEC CargaCS48 @Arquivo_ID
                    End
                    Else If @pTipo = 'FS1' Begin
                       EXEC CargaFS1 @Arquivo_ID
                    End
                    Else If @pTipo = 'FS22' Begin
                       EXEC CargaFS22 @Arquivo_ID
                    End
                    
                    Set @QtdArquivosCarregados = @QtdArquivosCarregados + 1
                    
                    COMMIT TRANSACTION -- Finaliza a transação                   
                    
                 END TRY
                 BEGIN CATCH
                 
                    ROLLBACK TRANSACTION -- Cancela a transação
                    
                    Select @ErrorNumber = ERROR_NUMBER(), @ErrorMessage = ERROR_MESSAGE()
                    
                    Insert Into Log ( DataHora, Origem, Tipo, Mensagem, Complemento, Arquivo )
                             Values ( GetDate(),
                                      'CargaTxt',
                                      'E',
                                      'Não conseguiu carregar as informações nas tabelas finais',
                                      @ErrorMessage,
                                      @NomeArquivo )
                                      
                    Delete From Arquivo Where Arquivo_ID = @Arquivo_ID                  
                    
                    RETURN -1
                 END CATCH
              End
           End
         End
         Else            -- Se não conseguiu carregar as linhas do arquivo ...
         Begin

           -- Registra o erro no LOG
           Insert Into Log ( DataHora, Origem, Tipo, Mensagem, Arquivo, Complemento )
                    Values ( GetDate(),
                             'CargaTxt',
                             'E',
                             'Não conseguiu carregar o arquivo - Erro:' + Cast(@ErrorNumber as Varchar),
                             @NomeArquivo,
                             @Bulk_Comando )

           Set @PastaDestino = @pPastaArqsErros
         End
       End

       If @PastaDestino Is Null Begin
          Set @PastaDestino = @pPastaArqsLidos
       End

/* Linhas desabilitadas durante os testes
       -- Move o arquivo para a pasta de destino (Lidos ou Erros)
       Set @Comando = 'move "' + @pPasta + @NomeArquivo + '" ' + ltrim(rtrim(@PastaDestino))
       Exec @Retorno = master.dbo.xp_cmdshell @Comando, NO_OUTPUT

       If @Retorno != 0  -- Se não conseguiu mover ...
       Begin
          -- Registra o erro no LOG
          Insert Into Log ( DataHora, Origem, Tipo, Mensagem, Arquivo, Complemento )
                   Values ( GetDate(),
                            'CargaTxt',
                            'E',
                            'Não conseguiu mover o arquivo - Erro:' + Cast(@ErrorNumber as Varchar),
                            @NomeArquivo,
                            @Comando )
       End
*/

       -- Próximo arquivo da pasta
       Fetch Next From arquivosCursor Into @NomeArquivo
   End

   Close arquivosCursor
   Deallocate arquivosCursor

   Insert Into Log ( DataHora, Origem, Tipo, Mensagem )
            Values ( GetDate(),
                     'CargaTxt',
                     'S',
                     'Qtd de arquivos carregados:' + Cast(@QtdArquivosCarregados as Varchar) )
End

-- Esvazia tabelas auxiliares
-- EXEC Carga_Truncate

RETURN @QtdArquivosCarregados

-- FIM
