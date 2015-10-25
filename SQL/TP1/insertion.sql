


delete from detail_commande
delete from commande
delete from produit
delete from client
delete from categorie


--insertion de 3 catégories
insert into categorie(id_cat,nom_cat) values('Ecr','Ecrans')
insert into categorie(id_cat,nom_cat) values('Sca','Scanners')
insert into categorie(id_cat,nom_cat) values('Imp','Imprimantes')


--insertion de 5 produits
insert into
produit(id_prod,id_cat,titre_prod,detail_prod,image_prod,nouv_prod,prom_prod,sel_prod,poids_prod,dispo_prod,delai_prod,prixht_prod,prixhtprom_prod,tauxtva_prod)
values ('Ecr_Sony','Ecr','Ecran Sony 17 pouces','C''est un écran',NULL,1,0,0,20,1,'5',209,190,19.6)

insert into
produit(id_prod,id_cat,titre_prod,detail_prod,image_prod,nouv_prod,prom_prod,sel_prod,poids_prod,dispo_prod,delai_prod,prixht_prod,prixhtprom_prod,tauxtva_prod)
values ('Ecr_Iiyama','Ecr','Ecran Iiyama 21 pouces','C''est mon écran',NULL,1,0,1,50,1,'7',418,400,19.6)


insert into
produit(id_prod,id_cat,titre_prod,detail_prod,image_prod,nouv_prod,prom_prod,sel_prod,poids_prod,dispo_prod,delai_prod,prixht_prod,prixhtprom_prod,tauxtva_prod)
values ('Ecr_Pana','Ecr','Ecran Iiyama 21 pouces','C''est un super grand écran',NULL,1,0,1,10,1,'2',170,167,19.6)

insert into
produit(id_prod,id_cat,titre_prod,detail_prod,image_prod,nouv_prod,prom_prod,sel_prod,poids_prod,dispo_prod,delai_prod,prixht_prod,prixhtprom_prod,tauxtva_prod)
values ('Imp_Epson','Imp','Imprimante Epson 740','C''est mon imprimante',NULL,1,0,0,4,0,'0',83,79,19.6)

insert into
produit(id_prod,id_cat,titre_prod,detail_prod,image_prod,nouv_prod,prom_prod,sel_prod,poids_prod,dispo_prod,delai_prod,prixht_prod,prixhtprom_prod,tauxtva_prod)
values ('Imp_HP','Imp','Imprimante Hewlet Packard','Ca c''est de l imprimante',NULL,0,1,1,5,1,'10',170,167,19.6)

--insertion d'un client
insert into
client(nom_client,prenom_client,adresse_client,postal_client,ville_client,region_client,tel_client,fax_client,email_client)
values ('Tuffery','Michel','20 allée de chez lui','75000','Paris','Ile de France','0661602560','0462602560','mt@free.fr')

--insertion de 2 clients avec commandes

insert into
client(nom_client,prenom_client,adresse_client,postal_client,ville_client,region_client,tel_client,fax_client,email_client)
values ('Teste','Olivier','20 allee de chez lui','31770','Colomiers','Midi Pyrénées','0561302520',NULL,'ot@yahoo.fr')


declare @id_client int
declare @id_com int


select @id_client = @@identity

insert into commande(id_client,dateenvoi_com,id_paiement,ref_paiement,total_com)
values (@id_client,'20/04/2001','CH','CHEQUE2',700)


select @id_com = @@identity

insert into detail_commande(id_prod,id_com,qt_dc,prix_dc) values
( 'Ecr_Iiyama',@id_com,1,500)

insert into detail_commande(id_prod,id_com,qt_dc,prix_dc) values
('Imp_HP',@id_com,1,200)

go

insert into
client(nom_client,prenom_client,adresse_client,postal_client,ville_client,region_client,tel_client,fax_client,email_client)
values ('Mokadem','Riad','20 Rue parmi tant','75000','Paris','Ile de France','0601234567','0561557442','mokadem@irir.fr')

declare @id_client int
declare @id_com int


select @id_client = @@identity

insert into commande(id_client,dateenvoi_com,id_paiement,ref_paiement,total_com)
values (@id_client,'15/05/2001','CA','CHEQUE2',550)


select @id_com = @@identity

insert into detail_commande(id_prod,id_com,qt_dc,prix_dc) values
('Ecr_Sony',@id_com,1,250)

insert into detail_commande(id_prod,id_com,qt_dc,prix_dc) values
('Ecr_Pana',@id_com,1,200)

insert into detail_commande(id_prod,id_com,qt_dc,prix_dc) values
('Imp_Epson',@id_com,1,100)



insert into commande(id_client,dateenvoi_com,id_paiement,ref_paiement,total_com)
values (@id_client,'15/09/2001','CA','CHEQUE2',1200)

select @id_com = @@identity

insert into detail_commande(id_prod,id_com,qt_dc,prix_dc) values
('Ecr_Iiyama',@id_com,3,400)


go

select * from client
select * from categorie
select * from produit
select * from commande
select * from detail_commande
go
