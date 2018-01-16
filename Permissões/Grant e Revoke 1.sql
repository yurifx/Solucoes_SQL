--Teste grant e revoke
use MeuBanco
GRANT INSERT ON MinhaTabela to LoginJP;
REVOKE SELECT ON MinhaTabela TO LoginJP;
-- The SELECT permission was denied on the object 'MinhaTabela', database 'MeuBanco', schema 'dbo'.
-- NO INSERT   (1 row(s) affected)

