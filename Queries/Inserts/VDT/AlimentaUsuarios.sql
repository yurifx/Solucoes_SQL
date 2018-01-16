Delete From Usuario
Delete From UsuarioPerfil
GO

Declare @Local_Santos_ID Int
Select  @Local_Santos_ID = LocalInspecao_ID From LocalInspecao Where Nome = 'Santos';

Declare @Cliente_Alianz_ID  Int
Select  @Cliente_Alianz_ID = Cliente_ID From Cliente Where Nome = 'Alianz';

Declare @UsuarioPerfil_Inspetor_ID         Int   -- Um perfil de inspetor
      , @UsuarioPerfil_BackOfficeSantos_ID Int   -- Um perfil de backoffice de um local específico
      , @UsuarioPerfil_BackOfficeGeral_ID  Int   -- Um perfil de backoffice geral
      , @UsuarioPerfil_AdmTabelas_ID       Int   -- Um perfil de usuário que faz manutenção em tabelas
      , @UsuarioPerfil_AdmUsr_ID           Int   -- Um perfil de administrador de usuários e direitos de acesso
      , @UsuarioPerfil_ClienteGM_ID        Int   -- Um perfil de cliente Alianz GM

--------------------------------------------------------------------------------
-- Tabela de perfis de acesso
--------------------------------------------------------------------------------
-- Um perfil de inspetor
Insert Into UsuarioPerfil (
   Clientes                 -- '*' ou lista dos clientes que os usuários têm acesso, separados por pipe (|)
  ,Locais                   -- '*' ou lista dos locais   que os usuários têm acesso, separados por pipe (|)

  ,Nome

  ,Administrador            -- Usuários podem fazer a manutenção das tabelas de usuários e de perfis de acesso

  ,AcessaModuloInspecao     -- Usuários podem acessar o módulo de inspeção
  ,AcessaModuloBackOffice   -- Usuários podem acessar o módulo de back-office
  ,AcessaModuloConsultas    -- Usuários podem acessar o módulo de consultas

  ,ConsultaInspecao         -- Usuários podem consultar dados das inspeções
  ,RegistraInspecao         -- Usuários podem registrar (inserir) inspeções
  ,AlteraInspecao           -- Usuários podem modificar dados das inspeções
  ,PublicaInspecao          -- Usuários podem publicar    inspeções
  ,DespublicaInspecao       -- Usuários podem despublicar inspeções

  ,ImportaListas            -- Usuários podem importar pack-lists e loading-lists

  ,InsereEscritorios        -- Usuários podem inserir novos escritórios
  ,AlteraEscritorios        -- Usuários podem alterar       escritórios

  ,InsereLocais             -- Usuários podem inserir novos locais de inspeção
  ,AlteraLocais             -- Usuários podem alterar       locais

  ,InsereCheckPoints        -- Usuários podem inserir novos check-points
  ,AlteraCheckPoints        -- Usuários podem alterar       check-points

  ,InsereMarcas             -- Usuários podem inserir novas marcas de veículos
  ,AlteraMarcas             -- Usuários podem alterar       marcas de veículos

  ,InsereModelos            -- Usuários podem inserir novos modelos de veículos
  ,AlteraModelos            -- Usuários podem alterar       modelos de veículos

  ,InsereTabAvarias         -- Usuários podem inserir linhas nas tabelas de áreas, danos, severidades, quadrantes, gravidades e condições de inspeção
  ,AlteraTabAvarias         -- Usuários podem alterar áreas, danos, severidades, quadrantes, gravidades e condições de inspeção

  ,InsereTransportadores    -- Usuários podem inserir novos transportadores
  ,AlteraTransportadores )  -- Usuários podem alterar       transportadores

