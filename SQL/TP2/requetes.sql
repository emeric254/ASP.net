-- TP2 : TRIGGERS ET PROCEDURES

--
-- Partie 1
-- TRIGGER DE MAJ

-- 1)
-- Ajout nouvelle colonne dans la table cat?orie

ALTER TABLE CATEGORIE
        ADD Nombre_produits INT
;

-- 2)
-- Requete update synchronisee

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

--
-- Partie 2
-- TRIGGER DE CONTRAINTE

-- 1)
-- Disponibilitee d'un produit

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

--
-- Partie 3
-- PROCEDURE STOCKEE

-- 1)
-- Procedure TOTAL_PRIX_CAT

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
-- Procedure PRISE_COMMANDE

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

-- ~ CREATE PROCEDURE AFFICHER_COMMANDES_CLIENT
        -- ~ @id_client int = 0
-- ~ AS
-- ~ BEGIN
        -- ~ DECLARE curseur CURSOR FOR
                -- ~ SELECT [Id_com]
                  -- ~ ,[Date_com]
                  -- ~ ,[Id_client]
                  -- ~ ,[DateEnvoi_com]
                  -- ~ ,[Id_paiement]
                  -- ~ ,[Ref_paiement]
                  -- ~ ,[Total_com]
                -- ~ FROM [stri16].[dbo].[COMMANDE]
                -- ~ WHERE [Id_client] = @id_client
        -- ~ ;

        -- ~ OPEN curseur
        -- ~ ;
        -- ~ FETCH NEXT FROM curseur
        -- ~ ;
        -- ~ WHILE @@FETCH_STATUS = 0
        -- ~ BEGIN
                -- ~ -- DECLARE @machin varchar
                -- ~ -- ;
                -- ~ -- SELECT @machin =  FROM [stri16].[dbo].[COMMANDE]
                -- ~ -- ;
                -- ~ -- PRINT(@machin)
                -- ~ ;
                -- ~ FETCH NEXT FROM curseur
                -- ~ -- ;
        -- ~ END
        -- ~ ;
        -- ~ CLOSE curseur
        -- ~ ;
        -- ~ DEALLOCATE curseur
        -- ~ ;
-- ~ END
-- ~ ;
