-- 1 - TRIGGER DE MAJ

-- 1)
-- Ajout nouvelle colonne dans la table catégorie

ALTER TABLE CATEGORIE
	ADD Nombre_produits INT
;

-- 2)
-- Requęte update synchronisée

UPDATE [stri16].[dbo].[CATEGORIE]
	SET [stri16].[dbo].[CATEGORIE].[Nombre_produits] =
		(SELECT COUNT (p.[Id_prod])
			FROM [stri16].[dbo].[PRODUIT] p
			WHERE [stri16].[dbo].[CATEGORIE].[Id_cat] = p.[Id_cat]
			GROUP BY [Id_cat])
;

-- 3)
-- Trigger de MAJ
CREATE TRIGGER Trigger_MAJ_Produit
   ON  [stri16].[dbo].[PRODUIT] 
   AFTER INSERT,DELETE,UPDATE
AS 
BEGIN
	UPDATE [stri16].[dbo].[CATEGORIE]
		SET [stri16].[dbo].[CATEGORIE].[Nombre_produits] =
			(SELECT COUNT (p.[Id_prod])
				FROM [stri16].[dbo].[PRODUIT] p
				WHERE [stri16].[dbo].[CATEGORIE].[Id_cat] = p.[Id_cat]
				GROUP BY [Id_cat])
	;
END
;



-- Q5)a)
-- Affichage du contenu de chaque table

SELECT [Id_cat]
      ,[Nom_cat]
  FROM [stri16].[dbo].[CATEGORIE]
;
SELECT [Id_prod]
      ,[Id_cat]
      ,[Titre_prod]
      ,[Detail_prod]
      ,[Image_prod]
      ,[Nouv_prod]
      ,[Prom_prod]
      ,[Sel_prod]
      ,[Poids_prod]
      ,[Dispo_prod]
      ,[Delai_prod]
      ,[Prixht_prod]
      ,[Prixhtprom_prod]
      ,[Tauxtva_prod]
  FROM [stri16].[dbo].[PRODUIT]
;
SELECT [Id_com]
      ,[Date_com]
      ,[Id_client]
      ,[DateEnvoi_com]
      ,[Id_paiement]
      ,[Ref_paiement]
      ,[Total_com]
  FROM [stri16].[dbo].[COMMANDE]
;
SELECT [Id_prod]
      ,[Id_com]
      ,[Qt_dc]
      ,[Prix_dc]
  FROM [stri16].[dbo].[DETAIL_COMMANDE]
;
SELECT [Id_client]
      ,[Nom_client]
      ,[Prenom_client]
      ,[Adresse_client]
      ,[Postal_client]
      ,[Ville_client]
      ,[Region_client]
      ,[Tel_client]
      ,[Fax_client]
      ,[Email_client]
  FROM [stri16].[dbo].[CLIENT]
;
-- b)
-- Affichage des produits en promotion

SELECT [Titre_prod]
      ,[Detail_prod]
      ,[Prixhtprom_prod]
  FROM [stri16].[dbo].[PRODUIT] WHERE [Prom_prod]=1
;
-- c)
-- Affichage de  'nom cat' pour chaque produit

SELECT [Titre_prod]
      ,[stri16].[dbo].[CATEGORIE].[Nom_cat]
      ,[Detail_prod]
      ,[Prixhtprom_prod]
	FROM [stri16].[dbo].[PRODUIT], [stri16].[dbo].[CATEGORIE]
	WHERE [stri16].[dbo].[CATEGORIE].[Id_cat]=[stri16].[dbo].[PRODUIT].[Id_cat] AND [Prom_prod]=1
;
-- d)
-- Affichage des produits appartenant ?une cat?orie dont le 'nom_cat' est donn?SELECT [Titre_prod]
      ,[stri16].[dbo].[CATEGORIE].[Nom_cat]
      ,[Detail_prod]
      ,[Prixhtprom_prod]
	FROM [stri16].[dbo].[PRODUIT], [stri16].[dbo].[CATEGORIE]
	WHERE [stri16].[dbo].[CATEGORIE].[Id_cat]=[stri16].[dbo].[PRODUIT].[Id_cat] AND [stri16].[dbo].[CATEGORIE].[Nom_cat] = 'Imprimantes'
