USE [pc_sisfrota]
GO

/****** Object:  Table [dbo].[SIAP]    Script Date: 02/20/2015 10:20:01 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

CREATE TABLE [dbo].[SIAP](
	[RG] [varchar](15) NOT NULL,
	[Nome] [varchar](255) NULL,
	[Delegacia] [int] NULL,
	[Unidade] [int] NULL,
	[Divisao] [int] NULL,
 CONSTRAINT [PK_SIAP] PRIMARY KEY CLUSTERED 
(
	[RG] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO

