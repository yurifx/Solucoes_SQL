USE [VDT2] 
GO

ALTER TABLE ListaVeiculos
  Add  LocalInspecao_ID     Int NOT NULL
	  ,Tipo                 Char (1) NOT NULL
GO