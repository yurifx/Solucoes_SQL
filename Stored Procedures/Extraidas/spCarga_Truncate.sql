--------------------------------------------------------------------------------
-- spCarga_Truncate.sql
-- Data   : 19/08/2013
-- Autor  : Amauri Rodrigues
-- Stored procedure para esvaziar as tabelas de carga de dados
--------------------------------------------------------------------------------

USE ArquivosAvon
GO

Alter Procedure Carga_Truncate
AS

Truncate Table CargaInicial

Truncate Table CargaInicialCS28
Truncate Table ConversaoCS28

/*
Truncate Table CargaInicialCS48
Truncate Table ConversaoCS48

Truncate Table CargaInicialCS13
Truncate Table ConversaoCS13

Truncate Table CargaInicialFS1
Truncate Table ConversaoFS1

Truncate Table CargaInicialFS22
Truncate Table ConversaoFS22

Truncate Table CargaInicialFS23
Truncate Table ConversaoFS23

Truncate Table CargaInicialFS3
Truncate Table ConversaoFS3

Truncate Table CargaInicialPP28
Truncate Table ConversaoPP28

Truncate Table CargaInicialPP37_Carga
Truncate Table ConversaoPP37_Carga

Truncate Table CargaInicialPP37_Cadastro
Truncate Table ConversaoPP37_Cadastro

Truncate Table CargaInicialBA01
Truncate Table ConversaoBA01
*/

-- FIM
