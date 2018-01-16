USE [pc_sisfrota]
GO

/****** Object:  Table [dbo].[tal_numeracao]    Script Date: 02/20/2015 10:20:15 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[tal_numeracao](
	[id] [smallint] NOT NULL,
	[dt_base] [smalldatetime] NOT NULL,
	[nr_controle] [int] NOT NULL,
	[rowid] [nchar](10) NULL,
 CONSTRAINT [PK_talao_numeracao] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

