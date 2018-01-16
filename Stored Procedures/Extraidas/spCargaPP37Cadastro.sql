--------------------------------------------------------------------------------
-- spCargaPP37Cadastro.sql
-- Data   : 02/09/2013
-- Autor  : Amauri
-- Stored procedure de carga de arquivos PP37 de Cadastro
-- Alimenta as tabelas finais
--------------------------------------------------------------------------------

USE ArquivosAvon
GO

Alter Procedure CargaPP37Cadastro
(
  @pArquivo_ID Int
)
AS

Set NoCount ON

-- Registra no LOG
Insert Into Log ( DataHora, Origem, Tipo, Mensagem, Arquivo )
         Values ( GetDate(),
                  'CargaPP37_Cad',
                  'S',
                  'Iniciando a carga de dados',
                  'PP37_Cad' )

Declare @ConversaoPP37_Cadastro_ID Int,
        @Setor                SmallInt,
        @RegistroAsc          Int,         
        @Classificacao        Char( 1),         
        @Valor_Misc           Money,         
        @Nome                 Varchar(50),         
        @Endereco             Varchar(60),         
        @Numero               Varchar( 5),         
        @Complemento          Varchar(20),         
        @Bairro               Varchar(30),         
        @Cidade               Varchar(20),         
        @UF                   Char(2),         
        @Cep                  Varchar( 8),         
        @DDD                  Varchar( 3),         
        @Tel_Residencia       Varchar( 8),         
        @DDD1                 Varchar( 3),         
        @Tel_Comercial        Varchar( 8),         
        @Ramal                Varchar( 5),         
        @DDD2                 Varchar( 3),         
        @Tel_Recado           Varchar( 8),         
        @DDD3                 Varchar( 3),         
        @Celular              Varchar( 8),         
        @Cpf                  Varchar(11),         
        @Rg                   Varchar(11),         
        @Orgao_Emissor        Varchar( 5),         
        @Data_Nasc            SmallDateTime,         
        @Data_Estab           SmallDateTime,         
        @Estado_Civil         Char( 1),         
        @Nome_Pai             Varchar(50),         
        @Nome_Mae             Varchar(50),         
        @Email                Varchar(50),         
        @Nome_Conjuge         Varchar(50)         

Declare @Operacao      Varchar(300)
      , @ErrorNumber   Int
      , @ErrorMessage  nVarchar(2048)
      , @ErrorSeverity Int
      , @ErrorState    Int

Set @Operacao = 'Abrindo Cursor'

-- Percorre as linhas com um cursor
Declare dadosCursor Cursor Local Fast_Forward For

     Select ConversaoPP37_Cadastro_ID,
            Setor,
            RegistroAsc,
            Classificacao,
            Valor_Misc,
            Nome,
            Endereco,
            Numero,
            Complemento,
            Bairro,
            Cidade,
            UF,
            Cep,
            DDD,
            Tel_Residencia,
            DDD1,
            Tel_Comercial,
            Ramal,
            DDD2,
            Tel_Recado,
            DDD3,
            Celular,
            Cpf,
            Rg,
            Orgao_Emissor,
            Data_Nasc,
            Data_Estab,
            Estado_Civil,
            Nome_Pai,
            Nome_Mae,
            Email,
            Nome_Conjuge
            
     From ConversaoPP37_Cadastro (nolock)
     Order by ConversaoPP37_Cadastro_ID 
            
Open dadosCursor
Fetch dadosCursor Into @ConversaoPP37_Cadastro_ID,
                       @Setor,
                       @RegistroAsc,
                       @Classificacao,
                       @Valor_Misc,
                       @Nome,
                       @Endereco,
                       @Numero,
                       @Complemento,
                       @Bairro,
                       @Cidade,
                       @UF,
                       @Cep,
                       @DDD,
                       @Tel_Residencia,
                       @DDD1,
                       @Tel_Comercial,
                       @Ramal,
                       @DDD2,
                       @Tel_Recado,
                       @DDD3,
                       @Celular,
                       @Cpf,
                       @Rg,
                       @Orgao_Emissor,
                       @Data_Nasc,
                       @Data_Estab,
                       @Estado_Civil,
                       @Nome_Pai,
                       @Nome_Mae,
                       @Email,
                       @Nome_Conjuge

