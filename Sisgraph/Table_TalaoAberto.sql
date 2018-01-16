USE [pc_sisfrota]
GO

/****** Object:  Table [dbo].[vtr06_talaoaberto]    Script Date: 02/20/2015 10:20:38 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

CREATE TABLE [dbo].[vtr06_talaoaberto](
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

ALTER TABLE [dbo].[vtr06_talaoaberto] ADD  CONSTRAINT [DF_vtr06_talaoaberto_BAS69_Patrimonio]  DEFAULT (NULL) FOR [BAS69_Patrimonio]
GO

ALTER TABLE [dbo].[vtr06_talaoaberto] ADD  CONSTRAINT [DF_vtr06_talaoaberto_VTR06_Prefixo]  DEFAULT (NULL) FOR [VTR06_Prefixo]
GO

ALTER TABLE [dbo].[vtr06_talaoaberto] ADD  CONSTRAINT [DF_vtr06_talaoaberto_VTR06_DataAbertura]  DEFAULT (NULL) FOR [VTR06_DataAbertura]
GO

ALTER TABLE [dbo].[vtr06_talaoaberto] ADD  CONSTRAINT [DF_vtr06_talaoaberto_VTR06_KmInicial]  DEFAULT (NULL) FOR [VTR06_KmInicial]
GO

ALTER TABLE [dbo].[vtr06_talaoaberto] ADD  CONSTRAINT [DF_vtr06_talaoaberto_VTR06_Cabine]  DEFAULT (NULL) FOR [VTR06_Cabine]
GO

ALTER TABLE [dbo].[vtr06_talaoaberto] ADD  CONSTRAINT [DF_vtr06_talaoaberto_VTR06_Talao]  DEFAULT (NULL) FOR [VTR06_Talao]
GO

ALTER TABLE [dbo].[vtr06_talaoaberto] ADD  CONSTRAINT [DF_vtr06_talaoaberto_VTR06_DataEncerramento]  DEFAULT (NULL) FOR [VTR06_DataEncerramento]
GO

ALTER TABLE [dbo].[vtr06_talaoaberto] ADD  CONSTRAINT [DF_vtr06_talaoaberto_VTR06_KmFinal]  DEFAULT (NULL) FOR [VTR06_KmFinal]
GO

ALTER TABLE [dbo].[vtr06_talaoaberto] ADD  CONSTRAINT [DF_vtr06_talaoaberto_VTR06_DataInc]  DEFAULT (NULL) FOR [VTR06_DataInc]
GO

ALTER TABLE [dbo].[vtr06_talaoaberto] ADD  CONSTRAINT [DF_vtr06_talaoaberto_VTR06_UsuarioInc]  DEFAULT (NULL) FOR [VTR06_UsuarioInc]
GO

ALTER TABLE [dbo].[vtr06_talaoaberto] ADD  CONSTRAINT [DF_vtr06_talaoaberto_VTR06_IPMaquinaInc]  DEFAULT (NULL) FOR [VTR06_IPMaquinaInc]
GO

ALTER TABLE [dbo].[vtr06_talaoaberto] ADD  CONSTRAINT [DF_vtr06_talaoaberto_VTR06_DataAtualiza]  DEFAULT (NULL) FOR [VTR06_DataAtualiza]
GO

ALTER TABLE [dbo].[vtr06_talaoaberto] ADD  CONSTRAINT [DF_vtr06_talaoaberto_VTR06_UsuarioAtualiza]  DEFAULT (NULL) FOR [VTR06_UsuarioAtualiza]
GO

ALTER TABLE [dbo].[vtr06_talaoaberto] ADD  CONSTRAINT [DF_vtr06_talaoaberto_VTR06_IPMaquinaAtualiza]  DEFAULT (NULL) FOR [VTR06_IPMaquinaAtualiza]
GO

