--------------------------------------------------------------------------------
-- spCargaFS22.sql
-- Data   : 29/08/2013
-- Autor  : Amauri
-- Stored procedure de carga de arquivos FS22 
-- Alimenta as tabelas finais
--------------------------------------------------------------------------------

USE ArquivosAvon
GO

--Drop Procedure CargaFS22
Create Procedure CargaFS22
(
  @pArquivo_ID  Int
)
AS

Set NoCount ON

/* Durante os testes
Insert Into Arquivo ( DataHora,
                      Nome,
                      Tipo,
                      QtdLinhasLidas,
                      QtdLinhasGravadas,
                      ComErros )

             Values ( GetDate(),
                      'TESTE',
                      'TESTE',
                      0,
                      0,
                      0 )

Declare @pArquivo_ID Int
Select  @pArquivo_ID = Max(Arquivo_ID) From Arquivo (nolock)
*/

-- Registra no LOG
Insert Into Log ( DataHora, Origem, Tipo, Mensagem, Arquivo )
         Values ( GetDate(),
                  'CargaFS22',
                  'S',
                  'Iniciando a carga de dados',
                  'FS22' )

Declare @ConversaoFS22_ID     Int,
        @IDDEVEDOR            Int,
        @DEVNOME              Varchar(50),
        @DEVENDERECO          Varchar(65),
        @DEVCOMPL             Varchar(20),
        @DEVBAIRRO            Varchar(30),
        @DEVCIDADE            Varchar(20),
        @DEVUF                Varchar(2),
        @DEVCEP               Varchar(8),
        @CODIGOBANCO          SmallInt,
        @NOMEBANCO            Varchar(30),
        @LINHADIGITAVEL       Varchar(60),
        @LOCALPAGAMENTO       Varchar(84),
        @PARCELA              Varchar(7),
        @VENCIMENTO           SmallDateTime,
        @CEDENTE              Varchar(84),
        @AGENCIACODIGOCEDENTE Varchar(19),
        @CAMPANHA             TinyInt,
        @AVISO_DEBITO         Int,
        @DATADOCUMENTO        SmallDateTime,
        @NUMERODOCUMENTO      Varchar(10),
        @ESPECIEDOCUMENTO     Varchar(2),
        @ACEITE               Char(1),
        @DATAPROCESSAMENTO    SmallDateTime,
        @NOSSONUMERO          Varchar(21),
        @USOBANCO             Varchar(4),
        @CARTEIRA             Varchar(3),
        @MOEDA                Varchar(4),
        @QUANTIDADE           Varchar(5),
        @VALOR                Money,
        @VALORDOCUMENTO       Money,
        @CIP                  SmallInt,
        @BONIFICACAO          Money,
        @COMISSAO             Money,
        @INSTRUCAO01          Varchar(98),
        @INSTRUCAO02          Varchar(98),
        @INSTRUCAO03          Varchar(98),
        @INSTRUCAO04          Varchar(98),
        @INSTRUCAO05          Varchar(98),
        @INSTRUCAO06          Varchar(98),
        @INSTRUCAO07          Varchar(98),
        @INSTRUCAO08          Varchar(98),
        @INSTRUCAO09          Varchar(98),
        @CODIGOBARRAS         Varchar(44)

Declare @Operacao      Varchar(300)
      , @ErrorNumber   Int
      , @ErrorMessage  nVarchar(2048)
      , @ErrorSeverity Int
      , @ErrorState    Int

Set @Operacao = 'Abrindo Cursor'

-- Percorre as linhas com um cursor
Declare dadosCursor Cursor Local Fast_Forward For

     Select ConversaoFS22_ID,
            IDDEVEDOR,
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
            CAMPANHA,
            AVISO_DEBITO,
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
            CODIGOBARRAS

     From ConversaoFS22 (nolock)
     Order by ConversaoFS22_ID 
            
