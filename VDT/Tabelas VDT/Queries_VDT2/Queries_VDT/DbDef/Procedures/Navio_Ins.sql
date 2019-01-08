If  Exists (Select Name
            From   sysobjects
            Where  Name = 'Navio_Ins' and type = 'P')
    Drop Procedure dbo.Navio_Ins
GO

Create Procedure dbo.Navio_Ins
----------------------------------------------------------------------------------------------------
-- Insere um novo navio
----------------------------------------------------------------------------------------------------
(
@p_Nome     Varchar(100),
@p_Navio_ID Int OUTPUT
)
AS

SET NOCOUNT ON

Insert Into Navio ( Nome )
Values ( @p_Nome )

Set @p_Navio_ID = SCOPE_IDENTITY()

GO

/*
Declare @Nome      Varchar(100),
        @Navio_ID  Int

Set @Nome             = 'Novo Navio'

EXEC Navio_Ins @Nome, @Navio_ID OUTPUT

Print @Nome + ':' + Cast(@Navio_ID as Varchar)

EXEC Navio_Lst @p_Ativos = 1
*/

-- FIM
