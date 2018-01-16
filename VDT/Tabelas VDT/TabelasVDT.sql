/*
Criação das tabelas da nova base de dados VDT

Tabelas de suporte
------------------

Cliente              Clientes
Marca                Marcas
Modelo               Modelos
AvArea               Áreas
AvDano               Tipos de Danos
AvSeveridade         Graus de severidade
AvQuadrante          Quadrantes
AvGravidade          Graus de gravidade
AvCondicao           Condições das inspeções
NumeracaoFoto        Numeração das fotos

EscritorioBV         Escritórios do Bureau Veritas
LocalInspecao        Locais de inspeção - Rio Grande, Santos, Guarujá, São Sebastião, Suape, etc.
LocalCheckPoint      Entrada - Porto, Subida Navio, Descida Navio, Saída Porto, etc.
Transportador        Tabela de transportadores marítimos e terrestres
FrotaViagem          Tabela de frotas de transportadores terrestres e de viagems de transportadores marítimos
Navio                Tabela de navios

Tabelas de operação
-------------------

Inspecao             Dados gerais das inspeções
InspVeiculo          Dados dos veículos inspecionados
InspAvaria           Registros das avarias
InspFoto             Fotos das avarias
InspLote             Lotes de veículos (a definir)
ListaVeiculos        Packing-list e Load-list - dados sobre o arquivo
ListaVeiculosVin     Packing-list e Load-list - veículos

Tabelas de controle de acesso
-----------------------------

Usuario              Cadastro dos usuários
UsuarioPerfil        Tabela de perfis de acesso
*/

--------------------------------------------------------------------------------
-- Cliente - Clientes
--------------------------------------------------------------------------------
Create Table Cliente (
  Cliente_ID         Int Not Null Identity Primary Key,
  Nome               Varchar(100),
  Ativo              Bit          Not Null Default 1
)
GO

--------------------------------------------------------------------------------
-- Marca - Marcas
--------------------------------------------------------------------------------
Create Table Marca (
  Marca_ID           Int Not Null Identity Primary Key,
  Cliente_ID         Int Not Null References Cliente(Cliente_ID),
  Nome               Varchar(100),
  Ativo              Bit          Not Null Default 1
)
GO

--------------------------------------------------------------------------------
-- Modelo - Modelos
--------------------------------------------------------------------------------
Create Table Modelo (
  Modelo_ID          Int Not Null Identity Primary Key,
  Cliente_ID         Int Not Null References Cliente(Cliente_ID),
  Nome               Varchar(100),
  Ativo              Bit          Not Null Default 1
)
GO

--------------------------------------------------------------------------------
-- AvArea - Áreas
--------------------------------------------------------------------------------
Create Table AvArea (
  AvArea_ID          Int Not Null Identity Primary Key,
  Cliente_ID         Int Not Null References Cliente(Cliente_ID),

  Codigo             Varchar(20),           -- Código da área

  Area_Pt            Varchar(50) Not Null,  -- Exemplos: Bateria, Parachoque, Porta
  Local_Pt           Varchar(50),           -- Exemplos: Dianteiro, Traseiro
  Lado_Pt            Varchar(50),           -- Exemplos: Esquerdo, Direito

  Area_En            Varchar(50),           -- Área  em inglês
  Local_En           Varchar(50),           -- Local em inglês
  Lado_En            Varchar(50),           -- Lado  em inglês

  Area_Es            Varchar(50),           -- Área  em espanhol
  Local_Es           Varchar(50),           -- Local em espanhol
  Lado_Es            Varchar(50),           -- Lado  em espanhol

  Nome_Pt            AS RTrim(Area_Pt             + ' ' + IsNull(Local_Pt, '') + ' ' + IsNull(Lado_Pt, '')) PERSISTED,
  Nome_En            AS RTrim(IsNull(Area_En, '') + ' ' + IsNull(Local_En, '') + ' ' + IsNull(Lado_En, '')) PERSISTED,
  Nome_Es            AS RTrim(IsNull(Area_Es, '') + ' ' + IsNull(Local_Es, '') + ' ' + IsNull(Lado_Es, '')) PERSISTED,

  Ativo              Bit          Not Null Default 1
)
GO

--------------------------------------------------------------------------------
-- AvDano - Tipos de Danos
--------------------------------------------------------------------------------
Create Table AvDano (
  AvDano_ID          Int Not Null Identity Primary Key,
  Cliente_ID         Int Not Null References Cliente(Cliente_ID),

  Codigo             Varchar(20),           -- Código da avaria

  Nome_Pt            Varchar(50) Not Null,
  Nome_En            Varchar(50),
  Nome_Es            Varchar(50),

  Ativo              Bit          Not Null Default 1
)
GO