Values ( '*'                                            -- '*' ou lista dos clientes que os usuários têm acesso, separados por pipe (|)
         ,'|' + Cast(@Local_Santos_ID as Varchar) + '|' -- '*' ou lista dos locais   que os usuários têm acesso, separados por pipe (|)

         ,'Inspetor em Santos'
         ,0                                             -- Usuários podem fazer a manutenção das tabelas de usuários e de perfis de acesso

         ,1                                             -- Usuários podem acessar o módulo de inspeção
         ,0                                             -- Usuários podem acessar o módulo de back-office
         ,0                                             -- Usuários podem acessar o módulo de consultas

         ,1                                             -- Usuários podem consultar dados das inspeções
         ,1                                             -- Usuários podem registrar (inserir) inspeções
         ,1                                             -- Usuários podem modificar dados das inspeções
         ,0                                             -- Usuários podem publicar    inspeções
         ,0                                             -- Usuários podem despublicar inspeções

         ,0                                             -- Usuários podem importar pack-lists e loading-lists

         ,0                                             -- Usuários podem inserir novos escritórios
         ,0                                             -- Usuários podem alterar       escritórios

         ,0                                             -- Usuários podem inserir novos locais de inspeção
         ,0                                             -- Usuários podem alterar       locais

         ,0                                             -- Usuários podem inserir novos check-points
         ,0                                             -- Usuários podem alterar       check-points

         ,1                                             -- Usuários podem inserir novas marcas de veículos
         ,0                                             -- Usuários podem alterar       marcas de veículos

         ,1                                             -- Usuários podem inserir novos modelos de veículos
         ,0                                             -- Usuários podem alterar       modelos de veículos

         ,0                                             -- Usuários podem inserir linhas nas tabelas de áreas, danos, severidades, quadrantes, gravidades e condições de inspeção
         ,0                                             -- Usuários podem alterar áreas, danos, severidades, quadrantes, gravidades e condições de inspeção

         ,1                                             -- Usuários podem inserir novos transportadores
         ,0 )                                           -- Usuários podem alterar       transportadores
Set @UsuarioPerfil_Inspetor_ID = SCOPE_IDENTITY();


-- Um perfil de backoffice de um local específico
Insert Into UsuarioPerfil (
   Clientes                 -- '*' ou lista dos clientes que os usuários têm acesso, separados por pipe (|)
  ,Locais                   -- '*' ou lista dos locais   que os usuários têm acesso, separados por pipe (|)

  ,Nome

  ,Administrador            -- Usuários podem fazer a manutenção das tabelas de usuários e de perfis de acesso

  ,AcessaModuloInspecao     -- Usuários podem acessar o módulo de inspeção
  ,AcessaModuloBackOffice   -- Usuários podem acessar o módulo de back-office
  ,AcessaModuloConsultas    -- Usuários podem acessar o módulo de consultas

  ,ConsultaInspecao         -- Usuários podem consultar dados das inspeções
  ,RegistraInspecao         -- Usuários podem registrar (inserir) inspeções
  ,AlteraInspecao           -- Usuários podem modificar dados das inspeções
  ,PublicaInspecao          -- Usuários podem publicar    inspeções
  ,DespublicaInspecao       -- Usuários podem despublicar inspeções

  ,ImportaListas            -- Usuários podem importar pack-lists e loading-lists

  ,InsereEscritorios        -- Usuários podem inserir novos escritórios
  ,AlteraEscritorios        -- Usuários podem alterar       escritórios

  ,InsereLocais             -- Usuários podem inserir novos locais de inspeção
  ,AlteraLocais             -- Usuários podem alterar       locais

  ,InsereCheckPoints        -- Usuários podem inserir novos check-points
  ,AlteraCheckPoints        -- Usuários podem alterar       check-points

  ,InsereMarcas             -- Usuários podem inserir novas marcas de veículos
  ,AlteraMarcas             -- Usuários podem alterar       marcas de veículos

  ,InsereModelos            -- Usuários podem inserir novos modelos de veículos
  ,AlteraModelos            -- Usuários podem alterar       modelos de veículos

  ,InsereTabAvarias         -- Usuários podem inserir linhas nas tabelas de áreas, danos, severidades, quadrantes, gravidades e condições de inspeção
  ,AlteraTabAvarias         -- Usuários podem alterar áreas, danos, severidades, quadrantes, gravidades e condições de inspeção

  ,InsereTransportadores    -- Usuários podem inserir novos transportadores
  ,AlteraTransportadores )  -- Usuários podem alterar       transportadores

