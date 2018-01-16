--------------------------------------------------------------------------------
-- spCargaCS28.sql
-- Data   : 26/08/2013
-- Autor  : Amauri
-- Stored procedure de carga de arquivos CS28
-- Alimenta as tabelas finais
--------------------------------------------------------------------------------

USE ArquivosAvon
GO

Alter Procedure CargaCS28
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
                  'CargaCS28',
                  'S',
                  'Iniciando a carga de dados',
                  'CS28' )

Declare @ConversaoCS28_ID     Int,
        @AVISO_DEBITO         Int, 
        @NOME                 Varchar(50), 
        @SETOR                SmallInt, 
        @REGASC               Int, 
        @DT_NASCIMENTO        SmallDateTime, 
        @RG_RA                Varchar(13), 
        @CPF_RA               Varchar(14), 
        @DDD_TEL              Varchar(17), 
        @ENDERECO             Varchar(60), 
        @NUMERO               Varchar(5), 
        @COMP                 Varchar(20), 
        @BAIRRO               Varchar(30), 
        @CEP                  Varchar(8), 
        @CIDADE               Varchar(20), 
        @UF                   Varchar(2), 
        @DT_ESTABELECIMENTO   SmallDateTime, 
        @EQUIPE               SmallInt, 
        @LOS                  SmallInt, 
        @AGENCIA              Varchar(33), 
        @NF                   Int, 
        @DT_NF                SmallDateTime, 
        @CAMPANHA             TinyInt, 
        @CAMPANHA_ANO         SmallInt,
        @DT_ENVIO_RA_COB      SmallDateTime, 
        @DT_DEVOLUCAO         SmallDateTime, 
        @N_AGENCIA            SmallInt, 
        @NOME_RA_INDICA       Varchar(50), 
        @END_RA_INDICA        Varchar(60), 
        @NUEMERO_RA_INDICA    Varchar(5), 
        @COMP_RA_INDICA       Varchar(20), 
        @BAIRRO_RA_INDICA     Varchar(30), 
        @CEP_RA_INDICA        Varchar(8), 
        @CIDADE_RA_INDICA     Varchar(20), 
        @UF_RA_INDICA         Varchar(2), 
        @REGASC_RA_INDICA     Int, 
        @VALOR_DEBITO         Money 

Declare @Operacao      Varchar(300)
      , @ErrorNumber   Int
      , @ErrorMessage  nVarchar(2048)
      , @ErrorSeverity Int
      , @ErrorState    Int

Set @Operacao = 'Abrindo Cursor'