--------------------------------------------------------------------------------
-- AvSeveridade - Graus de severidade
--------------------------------------------------------------------------------
Create Table AvSeveridade (
  AvSeveridade_ID    Int Not Null Identity Primary Key,
  Cliente_ID         Int Not Null References Cliente(Cliente_ID),

  Codigo             Varchar(20),           -- Código da severidade

  Nome_Pt            Varchar(50) Not Null,
  Nome_En            Varchar(50),
  Nome_Es            Varchar(50),

  Ativo              Bit          Not Null Default 1
)
GO

--------------------------------------------------------------------------------
-- AvQuadrante - Quadrantes
--------------------------------------------------------------------------------
Create Table AvQuadrante (
  AvQuadrante_ID     Int Not Null Identity Primary Key,
  Cliente_ID         Int Not Null References Cliente(Cliente_ID),

  Codigo             Varchar(20),           -- Código do quadrante

  Nome_Pt            Varchar(50) Not Null,
  Nome_En            Varchar(50),
  Nome_Es            Varchar(50),

  Ativo              Bit          Not Null Default 1
)
GO

--------------------------------------------------------------------------------
-- AvGravidade - Graus de gravidade
--------------------------------------------------------------------------------
Create Table AvGravidade (
  AvGravidade_ID     Int Not Null Identity Primary Key,
  Cliente_ID         Int Not Null References Cliente(Cliente_ID),

  Codigo             Varchar(20),           -- Código da gravidade

  Nome_Pt            Varchar(50) Not Null,
  Nome_En            Varchar(50),
  Nome_Es            Varchar(50),

  Ativo              Bit          Not Null Default 1
)
GO

--------------------------------------------------------------------------------
-- AvCondicao - Condições das inspeções
--------------------------------------------------------------------------------
Create Table AvCondicao (
  AvCondicao_ID      Int Not Null Identity Primary Key,

  Codigo             Varchar(20),           -- Código da condição

  Nome_Pt            Varchar(50) Not Null,
  Nome_En            Varchar(50),
  Nome_Es            Varchar(50),

  Ativo              Bit          Not Null Default 1
)
GO

--------------------------------------------------------------------------------
-- NumeracaoFoto - Numeração das fotos
--------------------------------------------------------------------------------
/*
Create Table NumeracaoFoto (
-- A DEFINIR
)
GO
*/

/*
--------------------------------------------------------------------------------
-- EscritorioBV - Escritórios do Bureau Veritas
--------------------------------------------------------------------------------
Create Table EscritorioBV (
  EscritorioBV_ID    SmallInt Not Null Identity Primary Key,
  CodigoInternoBV    Varchar(100),            -- Código interno (ZIG ?)
  Nome               Varchar(100) Not Null,   -- Nome do escritório
  Localizacao        Varchar(250),            -- Informação genérica sobre a localização do escritório
  Ativo              Bit          Not Null Default 1
)
GO
*/

--------------------------------------------------------------------------------
-- LocalInspecao - Locais de inspeção - Rio Grande, Santos, Guarujá, São Sebastião, Suape, etc.
--------------------------------------------------------------------------------
Create Table LocalInspecao (
  LocalInspecao_ID   Int Not Null Identity Primary Key,
  Nome               Varchar(100),
  Ativo              Bit          Not Null Default 1
)
GO

--------------------------------------------------------------------------------
-- CheckPoint - Entrada Porto, Subida Navio, Descida Navio, Saída Porto, etc.
--------------------------------------------------------------------------------
Create Table LocalCheckPoint (
  LocalCheckPoint_ID Int Not Null Identity Primary Key,
  LocalInspecao_ID   Int Not Null References LocalInspecao(LocalInspecao_ID),

  Codigo             Varchar(20),           -- Código do check-point

  Nome_Pt            Varchar(50) Not Null,
  Nome_En            Varchar(50),
  Nome_Es            Varchar(50),

  Operacao           Char(1)     Not Null,  -- E:Exportação I:Importacao

  Ativo              Bit         Not Null Default 1
)
GO

--------------------------------------------------------------------------------
-- Transportador - Tabela de transportadores marítimos e terrestres
--------------------------------------------------------------------------------
Create Table Transportador (
  Transportador_ID   Int Not Null Identity Primary Key,
  Nome               Varchar(100) Not Null,
  Tipo               Char(1)      Not Null,  -- T:Terrestre M:Marítimo
  Ativo              Bit          Not Null Default 1
)
GO

--------------------------------------------------------------------------------
-- FrotaViagem - Tabela de frotas de transportadores terrestres e de viagems de transportadores marítimos
--------------------------------------------------------------------------------
Create Table FrotaViagem (
  FrotaViagem_ID     Int Not Null Identity Primary Key,
  Transportador_ID   Int Not Null References Transportador(Transportador_ID),
  Nome               Varchar(100) Not Null,
  Ativo              Bit          Not Null Default 1
)
GO