Open dadosCursor
Fetch dadosCursor Into @ConversaoFS22_ID,
                       @IDDEVEDOR,
                       @DEVNOME,
                       @DEVENDERECO,
                       @DEVCOMPL,
                       @DEVBAIRRO,
                       @DEVCIDADE,
                       @DEVUF,
                       @DEVCEP,
                       @CODIGOBANCO,
                       @NOMEBANCO,
                       @LINHADIGITAVEL,
                       @LOCALPAGAMENTO,
                       @PARCELA,
                       @VENCIMENTO,
                       @CEDENTE,
                       @AGENCIACODIGOCEDENTE,
                       @CAMPANHA,
                       @AVISO_DEBITO,
                       @DATADOCUMENTO,
                       @NUMERODOCUMENTO,
                       @ESPECIEDOCUMENTO,
                       @ACEITE,
                       @DATAPROCESSAMENTO,
                       @NOSSONUMERO,
                       @USOBANCO,
                       @CARTEIRA,
                       @MOEDA,
                       @QUANTIDADE,
                       @VALOR,
                       @VALORDOCUMENTO,
                       @CIP,
                       @BONIFICACAO,
                       @COMISSAO,
                       @INSTRUCAO01,
                       @INSTRUCAO02,
                       @INSTRUCAO03,
                       @INSTRUCAO04,
                       @INSTRUCAO05,
                       @INSTRUCAO06,
                       @INSTRUCAO07,
                       @INSTRUCAO08,
                       @INSTRUCAO09,
                       @CODIGOBARRAS
            
