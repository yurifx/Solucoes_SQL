--------------------------------------------------------------------------------
-- spRevendedoraInsC428.sql
-- Data   : 28/08/2013
-- Autor  : Amauri
-- Stored procedure para inserir revendedoras, 
-- a partir de dados de CS48 e de FS1 
--------------------------------------------------------------------------------

USE ArquivosAvon
GO

Alter Procedure RevendedoraInsCS48
(
  @pREGASC              Int, 
  @pMunicipio_ID        Int,
  @pBairro_ID           Int,  
  @pNome                Varchar(50), 
  @pSexo                Varchar(1), 
  @pEndereco            Varchar(60), 
  @pNumero              Varchar(5), 
  @pComp                Varchar(20), 
  -- @pBairro              Varchar(30), 
  -- @pCidade              Varchar(20), 
  -- @pUF                  Varchar(2), 
  @pCEP                 Varchar(8), 
  -- @pDDD                 Varchar(3), 
  -- @pTEL                 Varchar(8), 
  -- @pDDD_COM             Varchar(3), 
  -- @pTEL_COM             Varchar(8), 
  -- @pRAMAL               Varchar(5), 
  -- @pDDD_REC             Varchar(3), 
  -- @pTEL_REC             Varchar(8), 
  -- @pDDD_CEL             Varchar(3), 
  -- @pTEL_CEL             Varchar(8), 
  @pCPF_RA              Varchar(11), 
  @pRG_RA               Varchar(11), 
  @pORGAO_EMISSOR       Varchar(5), 
  @pDT_NASCIMENTO       SmallDateTime, 
  @pDT_ESTABELECIMENTO  SmallDateTime, 
  @pESTADO_CIVIL        Varchar(1), 
  @pNOME_DO_PAI         Varchar(50), 
  @pNOME_DA_MAE         Varchar(50), 
  @pEMAIL               Varchar(50), 
  @pCONJUGE             Varchar(50), 
  @pSETOR               SmallInt, 
  @pArquivo_ID         Int  -- Fonte de dados mais recente
)
AS

Declare @Numero Varchar(5)
Set     @Numero = dbo.RemoveZeros(@pNumero)

If Not Exists ( Select 1 From Revendedora (nolock) Where Revendedora_ID = @pREGASC ) Begin

   Insert Into Revendedora ( Revendedora_ID,  
                             Municipio_ID,
                             Bairro_ID,          
                             Setor, 
                             Nome, 
                             Sexo, 
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

                    Values ( @pREGASC,
                             @pMunicipio_ID,
                             @pBairro_ID,
                             @pSETOR, 
                             @pNome, 
                             @pSexo, 
                             @pCPF_RA, 
                             @pRG_RA, 
                             @pORGAO_EMISSOR, 
                             @pEMAIL, 
                             @pDT_NASCIMENTO, 
                             @pDT_ESTABELECIMENTO, 
                             @pESTADO_CIVIL, 
                             @pNOME_DO_PAI, 
                             @pNOME_DA_MAE, 
                             @pCONJUGE, 
                             @pEndereco, 
                             @Numero, 
                             @pComp, 
                             @pCEP, 
                             @pArquivo_ID )
End
Else If Not Exists ( Select 1 
                     From  Revendedora (nolock) 
                     Where Revendedora_ID    = @pREGASC
                      and  Municipio_ID      = @pMunicipio_ID      
                      and  Bairro_ID         = @pBairro_ID            
                      and  Setor             = @pSETOR                 
                      and  Nome              = @pNome                  
                      and  Sexo              = @pSexo                  
                      and  CPF               = @pCPF_RA                
                      and  RGNumero          = @pRG_RA                 
                      and  RGOrgaoEmissor    = @pORGAO_EMISSOR         
                      and  Email             = @pEMAIL                 
                      and  DtNascimento      = @pDT_NASCIMENTO         
                      and  DtEstabelecimento = @pDT_ESTABELECIMENTO    
                      and  EstCivil          = @pESTADO_CIVIL          
                      and  NomePai           = @pNOME_DO_PAI           
                      and  NomeMae           = @pNOME_DA_MAE           
                      and  Conjuge           = @pCONJUGE               
                      and  EndLogradouro     = @pEndereco              
                      and  EndNumero         = @Numero                
                      and  EndComplemento    = @pComp                  
                      and  EndCep            = @pCEP ) Begin
          
   Update Revendedora
      Set Municipio_ID      = @pMunicipio_ID,      
          Bairro_ID         = @pBairro_ID,            
          Setor             = @pSETOR,
          Nome              = @pNome,
          Sexo              = @pSexo,
          CPF               = @pCPF_RA,
          RGNumero          = @pRG_RA,
          RGOrgaoEmissor    = @pORGAO_EMISSOR,
          Email             = @pEMAIL,
          DtNascimento      = @pDT_NASCIMENTO,
          DtEstabelecimento = @pDT_ESTABELECIMENTO,
          EstCivil          = @pESTADO_CIVIL,
          NomePai           = @pNOME_DO_PAI,
          NomeMae           = @pNOME_DA_MAE,
          Conjuge           = @pCONJUGE,
          EndLogradouro     = @pEndereco,
          EndNumero         = @Numero,
          EndComplemento    = @pComp,
          EndCep            = @pCEP,
          Arquivo_ID        = @pArquivo_ID 
          
   Where  Revendedora_ID = @pREGASC                       
End

GO 

-- FIM
