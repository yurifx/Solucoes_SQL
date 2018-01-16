USE [pc_sisfrota]
GO

/****** Object:  Table [dbo].[bas69_viaturas]    Script Date: 02/20/2015 10:19:36 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

CREATE TABLE [dbo].[bas69_viaturas](
	[BAS69_CodViatura] [int] NOT NULL,
	[BAS09_Unidade] [varchar](60) NULL,
	[BAS08_Delegacia] [varchar](60) NULL,
	[BAS09_Divisao] [varchar](60) NULL,
	[BAS69_Patrimonio] [int] NULL,
	[BAS69_Caracterizada] [varchar](3) NULL,
	[BAS69_Radio] [varchar](3) NULL,
	[BAS69_Combustivel] [varchar](20) NULL,
	[BAS69_Grupo] [varchar](3) NULL,
	[BAS69_AnoFab] [int] NULL,
	[BAS64_VeicMarca] [varchar](50) NULL,
	[BAS64_VeicModelo] [varchar](50) NULL,
	[BAS39_VeicCor] [varchar](20) NULL,
	[BAS69_RENAVAM] [int] NULL,
	[BAS69_RadioPatrimonio] [int] NULL,
	[BAS69_Computador] [varchar](3) NULL,
	[BAS69_GPS] [varchar](3) NULL,
	[BAS69_Camera] [varchar](3) NULL,
	[BAS69_OutrosEquipamentos] [varchar](90) NULL,
	[BAS69_Chassi] [varchar](50) NULL,
	[BAS69_Placas] [varchar](7) NULL,
	[BAS69_Cidade] [varchar](50) NULL,
	[BAS69_UF] [varchar](2) NULL,
	[BAS69_PlacasRes] [varchar](7) NULL,
	[BAS69_CidadeDel] [varchar](50) NULL,
	[BAS69_UF1] [varchar](2) NULL,
	[BAS69_Situacao] [varchar](50) NULL,
	[BAS69_Observacao] [text] NULL,
	[BAS69_DataInc] [varchar](50) NULL,
	[BAS69_UsuarioInc] [varchar](50) NULL,
	[BAS69_IPMaquinaInc] [varchar](50) NULL,
	[BAS69_DataAtualiza] [varchar](50) NULL,
	[BAS69_UsuarioAtualiza] [varchar](50) NULL,
	[BAS69_IPMaquinaAtualiza] [varchar](50) NULL,
	[cod_siap] [int] NULL,
	[tempSiap] [int] NOT NULL,
	[BAS69_KMAtual] [int] NOT NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO

ALTER TABLE [dbo].[bas69_viaturas] ADD  CONSTRAINT [DF__bas69_via__BAS09__7F60ED59]  DEFAULT (NULL) FOR [BAS09_Unidade]
GO

ALTER TABLE [dbo].[bas69_viaturas] ADD  CONSTRAINT [DF__bas69_via__BAS08__00551192]  DEFAULT (NULL) FOR [BAS08_Delegacia]
GO

ALTER TABLE [dbo].[bas69_viaturas] ADD  CONSTRAINT [DF__bas69_via__BAS09__014935CB]  DEFAULT (NULL) FOR [BAS09_Divisao]
GO

ALTER TABLE [dbo].[bas69_viaturas] ADD  CONSTRAINT [DF__bas69_via__BAS69__023D5A04]  DEFAULT ((0)) FOR [BAS69_Patrimonio]
GO

ALTER TABLE [dbo].[bas69_viaturas] ADD  CONSTRAINT [DF__bas69_via__BAS69__03317E3D]  DEFAULT (NULL) FOR [BAS69_Caracterizada]
GO

ALTER TABLE [dbo].[bas69_viaturas] ADD  CONSTRAINT [DF__bas69_via__BAS69__0425A276]  DEFAULT (NULL) FOR [BAS69_Radio]
GO

ALTER TABLE [dbo].[bas69_viaturas] ADD  CONSTRAINT [DF__bas69_via__BAS69__0519C6AF]  DEFAULT (NULL) FOR [BAS69_Combustivel]
GO

ALTER TABLE [dbo].[bas69_viaturas] ADD  CONSTRAINT [DF__bas69_via__BAS69__060DEAE8]  DEFAULT (NULL) FOR [BAS69_Grupo]
GO

ALTER TABLE [dbo].[bas69_viaturas] ADD  CONSTRAINT [DF__bas69_via__BAS69__07020F21]  DEFAULT ((0)) FOR [BAS69_AnoFab]
GO

ALTER TABLE [dbo].[bas69_viaturas] ADD  CONSTRAINT [DF__bas69_via__BAS64__07F6335A]  DEFAULT (NULL) FOR [BAS64_VeicMarca]
GO

ALTER TABLE [dbo].[bas69_viaturas] ADD  CONSTRAINT [DF__bas69_via__BAS64__08EA5793]  DEFAULT (NULL) FOR [BAS64_VeicModelo]
GO

ALTER TABLE [dbo].[bas69_viaturas] ADD  CONSTRAINT [DF__bas69_via__BAS39__09DE7BCC]  DEFAULT (NULL) FOR [BAS39_VeicCor]
GO

ALTER TABLE [dbo].[bas69_viaturas] ADD  CONSTRAINT [DF__bas69_via__BAS69__0AD2A005]  DEFAULT (NULL) FOR [BAS69_RENAVAM]
GO

ALTER TABLE [dbo].[bas69_viaturas] ADD  CONSTRAINT [DF__bas69_via__BAS69__0BC6C43E]  DEFAULT (NULL) FOR [BAS69_RadioPatrimonio]
GO

ALTER TABLE [dbo].[bas69_viaturas] ADD  CONSTRAINT [DF__bas69_via__BAS69__0CBAE877]  DEFAULT (NULL) FOR [BAS69_Computador]
GO

ALTER TABLE [dbo].[bas69_viaturas] ADD  CONSTRAINT [DF__bas69_via__BAS69__0DAF0CB0]  DEFAULT (NULL) FOR [BAS69_GPS]
GO

ALTER TABLE [dbo].[bas69_viaturas] ADD  CONSTRAINT [DF__bas69_via__BAS69__0EA330E9]  DEFAULT (NULL) FOR [BAS69_Camera]
GO

ALTER TABLE [dbo].[bas69_viaturas] ADD  CONSTRAINT [DF__bas69_via__BAS69__0F975522]  DEFAULT (NULL) FOR [BAS69_OutrosEquipamentos]
GO

ALTER TABLE [dbo].[bas69_viaturas] ADD  CONSTRAINT [DF__bas69_via__BAS69__108B795B]  DEFAULT (NULL) FOR [BAS69_Chassi]
GO

ALTER TABLE [dbo].[bas69_viaturas] ADD  CONSTRAINT [DF__bas69_via__BAS69__117F9D94]  DEFAULT (NULL) FOR [BAS69_Placas]
GO

ALTER TABLE [dbo].[bas69_viaturas] ADD  CONSTRAINT [DF__bas69_via__BAS69__1273C1CD]  DEFAULT (NULL) FOR [BAS69_Cidade]
GO

ALTER TABLE [dbo].[bas69_viaturas] ADD  CONSTRAINT [DF__bas69_via__BAS69__1367E606]  DEFAULT (NULL) FOR [BAS69_UF]
GO

ALTER TABLE [dbo].[bas69_viaturas] ADD  CONSTRAINT [DF__bas69_via__BAS69__145C0A3F]  DEFAULT (NULL) FOR [BAS69_PlacasRes]
GO

ALTER TABLE [dbo].[bas69_viaturas] ADD  CONSTRAINT [DF__bas69_via__BAS69__15502E78]  DEFAULT (NULL) FOR [BAS69_CidadeDel]
GO

ALTER TABLE [dbo].[bas69_viaturas] ADD  CONSTRAINT [DF__bas69_via__BAS69__164452B1]  DEFAULT (NULL) FOR [BAS69_UF1]
GO

ALTER TABLE [dbo].[bas69_viaturas] ADD  CONSTRAINT [DF__bas69_via__BAS69__173876EA]  DEFAULT (NULL) FOR [BAS69_Situacao]
GO

ALTER TABLE [dbo].[bas69_viaturas] ADD  CONSTRAINT [DF__bas69_via__BAS69__182C9B23]  DEFAULT (NULL) FOR [BAS69_DataInc]
GO

ALTER TABLE [dbo].[bas69_viaturas] ADD  CONSTRAINT [DF__bas69_via__BAS69__1920BF5C]  DEFAULT (NULL) FOR [BAS69_UsuarioInc]
GO

ALTER TABLE [dbo].[bas69_viaturas] ADD  CONSTRAINT [DF__bas69_via__BAS69__1A14E395]  DEFAULT (NULL) FOR [BAS69_IPMaquinaInc]
GO

ALTER TABLE [dbo].[bas69_viaturas] ADD  CONSTRAINT [DF__bas69_via__BAS69__1B0907CE]  DEFAULT (NULL) FOR [BAS69_DataAtualiza]
GO

ALTER TABLE [dbo].[bas69_viaturas] ADD  CONSTRAINT [DF__bas69_via__BAS69__1BFD2C07]  DEFAULT (NULL) FOR [BAS69_UsuarioAtualiza]
GO

ALTER TABLE [dbo].[bas69_viaturas] ADD  CONSTRAINT [DF__bas69_via__BAS69__1CF15040]  DEFAULT (NULL) FOR [BAS69_IPMaquinaAtualiza]
GO

ALTER TABLE [dbo].[bas69_viaturas] ADD  CONSTRAINT [DF__bas69_via__cod_s__1DE57479]  DEFAULT ((0)) FOR [cod_siap]
GO

ALTER TABLE [dbo].[bas69_viaturas] ADD  CONSTRAINT [DF__bas69_via__tempS__1ED998B2]  DEFAULT ((0)) FOR [tempSiap]
GO

ALTER TABLE [dbo].[bas69_viaturas] ADD  CONSTRAINT [DF__bas69_via__BAS69__681373AD]  DEFAULT ((0)) FOR [BAS69_KMAtual]
GO

