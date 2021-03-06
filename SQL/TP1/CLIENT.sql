USE [stri16]
GO
/****** Objet :  Table [dbo].[CLIENT]    Date de génération du script : 09/24/2015 14:14:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[CLIENT](
	[Id_client] [int] IDENTITY(1,1) NOT NULL,
	[Nom_client] [varchar](50) NULL,
	[Prenom_client] [varchar](50) NULL,
	[Adresse_client] [varchar](50) NULL,
	[Postal_client] [char](10) NULL,
	[Ville_client] [varchar](50) NULL,
	[Region_client] [varchar](50) NULL,
	[Tel_client] [char](10) NULL,
	[Fax_client] [char](10) NULL,
	[Email_client] [varchar](50) NULL,
 CONSTRAINT [PK_CLIENT] PRIMARY KEY CLUSTERED 
(
	[Id_client] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF