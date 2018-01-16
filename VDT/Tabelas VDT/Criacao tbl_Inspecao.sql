Drop Table Inspecao
CREATE TABLE Inspecao(
    Inspecao_ID int not null,
    Cliente_ID  int not null references Cliente(Cliente_ID),
    LocalInspecao_ID int not null references LocalInspecao(LocalInspecao_ID),
    LocalCheckPoint_ID int not null references LocalCheckPoint(LocalCheckPoint_ID),
    Transportador_ID int not null references Transportador (Transportador_ID),
    FrotaViagem_ID int not null references FrotaViagem(FrotaViagem_ID),
    Navio int references Navio(Navio_ID),
    Usuario_ID int not null references Usuario(Usuario_ID),
    Data DateTime not null,
    Publicado int not null default 0,
    PublicadoData datetime,
    PublicadoPor int references Usuario(Usuario_ID)
)
