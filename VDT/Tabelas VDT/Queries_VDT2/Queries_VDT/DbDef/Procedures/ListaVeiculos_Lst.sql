If  Exists (Select Name
            From   sysobjects
            Where  Name = 'ListaVeiculos_Lst' and type = 'P')
    Drop Procedure dbo.ListaVeiculos_Lst
GO

Create Procedure dbo.ListaVeiculos_Lst
----------------------------------------------------------------------------------------------------
-- Lista as 'lista de veículos' (packing list ou loading list)
----------------------------------------------------------------------------------------------------
(
@p_Cliente_ID           Int,   -- NULL: todos os clientes
@p_DataHoraInclusao_Ini Date,
@p_DataHoraInclusao_Fim Date
)
AS

SET NOCOUNT ON

Set @p_DataHoraInclusao_Fim = DateAdd(d, 1, @p_DataHoraInclusao_Fim)

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

Where ( @p_Cliente_ID Is Null  or  l.Cliente_ID = @p_Cliente_ID )

 and  l.DataHoraInclusao  >=  @p_DataHoraInclusao_Ini
 and  l.DataHoraInclusao  <   @p_DataHoraInclusao_Fim

GO

/*
EXEC ListaVeiculos_Lst @p_Cliente_ID           = 1,
                       @p_DataHoraInclusao_Ini = '2017-02-01',
                       @p_DataHoraInclusao_Fim = '2017-03-31'
*/

-- FIM
