USE [VDT2] 
GO

ALTER TABLE ListaVeiculos
  ADD  LocalInspecao_ID     INT NOT NULL
	  ,Tipo                 CHAR (1) NOT NULL
GO