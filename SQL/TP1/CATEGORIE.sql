USE [stri16]
GO
/****** Objet :  Table [dbo].[CATEGORIE]    Date de génération du script : 09/24/2015 14:13:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[CATEGORIE](
	[Id_cat] [char](10) NOT NULL,
	[Nom_cat] [varchar](50) NOT NULL,
 CONSTRAINT [IX_CATEGORIE] UNIQUE NONCLUSTERED 
(
	[Id_cat] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF