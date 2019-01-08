If  Exists (Select Name
            From   sysobjects
            Where  Name = 'Marca_Lst' and type = 'P')
    Drop Procedure dbo.Marca_Lst
GO

Create Procedure dbo.Marca_Lst
----------------------------------------------------------------------------------------------------
-- Lista as marcas de um cliente
----------------------------------------------------------------------------------------------------
(
@p_Cliente_ID  Int, -- Identificação do cliente
@p_Ativos      Bit  -- 1:Apenas as marcas ativas 0:Todos
)
AS

SET NOCOUNT ON

Select Marca_ID,
       Nome,
       Ativo

From   Marca
Where  Cliente_ID = @p_Cliente_ID

 and  (    Ativo = 1
        or @p_Ativos = 0 )

Order by Nome

GO

/*
EXEC Marca_Lst @p_Cliente_ID = 1, @p_Ativos = 1
*/

-- FIM