While @@fetch_status = 0
Begin       
   BEGIN TRY

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
      EXEC RevendedoraInsPP37Cadastro  @RegistroAsc,
                                       @Municipio_ID,
                                       @Bairro_ID,
                                       @Setor,
                                       @Classificacao,
                                       -- @Valor_Misc,
                                       @Nome,
                                       @Endereco,
                                       @Numero,
                                       @Complemento,
                                       @Cep,
                                       @Cpf,
                                       @Rg,
                                       @Orgao_Emissor,
                                       @Data_Nasc,
                                       @Data_Estab,
                                       @Estado_Civil,
                                       @Nome_Pai,
                                       @Nome_Mae,
                                       @Email,
                                       @Nome_Conjuge,
                                       @pArquivo_ID
                              
      -- Trata os telefones da revendedora
      Set @Operacao = 'Tratando o telefone P da revendedora'
      EXEC Rev_TelefoneIns @RegistroAsc,
                           'P',     -- P=Principal C=Comercial R=Recado M=Móvel (celular)
                           @DDD,
                           @Tel_Residencia,
                           NULL     -- Ramal
      
      Set @Operacao = 'Tratando o telefone C da revendedora'
      EXEC Rev_TelefoneIns @RegistroAsc,
                           'C',     -- P=Principal C=Comercial R=Recado M=Móvel (celular)
                           @DDD1,
                           @Tel_Comercial,
                           @Ramal     -- Ramal
      
      Set @Operacao = 'Tratando o telefone R da revendedora'
      EXEC Rev_TelefoneIns @RegistroAsc,
                           'R',     -- P=Principal C=Comercial R=Recado M=Móvel (celular)
                           @DDD2,
                           @Tel_Recado,
                           NULL     -- Ramal
      
      Set @Operacao = 'Tratando o telefone M da revendedora'
      EXEC Rev_TelefoneIns @RegistroAsc,
                           'M',     -- P=Principal C=Comercial R=Recado M=Móvel (celular)
                           @DDD3,
                           @Celular,
                           NULL     -- Ramal
      
   END TRY
   BEGIN CATCH
      
         -- Prepara o retorno
         Select @ErrorNumber   = ERROR_NUMBER(), 
                @ErrorMessage  = ERROR_MESSAGE(), 
                @ErrorSeverity = ERROR_SEVERITY(),
                @ErrorState    = ERROR_STATE()
   
         Declare @ComplementoMsg Varchar(4000)                 
         Set     @ComplementoMsg = 'Operacao:' + @Operacao + ' @ConversaoPP37_Cadastro_ID:' + Cast(@ConversaoPP37_Cadastro_ID as Varchar) +' ErrorNumber:' + Cast(@ErrorNumber as Varchar) + ' ErrorMessage:' + @ErrorMessage
   
         RAISERROR ( @ComplementoMsg, @ErrorSeverity, @ErrorState )
   END CATCH
   
   Fetch Next From dadosCursor Into @ConversaoPP37_Cadastro_ID,
                                    @Setor,
                                    @RegistroAsc,
                                    @Classificacao,
                                    @Valor_Misc,
                                    @Nome,
                                    @Endereco,
                                    @Numero,
                                    @Complemento,
                                    @Bairro,
                                    @Cidade,
                                    @UF,
                                    @Cep,
                                    @DDD,
                                    @Tel_Residencia,
                                    @DDD1,
                                    @Tel_Comercial,
                                    @Ramal,
                                    @DDD2,
                                    @Tel_Recado,
                                    @DDD3,
                                    @Celular,
                                    @Cpf,
                                    @Rg,
                                    @Orgao_Emissor,
                                    @Data_Nasc,
                                    @Data_Estab,
                                    @Estado_Civil,
                                    @Nome_Pai,
                                    @Nome_Mae,
                                    @Email,
                                    @Nome_Conjuge
End

GO

-- FIM