Values ( '*'                                            -- '*' ou lista dos clientes que os usuários têm acesso, separados por pipe (|)
         ,'|' + Cast(@Local_Santos_ID as Varchar) + '|' -- '*' ou lista dos locais   que os usuários têm acesso, separados por pipe (|)

         ,'Backoffice em Santos'

         ,0                                             -- Usuários podem fazer a manutenção das tabelas de usuários e de perfis de acesso

         ,0                                             -- Usuários podem acessar o módulo de inspeção
         ,1                                             -- Usuários podem acessar o módulo de back-office
         ,1                                             -- Usuários podem acessar o módulo de consultas

         ,1                                             -- Usuários podem consultar dados das inspeções
         ,1                                             -- Usuários podem registrar (inserir) inspeções
         ,1                                             -- Usuários podem modificar dados das inspeções
         ,1                                             -- Usuários podem publicar    inspeções
         ,0                                             -- Usuários podem despublicar inspeções

         ,1                                             -- Usuários podem importar pack-lists e loading-lists

         ,0                                             -- Usuários podem inserir novos escritórios
         ,0                                             -- Usuários podem alterar       escritórios

         ,0                                             -- Usuários podem inserir novos locais de inspeção
         ,0                                             -- Usuários podem alterar       locais

         ,0                                             -- Usuários podem inserir novos check-points
         ,0                                             -- Usuários podem alterar       check-points

         ,1                                             -- Usuários podem inserir novas marcas de veículos
         ,0                                             -- Usuários podem alterar       marcas de veículos

         ,1                                             -- Usuários podem inserir novos modelos de veículos
         ,0                                             -- Usuários podem alterar       modelos de veículos

         ,0                                             -- Usuários podem inserir linhas nas tabelas de áreas, danos, severidades, quadrantes, gravidades e condições de inspeção
         ,0                                             -- Usuários podem alterar áreas, danos, severidades, quadrantes, gravidades e condições de inspeção

         ,1                                             -- Usuários podem inserir novos transportadores
         ,0 )                                           -- Usuários podem alterar       transportadores
Set @UsuarioPerfil_BackOfficeSantos_ID = SCOPE_IDENTITY();


-- Um perfil de backoffice geral
Insert Into UsuarioPerfil (
   Clientes                 -- '*' ou lista dos clientes que os usuários têm acesso, separados por pipe (|)
  ,Locais                   -- '*' ou lista dos locais   que os usuários têm acesso, separados por pipe (|)

  ,Nome

  ,Administrador            -- Usuários podem fazer a manutenção das tabelas de usuários e de perfis de acesso

  ,AcessaModuloInspecao     -- Usuários podem acessar o módulo de inspeção
  ,AcessaModuloBackOffice   -- Usuários podem acessar o módulo de back-office
  ,AcessaModuloConsultas    -- Usuários podem acessar o módulo de consultas

  ,ConsultaInspecao         -- Usuários podem consultar dados das inspeções
  ,RegistraInspecao         -- Usuários podem registrar (inserir) inspeções
  ,AlteraInspecao           -- Usuários podem modificar dados das inspeções
  ,PublicaInspecao          -- Usuários podem publicar    inspeções
  ,DespublicaInspecao       -- Usuários podem despublicar inspeções

  ,ImportaListas            -- Usuários podem importar pack-lists e loading-lists

  ,InsereEscritorios        -- Usuários podem inserir novos escritórios
  ,AlteraEscritorios        -- Usuários podem alterar       escritórios

  ,InsereLocais             -- Usuários podem inserir novos locais de inspeção
  ,AlteraLocais             -- Usuários podem alterar       locais

  ,InsereCheckPoints        -- Usuários podem inserir novos check-points
  ,AlteraCheckPoints        -- Usuários podem alterar       check-points

  ,InsereMarcas             -- Usuários podem inserir novas marcas de veículos
  ,AlteraMarcas             -- Usuários podem alterar       marcas de veículos

  ,InsereModelos            -- Usuários podem inserir novos modelos de veículos
  ,AlteraModelos            -- Usuários podem alterar       modelos de veículos

  ,InsereTabAvarias         -- Usuários podem inserir linhas nas tabelas de áreas, danos, severidades, quadrantes, gravidades e condições de inspeção
  ,AlteraTabAvarias         -- Usuários podem alterar áreas, danos, severidades, quadrantes, gravidades e condições de inspeção

  ,InsereTransportadores    -- Usuários podem inserir novos transportadores
  ,AlteraTransportadores )  -- Usuários podem alterar       transportadores

