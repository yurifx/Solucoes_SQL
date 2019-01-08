If  Exists (Select Name
            From   sysobjects
            Where  Name = 'Inspecao_Lst' and type = 'P')
    Drop Procedure dbo.Inspecao_Lst
GO

Create Procedure dbo.Inspecao_Lst
----------------------------------------------------------------------------------------------------
-- Lista as inspeções
----------------------------------------------------------------------------------------------------
(
@p_Cliente_ID         Int,
@p_LocalInspecao_ID   Int,
@p_LocalCheckPoint_ID Int,
@p_Data               Date -- Data da inspeção
)
AS

SET NOCOUNT ON

Select i.Inspecao_ID,
       i.Cliente_ID,
       i.LocalInspecao_ID,
       i.LocalCheckPoint_ID,
       i.Transportador_ID,
       i.FrotaViagem_ID,
       i.Navio_ID,
       i.Usuario_ID,           -- Identificação do inspetor
       i.Data,                 -- Data da inspeção

       c.Nome            as ClienteNome,
       l.Nome            as LocalInspecaoNome,

       p.Codigo          as LocalCheckPointCodigo,
       p.Nome_Pt         as LocalCheckPointNome_Pt,
       p.Nome_En         as LocalCheckPointNome_En,
       p.Nome_Es         as LocalCheckPointNome_Es,
       p.Operacao        as LocalCheckPointOperacao,

       t.Nome            as TransportadorNome,
       t.Tipo            as TransportadorTipo,

       f.Nome            as FrotaViagemNome,

       n.Nome            as NavioNome,

       u.Login           as UsuarioLogin,
       u.Nome            as UsuarioNome

From       Inspecao        i
Inner Join Cliente         c on i.Cliente_ID         = c.Cliente_ID
Inner Join LocalInspecao   l on i.LocalInspecao_ID   = l.LocalInspecao_ID
Inner Join LocalCheckPoint p on i.LocalCheckPoint_ID = p.LocalCheckPoint_ID
Inner Join Transportador   t on i.Transportador_ID   = t.Transportador_ID
Inner Join FrotaViagem     f on i.FrotaViagem_ID     = f.FrotaViagem_ID
Inner Join Navio           n on i.Navio_ID           = n.Navio_ID
Inner Join Usuario         u on i.Usuario_ID         = u.Usuario_ID

Where i.Cliente_ID         = @p_Cliente_ID
 and  i.LocalInspecao_ID   = @p_LocalInspecao_ID
 and  i.LocalCheckPoint_ID = @p_LocalCheckPoint_ID
 and  i.Data               = @p_Data

Order by i.Data, l.Nome, i.LocalInspecao_ID
GO

/*
EXEC Inspecao_Lst @p_Cliente_ID         = 1,
                  @p_LocalInspecao_ID   = 1,
                  @p_LocalCheckPoint_ID = 1,
                  @p_Data               = '2017-03-01'
*/

-- FIM
