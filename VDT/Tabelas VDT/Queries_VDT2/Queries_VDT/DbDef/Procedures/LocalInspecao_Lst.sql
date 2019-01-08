If  Exists (Select Name
            From   sysobjects
            Where  Name = 'LocalInspecao_Lst' and type = 'P')
    Drop Procedure dbo.LocalInspecao_Lst
GO

Create Procedure dbo.LocalInspecao_Lst
----------------------------------------------------------------------------------------------------
-- Lista os locais que o usuário tem permissão de acesso
----------------------------------------------------------------------------------------------------
(
@p_Usuario_ID  Int, -- Identificação do usuário
@p_Ativos      Bit  -- 1:Apenas os ativos 0:Todos
)
AS

SET NOCOUNT ON

-- Monta a lista de locais que o usuário tem acesso
Declare @Locais Varchar(1000) -- '*' ou lista dos locais que o usuário tem acesso, separados por pipe (|)

Select  @Locais = Locais
From       Usuario       u
Inner Join UsuarioPerfil p on u.UsuarioPerfil_ID = p.UsuarioPerfil_ID

Where u.Usuario_ID = @p_Usuario_ID

-- Lista os locais
Select LocalInspecao_ID,
       Nome,
       Ativo

From   LocalInspecao

Where ( @Locais = '*'
        or  CharIndex( '|'+LTrim(RTrim(LocalInspecao_ID))+'|' , @Locais ) <> 0 )

 and  (    Ativo = 1
        or @p_Ativos = 0 )

Order by Nome

GO

/*
EXEC LocalInspecao_Lst @p_Usuario_ID = 1, @p_Ativos = 1  -- Inspetor em Santos
EXEC LocalInspecao_Lst @p_Usuario_ID = 2, @p_Ativos = 1  -- Backoffice em Santos
EXEC LocalInspecao_Lst @p_Usuario_ID = 3, @p_Ativos = 1  -- Backoffice em São Paulo
*/

-- FIM