Values ( '*'                                            -- '*' ou lista dos clientes que os usuários têm acesso, separados por pipe (|)
         ,'*'                                           -- '*' ou lista dos locais   que os usuários têm acesso, separados por pipe (|)

         ,'Backoffice em São Paulo'

         ,0                                             -- Usuários podem fazer a manutenção das tabelas de usuários e de perfis de acesso

         ,0                                             -- Usuários podem acessar o módulo de inspeção
         ,1                                             -- Usuários podem acessar o módulo de back-office
         ,1                                             -- Usuários podem acessar o módulo de consultas

         ,1                                             -- Usuários podem consultar dados das inspeções
         ,1                                             -- Usuários podem registrar (inserir) inspeções
         ,1                                             -- Usuários podem modificar dados das inspeções
         ,1                                             -- Usuários podem publicar    inspeções
         ,1                                             -- Usuários podem despublicar inspeções

         ,0                                             -- Usuários podem importar pack-lists e loading-lists

         ,0                                             -- Usuários podem inserir novos escritórios
         ,0                                             -- Usuários podem alterar       escritórios

         ,0                                             -- Usuários podem inserir novos locais de inspeção
         ,0                                             -- Usuários podem alterar       locais

         ,0                                             -- Usuários podem inserir novos check-points
         ,0                                             -- Usuários podem alterar       check-points

         ,1                                             -- Usuários podem inserir novas marcas de veículos
         ,0                                             -- Usuários podem alterar       marcas de veículos

         ,1                                             -- Usuários podem inserir novos modelos de veículos
         ,0                                             -- Usuários podem alterar       modelos de veículos

         ,0                                             -- Usuários podem inserir linhas nas tabelas de áreas, danos, severidades, quadrantes, gravidades e condições de inspeção
         ,0                                             -- Usuários podem alterar áreas, danos, severidades, quadrantes, gravidades e condições de inspeção

         ,1                                             -- Usuários podem inserir novos transportadores
         ,0 )                                           -- Usuários podem alterar       transportadores
Set @UsuarioPerfil_BackOfficeGeral_ID = SCOPE_IDENTITY();


-- Um perfil de usuário que faz manutenção em tabelas
Insert Into UsuarioPerfil (
   Clientes                 -- '*' ou lista dos clientes que os usuários têm acesso, separados por pipe (|)
  ,Locais                   -- '*' ou lista dos locais   que os usuários têm acesso, separados por pipe (|)

  ,Nome

  ,Administrador            -- Usuários podem fazer a manutenção das tabelas de usuários e de perfis de acesso

  ,AcessaModuloInspecao     -- Usuários podem acessar o módulo de inspeção
  ,AcessaModuloBackOffice   -- Usuários podem acessar o módulo de back-office
  ,AcessaModuloConsultas    -- Usuários podem acessar o módulo de consultas

  ,ConsultaInspecao         -- Usuários podem consultar dados das inspeções
  ,RegistraInspecao         -- Usuários podem registrar (inserir) inspeções
  ,AlteraInspecao           -- Usuários podem modificar dados das inspeções
  ,PublicaInspecao          -- Usuários podem publicar    inspeções
  ,DespublicaInspecao       -- Usuários podem despublicar inspeções

  ,ImportaListas            -- Usuários podem importar pack-lists e loading-lists

  ,InsereEscritorios        -- Usuários podem inserir novos escritórios
  ,AlteraEscritorios        -- Usuários podem alterar       escritórios

  ,InsereLocais             -- Usuários podem inserir novos locais de inspeção
  ,AlteraLocais             -- Usuários podem alterar       locais

  ,InsereCheckPoints        -- Usuários podem inserir novos check-points
  ,AlteraCheckPoints        -- Usuários podem alterar       check-points

  ,InsereMarcas             -- Usuários podem inserir novas marcas de veículos
  ,AlteraMarcas             -- Usuários podem alterar       marcas de veículos

  ,InsereModelos            -- Usuários podem inserir novos modelos de veículos
  ,AlteraModelos            -- Usuários podem alterar       modelos de veículos

  ,InsereTabAvarias         -- Usuários podem inserir linhas nas tabelas de áreas, danos, severidades, quadrantes, gravidades e condições de inspeção
  ,AlteraTabAvarias         -- Usuários podem alterar áreas, danos, severidades, quadrantes, gravidades e condições de inspeção

  ,InsereTransportadores    -- Usuários podem inserir novos transportadores
  ,AlteraTransportadores )  -- Usuários podem alterar       transportadores

