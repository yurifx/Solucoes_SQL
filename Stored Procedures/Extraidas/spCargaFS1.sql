--------------------------------------------------------------------------------
-- spCargaFS1.sql
-- Data   : 28/08/2013
-- Autor  : Amauri
-- Stored procedure de carga de arquivos FS1 
-- Alimenta as tabelas finais
--------------------------------------------------------------------------------

USE ArquivosAvon
GO

Alter Procedure CargaFS1
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
                  'CargaFS1',
                  'S',
                  'Iniciando a carga de dados',
                  'FS1' )

Declare @ConversaoFS1_ID         Int,
        @CodigoRevendedoraAsc    Int, 
        @NomeRevendedora         Varchar(50), 
        @Sexo                    Varchar(1), 
        @EnderecoRevendedora     Varchar(60), 
        @Numero                  Varchar(5), 
        @Complemento             Varchar(20), 
        @Bairro                  Varchar(30), 
        @Cidade                  Varchar(20), 
        @UF                      Varchar(2), 
        @CEP                     Varchar(8), 
        @DDDResidencial          Varchar(3),
        @TelefoneResidencial     Varchar(8),
        @DDDComercial            Varchar(3),
        @TelefoneComercial       Varchar(8),
        @RamalComercial          Varchar(5),
        @DDDRecados              Varchar(3),
        @TelefoneRecados         Varchar(8),
        @DDDCelular              Varchar(3),
        @TelefoneCelular         Varchar(8),
        @CPF                     Varchar(11), 
        @RG                      Varchar(11), 
        @OrgaoEmissor            Varchar( 5),
        @DataNascimento          SmallDateTime,
        @DataEstabelecimento     SmallDateTime,
        @EstadoCivil             Char(1),
        @NomePai                 Varchar(50),
        @NomeMae                 Varchar(50),
        @Email                   Varchar(50),
        @NomeConjuge             Varchar(50),
        @OrderId                 Int,
        @CampanhaFaturamento     TinyInt,
        @AnoCampanhaFaturamento  SmallInt,
        @ValorDebito             Money,
        @DataFaturamento         SmallDateTime,
        @DataVencimento          SmallDateTime,
        @DataExpiracaoBoleto     SmallDateTime,
        @DataEnvio               SmallDateTime,
        @Setor                   SmallInt

Declare @Operacao      Varchar(300)
      , @ErrorNumber   Int
      , @ErrorMessage  nVarchar(2048)
      , @ErrorSeverity Int
      , @ErrorState    Int

Set @Operacao = 'Abrindo Cursor'