;
-- e)
-- Affichage des commandes d'un client don le 'nom_client' est donn?
SELECT [stri16].[dbo].[COMMANDE].[Id_com]
      ,[stri16].[dbo].[COMMANDE].[Date_com]
      ,[stri16].[dbo].[COMMANDE].[Id_paiement]
      ,[stri16].[dbo].[DETAIL_COMMANDE].[Id_prod]
      ,[stri16].[dbo].[DETAIL_COMMANDE].[Qt_dc]
  FROM [stri16].[dbo].[COMMANDE], [stri16].[dbo].[DETAIL_COMMANDE] WHERE [stri16].[dbo].[COMMANDE].[Id_client]=2 AND [stri16].[dbo].[DETAIL_COMMANDE].[Id_com] = [stri16].[dbo].[COMMANDE].[Id_com] ORDER BY [stri16].[dbo].[COMMANDE].[Id_com]
;
-- f)
-- Affichage des clients ayant command?le produit dont le 'titre_prod' est donn?
SELECT [stri16].[dbo].[CLIENT].[Id_client]
      ,[stri16].[dbo].[CLIENT].[Nom_client]
      ,[stri16].[dbo].[CLIENT].[Prenom_client]
  FROM [stri16].[dbo].[PRODUIT], [stri16].[dbo].[DETAIL_COMMANDE],
		 [stri16].[dbo].[COMMANDE], [stri16].[dbo].[CLIENT]
WHERE [stri16].[dbo].[PRODUIT].[Titre_prod] = 'Imprimante Hewlet Packard' 
	AND [stri16].[dbo].[PRODUIT].[Id_prod] = [stri16].[dbo].[DETAIL_COMMANDE].[Id_prod]
AND [stri16].[dbo].[DETAIL_COMMANDE].[Id_com] =  [stri16].[dbo].[COMMANDE].[Id_com]
AND [stri16].[dbo].[COMMANDE].[Id_client] = [stri16].[dbo].[CLIENT].[Id_client]
;


-- 6)
-- Insertion d'un nouveau client
INSERT INTO [stri16].[dbo].[CLIENT]
           ([Nom_client]
           ,[Prenom_client]
           ,[Adresse_client]
           ,[Postal_client]
           ,[Ville_client]
           ,[Region_client]
           ,[Tel_client]
           ,[Fax_client]
           ,[Email_client])
     VALUES
           ('Jean'
           ,'Marc'
           ,'Jaures'
           ,'75019'
           ,'Paris'
           ,'IDF'
           ,'0'
           ,'0'
           ,'C@stri.fr')
;

-- 7)
-- Nouvelle commande de Jean Marc

DECLARE @idClient int;
SELECT @idClient = @@identity;

INSERT INTO [stri16].[dbo].[COMMANDE]
           ([Date_com]
           ,[Id_client]
           ,[DateEnvoi_com]
           ,[Id_paiement]
           ,[Ref_paiement]
           ,[Total_com])
     VALUES
           ('15/01/03'
           ,@idClient
           ,'16/01/03'
           ,'CH'
           ,'cheque'
           ,400)
;

-- 8)
-- Insertion d?ail de la commande

DECLARE @idCommande int;
SELECT @idCommande = @@identity;

INSERT INTO [stri16].[dbo].[DETAIL_COMMANDE]
           ([Id_prod]
           ,[Id_com]
           ,[Qt_dc]
           ,[Prix_dc])
     VALUES
           ('Imp_HP'
           ,@idCommande
           ,2
           ,200)
;

-- 9)
-- Affichage du client ayant fait le plus de commande

