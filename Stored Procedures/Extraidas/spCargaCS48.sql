--------------------------------------------------------------------------------
-- spCargaCS48.sql
-- Data   : 28/08/2013
-- Autor  : Amauri
-- Stored procedure de carga de arquivos CS48 
-- Alimenta as tabelas finais
--------------------------------------------------------------------------------

USE ArquivosAvon
GO

Alter Procedure CargaCS48
(
  @pArquivo_ID Int
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
                  'CargaCS48',
                  'S',
                  'Iniciando a carga de dados',
                  'CS48' )

Declare @ConversaoCS48_ID     Int,
        @REGASC               Int, 
        @Nome                 Varchar(50), 
        @Sexo                 Varchar(1), 
        @Endereco             Varchar(60), 
        @Numero               Varchar(5), 
        @Comp                 Varchar(20), 
        @Bairro               Varchar(30), 
        @Cidade               Varchar(20), 
        @UF                   Varchar(2), 
        @CEP                  Varchar(8), 
        @DDD                  Varchar(3), 
        @TEL                  Varchar(8), 
        @DDD_COM              Varchar(3), 
        @TEL_COM              Varchar(8), 
        @RAMAL                Varchar(5), 
        @DDD_REC              Varchar(3), 
        @TEL_REC              Varchar(8), 
        @DDD_CEL              Varchar(3), 
        @TEL_CEL              Varchar(8), 
        @CPF_RA               Varchar(11), 
        @RG_RA                Varchar(11), 
        @ORGAO_EMISSOR        Varchar(5), 
        @DT_NASCIMENTO        SmallDateTime, 
        @DT_ESTABELECIMENTO   SmallDateTime, 
        @ESTADO_CIVIL         Varchar(1), 
        @NOME_DO_PAI          Varchar(50), 
        @NOME_DA_MAE          Varchar(50), 
        @EMAIL                Varchar(50), 
        @CONJUGE              Varchar(50), 
        @ORDER_ID             Int, 
        @CAMPANHA             TinyInt, 
        @ANO_CAMPANHA         SmallInt, 
        @VALOR_PENDENCIA      Money, 
        @DT_FATURAMENTO       SmallDateTime, 
        @DT_VENCIMENTO        SmallDateTime, 
        @DT_EXPIRACAO         SmallDateTime, 
        @DATA_ENVIO           SmallDateTime, 
        @SETOR                SmallInt, 
        @COMISSAO             Money, 
        @JUROS                Money, 
        @NUMERO_DI            Varchar(16) 

Declare @Operacao      Varchar(300)
      , @ErrorNumber   Int
      , @ErrorMessage  nVarchar(2048)
      , @ErrorSeverity Int
      , @ErrorState    Int

Set @Operacao = 'Abrindo Cursor'

