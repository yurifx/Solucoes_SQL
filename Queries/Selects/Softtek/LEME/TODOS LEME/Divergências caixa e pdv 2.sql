select a.codfil, a.numcxa, b.enderecoip, a.dtnota dtnota, Sum(a.VLTOTAL) VlrMS, b.VLCONT VlrPDV, abs(sum(a.VLTOTAL) - nvl(b.VLCONT,0)) Div
from mov_saida a, PDV_FISCAL b, cad_filial f
where a.codfil = b.codfil(+)
and a.filped = f.codfil
and a.numcxa = b.pdv(+)
and a.dtnota = b.data(+)and b.tipo(+) = 'F'and a.tpnota = 512 and a.status <> 9and a.codfil not in (6,14,519)--and a.codfil in (12,512)18
and a.serie not in ('1','2','3','4','5')
--and a.numcxa in (42
and a.DTNOTA between '01/07/2015' and '21/07/2015'
group by a.codfil, a.DTNOTA, a.numcxa, b.enderecoip, b.VLCONT
having abs(sum(a.VLTOTAL) - nvl(b.VLCONT,0))> 1.0
union
--N�O EXISTE NA MOV_SAIDA
select b.codfil, b.pdv numcxa, b.enderecoip, b.data dtnota, 0 VlrMS,b.Vlcont VlrPDV, b.Vlcont Div
from PDV_FISCAL b
where 
--b.codfil in (12,512) AND 25
--and B.PDV in (42)3
b.data between '01/07/2015' and '21/07/2015'and b.tipo = 'F'
AND b.Vlcont > 0
and not exists(select 'x' from mov_saida a
where
a.CODFIL = b.codfil
and a.numcxa = b.pdv
and a.dtnota = b.data
and a.tpnota = 512
and a.status <> 9
and a.codfil not in (6,14,519)
and a.DTNOTA between b.data and b.data)     -----17 Registros 21/05/2012.
