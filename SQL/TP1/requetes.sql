-- TP1)
--
-- 5)
--
-- a)
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
-- Affichage des produits appartenant à une catégorie dont le 'nom_cat' est donné
SELECT [Titre_prod]
      ,[stri16].[dbo].[CATEGORIE].[Nom_cat]
      ,[Detail_prod]
      ,[Prixhtprom_prod]
    FROM [stri16].[dbo].[PRODUIT], [stri16].[dbo].[CATEGORIE]
    WHERE [stri16].[dbo].[CATEGORIE].[Id_cat]=[stri16].[dbo].[PRODUIT].[Id_cat] AND [stri16].[dbo].[CATEGORIE].[Nom_cat] = 'Imprimantes'
;

-- e)
-- Affichage des commandes d'un client don le 'nom_client' est donné

SELECT [stri16].[dbo].[COMMANDE].[Id_com]
      ,[stri16].[dbo].[COMMANDE].[Date_com]
      ,[stri16].[dbo].[COMMANDE].[Id_paiement]
      ,[stri16].[dbo].[DETAIL_COMMANDE].[Id_prod]
      ,[stri16].[dbo].[DETAIL_COMMANDE].[Qt_dc]
  FROM [stri16].[dbo].[COMMANDE], [stri16].[dbo].[DETAIL_COMMANDE] WHERE [stri16].[dbo].[COMMANDE].[Id_client]=2 AND [stri16].[dbo].[DETAIL_COMMANDE].[Id_com] = [stri16].[dbo].[COMMANDE].[Id_com] ORDER BY [stri16].[dbo].[COMMANDE].[Id_com]
;

-- f)
-- Affichage des clients ayant commandé le produit dont le 'titre_prod' est donné

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
-- Insertion détail de la commande

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
