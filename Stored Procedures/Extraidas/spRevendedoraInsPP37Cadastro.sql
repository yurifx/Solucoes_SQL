--------------------------------------------------------------------------------
-- spRevendedoraInsPP37Cadastro.sql
-- Data   : 02/09/2013
-- Autor  : Amauri
-- Stored procedure para inserir revendedoras, a partir de dados de PP37 de Cadastro 
--------------------------------------------------------------------------------

USE ArquivosAvon
GO

Alter Procedure RevendedoraInsPP37Cadastro
(
  @pRegistroAsc        Int,         
  @pMunicipio_ID       Int,
  @pBairro_ID          Int,
  @pSetor              SmallInt,
  @pClassificacao      Char( 1),         
  -- @pValor_Misc         Money,         
  @pNome               Varchar(50),         
  @pEndereco           Varchar(60),         
  @pNumero             Varchar( 5),         
  @pComplemento        Varchar(20),         
  @pCep                Varchar( 8),         
  @pCpf                Varchar(11),         
  @pRg                 Varchar(11),         
  @pOrgao_Emissor      Varchar( 5),         
  @pData_Nasc          SmallDateTime,         
  @pData_Estab         SmallDateTime,         
  @pEstado_Civil       Char( 1),         
  @pNome_Pai           Varchar(50),         
  @pNome_Mae           Varchar(50),         
  @pEmail              Varchar(50),         
  @pNome_Conjuge       Varchar(50),         
  @pArquivo_ID         Int  -- Fonte de dados mais recente
)
AS

Declare @Numero Varchar(5)
Set     @Numero = dbo.RemoveZeros(@pNumero)

If Not Exists ( Select 1 From Revendedora (nolock) Where Revendedora_ID = @pRegistroAsc ) Begin

   Insert Into Revendedora ( Revendedora_ID,  
                             Municipio_ID,
                             Bairro_ID,          
                             Setor, 
                             Classificacao,
                             Nome, 
                             CPF, 
                             RGNumero, 
                             RGOrgaoEmissor, 
                             Email, 
                             DtNascimento, 
                             DtEstabelecimento, 
                             EstCivil, 
                             NomePai, 
                             NomeMae, 
                             Conjuge, 
                             EndLogradouro, 
                             EndNumero, 
                             EndComplemento, 
                             EndCep,
                             Arquivo_ID ) 

                    Values ( @pRegistroAsc,
                             @pMunicipio_ID,
                             @pBairro_ID,
                             @pSetor, 
                             @pClassificacao,
                             @pNome, 
                             @pCpf, 
                             @pRg, 
                             @pOrgao_Emissor, 
                             @pEmail, 
                             @pData_Nasc, 
                             @pData_Estab, 
                             @pEstado_Civil, 
                             @pNome_Pai, 
                             @pNome_Mae, 
                             @pNome_Conjuge, 
                             @pEndereco, 
                             @Numero, 
                             @pComplemento, 
                             @pCep, 
                             @pArquivo_ID )
End
Else If Not Exists ( Select 1 
                     From  Revendedora (nolock) 
                     Where Revendedora_ID    = @pRegistroAsc
                      and  Municipio_ID      = @pMunicipio_ID      
                      and  Bairro_ID         = @pBairro_ID            
                      and  Setor             = @pSetor   
                      and  Classificacao     = @pClassificacao         
                      and  Nome              = @pNome                  
                      and  CPF               = @pCpf                
                      and  RGNumero          = @pRg                 
                      and  RGOrgaoEmissor    = @pOrgao_Emissor         
                      and  Email             = @pEmail                 
                      and  DtNascimento      = @pData_Nasc         
                      and  DtEstabelecimento = @pData_Estab    
                      and  EstCivil          = @pEstado_Civil          
                      and  NomePai           = @pNome_Pai           
                      and  NomeMae           = @pNome_Mae           
                      and  Conjuge           = @pNome_Conjuge               
                      and  EndLogradouro     = @pEndereco              
                      and  EndNumero         = @Numero                
                      and  EndComplemento    = @pComplemento                  
                      and  EndCep            = @pCEP ) Begin
          
   Update Revendedora
      Set Municipio_ID      = @pMunicipio_ID,      
          Bairro_ID         = @pBairro_ID,            
          Setor             = @pSetor,
          Classificacao     = @pClassificacao,
          Nome              = @pNome,
          CPF               = @pCpf,
          RGNumero          = @pRg,
          RGOrgaoEmissor    = @pOrgao_Emissor,
          Email             = @pEmail,
          DtNascimento      = @pData_Nasc,
          DtEstabelecimento = @pData_Estab,
          EstCivil          = @pEstado_Civil,
          NomePai           = @pNome_Pai,
          NomeMae           = @pNome_Mae,
          Conjuge           = @pNome_Conjuge,
          EndLogradouro     = @pEndereco,
          EndNumero         = @Numero,
          EndComplemento    = @pComplemento,
          EndCep            = @pCEP,
          Arquivo_ID        = @pArquivo_ID 
          
   Where  Revendedora_ID = @pRegistroAsc                       
End

GO 

-- FIM