Values ( '*'                                            -- '*' ou lista dos clientes que os usuários têm acesso, separados por pipe (|)
         ,'*'                                           -- '*' ou lista dos locais   que os usuários têm acesso, separados por pipe (|)

         ,'Administrador de tabelas'

         ,0                                             -- Usuários podem fazer a manutenção das tabelas de usuários e de perfis de acesso

         ,0                                             -- Usuários podem acessar o módulo de inspeção
         ,0                                             -- Usuários podem acessar o módulo de back-office
         ,1                                             -- Usuários podem acessar o módulo de consultas

         ,1                                             -- Usuários podem consultar dados das inspeções
         ,0                                             -- Usuários podem registrar (inserir) inspeções
         ,0                                             -- Usuários podem modificar dados das inspeções
         ,0                                             -- Usuários podem publicar    inspeções
         ,0                                             -- Usuários podem despublicar inspeções

         ,0                                             -- Usuários podem importar pack-lists e loading-lists

         ,1                                             -- Usuários podem inserir novos escritórios
         ,1                                             -- Usuários podem alterar       escritórios

         ,1                                             -- Usuários podem inserir novos locais de inspeção
         ,1                                             -- Usuários podem alterar       locais

         ,1                                             -- Usuários podem inserir novos check-points
         ,1                                             -- Usuários podem alterar       check-points

         ,1                                             -- Usuários podem inserir novas marcas de veículos
         ,1                                             -- Usuários podem alterar       marcas de veículos

         ,1                                             -- Usuários podem inserir novos modelos de veículos
         ,1                                             -- Usuários podem alterar       modelos de veículos

         ,1                                             -- Usuários podem inserir linhas nas tabelas de áreas, danos, severidades, quadrantes, gravidades e condições de inspeção
         ,1                                             -- Usuários podem alterar áreas, danos, severidades, quadrantes, gravidades e condições de inspeção

         ,1                                             -- Usuários podem inserir novos transportadores
         ,1 )                                           -- Usuários podem alterar       transportadores
Set @UsuarioPerfil_AdmTabelas_ID = SCOPE_IDENTITY();


-- Um perfil de administrador de usuários e direitos de acesso
Insert Into UsuarioPerfil (
   Clientes                 -- '*' ou lista dos clientes que os usuários têm acesso, separados por pipe (|)
  ,Locais                   -- '*' ou lista dos locais   que os usuários têm acesso, separados por pipe (|)

  ,Nome

  ,Administrador            -- Usuários podem fazer a manutenção das tabelas de usuários e de perfis de acesso

  ,AcessaModuloInspecao     -- Usuários podem acessar o módulo de inspeção
  ,AcessaModuloBackOffice   -- Usuários podem acessar o módulo de back-office
  ,AcessaModuloConsultas    -- Usuários podem acessar o módulo de consultas

  ,ConsultaInspecao         -- Usuários podem consultar dados das inspeções
  ,RegistraInspecao         -- Usuários podem registrar (inserir) inspeções
  ,AlteraInspecao           -- Usuários podem modificar dados das inspeções
  ,PublicaInspecao          -- Usuários podem publicar    inspeções
  ,DespublicaInspecao       -- Usuários podem despublicar inspeções

  ,ImportaListas            -- Usuários podem importar pack-lists e loading-lists

  ,InsereEscritorios        -- Usuários podem inserir novos escritórios
  ,AlteraEscritorios        -- Usuários podem alterar       escritórios

  ,InsereLocais             -- Usuários podem inserir novos locais de inspeção
  ,AlteraLocais             -- Usuários podem alterar       locais

  ,InsereCheckPoints        -- Usuários podem inserir novos check-points
  ,AlteraCheckPoints        -- Usuários podem alterar       check-points

  ,InsereMarcas             -- Usuários podem inserir novas marcas de veículos
  ,AlteraMarcas             -- Usuários podem alterar       marcas de veículos

  ,InsereModelos            -- Usuários podem inserir novos modelos de veículos
  ,AlteraModelos            -- Usuários podem alterar       modelos de veículos

  ,InsereTabAvarias         -- Usuários podem inserir linhas nas tabelas de áreas, danos, severidades, quadrantes, gravidades e condições de inspeção
  ,AlteraTabAvarias         -- Usuários podem alterar áreas, danos, severidades, quadrantes, gravidades e condições de inspeção

  ,InsereTransportadores    -- Usuários podem inserir novos transportadores
  ,AlteraTransportadores )  -- Usuários podem alterar       transportadores

