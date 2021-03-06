USE [VDT2]
GO

Drop Table ListaVeiculosVin
GO

Create Table ListaVeiculosVin (
  ListaVeiculosVin_ID Int Not Null Identity Primary Key,
  ListaVeiculos_ID    Int Not Null References ListaVeiculos(ListaVeiculos_ID),
  VIN                 Char(17) Not Null,          -- Chassi completo
  VIN_6               AS Right(VIN, 6) PERSISTED  -- �ltimos seis caracteres do chassi
)
GO