BEGIN TRY

   -- Percorre as linhas com um cursor
   Declare dadosCursor Cursor Local Fast_Forward For
   
        Select ConversaoCS48_ID,
               REGASC,
               Nome, 
               Sexo, 
               Endereco, 
               Numero, 
               Comp, 
               Bairro, 
               Cidade, 
               UF, 
               CEP, 
               DDD, 
               TEL, 
               DDD_COM, 
               TEL_COM, 
               RAMAL, 
               DDD_REC, 
               TEL_REC, 
               DDD_CEL, 
               TEL_CEL, 
               CPF_RA, 
               RG_RA, 
               ORGAO_EMISSOR, 
               DT_NASCIMENTO, 
               DT_ESTABELECIMENTO, 
               ESTADO_CIVIL, 
               NOME_DO_PAI, 
               NOME_DA_MAE, 
               EMAIL, 
               CONJUGE, 
               ORDER_ID, 
               CAMPANHA, 
               ANO_CAMPANHA, 
               VALOR_PENDENCIA, 
               DT_FATURAMENTO, 
               DT_VENCIMENTO, 
               DT_EXPIRACAO, 
               DATA_ENVIO, 
               SETOR, 
               COMISSAO, 
               JUROS, 
               NUMERO_DI 
 
        From ConversaoCS48 (nolock)
        Order by ConversaoCS48_ID 
               
   Open dadosCursor
   Fetch dadosCursor Into @ConversaoCS48_ID, 
                          @REGASC, 
                          @Nome, 
                          @Sexo, 
                          @Endereco, 
                          @Numero, 
                          @Comp, 
                          @Bairro, 
                          @Cidade, 
                          @UF, 
                          @CEP, 
                          @DDD, 
                          @TEL, 
                          @DDD_COM, 
                          @TEL_COM, 
                          @RAMAL, 
                          @DDD_REC, 
                          @TEL_REC, 
                          @DDD_CEL, 
                          @TEL_CEL, 
                          @CPF_RA, 
                          @RG_RA, 
                          @ORGAO_EMISSOR, 
                          @DT_NASCIMENTO, 
                          @DT_ESTABELECIMENTO, 
                          @ESTADO_CIVIL, 
                          @NOME_DO_PAI, 
                          @NOME_DA_MAE, 
                          @EMAIL, 
                          @CONJUGE, 
                          @ORDER_ID, 
                          @CAMPANHA, 
                          @ANO_CAMPANHA, 
                          @VALOR_PENDENCIA, 
                          @DT_FATURAMENTO, 
                          @DT_VENCIMENTO, 
                          @DT_EXPIRACAO, 
                          @DATA_ENVIO, 
                          @SETOR, 
                          @COMISSAO, 
                          @JUROS, 
                          @NUMERO_DI 
               
   While @@fetch_status = 0
   Begin       
   
      -- Trata a cidade da revendedora
      Set @Operacao = 'Tratando a cidade da revendedora'
   
      Declare @Municipio_ID Int
      Set     @Municipio_ID = Null
      
      If @UF Is Not Null and @CIDADE Is Not Null Begin
         EXEC MunicipioIns @UF, @CIDADE, @Municipio_ID OUTPUT
      End
   
      -- Trata o bairro da revendedora
      Set @Operacao = 'Tratando o bairro da revendedora'
      Declare @Bairro_ID Int
      Set     @Bairro_ID = Null
      
      If @Municipio_ID Is Not Null and @BAIRRO Is Not Null Begin
         EXEC BairroIns @Municipio_ID, @BAIRRO, @Bairro_ID OUTPUT
      End
      
      -- Trata a revendedora  
      Set @Operacao = 'Tratando a revendedora'
      EXEC RevendedoraInsCS48 @REGASC, 
                              @Municipio_ID,
                              @Bairro_ID,
                              @Nome, 
                              @Sexo, 
                              @Endereco, 
                              @Numero, 
                              @Comp, 
                              -- @Bairro, 
                              -- @Cidade, 
                              -- @UF, 
                              @CEP, 
                              -- @DDD, 
                              -- @TEL, 
                              -- @DDD_COM, 
                              -- @TEL_COM, 
                              -- @RAMAL, 
                              -- @DDD_REC, 
                              -- @TEL_REC, 
                              -- @DDD_CEL, 
                              -- @TEL_CEL, 
                              @CPF_RA, 
                              @RG_RA, 
                              @ORGAO_EMISSOR, 
                              @DT_NASCIMENTO, 
                              @DT_ESTABELECIMENTO, 
                              @ESTADO_CIVIL, 
                              @NOME_DO_PAI, 
                              @NOME_DA_MAE, 
                              @EMAIL, 
                              @CONJUGE, 
                              @SETOR,
                              @pArquivo_ID      
      
      -- Trata o telefone da revendedora
      Set @Operacao = 'Tratando o telefone principal da revendedora'
      EXEC Rev_TelefoneIns @REGASC,
                           'P',     -- P=Principal C=Comercial R=Recado M=Móvel (celular)
                           @DDD,
                           @TEL,
                           NULL     -- Ramal
      
      Set @Operacao = 'Tratando o telefone comercial da revendedora'
      EXEC Rev_TelefoneIns @REGASC,
                           'C',     -- P=Principal C=Comercial R=Recado M=Móvel (celular)
                           @DDD_COM,
                           @TEL_COM,
                           @RAMAL
      
      Set @Operacao = 'Tratando o telefone de recados da revendedora'
      EXEC Rev_TelefoneIns @REGASC,
                           'R',     -- P=Principal C=Comercial R=Recado M=Móvel (celular)
                           @DDD_REC,
                           @TEL_REC,
                           NULL     -- Ramal
      
      Set @Operacao = 'Tratando o telefone móvel da revendedora'
      EXEC Rev_TelefoneIns @REGASC,
                           'M',     -- P=Principal C=Comercial R=Recado M=Móvel (celular)
                           @DDD_CEL,
                           @TEL_CEL,
                           NULL     -- Ramal
      
      -- Trata o débito   
      Set @Operacao = 'Tratando o débito'
      Insert Into CS48 ( Arquivo_ID,
                         Revendedora_ID,
                         AvisoDebito,
                         NumeroDI,
                         CampanhaNro,
                         CampanhaAno,
                         DtFaturamento,
                         DtVencimento,
                         DtExpiracao,
                         DtEnvio,
                         ValorPendencia,
                         Comissao,
                         Juros )
                          
                Values ( @pArquivo_ID,
                         @REGASC,
                         @ORDER_ID,
                         @NUMERO_DI,
                         @CAMPANHA,
                         @ANO_CAMPANHA,
                         @DT_FATURAMENTO,
                         @DT_VENCIMENTO,
                         @DT_EXPIRACAO,
                         @DATA_ENVIO,
                         @VALOR_PENDENCIA,
                         @COMISSAO,
                         @JUROS )
                         
      Fetch Next From dadosCursor Into @ConversaoCS48_ID, 
                                       @REGASC, 
                                       @Nome, 
                                       @Sexo, 
                                       @Endereco, 
                                       @Numero, 
                                       @Comp, 
                                       @Bairro, 
                                       @Cidade, 
                                       @UF, 
                                       @CEP, 
                                       @DDD, 
                                       @TEL, 
                                       @DDD_COM, 
                                       @TEL_COM, 
                                       @RAMAL, 
                                       @DDD_REC, 
                                       @TEL_REC, 
                                       @DDD_CEL, 
                                       @TEL_CEL, 
                                       @CPF_RA, 
                                       @RG_RA, 
                                       @ORGAO_EMISSOR, 
                                       @DT_NASCIMENTO, 
                                       @DT_ESTABELECIMENTO, 
                                       @ESTADO_CIVIL, 
                                       @NOME_DO_PAI, 
                                       @NOME_DA_MAE, 
                                       @EMAIL, 
                                       @CONJUGE, 
                                       @ORDER_ID, 
                                       @CAMPANHA, 
                                       @ANO_CAMPANHA, 
                                       @VALOR_PENDENCIA, 
                                       @DT_FATURAMENTO, 
                                       @DT_VENCIMENTO, 
                                       @DT_EXPIRACAO, 
                                       @DATA_ENVIO, 
                                       @SETOR, 
                                       @COMISSAO, 
                                       @JUROS, 
                                       @NUMERO_DI
   End
