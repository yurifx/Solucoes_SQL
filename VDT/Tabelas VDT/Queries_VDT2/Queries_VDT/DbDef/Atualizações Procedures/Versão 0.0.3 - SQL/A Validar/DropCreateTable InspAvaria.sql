USE [VDT2]
Drop Table InspAvaria
GO
Create Table InspAvaria (
  InspAvaria_ID      Int  Not Null Identity Primary Key,
  InspVeiculo_ID     Int  Not Null References InspVeiculo(InspVeiculo_ID),

  AvArea_ID          Int  Not Null References AvArea(AvArea_ID),
  AvDano_ID          Int  Not Null References AvDano(AvDano_ID),
  AvSeveridade_ID    Int  Not Null References AvSeveridade(AvSeveridade_ID),
  AvQuadrante_ID     Int  Not Null References AvQuadrante(AvQuadrante_ID),
  AvGravidade_ID     Int  Not Null References AvGravidade(AvGravidade_ID),
  AvCondicao_ID      Int  Not Null References AvCondicao(AvCondicao_ID),

  FabricaTransporte  Char(1) Not Null, -- F: Defeito de Fábrica  T:Avaria de Transporte
  DanoOrigem         Bit Not Null Default 0
)
GO


