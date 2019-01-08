select a.codfil, a.IMPRSEPARARETDEP , b.descricao
from cad_filial_compl a, cad_impressora b
where 1 = 1
and a.codfil in (26,526)
and a.imprsepararetdep = b.codimpr
