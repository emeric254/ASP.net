-- TP3
-- Procedure stockees, Curseurs et Triggers
-- 
-- Auteurs :
-- Barbaste Remi
-- Costa Erwan
-- Tosi Emeric
--
--
-- 1)
-- Trigger de suppression de categorie et les sous entrees concernees dans les autres tables

CREATE TRIGGER TRIGGER_SUPPR 
   ON  [stri16].[dbo].[CATEGORIE] 
   INSTEAD OF DELETE
AS
	DECLARE @id_cat char(10)
	DECLARE @id_prod char(10)
	DECLARE @id_com	int
BEGIN
	-- recuperation id de la categorie a supprimer
	SELECT @id_cat = [Id_cat] FROM DELETED
	;
	-- supression des details de commandes
-- methode avec curseur :
--	DECLARE curseur CURSOR FOR
--		SELECT p.[Id_prod], dc.[Id_com]
--		  FROM [stri16].[dbo].[DETAIL_COMMANDE] dc, [stri16].[dbo].[PRODUIT] p
--		  WHERE dc.[Id_prod] = p.[Id_prod] AND @id_cat = p.[Id_cat]
--	;
--	OPEN curseur
--	;
--	FETCH NEXT FROM curseur INTO @id_com, @id_prod
--	;
--	WHILE @@FETCH_STATUS = 0
--	BEGIN
--		DELETE FROM [stri16].[dbo].[DETAIL_COMMANDE]
--		  WHERE [Id_prod] = @id_prod AND @id_com = [Id_com]
--		;
--		FETCH NEXT FROM curseur INTO @id_com, @id_prod
--		;
--	END
--	;
--	CLOSE curseur
--	;
--	DEALLOCATE curseur
--	;
--
-- fin curseur
--
-- methode sans le curseur :
	DELETE FROM [stri16].[dbo].[DETAIL_COMMANDE]
	  WHERE [Id_prod] IN (SELECT [Id_prod] FROM [stri16].[dbo].[PRODUIT] WHERE @id_cat = [Id_cat])
		AND [Id_com] IN (SELECT dc.[Id_com] FROM [stri16].[dbo].[DETAIL_COMMANDE] dc, [stri16].[dbo].[PRODUIT] p WHERE dc.[Id_prod] = 
p.[Id_prod] AND @id_cat = p.[Id_cat])
	;
--
	-- fin supression des details de commandes
	--
	-- supression des produits
	DELETE FROM [stri16].[dbo].[PRODUIT]
    WHERE @id_cat = [Id_cat]
	;
	-- supression de la categorie
	DELETE FROM [stri16].[dbo].[CATEGORIE]
    WHERE @id_cat = [Id_cat]
	;
END
;
--

--
-- test : on supprime la categorie imprimante donc on va supprimer !
DELETE FROM [stri16].[dbo].[CATEGORIE] WHERE [Id_cat] = 'Imp'
;
--
--


-- 2)
-- Procedure d'affichage des produits et des categories

CREATE PROCEDURE AFFICHE_PRODUITS_CATEGORIE
AS
BEGIN
	-- parcours des categories
	DECLARE @categorie char(10)
	;
	DECLARE curseur_cat CURSOR FOR 
		SELECT [Id_cat]
		  FROM [stri16].[dbo].[CATEGORIE]
		;
	OPEN curseur_cat
	;
	FETCH NEXT FROM curseur_cat INTO @categorie
	;
	WHILE @@FETCH_STATUS = 0
	BEGIN
		-- affichage nom categorie
		PRINT 'Categorie : ' + @categorie
		;
		-- parcours des produit de cette categorie
		DECLARE @produit char(10)
		;
		DECLARE curseur_prod CURSOR FOR
			SELECT p.[Id_prod]
			  FROM [stri16].[dbo].[PRODUIT] p
			  WHERE p.[Id_cat] = @categorie
		;
		OPEN curseur_prod
		;
		FETCH NEXT FROM curseur_prod INTO @produit
		;
		WHILE @@FETCH_STATUS = 0
		BEGIN
			-- nbr de fois que le produit est commande
			DECLARE @nb_commande char(10)
			;
			SELECT @nb_commande = COUNT([Id_com])
				FROM [stri16].[dbo].[DETAIL_COMMANDE]
				WHERE [Id_prod] = @produit 
			;
			-- affichage de la ligne du produit avec son nom et son nbr de commande
			PRINT '     ' + @produit + ' commandé ' + @nb_commande + ' fois'
			;
			FETCH NEXT FROM curseur_prod INTO @produit
			;
		END
		;
		CLOSE curseur_prod
		;
		DEALLOCATE curseur_prod
		;
		-- fin parcours des produit de cette categorie
		--
		-- prochaine categorie
		FETCH NEXT FROM curseur_cat INTO @categorie
		;
	END
	;
	CLOSE curseur_cat
	;
	DEALLOCATE curseur_cat
	;
	-- fin parcours des categories
END
;
--

--
-- test
execute AFFICHE_PRODUITS_CATEGORIE
;
--
--