Values ( '*'                                            -- '*' ou lista dos clientes que os usuários têm acesso, separados por pipe (|)
         ,'*'                                           -- '*' ou lista dos locais   que os usuários têm acesso, separados por pipe (|)

         ,'Administrador de usuários'

         ,1                                             -- Usuários podem fazer a manutenção das tabelas de usuários e de perfis de acesso

         ,0                                             -- Usuários podem acessar o módulo de inspeção
         ,0                                             -- Usuários podem acessar o módulo de back-office
         ,1                                             -- Usuários podem acessar o módulo de consultas

         ,1                                             -- Usuários podem consultar dados das inspeções
         ,0                                             -- Usuários podem registrar (inserir) inspeções
         ,0                                             -- Usuários podem modificar dados das inspeções
         ,0                                             -- Usuários podem publicar    inspeções
         ,0                                             -- Usuários podem despublicar inspeções

         ,0                                             -- Usuários podem importar pack-lists e loading-lists

         ,0                                             -- Usuários podem inserir novos escritórios
         ,0                                             -- Usuários podem alterar       escritórios

         ,0                                             -- Usuários podem inserir novos locais de inspeção
         ,0                                             -- Usuários podem alterar       locais

         ,0                                             -- Usuários podem inserir novos check-points
         ,0                                             -- Usuários podem alterar       check-points

         ,0                                             -- Usuários podem inserir novas marcas de veículos
         ,0                                             -- Usuários podem alterar       marcas de veículos

         ,0                                             -- Usuários podem inserir novos modelos de veículos
         ,0                                             -- Usuários podem alterar       modelos de veículos

         ,0                                             -- Usuários podem inserir linhas nas tabelas de áreas, danos, severidades, quadrantes, gravidades e condições de inspeção
         ,0                                             -- Usuários podem alterar áreas, danos, severidades, quadrantes, gravidades e condições de inspeção

         ,0                                             -- Usuários podem inserir novos transportadores
         ,0 )                                           -- Usuários podem alterar       transportadores
Set @UsuarioPerfil_AdmUsr_ID = SCOPE_IDENTITY();


-- Um perfil de cliente Alianz GM
Insert Into UsuarioPerfil (
   Clientes                 -- '*' ou lista dos clientes que os usuários têm acesso, separados por pipe (|)
  ,Locais                   -- '*' ou lista dos locais   que os usuários têm acesso, separados por pipe (|)

  ,Nome

  ,Administrador            -- Usuários podem fazer a manutenção das tabelas de usuários e de perfis de acesso

  ,AcessaModuloInspecao     -- Usuários podem acessar o módulo de inspeção
  ,AcessaModuloBackOffice   -- Usuários podem acessar o módulo de back-office
  ,AcessaModuloConsultas    -- Usuários podem acessar o módulo de consultas

  ,ConsultaInspecao         -- Usuários podem consultar dados das inspeções
  ,RegistraInspecao         -- Usuários podem registrar (inserir) inspeções
  ,AlteraInspecao           -- Usuários podem modificar dados das inspeções
  ,PublicaInspecao          -- Usuários podem publicar    inspeções
  ,DespublicaInspecao       -- Usuários podem despublicar inspeções

  ,ImportaListas            -- Usuários podem importar pack-lists e loading-lists

  ,InsereEscritorios        -- Usuários podem inserir novos escritórios
  ,AlteraEscritorios        -- Usuários podem alterar       escritórios

  ,InsereLocais             -- Usuários podem inserir novos locais de inspeção
  ,AlteraLocais             -- Usuários podem alterar       locais

  ,InsereCheckPoints        -- Usuários podem inserir novos check-points
  ,AlteraCheckPoints        -- Usuários podem alterar       check-points

  ,InsereMarcas             -- Usuários podem inserir novas marcas de veículos
  ,AlteraMarcas             -- Usuários podem alterar       marcas de veículos

  ,InsereModelos            -- Usuários podem inserir novos modelos de veículos
  ,AlteraModelos            -- Usuários podem alterar       modelos de veículos

  ,InsereTabAvarias         -- Usuários podem inserir linhas nas tabelas de áreas, danos, severidades, quadrantes, gravidades e condições de inspeção
  ,AlteraTabAvarias         -- Usuários podem alterar áreas, danos, severidades, quadrantes, gravidades e condições de inspeção

  ,InsereTransportadores    -- Usuários podem inserir novos transportadores
  ,AlteraTransportadores )  -- Usuários podem alterar       transportadores