While @@fetch_status = 0
Begin       

   BEGIN TRY

   -- Trata a cidade da revendedora
   Set @Operacao = 'Tratando a cidade da revendedora'

   Declare @Municipio_ID Int
   Set     @Municipio_ID = Null
   
   If @DEVUF Is Not Null and @DEVCIDADE Is Not Null Begin
      EXEC MunicipioIns @DEVUF, @DEVCIDADE, @Municipio_ID OUTPUT
   End

   -- Trata o bairro da revendedora
   Set @Operacao = 'Tratando o bairro da revendedora'
   Declare @Bairro_ID Int
   Set     @Bairro_ID = Null
   
   If @Municipio_ID Is Not Null and @DEVBAIRRO Is Not Null Begin
      EXEC BairroIns @Municipio_ID, @DEVBAIRRO, @Bairro_ID OUTPUT
   End
   
   -- Trata a revendedora  
   Set @Operacao = 'Tratando a revendedora'
   EXEC RevendedoraInsFS22 @IDDEVEDOR, 
                           @Municipio_ID,
                           @Bairro_ID,
                           @DEVNOME, 
                           @DEVENDERECO,
                           @DEVCOMPL,
                           @DEVCEP, 
                           @pArquivo_ID
                           
   -- Trata o banco
   Set @Operacao = 'Tratando o banco'
   If @CODIGOBANCO Is Not Null and @NOMEBANCO Is Not Null Begin
      EXEC BancoIns @CODIGOBANCO, @NOMEBANCO
   End

   -- Trata o local de pagamento      
   Set @Operacao = 'Tratando o local de pagamento'                   
   Declare @BoletoLocalPagto_ID Int
   Set     @BoletoLocalPagto_ID = Null
   
   If @LOCALPAGAMENTO Is Not Null Begin
      EXEC BoletoLocalPagtoIns @LOCALPAGAMENTO, @BoletoLocalPagto_ID OUTPUT
   End

   -- Trata o cedente
   Set @Operacao = 'Tratando o cedente'                   
   Declare @BoletoCedente_ID Int
   Set     @BoletoCedente_ID = Null
   
   If @CEDENTE Is Not Null Begin
      EXEC BoletoCedenteIns @CEDENTE, @BoletoCedente_ID OUTPUT
   End

   -- Trata agência e cod cedente
   Set @Operacao = 'Tratando agência e cod cedente'                   
   Declare @BoletoAgenciaCodCedente_ID  Int
   Set     @BoletoAgenciaCodCedente_ID = Null
   
   If @AGENCIACODIGOCEDENTE  Is Not Null Begin
      EXEC BoletoAgenciaCodCedenteIns @AGENCIACODIGOCEDENTE, @BoletoAgenciaCodCedente_ID OUTPUT
   End

   -- Trata a instrução 1 do boleto
   Set @Operacao = 'Tratando a instrução 1'                   
   Declare @BoletoInstrucao1_ID Int
   Set     @BoletoInstrucao1_ID = Null
   
   If @INSTRUCAO01 Is Not Null Begin
      EXEC BoletoInstrucaoIns @INSTRUCAO01, @BoletoInstrucao1_ID OUTPUT
   End

   -- Trata a instrução 2 do boleto
   Set @Operacao = 'Tratando a instrução 2'                   
   Declare @BoletoInstrucao2_ID Int
   Set     @BoletoInstrucao2_ID = Null
   
   If @INSTRUCAO02 Is Not Null Begin
      EXEC BoletoInstrucaoIns @INSTRUCAO02, @BoletoInstrucao2_ID OUTPUT
   End

   -- Trata a instrução 3 do boleto
   Set @Operacao = 'Tratando a instrução 3'                   
   Declare @BoletoInstrucao3_ID Int
   Set     @BoletoInstrucao3_ID = Null
   
   If @INSTRUCAO03 Is Not Null Begin
      EXEC BoletoInstrucaoIns @INSTRUCAO03, @BoletoInstrucao3_ID OUTPUT
   End

   -- Trata a instrução 4 do boleto
   Set @Operacao = 'Tratando a instrução 4'                   
   Declare @BoletoInstrucao4_ID Int
   Set     @BoletoInstrucao4_ID = Null
   
   If @INSTRUCAO04 Is Not Null Begin
      EXEC BoletoInstrucaoIns @INSTRUCAO04, @BoletoInstrucao4_ID OUTPUT
   End

   -- Trata a instrução 5 do boleto
   Set @Operacao = 'Tratando a instrução 5'                   
   Declare @BoletoInstrucao5_ID Int
   Set     @BoletoInstrucao5_ID = Null
   
   If @INSTRUCAO05 Is Not Null Begin
      EXEC BoletoInstrucaoIns @INSTRUCAO05, @BoletoInstrucao5_ID OUTPUT
   End

   -- Trata a instrução 6 do boleto
   Set @Operacao = 'Tratando a instrução 6'                   
   Declare @BoletoInstrucao6_ID Int
   Set     @BoletoInstrucao6_ID = Null
   
   If @INSTRUCAO06 Is Not Null Begin
      EXEC BoletoInstrucaoIns @INSTRUCAO06, @BoletoInstrucao6_ID OUTPUT
   End

   -- Trata a instrução 7 do boleto
   Set @Operacao = 'Tratando a instrução 7'                   
   Declare @BoletoInstrucao7_ID Int
   Set     @BoletoInstrucao7_ID = Null
   
   If @INSTRUCAO07 Is Not Null Begin
      EXEC BoletoInstrucaoIns @INSTRUCAO07, @BoletoInstrucao7_ID OUTPUT
   End

   -- Trata a instrução 8 do boleto
   Set @Operacao = 'Tratando a instrução 8'                   
   Declare @BoletoInstrucao8_ID Int
   Set     @BoletoInstrucao8_ID = Null
   
   If @INSTRUCAO08 Is Not Null Begin
      EXEC BoletoInstrucaoIns @INSTRUCAO08, @BoletoInstrucao8_ID OUTPUT
   End

   -- Trata a instrução 9 do boleto
   Set @Operacao = 'Tratando a instrução 9'                   
   Declare @BoletoInstrucao9_ID Int
   Set     @BoletoInstrucao9_ID = Null
   
   If @INSTRUCAO09 Is Not Null Begin
      EXEC BoletoInstrucaoIns @INSTRUCAO09, @BoletoInstrucao9_ID OUTPUT
   End

   -- Trata o débito   
   Set @Operacao = 'Tratando o débito'
   Insert Into FS22  ( Arquivo_ID,
                       Revendedora_ID,
                       Banco_ID,
                       BoletoLocalPagto_ID,
                       BoletoCedente_ID,
                       BoletoAgenciaCodCedente_ID,
                       BoletoInstrucao1_ID,
                       BoletoInstrucao2_ID,
                       BoletoInstrucao3_ID,
                       BoletoInstrucao4_ID,
                       BoletoInstrucao5_ID,
                       BoletoInstrucao6_ID,
                       BoletoInstrucao7_ID,
                       BoletoInstrucao8_ID,
                       BoletoInstrucao9_ID,
                       LinhaDigitavel,
                       Parcela,
                       Vencimento,
                       Campanha,
                       AvisoDebito,
                       DataDocumento,
                       NumeroDocumento,
                       EspecieDocumento,
                       Aceite,
                       DataProcessamento,
                       NossoNumero,
                       UsoBanco,
                       Carteira,
                       Moeda,
                       Quantidade,
                       Valor,
                       ValorDocumento,
                       Cip,
                       Bonificacao,
                       Comissao,
                       Codigobarras )
                       
             Values ( @pArquivo_ID,
                      @IDDEVEDOR,
                      @CODIGOBANCO,
                      @BoletoLocalPagto_ID,
                      @BoletoCedente_ID,
                      @BoletoAgenciaCodCedente_ID,
                      @BoletoInstrucao1_ID,
                      @BoletoInstrucao2_ID,
                      @BoletoInstrucao3_ID,
                      @BoletoInstrucao4_ID,
                      @BoletoInstrucao5_ID,
                      @BoletoInstrucao6_ID,
                      @BoletoInstrucao7_ID,
                      @BoletoInstrucao8_ID,
                      @BoletoInstrucao9_ID,
                      @LINHADIGITAVEL,
                      @PARCELA,
                      @VENCIMENTO,
                      @CAMPANHA,
                      @AVISO_DEBITO,
                      @DATADOCUMENTO,
                      @NUMERODOCUMENTO,
                      @ESPECIEDOCUMENTO,
                      @ACEITE,
                      @DATAPROCESSAMENTO,
                      @NOSSONUMERO,
                      @USOBANCO,
                      @CARTEIRA,
                      @MOEDA,
                      @QUANTIDADE,
                      @VALOR,
                      @VALORDOCUMENTO,
                      @CIP,
                      @BONIFICACAO,
                      @COMISSAO,
                      @CODIGOBARRAS )
                      
   END TRY
   BEGIN CATCH
                       
      -- Prepara o retorno
      Select @ErrorNumber   = ERROR_NUMBER(), 
             @ErrorMessage  = ERROR_MESSAGE(), 
             @ErrorSeverity = ERROR_SEVERITY(),
             @ErrorState    = ERROR_STATE()

      Declare @Complemento Varchar(4000)                 
      Set     @Complemento = 'Operacao:' + @Operacao + ' ConversaoFS22_ID:' + Cast(@ConversaoFS22_ID as Varchar) +' ErrorNumber:' + Cast(@ErrorNumber as Varchar) + ' ErrorMessage:' + @ErrorMessage

      RAISERROR ( @Complemento, @ErrorSeverity, @ErrorState )
   END CATCH

   Fetch Next From dadosCursor Into @ConversaoFS22_ID,
                                    @IDDEVEDOR,
                                    @DEVNOME,
                                    @DEVENDERECO,
                                    @DEVCOMPL,
                                    @DEVBAIRRO,
                                    @DEVCIDADE,
                                    @DEVUF,
                                    @DEVCEP,
                                    @CODIGOBANCO,
                                    @NOMEBANCO,
                                    @LINHADIGITAVEL,
                                    @LOCALPAGAMENTO,
                                    @PARCELA,
                                    @VENCIMENTO,
                                    @CEDENTE,
                                    @AGENCIACODIGOCEDENTE,
                                    @CAMPANHA,
                                    @AVISO_DEBITO,
                                    @DATADOCUMENTO,
                                    @NUMERODOCUMENTO,
                                    @ESPECIEDOCUMENTO,
                                    @ACEITE,
                                    @DATAPROCESSAMENTO,
                                    @NOSSONUMERO,
                                    @USOBANCO,
                                    @CARTEIRA,
                                    @MOEDA,
                                    @QUANTIDADE,
                                    @VALOR,
                                    @VALORDOCUMENTO,
                                    @CIP,
                                    @BONIFICACAO,
                                    @COMISSAO,
                                    @INSTRUCAO01,
                                    @INSTRUCAO02,
                                    @INSTRUCAO03,
                                    @INSTRUCAO04,
                                    @INSTRUCAO05,
                                    @INSTRUCAO06,
                                    @INSTRUCAO07,
                                    @INSTRUCAO08,
                                    @INSTRUCAO09,
                                    @CODIGOBARRAS
End

GO

-- FIM