--------------------------------------------------------------------------------
-- Navio - Tabela de navios
--------------------------------------------------------------------------------
Create Table Navio (
  Navio_ID           Int Not Null Identity Primary Key,
  Nome               Varchar(100) Not Null,
  Ativo              Bit          Not Null Default 1
)
GO

--------------------------------------------------------------------------------
-- Tabela de perfis de acesso
--------------------------------------------------------------------------------
Create Table UsuarioPerfil (
  UsuarioPerfil_ID       Smallint Not Null Identity Primary Key,
  Clientes               Varchar(1000),         -- '*' ou lista dos clientes que os usuários têm acesso, separados por pipe (|)
  Locais                 Varchar(1000),         -- '*' ou lista dos locais   que os usuários têm acesso, separados por pipe (|)

  Nome                   Varchar(100),          -- Nome do perfil

  Ativo                  Bit          Not Null Default 1,

  Administrador          Bit Default 0,         -- Usuários podem fazer a manutenção das tabelas de usuários e de perfis de acesso

  AcessaModuloInspecao   Bit Default 0,         -- Usuários podem acessar o módulo de inspeção
  AcessaModuloBackOffice Bit Default 0,         -- Usuários podem acessar o módulo de back-office
  AcessaModuloConsultas  Bit Default 0,         -- Usuários podem acessar o módulo de consultas

  ConsultaInspecao       Bit Default 0,         -- Usuários podem consultar dados das inspeções
  RegistraInspecao       Bit Default 0,         -- Usuários podem registrar (inserir) inspeções
  AlteraInspecao         Bit Default 0,         -- Usuários podem modificar dados das inspeções
  PublicaInspecao        Bit Default 0,         -- Usuários podem publicar    inspeções
  DespublicaInspecao     Bit Default 0,         -- Usuários podem despublicar inspeções

  ImportaListas          Bit Default 0,         -- Usuários podem importar pack-lists e loading-lists

  InsereEscritorios      Bit Default 0,         -- Usuários podem inserir novos escritórios
  AlteraEscritorios      Bit Default 0,         -- Usuários podem alterar       escritórios

  InsereLocais           Bit Default 0,         -- Usuários podem inserir novos locais de inspeção
  AlteraLocais           Bit Default 0,         -- Usuários podem alterar       locais

  InsereCheckPoints      Bit Default 0,         -- Usuários podem inserir novos check-points
  AlteraCheckPoints      Bit Default 0,         -- Usuários podem alterar       check-points

  InsereMarcas           Bit Default 0,         -- Usuários podem inserir novas marcas de veículos
  AlteraMarcas           Bit Default 0,         -- Usuários podem alterar       marcas de veículos

  InsereModelos          Bit Default 0,         -- Usuários podem inserir novos modelos de veículos
  AlteraModelos          Bit Default 0,         -- Usuários podem alterar       modelos de veículos

  InsereTabAvarias       Bit Default 0,         -- Usuários podem inserir linhas nas tabelas de áreas, danos, severidades, quadrantes, gravidades e condições de inspeção
  AlteraTabAvarias       Bit Default 0,         -- Usuários podem alterar áreas, danos, severidades, quadrantes, gravidades e condições de inspeção

  InsereTransportadores  Bit Default 0,         -- Usuários podem inserir novos transportadores
  AlteraTransportadores  Bit Default 0          -- Usuários podem alterar       transportadores
)
GO

--------------------------------------------------------------------------------
-- Tabela de Usuários
--------------------------------------------------------------------------------
Create Table Usuario (
  Usuario_ID            Int Not Null Identity Primary Key,
  UsuarioPerfil_ID      Smallint     Not Null References UsuarioPerfil(UsuarioPerfil_ID),
  -- EscritorioBV_ID       Smallint,              -- Escritório onde o usuário trabalha - NULL para clientes

  Login                 Varchar(100) Not Null, -- Identificação do usuário para login
  Nome                  Varchar(50)  Not Null, -- Nome completo do usuário
  Senha                 Varchar(50)  Not Null,
  Email                 Varchar(100) Not Null, -- Endereço de e-mail
  Inspetor              Bit          Not Null Default 0,  -- Indica se o usuário é um inspetor
  Ativo                 Bit          Not Null Default 1,

  DataInicio            Date         Not Null Default GetDate(),
  DataValidade          Date         Not Null Default DateAdd(d, 60, GetDate()),
  RequerTrocaSenha      Bit          Not Null Default 0
)
GO

