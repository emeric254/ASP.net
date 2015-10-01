-- 1 - TRIGGER DE MAJ

-- 1)
-- Ajout nouvelle colonne dans la table catégorie

ALTER TABLE CATEGORIE
	ADD Nombre_produits INT
;

-- 2)
-- Requête update synchronisée

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
