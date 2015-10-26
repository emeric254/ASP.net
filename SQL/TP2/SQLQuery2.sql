USE [stri7]
GO
/****** Objet :  StoredProcedure [dbo].[PRISE_COMMANDE]    Date de génération du script : 10/26/2015 10:11:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[PRISE_COMMANDE] 
	@nom varchar(500),
	@prenom varchar(500),
	@adresse varchar(500),
	@date_com datetime,
	@id_paiement char(500),
	@ref_paiement varchar(500), 
	@id_prod1 varchar(500),
	@qte_com1 int = 0,
	@id_prod2 varchar(500),
	@qte_com2 int = 0,
	@id_client int OUTPUT,
	@id_com int OUTPUT
AS
BEGIN
	INSERT INTO CLIENT(Nom_client, Prenom_client, Adresse_client)
	VALUES(@nom, @prenom, @adresse);
	SELECT @id_client = @@identity;
	DECLARE @somme_prix1 int;
	
	SELECT @somme_prix1 = ((PRODUIT.Prixht_prod *( 1 + PRODUIT.Tauxtva_prod / 100)) * @qte_com1)
	FROM PRODUIT
	WHERE PRODUIT.Id_prod = @id_prod1; 

	DECLARE @somme_prix2 int;
	
	SELECT @somme_prix2 = ((PRODUIT.Prixht_prod *( 1 + PRODUIT.Tauxtva_prod / 100)) * @qte_com2 )
	FROM PRODUIT
	WHERE PRODUIT.Id_prod = @id_prod2; 

	DECLARE @somme_prix_total int;
	SELECT @somme_prix_total = @somme_prix1 + @somme_prix2; 	



	INSERT INTO COMMANDE(Date_com, Id_client , Id_paiement, Ref_paiement, Total_com)
	VALUES(@date_com , @id_client, @id_paiement, @ref_paiement, @somme_prix_total);	

	SELECT @id_com = @@identity;

	INSERT INTO DETAIL_COMMANDE(Id_prod,Id_com ,Qt_dc,Prix_dc)
	VALUES(@id_prod1, @id_com, @qte_com1, @somme_prix1);

	INSERT INTO DETAIL_COMMANDE(Id_prod, Id_com, Qt_dc, Prix_dc)
	VALUES(@id_prod2, @id_com, @qte_com2, @somme_prix2);

END;