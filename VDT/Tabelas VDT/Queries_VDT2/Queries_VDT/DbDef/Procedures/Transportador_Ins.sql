If  Exists (Select Name
            From   sysobjects
            Where  Name = 'Transportador_Ins' and type = 'P')
    Drop Procedure dbo.Transportador_Ins
GO

Create Procedure dbo.Transportador_Ins
----------------------------------------------------------------------------------------------------
-- Insere um novo transportador
----------------------------------------------------------------------------------------------------
(
@p_Nome             Varchar(100),
@p_Tipo             Char(1),      -- T:Terrestre M:Marítimo
@p_Transportador_ID Int OUTPUT
)
AS

SET NOCOUNT ON

Insert Into Transportador ( Nome, Tipo )
Values ( @p_Nome,
         @p_Tipo )

Set @p_Transportador_ID = SCOPE_IDENTITY()

GO

/*
Declare @Nome             Varchar(100),
        @Tipo             Char(1),
        @Transportador_ID Int

Set @Nome             = 'Novo Transportador Terrestre Teste'
Set @Tipo             = 'T'

EXEC Transportador_Ins @Nome, @Tipo, @Transportador_ID OUTPUT

Print @Nome + ':' + Cast(@Transportador_ID as Varchar)

EXEC Transportador_Sel @p_Transportador_ID = @Transportador_ID
*/

-- FIM
