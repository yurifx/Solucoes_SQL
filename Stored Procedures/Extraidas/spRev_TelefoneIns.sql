--------------------------------------------------------------------------------
-- spRev_TelefoneIns.sql
-- Data   : 27/08/2013
-- Autor  : Amauri
-- Stored procedure para inserir telefone de uma revendedora 
--------------------------------------------------------------------------------

USE ArquivosAvon
GO

Alter Procedure Rev_TelefoneIns
(
  @pRevendedora_ID      Int,
  @pTipo                Char(1), -- P=Principal C=Comercial R=Recado M=Móvel (celular)
  @pDDD                 Varchar(4),
  @pNumero              Varchar(17),
  @pRamal               Varchar(5)
)
AS

Declare @DDD    Varchar(4),
        @Numero VarChar(9)
        
If @pDDD Is Not Null or @pNumero Is Not Null Begin
        
   If @pDDD Is Not Null Begin
      Set @DDD    = @pDDD
      Set @Numero = @pNumero
   End         
   Else If @pDDD Is Null and @pNumero Is Not Null Begin
   
      If SubString(@pNumero,1,1) = '(' and SubString(@pNumero,6,1) = ')' Begin -- Padrão: (1234)  5678-9012
         Set @DDD = SubString(@pNumero,2,4)
         If @DDD = '0000' 
            Set @DDD = Null
         
         Set @Numero = LTrim(RTrim( SubString(@pNumero, 9,9) ))
         Set @Numero = Replace(@Numero, '-', '')  
         Set @Numero = dbo.RemoveZeros(@Numero) 
      End
      Else Begin
         Set @DDD = Null
         
         Set @Numero = LTrim(RTrim( @pNumero ))
         Set @Numero = Replace(@Numero, '-', '')  
         Set @Numero = dbo.RemoveZeros(@Numero) 
      End
   End
   
   
   If Not Exists ( Select 1 
                   From  Rev_Telefone (nolock) 
                   Where Revendedora_ID = @pRevendedora_ID
                    and  Numero         = @Numero ) Begin
   
      Insert Into Rev_Telefone ( Revendedora_ID,  
                                 Tipo,
                                 DDD,
                                 Numero,
                                 Ramal )
                                
                       Values ( @pRevendedora_ID, 
                                @pTipo, 
                                @DDD, 
                                @Numero, 
                                @pRamal ) 
   End
   Else If Not Exists ( Select 1 
                        From  Rev_Telefone (nolock) 
                        Where Revendedora_ID = @pRevendedora_ID
                         and  Tipo           = @pTipo 
                         and  DDD            = @DDD 
                         and  Numero         = @Numero
                         and  Ramal          = @pRamal ) Begin 
   
      Update Rev_Telefone
      
         Set Tipo           = @pTipo,
             DDD            = @DDD,
             Ramal          = @pRamal 
             
      Where  Revendedora_ID = @pRevendedora_ID
       and   Numero         = @Numero                       
   End
End

GO 

-- FIM
