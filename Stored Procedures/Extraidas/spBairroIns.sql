--------------------------------------------------------------------------------
-- spBairroIns.sql
-- Data   : 26/08/2013
-- Autor  : Amauri
-- Stored procedure para inserir bairros 
--------------------------------------------------------------------------------

USE ArquivosAvon
GO

Alter Procedure BairroIns
(
  @pMunicipio_ID Int,
  @pNome         Varchar(30),
  @pBairro_ID    Int  OUTPUT
)
AS

Declare @ID Int

Select @ID = Bairro_ID
From   Bairro (nolock)
Where  Municipio_ID = @pMunicipio_ID
 and   Nome         = @pNome

If @ID Is Null Begin  -- Se ainda não existir na tabela
   Insert Into Bairro (   Municipio_ID,   Nome) 
               Values ( @pMunicipio_ID, @pNome )
                  
   Set @ID = SCOPE_IDENTITY()                  
End

Set @pBairro_ID = @ID

GO

-- FIM
