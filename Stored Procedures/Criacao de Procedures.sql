use TESTE_BANCO
go

create procedure teste (@p1 int, @p2 varchar(20))
AS
(
select * from A
)

use TESTE_BANCO
create table A(a int, b varchar (20))



exec teste 1,'haha'



USE TESTE_BANCO
GO

Create Procedure [dbo].[ProcedureTeste]
----------------------------------------------------------------------------------------------------
-- Lista todas informações da tabela A
----------------------------------------------------------------------------------------------------
(
@p_Parametro1  Int, --Primeiro parametro passado
@p_Parametro2  VarChar(2) -- Segundo parametro passado
)
AS

SELECT * from A



exec ProcedureTeste(1)



--Exemplo real
USE [VDT2]
GO

/****** Object:  StoredProcedure [dbo].[Cliente_Lst]    Script Date: 04/04/2017 12:24:03 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


Create Procedure [dbo].[Cliente_Lst]
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



