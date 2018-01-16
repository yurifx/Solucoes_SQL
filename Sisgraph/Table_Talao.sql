USE [pc_sisfrota]
GO

/****** Object:  Table [dbo].[vtr06_talao]    Script Date: 02/20/2015 10:20:25 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

CREATE TABLE [dbo].[vtr06_talao](
	[VTR06_CodTalao] [int] NOT NULL,
	[BAS69_Patrimonio] [int] NULL,
	[VTR06_Prefixo] [varchar](45) NULL,
	[VTR06_DataAbertura] [varchar](50) NULL,
	[VTR06_KmInicial] [int] NULL,
	[VTR06_Cabine] [decimal](10, 0) NULL,
	[VTR06_Talao] [int] NULL,
	[VTR06_TalaoNatureza] [varchar](max) NULL,
	[VTR06_Area] [varchar](max) NULL,
	[VTR06_Componentes] [varchar](max) NULL,
	[VTR06_Ocorrencias] [text] NULL,
	[VTR06_DataEncerramento] [varchar](50) NULL,
	[VTR06_KmFinal] [int] NULL,
	[VTR06_DataInc] [varchar](50) NULL,
	[VTR06_UsuarioInc] [varchar](90) NULL,
	[VTR06_IPMaquinaInc] [varchar](45) NULL,
	[VTR06_DataAtualiza] [varchar](50) NULL,
	[VTR06_UsuarioAtualiza] [varchar](90) NULL,
	[VTR06_IPMaquinaAtualiza] [varchar](45) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO

ALTER TABLE [dbo].[vtr06_talao] ADD  CONSTRAINT [DF__vtr06_tal__BBAS6__1FCDBCEB]  DEFAULT (NULL) FOR [BAS69_Patrimonio]
GO

ALTER TABLE [dbo].[vtr06_talao] ADD  CONSTRAINT [DF__vtr06_tal__VTR06__20C1E124]  DEFAULT (NULL) FOR [VTR06_Prefixo]
GO

ALTER TABLE [dbo].[vtr06_talao] ADD  CONSTRAINT [DF__vtr06_tal__VTR06__21B6055D]  DEFAULT (NULL) FOR [VTR06_DataAbertura]
GO

ALTER TABLE [dbo].[vtr06_talao] ADD  CONSTRAINT [DF__vtr06_tal__VTR06__22AA2996]  DEFAULT (NULL) FOR [VTR06_KmInicial]
GO

ALTER TABLE [dbo].[vtr06_talao] ADD  CONSTRAINT [DF__vtr06_tal__VTR06__239E4DCF]  DEFAULT (NULL) FOR [VTR06_Cabine]
GO

ALTER TABLE [dbo].[vtr06_talao] ADD  CONSTRAINT [DF__vtr06_tal__VTR06__24927208]  DEFAULT (NULL) FOR [VTR06_Talao]
GO

ALTER TABLE [dbo].[vtr06_talao] ADD  CONSTRAINT [DF__vtr06_tal__VTR06__25869641]  DEFAULT (NULL) FOR [VTR06_DataEncerramento]
GO

ALTER TABLE [dbo].[vtr06_talao] ADD  CONSTRAINT [DF__vtr06_tal__VTR06__267ABA7A]  DEFAULT (NULL) FOR [VTR06_KmFinal]
GO

ALTER TABLE [dbo].[vtr06_talao] ADD  CONSTRAINT [DF__vtr06_tal__VTR06__276EDEB3]  DEFAULT (NULL) FOR [VTR06_DataInc]
GO

ALTER TABLE [dbo].[vtr06_talao] ADD  CONSTRAINT [DF__vtr06_tal__VTR06__286302EC]  DEFAULT (NULL) FOR [VTR06_UsuarioInc]
GO

ALTER TABLE [dbo].[vtr06_talao] ADD  CONSTRAINT [DF__vtr06_tal__VTR06__29572725]  DEFAULT (NULL) FOR [VTR06_IPMaquinaInc]
GO

ALTER TABLE [dbo].[vtr06_talao] ADD  CONSTRAINT [DF__vtr06_tal__VTR06__2A4B4B5E]  DEFAULT (NULL) FOR [VTR06_DataAtualiza]
GO

ALTER TABLE [dbo].[vtr06_talao] ADD  CONSTRAINT [DF__vtr06_tal__VTR06__2B3F6F97]  DEFAULT (NULL) FOR [VTR06_UsuarioAtualiza]
GO

ALTER TABLE [dbo].[vtr06_talao] ADD  CONSTRAINT [DF__vtr06_tal__VTR06__2C3393D0]  DEFAULT (NULL) FOR [VTR06_IPMaquinaAtualiza]
GO

