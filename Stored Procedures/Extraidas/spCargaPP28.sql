--------------------------------------------------------------------------------
-- spCargaPP28.sql
-- Data   : 02/09/2013
-- Autor  : Amauri
-- Stored procedure de carga de arquivos PP28
-- Alimenta as tabelas finais
--------------------------------------------------------------------------------

USE ArquivosAvon
GO

Alter Procedure CargaPP28
(
  @pArquivo_ID Int
)
AS

Set NoCount ON

-- Registra no LOG
Insert Into Log ( DataHora, Origem, Tipo, Mensagem, Arquivo )
         Values ( GetDate(),
                  'CargaPP28',
                  'S',
                  'Iniciando a carga de dados',
                  'PP28' )

Declare @ConversaoPP28_ID Int,
        @Setor            SmallInt,
        @RegAsc           Int,
        @Nome_Ra          Varchar(50),
        @Dt_Lacto         SmallDateTime,
        @AD               Int,
        @Vlr_Deb          Money,
        @Ano_Cp           SmallInt,
        @Cp               TinyInt,
        @Vlr_Saldo        Money 

Declare @Operacao      Varchar(300)
      , @ErrorNumber   Int
      , @ErrorMessage  nVarchar(2048)
      , @ErrorSeverity Int
      , @ErrorState    Int

Set @Operacao = 'Abrindo Cursor'

-- Percorre as linhas com um cursor
Declare dadosCursor Cursor Local Fast_Forward For

     Select ConversaoPP28_ID,
            Setor,
            RegAsc,
            Nome_Ra,
            Dt_Lacto,
            AD,
            Vlr_Deb,
            Ano_Cp,
            Cp,
            Vlr_Saldo

     From ConversaoPP28 (nolock)
     Order by ConversaoPP28_ID 
            
Open dadosCursor
Fetch dadosCursor Into @ConversaoPP28_ID,
                       @Setor,
                       @RegAsc,
                       @Nome_Ra,
                       @Dt_Lacto,
                       @AD,
                       @Vlr_Deb,
                       @Ano_Cp,
                       @Cp,
                       @Vlr_Saldo
            
While @@fetch_status = 0
Begin       
   BEGIN TRY

      -- Trata a revendedora  
      Set @Operacao = 'Tratando a revendedora'
      EXEC RevendedoraInsPP28 @RegAsc,
                              @Setor, 
                              @Nome_Ra, 
                              @pArquivo_ID

      -- Trata o débito   
      Set @Operacao = 'Tratando o débito'
      Insert Into PP28 ( Arquivo_ID, 
                         Revendedora_ID,
                         AvisoDebito,
                         DtLancamento,
                         CampanhaNro,
                         CampanhaAno,
                         ValorDebito,
                         ValorSaldo )
                          
                Values ( @pArquivo_ID,
                         @RegAsc,
                         @AD,
                         @Dt_Lacto,
                         @Cp,
                         @Ano_Cp,
                         @Vlr_Deb,
                         @Vlr_Saldo )
                         
   END TRY
   BEGIN CATCH
      
         -- Prepara o retorno
         Select @ErrorNumber   = ERROR_NUMBER(), 
                @ErrorMessage  = ERROR_MESSAGE(), 
                @ErrorSeverity = ERROR_SEVERITY(),
                @ErrorState    = ERROR_STATE()
   
         Declare @Complemento Varchar(4000)                 
         Set     @Complemento = 'Operacao:' + @Operacao + ' @ConversaoPP28_ID:' + Cast(@ConversaoPP28_ID as Varchar) +' ErrorNumber:' + Cast(@ErrorNumber as Varchar) + ' ErrorMessage:' + @ErrorMessage
   
         RAISERROR ( @Complemento, @ErrorSeverity, @ErrorState )
   END CATCH
   
   Fetch Next From dadosCursor Into @ConversaoPP28_ID,
                       @Setor,
                       @RegAsc,
                       @Nome_Ra,
                       @Dt_Lacto,
                       @AD,
                       @Vlr_Deb,
                       @Ano_Cp,
                       @Cp,
                       @Vlr_Saldo
End

GO

-- FIM
