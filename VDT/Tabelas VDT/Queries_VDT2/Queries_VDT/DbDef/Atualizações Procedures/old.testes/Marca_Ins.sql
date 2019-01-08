If  Exists (Select Name
            From   sysobjects
            Where  Name = 'Marca_Ins' and type = 'P')
    Drop Procedure dbo.Marca_Ins
GO

Create Procedure dbo.Marca_Ins
----------------------------------------------------------------------------------------------------
-- Insere uma nova Marca
----------------------------------------------------------------------------------------------------
(
@p_Cliente_ID             int,
@p_Nome             Varchar(100),
@p_Ativo			int,
@p_Marca_ID Int OUTPUT
)
AS

SET NOCOUNT ON

Insert Into Marca ( Cliente_ID, Nome, Ativo )
Values ( @p_Cliente_ID,
         @p_Nome, 
		 @p_Ativo)

Set @p_Marca_ID = SCOPE_IDENTITY()

GO
