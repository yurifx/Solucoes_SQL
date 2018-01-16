--------------------------------------------------------------------------------
-- fnRemoveAcentos.sql
-- Data   : 26/08/2013
-- Autor  : Amauri
-- Remove acentos e outros caracteres do nome do municipio 
--------------------------------------------------------------------------------

USE ArquivosAvon
GO

Alter Function dbo.RemoveAcentos
(
@pTextoOriginal VarChar(250)
)
Returns VarChar(250)

AS
BEGIN

Declare @resultado Varchar(250),
        @t         Int,          -- Tamanho do texto original
        @p         Int,          -- Ponteiro para o enÈsimo caractere
        @c         Char(1),      -- Um caractere do texto original
        @x         Int           -- Auxiliar
        
Declare @ComAcentos Char(24),
        @SemAcentos Char(24)
        
Set @ComAcentos = '¡¿¬√ƒ…» ÀÕÃŒœ”“‘’÷⁄Ÿ€‹«—'     
Set @SemAcentos = 'AAAAAEEEEIIIIOOOOOUUUUCN'  
        
Set @resultado = ''
Set @t = Len(RTrim(@pTextoOriginal))
Set @p = 1

While @p <= @t Begin

  Set @c = Upper(SubString(@pTextoOriginal, @p, 1))
  
  Set @x = CharIndex(@c, 'ABCDEFGHIJKLMNOPQRSTUVWXYZ')
  
  If @x > 0 Begin  -- Se o caractere È uma letra ...
     Set @resultado = @resultado + @c
  End
  Else Begin       -- Se o caractere È uma letra com acento ...
     Set @x = CharIndex(@c, @ComAcentos)
     If @x > 0 Begin
        Set @c = SubString(@SemAcentos, @x, 1) -- ObtÈm o caractere correspondente, sem acento
        Set @resultado = @resultado + @c
     End
  End
    
  Set @p = @p + 1
End

Return @resultado

END

-- FIM
