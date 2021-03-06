USE [stri16]
GO
/****** Objet :  Table [dbo].[PRODUIT]    Date de génération du script : 09/24/2015 14:14:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[PRODUIT](
	[Id_prod] [char](10) NOT NULL,
	[Id_cat] [char](10) NOT NULL,
	[Titre_prod] [varchar](50) NOT NULL,
	[Detail_prod] [varchar](50) NULL,
	[Image_prod] [varchar](50) NULL,
	[Nouv_prod] [bit] NULL,
	[Prom_prod] [bit] NULL,
	[Sel_prod] [bit] NULL,
	[Poids_prod] [numeric](18, 0) NULL,
	[Dispo_prod] [bit] NULL,
	[Delai_prod] [varchar](50) NULL,
	[Prixht_prod] [numeric](18, 0) NULL,
	[Prixhtprom_prod] [numeric](18, 0) NULL,
	[Tauxtva_prod] [numeric](18, 0) NULL,
 CONSTRAINT [PK_PRODUIT] PRIMARY KEY CLUSTERED 
(
	[Id_prod] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
ALTER TABLE [dbo].[PRODUIT]  WITH CHECK ADD  CONSTRAINT [FK_PRODUIT_CATEGORIE] FOREIGN KEY([Id_cat])
REFERENCES [dbo].[CATEGORIE] ([Id_cat])
GO
ALTER TABLE [dbo].[PRODUIT] CHECK CONSTRAINT [FK_PRODUIT_CATEGORIE]