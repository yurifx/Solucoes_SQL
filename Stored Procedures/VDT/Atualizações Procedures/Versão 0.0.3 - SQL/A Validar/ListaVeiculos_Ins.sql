USE [VDT2]
GO

If  Exists (Select Name
            From   sysobjects
            Where  Name = 'ListaVeiculos_Ins' and type = 'P')
    Drop Procedure dbo.ListaVeiculos_Ins
GO

Create Procedure dbo.ListaVeiculos_Ins
----------------------------------------------------------------------------------------------------
-- Insere os dados gerais de uma lista de veículos
-- 22/03 - Inclusão dos campos LocalInspecao_ID e Tipo
----------------------------------------------------------------------------------------------------
(
@p_Cliente_ID        Int,
@p_Usuario_ID        Int,          -- Identificação do usuário que está incluindoi os dados do arquivo na base de dados
@p_NomeArquivo       Varchar(50),  -- Nome do arquivo sem as pastas
@p_LocalInspecao_ID  Int,
@p_Tipo              Char(1),
@p_ListaVeiculos_ID  Int OUTPUT
)
AS

SET NOCOUNT ON

Insert Into ListaVeiculos ( Cliente_ID, Usuario_ID, NomeArquivo, LocalInspecao_ID, Tipo)

Values ( @p_Cliente_ID,
         @p_Usuario_ID,
         @p_NomeArquivo,
		 @p_LocalInspecao_ID,
		 @p_Tipo )

Set @p_ListaVeiculos_ID = SCOPE_IDENTITY()

GO

/*
Declare @Cliente_ID       Int,
        @Usuario_ID       Int,
        @NomeArquivo      Varchar(50),
        @ListaVeiculos_ID Int

Set @Cliente_ID       = 1
Set @Usuario_ID       = 1
Set @NomeArquivo      = 'Teste.csv'

EXEC ListaVeiculos_Ins @Cliente_ID, @Usuario_ID, @NomeArquivo, @ListaVeiculos_ID OUTPUT

Print '@ListaVeiculos_ID:' + Cast(@ListaVeiculos_ID as Varchar)

EXEC ListaVeiculos_Sel @p_ListaVeiculos_ID = @ListaVeiculos_ID
*/

-- FIM

