--------------------------------------------------------------------------------
-- spMunicipioIns.sql
-- Data   : 26/08/2013
-- Autor  : Amauri
-- Stored procedure para inserir municipios 
--------------------------------------------------------------------------------

USE ArquivosAvon
GO

Alter  Procedure MunicipioIns
(
  @pUF           Char(2),
  @pNome         Varchar(50),
  @pMunicipio_ID Int  OUTPUT
)
AS

Declare @ID     Int,
        @UFNome Varchar(52)

Set @UFNome = dbo.RemoveAcentos(@pUF + @pNome)
         
Select @ID = Municipio_ID
From   Municipio (nolock)
Where  UFNome = @UFNome

If @ID Is Null Begin  -- Se ainda não existir na tabela
   Insert Into Municipio (   UF,   Nome,  UFNome ) 
                  Values ( @pUF, @pNome, @UFNome )
                  
   Set @ID = SCOPE_IDENTITY()                  
End

Set @pMunicipio_ID = @ID

GO

-- FIM