SELECT TOP 1 l.[Id_client],
			(select u.[Nom_Client] from [stri16].[dbo].[CLIENT] u where l.[Id_client] = u.[Id_client]) as 'NomClient',
			(select u.[Prenom_Client] from [stri16].[dbo].[CLIENT] u where l.[Id_client] = u.[Id_client]) as 'PrenomClient',
			COUNT(c.[Id_com]) as 'NbCommandes'
	FROM [stri16].[dbo].[COMMANDE] c, [stri16].[dbo].[CLIENT] l
	WHERE c.[Id_client] = l.[Id_client]
	GROUP BY l.[Id_client] ORDER BY NbCommandes desc
;

-- 10) 
-- Affichage du client dont la commande comporte le plus de produits

SELECT TOP 1 l.[Id_client],
			(select u.[Nom_Client] from [stri16].[dbo].[CLIENT] u where l.[Id_client] = u.[Id_client]) as 'NomClient',
			(select u.[Prenom_Client] from [stri16].[dbo].[CLIENT] u where l.[Id_client] = u.[Id_client]) as 'PrenomClient',
			COUNT(d.[Qt_dc]) as 'NbProduitsCommandes'
	FROM [stri16].[dbo].[COMMANDE] c, [stri16].[dbo].[CLIENT] l, [stri16].[dbo].[DETAIL_COMMANDE] d
	WHERE c.[Id_client] = l.[Id_client] AND c.[Id_com] = d.[Id_com]
	GROUP BY d.[Id_com], l.[Id_client] ORDER BY NbProduitsCommandes desc
;

-- TP2 : TRIGGERS ET PROCEDURES
-- 1 - TRIGGER DE MAJ

-- 1)
-- Ajout nouvelle colonne dans la table cat?orie

ALTER TABLE CATEGORIE
	ADD Nombre_produits INT
;

-- 2)
-- Requ?e update synchronis?

UPDATE [stri16].[dbo].[CATEGORIE]

	SET [stri16].[dbo].[CATEGORIE].[Nombre_produits] =

		(SELECT COUNT (p.[Id_prod])

			FROM [stri16].[dbo].[PRODUIT] p

			WHERE [stri16].[dbo].[CATEGORIE].[Id_cat] = p.[Id_cat]

			GROUP BY [Id_cat])

;



-- 3)

-- Trigger de MAJ

CREATE TRIGGER Trigger_MAJ_Produit

   ON  [stri16].[dbo].[PRODUIT] 

   AFTER INSERT,DELETE,UPDATE

AS 

BEGIN
	UPDATE [stri16].[dbo].[CATEGORIE]

		SET [stri16].[dbo].[CATEGORIE].[Nombre_produits] =

			(SELECT COUNT (p.[Id_prod])

				FROM [stri16].[dbo].[PRODUIT] p

				WHERE [stri16].[dbo].[CATEGORIE].[Id_cat] = p.[Id_cat]

				GROUP BY [Id_cat])

	;

END

;



-- 2 - TRIGGER DE CONTRAINTE

-- 1)

-- Disponibilit?d'un produit



CREATE TRIGGER Trigger_Dispo 

   ON  [stri16].[dbo].[DETAIL_COMMANDE] 

   AFTER INSERT

AS 

BEGIN

	IF (SELECT p.[Dispo_prod] FROM [stri16].[dbo].[PRODUIT] p, INSERTED I WHERE I.[Id_prod] = p.[Id_prod]) = 0

	BEGIN

		RAISERROR('PRODUIT NON DISPONIBLE', -1, -1, 50001)

		;

	END

	;

END

;



-- 3 - PROCEDURE STOCKEE

-- 1)

-- Proc?ure TOTAL_PRIX_CAT



CREATE PROCEDURE TOTAL_PRIX_CAT 

	@categorie int = 0, 

	@total_prix int OUTPUT

AS

BEGIN

	SELECT SUM([stri16].[dbo].[PRODUIT].[Prixht_prod])

		FROM [stri16].[dbo].[PRODUIT]

		WHERE [stri16].[dbo].[PRODUIT].[Id_cat] = @categorie

		GROUP BY [stri16].[dbo].[PRODUIT].[Id_cat]

	;

