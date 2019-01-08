If  Exists (Select Name
            From   sysobjects
            Where  Name = 'LocalCheckPoint_Lst' and type = 'P')
    Drop Procedure dbo.LocalCheckPoint_Lst
GO

Create Procedure dbo.LocalCheckPoint_Lst
----------------------------------------------------------------------------------------------------
-- Lista os check-points dos locais que o usuário tem permissão de acesso
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

-- Lista os check-points
Select   c.LocalCheckPoint_ID,
         c.LocalInspecao_ID,

         c.Codigo,

         c.Nome_Pt,
         c.Nome_En,
         c.Nome_Es,

         l.Nome      as LocalInspecaoNome,

         c.Operacao,            -- E:Exportação I:Importacao

         c.Ativo

From       LocalCheckPoint c
Inner Join LocalInspecao   l on c.LocalInspecao_ID = l.LocalInspecao_ID

Where ( @Locais = '*'
        or  CharIndex( '|'+LTrim(RTrim(l.LocalInspecao_ID))+'|' , @Locais ) <> 0 )

 and  (    c.Ativo = 1
        or @p_Ativos = 0 )

 and  (    l.Ativo = 1
        or @p_Ativos = 0 )

Order by c.LocalInspecao_ID, c.LocalCheckPoint_ID

GO

/*
EXEC LocalCheckPoint_Lst @p_Usuario_ID = 1, @p_Ativos = 1  -- Inspetor em Santos
EXEC LocalCheckPoint_Lst @p_Usuario_ID = 2, @p_Ativos = 1  -- Backoffice em Santos
EXEC LocalCheckPoint_Lst @p_Usuario_ID = 3, @p_Ativos = 1  -- Backoffice em São Paulo
*/

-- FIM
