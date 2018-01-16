--------------------------------------------------------------------------------
-- fnRemoveZeros.sql
-- Data   : 27/08/2013
-- Autor  : Amauri
-- Remove zeros iniciais no número de um endereço ou de um telefone
--------------------------------------------------------------------------------

USE ArquivosAvon
GO

Alter Function dbo.RemoveZeros
(
@pNUMERO VarChar(20)
)
Returns VarChar(20)

AS
BEGIN

Declare @NUMERO Varchar(20)
Set     @NUMERO = @pNUMERO

While @NUMERO Is Not Null and Left(@NUMERO,1) = '0'
      Set @NUMERO = Stuff(@NUMERO, 1, 1, '')
      
If Len(@NUMERO) = 0
   Set @NUMERO = NULL

Return @NUMERO

END
-- FIM
