If  Exists (Select Name
            From   sysobjects
            Where  Name = 'Cliente_Lst' and type = 'P')
    Drop Procedure dbo.Cliente_Lst
GO

Create Procedure dbo.Cliente_Lst
----------------------------------------------------------------------------------------------------
-- Lista os clientes
----------------------------------------------------------------------------------------------------
(
@p_Usuario_ID  Int, -- Identificação do usuário
@p_Ativos      Bit  -- 1:Apenas os ativos 0:Todos
)
AS

SET NOCOUNT ON

-- Monta a lista de clientes que o usuário tem acesso
Declare @Clientes Varchar(1000) -- '*' ou lista dos clientes que os usuários têm acesso, separados por pipe (|)

Select  @Clientes = Clientes
From       Usuario       u
Inner Join UsuarioPerfil p on u.UsuarioPerfil_ID = p.UsuarioPerfil_ID

Where u.Usuario_ID = @p_Usuario_ID

-- Lista os clientes
Select  Cliente_ID,
        Nome,
        Ativo

From    Cliente
Where ( @Clientes = '*'
        or  CharIndex( '|'+LTrim(RTrim(Cliente_ID))+'|' , @Clientes ) <> 0 )

 and  (    Ativo = 1
        or @p_Ativos = 0 )

Order by Cliente_ID

GO

/*
EXEC Cliente_Lst @p_Usuario_ID = 1, @p_Ativos = 1  -- Inspetor
EXEC Cliente_Lst @p_Usuario_ID = 6, @p_Ativos = 1  -- Cliente Alianz GM
*/

-- FIM