BEGIN TRY

   -- Percorre as linhas com um cursor
   Declare dadosCursor Cursor Local Fast_Forward For
   
        Select ConversaoFS1_ID,
               CodigoRevendedoraAsc,
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
               Setor
 
        From ConversaoFS1 (nolock)
        Order by ConversaoFS1_ID 
               
   Open dadosCursor
   Fetch dadosCursor Into @ConversaoFS1_ID,
                          @CodigoRevendedoraAsc,
                          @NomeRevendedora,
                          @Sexo,
                          @EnderecoRevendedora,
                          @Numero,
                          @Complemento,
                          @Bairro,
                          @Cidade,
                          @UF,
                          @CEP,
                          @DDDResidencial,
                          @TelefoneResidencial,
                          @DDDComercial,
                          @TelefoneComercial,
                          @RamalComercial,
                          @DDDRecados,
                          @TelefoneRecados,
                          @DDDCelular,
                          @TelefoneCelular,
                          @CPF,
                          @RG,
                          @OrgaoEmissor,
                          @DataNascimento,
                          @DataEstabelecimento,
                          @EstadoCivil,
                          @NomePai,
                          @NomeMae,
                          @Email,
                          @NomeConjuge,
                          @OrderId,
                          @CampanhaFaturamento,
                          @AnoCampanhaFaturamento,
                          @ValorDebito,
                          @DataFaturamento,
                          @DataVencimento,
                          @DataExpiracaoBoleto,
                          @DataEnvio,
                          @Setor 
               
   While @@fetch_status = 0
   Begin       
   
      -- Trata a cidade da revendedora
      Set @Operacao = 'Tratando a cidade da revendedora'
   
      Declare @Municipio_ID Int
      Set     @Municipio_ID = Null
      
      If @UF Is Not Null and @Cidade Is Not Null Begin
         EXEC MunicipioIns @UF, @Cidade, @Municipio_ID OUTPUT
      End
   
      -- Trata o bairro da revendedora
      Set @Operacao = 'Tratando o bairro da revendedora'
      Declare @Bairro_ID Int
      Set     @Bairro_ID = Null
      
      If @Municipio_ID Is Not Null and @Bairro Is Not Null Begin
         EXEC BairroIns @Municipio_ID, @Bairro, @Bairro_ID OUTPUT
      End
      
      -- Trata a revendedora  
      Set @Operacao = 'Tratando a revendedora'
      EXEC RevendedoraInsCS48 @CodigoRevendedoraAsc, 
                              @Municipio_ID,
                              @Bairro_ID,
                              @NomeRevendedora, 
                              @Sexo, 
                              @EnderecoRevendedora,      
                              @Numero, 
                              @Complemento,              
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
                              @CPF, 
                              @RG, 
                              @OrgaoEmissor,             
                              @DataNascimento,          
                              @DataEstabelecimento,     
                              @EstadoCivil,              
                              @NomePai, 
                              @NomeMae, 
                              @Email,                   
                              @NomeConjuge,
                              @Setor,
                              @pArquivo_ID      
      
      -- Trata o telefone da revendedora
      Set @Operacao = 'Tratando o telefone principal da revendedora'
      EXEC Rev_TelefoneIns @CodigoRevendedoraAsc,
                           'P',     -- P=Principal C=Comercial R=Recado M=Móvel (celular)
                           @DDDResidencial,
                           @TelefoneResidencial,
                           NULL     -- Ramal
      
      Set @Operacao = 'Tratando o telefone comercial da revendedora'
      EXEC Rev_TelefoneIns @CodigoRevendedoraAsc,
                           'C',     -- P=Principal C=Comercial R=Recado M=Móvel (celular)
                           @DDDComercial,
                           @TelefoneComercial,
                           @RamalComercial
      
      Set @Operacao = 'Tratando o telefone de recados da revendedora'
      EXEC Rev_TelefoneIns @CodigoRevendedoraAsc,
                           'R',     -- P=Principal C=Comercial R=Recado M=Móvel (celular)
                           @DDDRecados,
                           @TelefoneRecados,
                           NULL     -- Ramal
      
      Set @Operacao = 'Tratando o telefone móvel da revendedora'
      EXEC Rev_TelefoneIns @CodigoRevendedoraAsc,
                           'M',     -- P=Principal C=Comercial R=Recado M=Móvel (celular)
                           @DDDCelular,
                           @TelefoneCelular,
                           NULL     -- Ramal
      
      -- Trata o débito   
      Set @Operacao = 'Tratando o débito'
      Insert Into FS1  ( Arquivo_ID,
                         Revendedora_ID,
                         AvisoDebito,                         
                         CampanhaNro,
                         CampanhaAno,
                         DtFaturamento,
                         DtVencimento,
                         DtExpiracao,
                         DtEnvio,
                         ValorDebito )
                          
                Values ( @pArquivo_ID,
                         @CodigoRevendedoraAsc,
                         @OrderId,
                         @CampanhaFaturamento,
                         @AnoCampanhaFaturamento,
                         @DataFaturamento,         
                         @DataVencimento,          
                         @DataExpiracaoBoleto,     
                         @DataEnvio,               
                         @ValorDebito )
                         
      Fetch Next From dadosCursor Into @ConversaoFS1_ID,
                                       @CodigoRevendedoraAsc,
                                       @NomeRevendedora,
                                       @Sexo,
                                       @EnderecoRevendedora,
                                       @Numero,
                                       @Complemento,
                                       @Bairro,
                                       @Cidade,
                                       @UF,
                                       @CEP,
                                       @DDDResidencial,
                                       @TelefoneResidencial,
                                       @DDDComercial,
                                       @TelefoneComercial,
                                       @RamalComercial,
                                       @DDDRecados,
                                       @TelefoneRecados,
                                       @DDDCelular,
                                       @TelefoneCelular,
                                       @CPF,
                                       @RG,
                                       @OrgaoEmissor,
                                       @DataNascimento,
                                       @DataEstabelecimento,
                                       @EstadoCivil,
                                       @NomePai,
                                       @NomeMae,
                                       @Email,
                                       @NomeConjuge,
                                       @OrderId,
                                       @CampanhaFaturamento,
                                       @AnoCampanhaFaturamento,
                                       @ValorDebito,
                                       @DataFaturamento,
                                       @DataVencimento,
                                       @DataExpiracaoBoleto,
                                       @DataEnvio,
                                       @Setor
   End
END TRY
BEGIN CATCH
   
      -- Prepara o retorno
      Select @ErrorNumber   = ERROR_NUMBER(), 
             @ErrorMessage  = ERROR_MESSAGE(), 
             @ErrorSeverity = ERROR_SEVERITY(),
             @ErrorState    = ERROR_STATE()

      Declare @ComplementoErro Varchar(4000)                 
      Set     @ComplementoErro = 'Operacao:' + @Operacao + ' ConversaoFS1_ID:' + Cast(@ConversaoFS1_ID as Varchar) +' ErrorNumber:' + Cast(@ErrorNumber as Varchar) + ' ErrorMessage:' + @ErrorMessage

      RAISERROR ( @Complemento, @ErrorSeverity, @ErrorState )
END CATCH

GO

-- FIM
