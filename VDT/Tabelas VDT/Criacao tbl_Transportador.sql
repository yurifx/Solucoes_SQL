DROP TABLE Transportador
    CREATE TABLE Transportador
(
    Transportador_ID int not null identity,
    Nome varchar(100),
    Tipo Char,
    Ativo bit not null default 0
)