Values (  '|' + Cast(@Cliente_Alianz_ID as Varchar) + '|' -- '*' ou lista dos clientes que os usuários têm acesso, separados por pipe (|)
         ,'*'                                           -- '*' ou lista dos locais   que os usuários têm acesso, separados por pipe (|)

         ,'Cliente Alianz GM'

         ,0                                             -- Usuários podem fazer a manutenção das tabelas de usuários e de perfis de acesso

         ,0                                             -- Usuários podem acessar o módulo de inspeção
         ,0                                             -- Usuários podem acessar o módulo de back-office
         ,1                                             -- Usuários podem acessar o módulo de consultas

         ,1                                             -- Usuários podem consultar dados das inspeções
         ,0                                             -- Usuários podem registrar (inserir) inspeções
         ,0                                             -- Usuários podem modificar dados das inspeções
         ,0                                             -- Usuários podem publicar    inspeções
         ,0                                             -- Usuários podem despublicar inspeções

         ,0                                             -- Usuários podem importar pack-lists e loading-lists

         ,0                                             -- Usuários podem inserir novos escritórios
         ,0                                             -- Usuários podem alterar       escritórios

         ,0                                             -- Usuários podem inserir novos locais de inspeção
         ,0                                             -- Usuários podem alterar       locais

         ,0                                             -- Usuários podem inserir novos check-points
         ,0                                             -- Usuários podem alterar       check-points

         ,0                                             -- Usuários podem inserir novas marcas de veículos
         ,0                                             -- Usuários podem alterar       marcas de veículos

         ,0                                             -- Usuários podem inserir novos modelos de veículos
         ,0                                             -- Usuários podem alterar       modelos de veículos

         ,0                                             -- Usuários podem inserir linhas nas tabelas de áreas, danos, severidades, quadrantes, gravidades e condições de inspeção
         ,0                                             -- Usuários podem alterar áreas, danos, severidades, quadrantes, gravidades e condições de inspeção

         ,0                                             -- Usuários podem inserir novos transportadores
         ,0 )                                           -- Usuários podem alterar       transportadores
Set @UsuarioPerfil_ClienteGM_ID = SCOPE_IDENTITY();


-- Um usuário Inspetor
Insert Into Usuario (  UsuarioPerfil_ID
                      ,Login
                      ,Nome
                      ,Senha
                      ,Email
                      ,Inspetor )
Values (  @UsuarioPerfil_Inspetor_ID
         ,'inspetor'
         ,'Inspetor Teste'
         , '123456'
         , 'inspetor@teste.com.br'
         , 1 )

-- Um usuário de backoffice de um local específico
Insert Into Usuario (  UsuarioPerfil_ID
                      ,Login
                      ,Nome
                      ,Senha
                      ,Email
                      ,Inspetor )
Values (  @UsuarioPerfil_BackOfficeSantos_ID
         ,'santos'
         ,'Validador Santos'
         , '123456'
         , 'validador@teste.com.br'
         , 0 )

-- Um usuário de backoffice geral
Insert Into Usuario (  UsuarioPerfil_ID
                      ,Login
                      ,Nome
                      ,Senha
                      ,Email
                      ,Inspetor )
Values (  @UsuarioPerfil_BackOfficeGeral_ID
         ,'publicador'
         ,'Publicador Sao Paulo'
         , '123456'
         , 'publicador.com.br'
         , 0 )

-- Um usuário que faz manutenção em tabelas
Insert Into Usuario (  UsuarioPerfil_ID
                      ,Login
                      ,Nome
                      ,Senha
                      ,Email
                      ,Inspetor )
Values (  @UsuarioPerfil_AdmTabelas_ID
         ,'admtab'
         ,'Administrador de tabelas'
         , '123456'
         , 'admtab.com.br'
         , 0 )

-- Um usuário administrador de usuários e direitos de acesso
Insert Into Usuario (  UsuarioPerfil_ID
                      ,Login
                      ,Nome
                      ,Senha
                      ,Email
                      ,Inspetor )
Values (  @UsuarioPerfil_AdmUsr_ID
         ,'admusr'
         ,'Administrador de usuários'
         , '123456'
         , 'admusr.com.br'
         , 0 )

-- Um usuário Alianz GM
Insert Into Usuario (  UsuarioPerfil_ID
                      ,Login
                      ,Nome
                      ,Senha
                      ,Email
                      ,Inspetor )
Values (  @UsuarioPerfil_ClienteGM_ID
         ,'alianz'
         ,'Cliente Alianz GM'
         , '123456'
         , 'admusr.com.br'
         , 0 )
GO

Select * From UsuarioPerfil
Select * From Usuario

-- FIM