Create Index Ind_Login on Usuario (Login)
GO

--------------------------------------------------------------------------------
-- Inspecao - Dados gerais das inspeções
--            Uma ou mais linhas compõem uma inspeção pois:
--            a) Vários inspetores podem registrar dados ao mesmo tempo durante a mesma operação de inspeção)
--            b) Uma inspeção pode envolver vários transportadores
--------------------------------------------------------------------------------
Create Table Inspecao (
  Inspecao_ID        Int  Not Null Identity Primary Key,
  Cliente_ID         Int  Not Null References Cliente(Cliente_ID),
  LocalInspecao_ID   Int  Not Null References LocalInspecao(LocalInspecao_ID),
  LocalCheckPoint_ID Int  Not Null References LocalCheckPoint(LocalCheckPoint_ID),
  Transportador_ID   Int  Not Null References Transportador(Transportador_ID),
  FrotaViagem_ID     Int  Not Null References FrotaViagem(FrotaViagem_ID),
  Navio_ID           Int           References Navio(Navio_ID),
  Usuario_ID         Int  Not Null References Usuario(Usuario_ID),  -- Identificação do inspetor

  Data               Date Not Null  -- Data da inspeção
)
GO

--------------------------------------------------------------------------------
-- InspVeiculo - Dados dos veículos inspecionados
--------------------------------------------------------------------------------
Create Table InspVeiculo (
  InspVeiculo_ID     Int  Not Null Identity Primary Key,
  Inspecao_ID        Int  Not Null References Inspecao(Inspecao_ID),
  Marca_ID           Int  Not Null References Marca(Marca_ID),
  Modelo_ID          Int  Not Null References Modelo(Modelo_ID),

  VIN_6              Varchar(6),    -- Últimos seis caracteres do chassi
  VIN                Char(17),      -- Chassi completo

  Observacoes        Varchar(1000)  -- Observações gerais sobre o veículo
)
GO

--------------------------------------------------------------------------------
-- InspAvaria - Registros das avarias
--------------------------------------------------------------------------------
Create Table InspAvaria (
  InspAvaria_ID      Int  Not Null Identity Primary Key,
  InspVeiculo_ID     Int  Not Null References InspVeiculo(InspVeiculo_ID),

  AvArea_ID          Int  Not Null References AvArea(AvArea_ID),
  AvDano_ID          Int  Not Null References AvDano(AvDano_ID),
  AvSeveridade_ID    Int  Not Null References AvSeveridade(AvSeveridade_ID),
  AvQuadrante_ID     Int  Not Null References AvQuadrante(AvQuadrante_ID),
  AvGravidade_ID     Int  Not Null References AvGravidade(AvGravidade_ID),
  AvCondicao_ID      Int  Not Null References AvCondicao(AvCondicao_ID),

  FabricaTransporte  Char(1) Not Null -- F:Defeito de Fábrica  T:Avaria de Transporte
)
GO

--------------------------------------------------------------------------------
-- InspFoto - Fotos das avarias
--------------------------------------------------------------------------------
/*
Create Table InspFoto (
  InspFoto_ID        Int  Not Null Identity Primary Key,
  InspAvaria_ID      Int  Not Null References InspVeiculo(InspVeiculo_ID),
-- A DEFINIR
)
GO
*/

--------------------------------------------------------------------------------
-- InspLote - Lotes de veículos (a definir)
--------------------------------------------------------------------------------
/*
Create Table InspLote (
-- A DEFINIR
)
GO
*/

--------------------------------------------------------------------------------
-- Lista - Packing-list e Load-list
--------------------------------------------------------------------------------
Create Table ListaVeiculos (
  ListaVeiculos_ID   Int Not Null Identity Primary Key,
  Cliente_ID         Int Not Null References Cliente(Cliente_ID),
  Usuario_ID         Int  Not Null References Usuario(Usuario_ID),  -- Identificação do usuário que incluiu os dados do arquivo na base de dados
  NomeArquivo        Varchar(50)   Not Null,  -- Nome do arquivo sem as pastas
  DataHoraInclusao   SmallDateTime Not Null Default GetDate()  -- Data e hora da inclusão do arquivo na base de dados
)
GO

--------------------------------------------------------------------------------
-- ListaVeiculosVin - Packing-list e Load-list - veículos
--------------------------------------------------------------------------------
Create Table ListaVeiculosVin (
  ListaVeiculosVin_ID Int Not Null Identity Primary Key,
  ListaVeiculos_ID    Int Not Null References Cliente(Cliente_ID),
  VIN                 Char(17) Not Null,          -- Chassi completo
  VIN_6               AS Right(VIN, 6) PERSISTED  -- Últimos seis caracteres do chassi
)
GO

-- FIM
