If  Exists (Select Name
            From   sysobjects
            Where  Name = 'Modelo_Ins' and type = 'P')
    Drop Procedure dbo.Modelo_Ins
GO

Create Procedure dbo.Modelo_Ins
----------------------------------------------------------------------------------------------------
-- Insere um novo Modelo
----------------------------------------------------------------------------------------------------
(
@p_Cliente_ID             int,
@p_Nome             Varchar(100),
@p_Ativo			int,
@p_Modelo_ID Int OUTPUT
)
AS

SET NOCOUNT ON

Insert Into Modelo ( Cliente_ID, Nome, Ativo )
Values ( @p_Cliente_ID,
         @p_Nome, 
		 @p_Ativo)

Set @p_Modelo_ID = SCOPE_IDENTITY()

GO
