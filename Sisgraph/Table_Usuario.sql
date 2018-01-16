USE [pc_sisfrota]
GO

/****** Object:  Table [dbo].[seg02_usuario]    Script Date: 02/20/2015 10:19:49 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

CREATE TABLE [dbo].[seg02_usuario](
	[SEG02_CODUSUARIO] [int] NOT NULL,
	[SEG02_LOGIN] [varchar](12) NULL,
	[SEG02_NOME] [varchar](200) NULL,
	[SEG02_GRAUSIGILO] [int] NULL,
	[SEG02_NIVEL] [int] NULL,
	[SEG02_PERFIL] [int] NULL,
	[SEG02_SENHA] [varchar](9) NULL,
	[SEG02_RG] [int] NULL,
	[BAS09_UNIDADE] [varchar](90) NULL,
	[BAS08_DIVISAO] [varchar](60) NULL,
	[BAS08_DELEGACIA] [varchar](90) NULL,
	[SEG02_DATAINC] [datetime] NULL,
	[SEG02_USUARIOINC] [varchar](50) NULL,
	[SEG02_IPMAQINC] [varchar](50) NULL,
	[SEG02_DATAATUALIZA] [datetime] NULL,
	[SEG02_USUARIOATUALIZA] [varchar](50) NULL,
	[SEG02_IPMAQATUALIZA] [varchar](50) NULL
) ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO

