If  Exists (Select Name
            From   sysobjects
            Where  Name = 'ListaVeiculos_Sel' and type = 'P')
    Drop Procedure dbo.ListaVeiculos_Sel
GO

Create Procedure dbo.ListaVeiculos_Sel
----------------------------------------------------------------------------------------------------
-- Consulta os dados de uma lista de veículos (packing list ou loading list)
----------------------------------------------------------------------------------------------------
(
@p_ListaVeiculos_ID Int
)
AS

SET NOCOUNT ON

Select l.ListaVeiculos_ID,
       l.Cliente_ID,
       l.Usuario_ID,
       l.NomeArquivo,
       l.DataHoraInclusao,

       c.Nome             as ClienteNome,
       u.Nome             as UsuarioNome

From       ListaVeiculos l
Inner Join Cliente       c on l.Cliente_ID = c.Cliente_ID
Inner Join Usuario       u on l.Usuario_ID = u.Usuario_ID

Where l.ListaVeiculos_ID = @p_ListaVeiculos_ID

GO

/*
EXEC ListaVeiculos_Sel @p_ListaVeiculos_ID = 1
*/

-- FIM
