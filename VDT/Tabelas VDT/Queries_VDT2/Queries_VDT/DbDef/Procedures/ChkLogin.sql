If  Exists (Select Name
            From   sysobjects
            Where  Name = 'ChkLogin' and type = 'P')
    Drop Procedure dbo.ChkLogin
GO

Create Procedure dbo.ChkLogin
----------------------------------------------------------------------------------------------------
-- Consulta os dados de um usuário para login
----------------------------------------------------------------------------------------------------
(
@p_Login  Varchar(100) -- Identificação do usuário para login
)
AS

SET NOCOUNT ON

Select u.Usuario_ID,
       u.UsuarioPerfil_ID,

       u.Login,
       u.Nome,
       u.Senha,
       u.Email,
       u.Inspetor,
       u.RequerTrocaSenha,

       p.Clientes,                -- '*' ou lista dos clientes que os usuários têm acesso, separados por pipe (|)
       p.Locais,                  -- '*' ou lista dos locais   que os usuários têm acesso, separados por pipe (|)

       p.Nome  as UsuarioPerfilNome, -- Nome do perfil

       p.Administrador,           -- Usuários podem fazer a manutenção das tabelas de usuários e de perfis de acesso

       p.AcessaModuloInspecao,    -- Usuários podem acessar o módulo de inspeção
       p.AcessaModuloBackOffice,  -- Usuários podem acessar o módulo de back-office
       p.AcessaModuloConsultas,   -- Usuários podem acessar o módulo de consultas

       p.ConsultaInspecao,        -- Usuários podem consultar dados das inspeções
       p.RegistraInspecao,        -- Usuários podem registrar (inserir) inspeções
       p.AlteraInspecao,          -- Usuários podem modificar dados das inspeções
       p.PublicaInspecao,         -- Usuários podem publicar    inspeções
       p.DespublicaInspecao,      -- Usuários podem despublicar inspeções

       p.ImportaListas,           -- Usuários podem importar pack-lists e loading-lists

       p.InsereEscritorios,       -- Usuários podem inserir novos escritórios
       p.AlteraEscritorios,       -- Usuários podem alterar       escritórios

       p.InsereLocais,            -- Usuários podem inserir novos locais de inspeção
       p.AlteraLocais,            -- Usuários podem alterar       locais

       p.InsereCheckPoints,       -- Usuários podem inserir novos check-points
       p.AlteraCheckPoints,       -- Usuários podem alterar       check-points

       p.InsereMarcas,            -- Usuários podem inserir novas marcas de veículos
       p.AlteraMarcas,            -- Usuários podem alterar       marcas de veículos

       p.InsereModelos,           -- Usuários podem inserir novos modelos de veículos
       p.AlteraModelos,           -- Usuários podem alterar       modelos de veículos

       p.InsereTabAvarias,        -- Usuários podem inserir linhas nas tabelas de áreas, danos, severidades, quadrantes, gravidades e condições de inspeção
       p.AlteraTabAvarias,        -- Usuários podem alterar áreas, danos, severidades, quadrantes, gravidades e condições de inspeção

       p.InsereTransportadores,   -- Usuários podem inserir novos transportadores
       p.AlteraTransportadores    -- Usuários podem alterar       transportadores

From       Usuario       u
Inner Join UsuarioPerfil p on u.UsuarioPerfil_ID = p.UsuarioPerfil_ID

Where u.Login = @p_Login
 and  u.Ativo = 1
 and  p.Ativo = 1

 -- Verifica a data de inicio
 and  u.DataInicio <= GetDate()

 -- Verifica a data de validade, considerando apenas dia/mês/ano (desprezando horas, minutos e segundos)
 and  u.DataValidade >= DateAdd(dd, 0, DateDiff(dd, 0, GetDate()))
GO

/*
EXEC ChkLogin 'inspetor'
EXEC ChkLogin 'santos'
EXEC ChkLogin 'publicador'
EXEC ChkLogin 'admtab'
EXEC ChkLogin 'admusr'
EXEC ChkLogin 'alianz'
*/

-- FIM