BEGIN TRY

   -- Percorre as linhas com um cursor
   Declare dadosCursor Cursor Local Fast_Forward For
   
        Select ConversaoCS28_ID,
               AVISO_DEBITO, 
               NOME, 
               SETOR, 
               REGASC, 
               DT_NASCIMENTO, 
               RG_RA, 
               CPF_RA, 
               DDD_TEL, 
               ENDERECO, 
               NUMERO, 
               COMP, 
               BAIRRO, 
               CEP, 
               CIDADE, 
               UF, 
               DT_ESTABELECIMENTO, 
               EQUIPE, 
               LOS, 
               AGENCIA, 
               NF, 
               DT_NF, 
               CAMPANHA, 
               CAMPANHA_ANO,
               DT_ENVIO_RA_COB, 
               DT_DEVOLUCAO, 
               N_AGENCIA, 
               NOME_RA_INDICA, 
               END_RA_INDICA, 
               NUEMERO_RA_INDICA, 
               COMP_RA_INDICA, 
               BAIRRO_RA_INDICA, 
               CEP_RA_INDICA, 
               CIDADE_RA_INDICA, 
               UF_RA_INDICA, 
               REGASC_RA_INDICA, 
               VALOR_DEBITO
        From ConversaoCS28 (nolock)
        Order by ConversaoCS28_ID 
               
   Open dadosCursor
   Fetch dadosCursor Into @ConversaoCS28_ID,
                          @AVISO_DEBITO,
                          @NOME, 
                          @SETOR, 
                          @REGASC, 
                          @DT_NASCIMENTO, 
                          @RG_RA, 
                          @CPF_RA, 
                          @DDD_TEL, 
                          @ENDERECO, 
                          @NUMERO, 
                          @COMP, 
                          @BAIRRO, 
                          @CEP, 
                          @CIDADE, 
                          @UF, 
                          @DT_ESTABELECIMENTO, 
                          @EQUIPE, 
                          @LOS, 
                          @AGENCIA, 
                          @NF, 
                          @DT_NF, 
                          @CAMPANHA, 
                          @CAMPANHA_ANO,
                          @DT_ENVIO_RA_COB, 
                          @DT_DEVOLUCAO, 
                          @N_AGENCIA, 
                          @NOME_RA_INDICA, 
                          @END_RA_INDICA, 
                          @NUEMERO_RA_INDICA, 
                          @COMP_RA_INDICA, 
                          @BAIRRO_RA_INDICA, 
                          @CEP_RA_INDICA, 
                          @CIDADE_RA_INDICA, 
                          @UF_RA_INDICA, 
                          @REGASC_RA_INDICA, 
                          @VALOR_DEBITO
               
   While @@fetch_status = 0
   Begin       
      -- Trata a cidade da revendedora
      Set @Operacao = 'Tratando a cidade da revendedora'
   
      Declare @MunicipioRev_ID Int
      Set     @MunicipioRev_ID = Null
      
      If @UF Is Not Null and @CIDADE Is Not Null Begin
         EXEC MunicipioIns @UF, @CIDADE, @MunicipioRev_ID OUTPUT
      End
   
      -- Trata o bairro da revendedora
      Set @Operacao = 'Tratando o bairro da revendedora'
      Declare @BairroRev_ID Int
      Set     @BairroRev_ID = Null
      
      If @MunicipioRev_ID Is Not Null and @BAIRRO Is Not Null Begin
         EXEC BairroIns @MunicipioRev_ID, @BAIRRO, @BairroRev_ID OUTPUT
      End
      
      -- Trata a cidade da indicante
      Set @Operacao = 'Tratando a cidade da indicante'
      Declare @MunicipioInd_ID Int
      Set     @MunicipioInd_ID = Null
      
      If @UF_RA_INDICA Is Not Null and @CIDADE_RA_INDICA Is Not Null Begin
         EXEC MunicipioIns @UF_RA_INDICA, @CIDADE_RA_INDICA, @MunicipioInd_ID OUTPUT
      End
   
      -- Trata o bairro da indicante
      Set @Operacao = 'Tratando o bairro da indicante'
      Declare @BairroInd_ID Int
      Set     @BairroInd_ID = Null
      
      If @MunicipioInd_ID Is Not Null and @BAIRRO_RA_INDICA Is Not Null Begin
         EXEC BairroIns @MunicipioInd_ID, @BAIRRO_RA_INDICA, @BairroInd_ID OUTPUT
      End
      
      -- Trata a agência
      Set @Operacao = 'Tratando a agência'
      If @N_AGENCIA Is Not Null and @AGENCIA Is Not Null Begin
         EXEC AgenciaIns @N_AGENCIA, @AGENCIA
      End
      
      -- Trata a indicante
      Set @Operacao = 'Tratando a indicante'
      If @REGASC_RA_INDICA Is Not Null Begin
      
         EXEC RevendedoraInsCS28Ind @REGASC_RA_INDICA, 
                                    @MunicipioInd_ID, 
                                    @BairroInd_ID, 
                                    @NOME_RA_INDICA, 
                                    @END_RA_INDICA, 
                                    @NUEMERO_RA_INDICA, 
                                    @COMP_RA_INDICA, 
                                    @CEP_RA_INDICA,
                                    @pArquivo_ID 
      End
                                              
      -- Trata a revendedora  
      Set @Operacao = 'Tratando a revendedora'
      EXEC RevendedoraInsCS28 @REGASC,
                              @REGASC_RA_INDICA, 
                              @MunicipioRev_ID, 
                              @BairroRev_ID, 
                              @NOME, 
                              @SETOR, 
                              @DT_NASCIMENTO, 
                              @RG_RA, 
                              @CPF_RA, 
                              @ENDERECO, 
                              @NUMERO, 
                              @COMP, 
                              @CEP, 
                              @DT_ESTABELECIMENTO, 
                              @EQUIPE, 
                              @LOS,
                              @pArquivo_ID
                              
      -- Trata o telefone da revendedora
      Set @Operacao = 'Tratando o telefone da revendedora'
      EXEC Rev_TelefoneIns @REGASC,
                           'P',     -- P=Principal C=Comercial R=Recado M=Móvel (celular)
                           NULL,    -- DDD
                           @DDD_TEL,
                           NULL     -- Ramal
      
      -- Trata o débito   
      Set @Operacao = 'Tratando o débito'
      Insert Into CS28 ( Arquivo_ID, 
                         Revendedora_ID, 
                         Agencia_ID, 
                         AvisoDebito, 
                         NF, 
                         DtNF, 
                         CampanhaNro, 
                         CampanhaAno, 
                         DtEnvioCobranca, 
                         DtDevolucao, 
                         ValorDebito )
                          
                Values ( @pArquivo_ID,
                         @REGASC,
                         @N_AGENCIA,
                         @AVISO_DEBITO,
                         @NF, 
                         @DT_NF, 
                         @CAMPANHA, 
                         @CAMPANHA_ANO,
                         @DT_ENVIO_RA_COB, 
                         @DT_DEVOLUCAO, 
                         @VALOR_DEBITO )
                         
      Fetch Next From dadosCursor Into @ConversaoCS28_ID,
                                       @AVISO_DEBITO,
                                       @NOME, 
                                       @SETOR, 
                                       @REGASC, 
                                       @DT_NASCIMENTO, 
                                       @RG_RA, 
                                       @CPF_RA, 
                                       @DDD_TEL, 
                                       @ENDERECO, 
                                       @NUMERO, 
                                       @COMP, 
                                       @BAIRRO, 
                                       @CEP, 
                                       @CIDADE, 
                                       @UF, 
                                       @DT_ESTABELECIMENTO, 
                                       @EQUIPE, 
                                       @LOS, 
                                       @AGENCIA, 
                                       @NF, 
                                       @DT_NF, 
                                       @CAMPANHA, 
                                       @CAMPANHA_ANO,
                                       @DT_ENVIO_RA_COB, 
                                       @DT_DEVOLUCAO, 
                                       @N_AGENCIA, 
                                       @NOME_RA_INDICA, 
                                       @END_RA_INDICA, 
                                       @NUEMERO_RA_INDICA, 
                                       @COMP_RA_INDICA, 
                                       @BAIRRO_RA_INDICA, 
                                       @CEP_RA_INDICA, 
                                       @CIDADE_RA_INDICA, 
                                       @UF_RA_INDICA, 
                                       @REGASC_RA_INDICA, 
                                       @VALOR_DEBITO
   End
END TRY
BEGIN CATCH
   
      -- Prepara o retorno
      Select @ErrorNumber   = ERROR_NUMBER(), 
             @ErrorMessage  = ERROR_MESSAGE(), 
             @ErrorSeverity = ERROR_SEVERITY(),
             @ErrorState    = ERROR_STATE()

      Declare @Complemento Varchar(4000)                 
      Set     @Complemento = 'Operacao:' + @Operacao + ' @ConversaoCS48_ID:' + Cast(@ConversaoCS28_ID as Varchar) +' ErrorNumber:' + Cast(@ErrorNumber as Varchar) + ' ErrorMessage:' + @ErrorMessage

      RAISERROR ( @Complemento, @ErrorSeverity, @ErrorState )
END CATCH

GO

-- FIM
