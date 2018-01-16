--------------------------------------------------------------------------------
-- spCargaBA01_SeparaColunas.sql
-- Data   : 20/08/2013
-- Autor  : Amauri
-- Stored procedure de carga inicial de arquivos BA01 
-- Apenas separa as colunas de uma linha
--------------------------------------------------------------------------------

USE ArquivosAvon
GO

Create Procedure CargaBA01_SeparaColunas
(
  @pCargaInicial_ID   Int,
  @pModeloLayout      Int           OUTPUT,  -- '1'=Sem sub-transação '2'=Com sub-transação
  @pDataMovimento     SmallDateTime OUTPUT,
  @pUltimaLinha       Bit           OUTPUT
)
AS

Set NoCount ON

Declare @Dados Varchar(4000)
Select  @Dados = Dados From CargaInicial (nolock) Where CargaInicial_ID = @pCargaInicial_ID

Set @pUltimaLinha = 0

If @Dados Is Null
   RETURN 0 -- A linha não contém valores
   
Set @Dados = RTrim(@Dados)
If Len(@Dados) < 55   
   RETURN 0 -- A linha não contém valores

-- Extrai a data do movimento
If @pDataMovimento Is Null Begin
   If @Dados Like '%DIARIO  DO  DIA%' Begin
      Declare @AuxDataMovimento Varchar(10)
      Set     @AuxDataMovimento = SubString(@Dados, 33, 10)
      Set     @pDataMovimento   = Convert ( SmallDateTime, @AuxDataMovimento, 103) -- dd/mm/yyyy
      RETURN 0 -- A linha não contém valores
   End
End

Declare @PrimeiroCaractere Char(1)
Set     @PrimeiroCaractere = Left(@Dados,1)

-- Verifica o modelo de lay-out
If @pModeloLayout Is Null Begin
   If @PrimeiroCaractere = '0' and @Dados Like '%MOVIMENTO%' Begin
      If @Dados Like '%SUB%' Begin
         Set @pModeloLayout = '2' -- Com sub-transação
      End
      Else Begin
         Set @pModeloLayout = '1' -- Sem sub-transação
      End
      RETURN 0 -- A linha não contém valores
   End
End

-- Verifica se é a última linha útil do arquivo
If @PrimeiroCaractere = '0' and @Dados Like '%TOTAL GERAL%' Begin
   Set @pUltimaLinha = 1
   RETURN 0 -- A linha não contém valores
End
 
-- Verifica se é uma linha útil
If @PrimeiroCaractere in ('0', '1', '2', '-')  or  @Dados Like '%SETOR%'  or  @Dados Like '%DIARIO%' Begin
   RETURN 0 -- A linha não contém valores
End

-- Extrai os dados da linha útil
Insert Into CargaInicialBA01 ( ModeloLayout,
                               DebCred,
                               Setor,
                               RegAsc,
                               CampanhaNro,
                               CampanhaAno,
                               NroDocumento,
                               Transacao,
                               SubTransacao,
                               Debito,
                               Credito )   
                               
Select @pModeloLayout,
       LTrim(RTrim(Substring(@Dados, 6,   1)))  as DebCred,
       LTrim(RTrim(Substring(@Dados, 9,   3)))  as Setor,
       LTrim(RTrim(Substring(@Dados, 14,  8)))  as RegAsc,
       LTrim(RTrim(Substring(@Dados, 25,  2)))  as CampanhaNro,
       LTrim(RTrim(Substring(@Dados, 28,  4)))  as CampanhaAno,
       LTrim(RTrim(Substring(@Dados, 33,  7)))  as NroDocumento,
       LTrim(RTrim(Substring(@Dados, 42,  3)))  as Transacao,
       LTrim(RTrim(Substring(@Dados, 46,  3)))  as SubTransacao,
       LTrim(RTrim(Substring(@Dados, 50, 14)))  as Debito,
       LTrim(RTrim(Substring(@Dados, 65, 14)))  as Credito                                         

--From   CargaInicial (nolock)
--Where  CargaInicial_ID = @pCargaInicial_ID

RETURN 1 -- A linha contém valores
-- FIM
