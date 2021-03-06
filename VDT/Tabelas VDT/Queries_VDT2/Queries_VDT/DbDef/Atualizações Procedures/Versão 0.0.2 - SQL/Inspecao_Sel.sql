If  Exists (Select Name
            From   sysobjects
            Where  Name = 'Inspecao_Sel' and type = 'P')
    Drop Procedure dbo.Inspecao_Sel
GO

Create Procedure dbo.Inspecao_Sel
----------------------------------------------------------------------------------------------------
-- Consulta os dados gerais de uma inspeção
-- Atualização Yuri - 05/03/2017 -  Adicionar o campo Cliente_ID
-- Atualização Yuri - 07/03/2017 -  Adicionar Left Join no Navio
----------------------------------------------------------------------------------------------------
(
@p_Inspecao_ID Int
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
Left Join  Navio           n on i.Navio_ID           = n.Navio_ID
Inner Join Usuario         u on i.Usuario_ID         = u.Usuario_ID

Where i.Inspecao_ID = @p_Inspecao_ID

GO

-- FIM
