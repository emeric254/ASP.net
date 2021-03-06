USE [stri16]
GO
/****** Objet :  Table [dbo].[COMMANDE]    Date de génération du script : 09/24/2015 14:14:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[COMMANDE](
	[Id_com] [int] IDENTITY(1,1) NOT NULL,
	[Date_com] [datetime] NULL,
	[Id_client] [int] NOT NULL,
	[DateEnvoi_com] [datetime] NULL,
	[Id_paiement] [char](10) NULL,
	[Ref_paiement] [varchar](50) NULL,
	[Total_com] [numeric](18, 0) NULL,
 CONSTRAINT [PK_COMMANDE] PRIMARY KEY CLUSTERED 
(
	[Id_com] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
ALTER TABLE [dbo].[COMMANDE]  WITH CHECK ADD  CONSTRAINT [FK_COMMANDE_CLIENT] FOREIGN KEY([Id_client])
REFERENCES [dbo].[CLIENT] ([Id_client])
GO
ALTER TABLE [dbo].[COMMANDE] CHECK CONSTRAINT [FK_COMMANDE_CLIENT]