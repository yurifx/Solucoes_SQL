If  Exists (Select Name
            From   sysobjects
            Where  Name = 'FrotaViagem_Ins' and type = 'P')
    Drop Procedure dbo.FrotaViagem_Ins
GO

Create Procedure dbo.FrotaViagem_Ins
----------------------------------------------------------------------------------------------------
-- Insere uma nova frota/viagem
----------------------------------------------------------------------------------------------------
(
@p_Transportador_ID   Int,
@p_Nome               Varchar(100),
@p_FrotaViagem_ID     Int OUTPUT
)
AS

SET NOCOUNT ON

Insert Into FrotaViagem ( Transportador_ID, Nome )
Values ( @p_Transportador_ID,
         @p_Nome )

Set @p_FrotaViagem_ID = SCOPE_IDENTITY()

GO

/*
Declare @Transportador_ID  Int,
        @Nome              Varchar(100),
        @FrotaViagem_ID    Int

-- Frota/Viagem Teste 1
Set @Transportador_ID = 1
Set @Nome             = 'Frota/Viagem Teste 1'

EXEC FrotaViagem_Ins @Transportador_ID, @Nome, @FrotaViagem_ID OUTPUT

Print @Nome + ':' + Cast(@FrotaViagem_ID as Varchar)

EXEC FrotaViagem_Sel @p_FrotaViagem_ID = @FrotaViagem_ID

-- Frota/Viagem Teste 2
Set @Transportador_ID = 4
Set @Nome             = 'Frota/Viagem Teste 1'

EXEC FrotaViagem_Ins @Transportador_ID, @Nome, @FrotaViagem_ID OUTPUT

Print @Nome + ':' + Cast(@FrotaViagem_ID as Varchar)

EXEC FrotaViagem_Sel @p_FrotaViagem_ID = @FrotaViagem_ID

*/

-- FIM