END TRY
BEGIN CATCH
   
      -- Prepara o retorno
      Select @ErrorNumber   = ERROR_NUMBER(), 
             @ErrorMessage  = ERROR_MESSAGE(), 
             @ErrorSeverity = ERROR_SEVERITY(),
             @ErrorState    = ERROR_STATE()

      Declare @Complemento Varchar(4000)                 
      Set     @Complemento = 'Operacao:' + @Operacao + ' ConversaoFS22_ID:' + Cast(@ConversaoCS48_ID as Varchar) +' ErrorNumber:' + Cast(@ErrorNumber as Varchar) + ' ErrorMessage:' + @ErrorMessage

      RAISERROR ( @Complemento, @ErrorSeverity, @ErrorState )

   Insert Into Log ( DataHora, Origem, Tipo, Mensagem, Complemento )
            Values ( GetDate(),
                     'CargaCS48',
                     'E',
                     'Não conseguiu inserir nas tabelas finais - Operacao:' + @Operacao + ' ConversaoCS48_ID:' + Cast(@ConversaoCS48_ID as Varchar),
                     'ErrorNumber:' + Cast(@ErrorNumber as Varchar) + ' ErrorMessage:' + @ErrorMessage )
                     
   RAISERROR ( @ErrorMessage, @ErrorSeverity, @ErrorState )
END CATCH

GO

-- FIM