END

;



-- 2)

-- Proc?ure PRISE_COMMANDE



CREATE PROCEDURE PRISE_COMMANDE 

	@nom varchar,

	@prenom varchar,

	@adresse varchar,

	@date_com datetime,

	@id_paiement char(10),

	@ref_paiement varchar, 

	@id_prod1 int = 0, 

	@qte_com1 int = 0, 

	@id_prod2 int = 0, 

	@qte_com2 int = 0,

	@id_client int OUTPUT,

	@id_com int OUTPUT

AS

BEGIN

	INSERT INTO [stri16].[dbo].[CLIENT]

           ([Nom_client]

           ,[Prenom_client]

           ,[Adresse_client])

     VALUES

           (@nom

           ,@prenom

           ,@adresse)

	;



	SELECT @id_client = @@identity

	;



	DECLARE @somme_prix1 int

	;



	SELECT @somme_prix1 = (([stri16].[dbo].[PRODUIT].[Prixht_prod] *

							( 1 + [stri16].[dbo].[PRODUIT].[Tauxtva_prod] / 100)) * 

							 @qte_com1 )

			FROM [stri16].[dbo].[PRODUIT]

			WHERE [stri16].[dbo].[PRODUIT].[Id_prod] = @id_prod1

	; 



	DECLARE @somme_prix2 int

	;



	SELECT @somme_prix2 = (([stri16].[dbo].[PRODUIT].[Prixht_prod] *

							( 1 + [stri16].[dbo].[PRODUIT].[Tauxtva_prod] / 100)) * 

							 @qte_com2 )

			FROM [stri16].[dbo].[PRODUIT]

			WHERE [stri16].[dbo].[PRODUIT].[Id_prod] = @id_prod2

	; 



	DECLARE @somme_prix_total int

	;



	SELECT @somme_prix_total = @somme_prix1 + @somme_prix2

	; 	



	INSERT INTO [stri16].[dbo].[COMMANDE]

           ([Date_com]

           ,[Id_client]

           ,[Id_paiement]

           ,[Ref_paiement]

           ,[Total_com])

     VALUES

           (@date_com

           ,@id_client

           ,@id_paiement

           ,@ref_paiement

		   ,@somme_prix_total)

	;	

	

	SELECT @id_com = @@identity

	;



	INSERT INTO [stri16].[dbo].[DETAIL_COMMANDE]

           ([Id_prod]

           ,[Id_com]

           ,[Qt_dc]

           ,[Prix_dc])

     VALUES

           (@id_prod1

           ,@id_com

           ,@qte_com1

           ,@somme_prix1)

	;



	INSERT INTO [stri16].[dbo].[DETAIL_COMMANDE]

           ([Id_prod]

           ,[Id_com]

           ,[Qt_dc]

           ,[Prix_dc])

     VALUES

           (@id_prod2

           ,@id_com

           ,@qte_com2

           ,@somme_prix2)

	;



END

;



-- 3)

-- Afficher les commandes du client



CREATE PROCEDURE AFFICHER_COMMANDES_CLIENT 

	@id_client int = 0

AS

BEGIN

	DECLARE curseur CURSOR FOR 

		SELECT [Id_com]

		  ,[Date_com]

		  ,[Id_client]

		  ,[DateEnvoi_com]

		  ,[Id_paiement]

		  ,[Ref_paiement]

		  ,[Total_com]

		FROM [stri16].[dbo].[COMMANDE]

		WHERE [Id_client] = @id_client

	;



	OPEN curseur

	;

	FETCH NEXT FROM curseur

	;

	WHILE @@FETCH_STATUS = 0

	BEGIN

		-- DECLARE @machin varchar

		-- ;

		-- SELECT @machin =  FROM [stri16].[dbo].[COMMANDE]

		-- ;

		-- PRINT(@machin)

		;

		FETCH NEXT FROM curseur

		-- ;

	END

	;

	CLOSE curseur

	;

	DEALLOCATE curseur

	;

END

;

