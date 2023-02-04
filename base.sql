CREATE database enchere  ;
\c enchere

CREATE  TABLE admin ( 
	id                   serial  NOT NULL  ,
	identifiant          varchar(50)  NOT NULL  ,
	mdp                  varchar(50)  NOT NULL  ,
	unique(identifiant,mdp),
	CONSTRAINT pk_tbl PRIMARY KEY ( id )
 );

CREATE  TABLE categorie ( 
	id                   serial  NOT NULL  ,
	nomcategorie         varchar(50)  NOT NULL  ,
	CONSTRAINT pk_categorie PRIMARY KEY ( id )
 );

CREATE  TABLE commission ( 
	id                   serial  NOT NULL  ,
	valeur               float8    check(valeur>0),
	CONSTRAINT pk_commission PRIMARY KEY ( id )
 );

-- CREATE  TABLE tokenadmin ( 
-- 	id                   serial  NOT NULL  ,
-- 	valeur               varchar(50)  NOT NULL  ,
-- 	expiration           timestamp  NOT NULL  ,
-- 	idadmin              integer  NOT NULL  ,
-- 	CONSTRAINT pk_tokenadmin PRIMARY KEY ( id )
--  );

CREATE  TABLE utilisateur ( 
	id                   serial  NOT NULL  ,
	identifiant          varchar(50)  NOT NULL  ,
	mdp                  varchar(50)  NOT NULL  ,
	CONSTRAINT pk_utilisateur PRIMARY KEY ( id )
 );

CREATE  TABLE compte ( 
	id                   serial  NOT NULL  ,
	idutilisateur        integer  NOT NULL unique,
	CONSTRAINT pk_compte PRIMARY KEY ( id )
 );

CREATE  TABLE demanderecharge ( 
	id                   serial  NOT NULL  ,
	idutilisateur        integer  NOT NULL  ,
	"date"               timestamp DEFAULT now() NOT NULL  ,
	-- *****
	montant              float8  NOT NULL  check(montant>0),
	statut               integer DEFAULT 0   ,
	-- *****
	CONSTRAINT pk_demanderecharge PRIMARY KEY ( id )
 );

CREATE  TABLE enchere ( 
	id                   serial  NOT NULL  ,
	"date"               timestamp DEFAULT now() NOT NULL  ,
	description          varchar(255)  NOT NULL  ,
	duree                integer  NOT NULL  ,
	produit              varchar(50)  NOT NULL  ,
	-- ***   
	prix                 float8  NOT NULL check(prix>0)  ,
	-- ****
	idutilisateur        integer  NOT NULL  ,
	idcategorie          integer  NOT NULL  ,
	statut               integer DEFAULT 0   ,
	-- *****
	photo varchar(50) not null,
	
	-- tokony ho text
	-- *****
	CONSTRAINT pk_enchere PRIMARY KEY ( id )
 );

CREATE  TABLE encherissement ( 
	idenchere            integer  NOT NULL,
	prix                 float8  NOT NULL check(prix>0),
	idutilisateur  int not null,
	"date"               timestamp DEFAULT now()   
 );

CREATE  TABLE token ( 
	id                   serial  NOT NULL  ,
	valeur               varchar(50)  NOT NULL  ,
	expiration           timestamp  NOT NULL  ,
	idutilisateur        integer  NOT NULL  ,
	CONSTRAINT pk_tokenuser PRIMARY KEY ( id )
 );

CREATE  TABLE transactioncompte ( 
	idcompte             integer  NOT NULL  ,
	montant              float8  NOT NULL  ,
	"date"               timestamp  NOT NULL default now () 
 );
-- *****
 create table blocage(
	idutilisateur int not null,
	idenchere int not null,
	montant float8 not null check(montant>0)
 );


ALTER TABLE compte ADD CONSTRAINT idutilisateur_1 FOREIGN KEY ( idutilisateur ) REFERENCES utilisateur( id );

ALTER TABLE demanderecharge ADD CONSTRAINT idutilisateur FOREIGN KEY ( idutilisateur ) REFERENCES utilisateur( id );

ALTER TABLE enchere ADD CONSTRAINT idutilisateur_2 FOREIGN KEY ( idutilisateur ) REFERENCES utilisateur( id );

ALTER TABLE enchere ADD CONSTRAINT idcategorie_0 FOREIGN KEY ( idcategorie ) REFERENCES categorie( id );

ALTER TABLE encherissement ADD CONSTRAINT fk_encherissement_enchere FOREIGN KEY ( idenchere ) REFERENCES enchere( id );

-- ALTER TABLE tokenadmin ADD CONSTRAINT idadmin_0 FOREIGN KEY ( idadmin ) REFERENCES "admin"( id );

ALTER TABLE token ADD CONSTRAINT idutilisateur_0 FOREIGN KEY ( idutilisateur ) REFERENCES utilisateur( id );

ALTER TABLE transactioncompte ADD CONSTRAINT idcompte_0 FOREIGN KEY ( idcompte ) REFERENCES compte( id );
-- ***
ALTER TABLE encherissement ADD  FOREIGN KEY ( idutilisateur ) REFERENCES utilisateur( id );
-- ***
alter table blocage add FOREIGN KEY (idutilisateur) REFERENCES utilisateur(id);
alter table blocage add FOREIGN KEY (idenchere) REFERENCES enchere(id);


insert into admin(identifiant,mdp) values ('admin1','mdp1');

insert into utilisateur (identifiant, mdp) values('Bema', 'maharo000');
insert into utilisateur (identifiant, mdp) values('Bary', 'bary1234');
insert into utilisateur (identifiant, mdp) values('Koto', 'kotokely');
insert into utilisateur (identifiant, mdp) values('user4', 'mdp4');


insert into categorie(nomcategorie) values('Boisson');
insert into categorie(nomcategorie) values('Tennis');
insert into categorie(nomcategorie) values('Smartphone');
insert into categorie(nomcategorie) values('Art');

insert into commission(valeur) values(0.25);


insert into enchere(description, duree, produit, prix, idutilisateur, idcategorie,photo)
values('produit milay', 50, 'cocacola', 5000, 1, 1,'photo.jpg');
insert into enchere(description, duree, produit, prix, idutilisateur, idcategorie,photo)
values('nouveau iphone 2022', 50, 'iphone 14', 18000, 2, 3,'photo.jpg');

insert into enchere(description, duree, produit, prix, idutilisateur, idcategorie,photo)
values('descrition test', 2, 'test', 250, 1, 2,'photo.jpg');

insert into enchere(description, duree, produit, prix, idutilisateur, idcategorie,photo)
values('podnppv vzeezpnnvoen', 2, 'prod', 1129, 3, 1,'photo.jpg');

insert into enchere(description, duree, produit, prix, idutilisateur, idcategorie,photo)
values('sssss zdzddd', 10, 'testdedk', 4933, 2, 3,'photo.jpg');
-- *****************************************************************************


insert into encherissement(idenchere,prix,idutilisateur,date) values(1,6500,2,'2023-01-20 13:27:31');

insert into encherissement(idenchere,prix,idutilisateur,date) values(2,27000,3,'2023-01-20 13:30:31');
insert into encherissement(idenchere,prix,idutilisateur,date) values(3,1000,4,'2023-01-20 13:28:31');
insert into encherissement(idenchere,prix,idutilisateur,date) values(5,15389,1,'2023-01-20 13:28:31');

-- ***************************************************************************
insert into enchere(description, duree, produit, prix, idutilisateur, idcategorie,photo) values
	('Edition limite et tres rare', 3, 'Adidas collector', 3400, 3, 2,'adidas.jpg'),
	('Collection de vieux livres ', 3, 'Pack d ouvrages litteraires', 13289, 1, 4,'livre.jpg'),
	('Vin italien tres rare ', 3, 'Vin rouge 1998', 21900, 2, 1,'vin.jpg'),
	('Smartphone multifonction et haut de gamme', 3, 'Samsung s22 Ultra', 124570, 2, 1,'s22.jpg'),
	('Chaussures urbaines decontractees', 16059755, 'Puma Suede', 28993, 4, 2,'suede.jpg'),
	('Miel de licthi confectionne avec soin et de bonne qualite', 22976005, 'Miel pur de Madagascar', 5420, 1, 1,'suede.jpg'),
	('Tableau d un grand peintre de la Renaissance', 12590990, 'Tableau du XIV e siecle', 308765, 3, 4,'peinture.jpg');


insert into encherissement(idenchere,prix,idutilisateur) values(7,7000,1);
insert into encherissement(idenchere,prix,idutilisateur) values(8,24000,3);
insert into encherissement(idenchere,prix,idutilisateur) values(9,60000,4);
insert into encherissement(idenchere,prix,idutilisateur) values(10,147000,1);
insert into encherissement(idenchere,prix,idutilisateur) values(12,400000,1);


insert into compte(idutilisateur) values (1);
insert into compte(idutilisateur) values (2);
insert into compte(idutilisateur) values (3);
insert into compte(idutilisateur) values (4);

insert into transactioncompte(idcompte,montant) values (1,300);
insert into transactioncompte(idcompte,montant) values (1,-50);
insert into transactioncompte(idcompte,montant) values (1,200);
insert into transactioncompte(idcompte,montant) values (1,32000);
insert into transactioncompte(idcompte,montant) values (1,214000);

insert into transactioncompte(idcompte,montant) values (2,800);
insert into transactioncompte(idcompte,montant) values (2,-100);
insert into transactioncompte(idcompte,montant) values (2,50);

insert into transactioncompte(idcompte,montant) values (3,1250);

insert into transactioncompte(idcompte,montant) values (4,156250);
insert into transactioncompte(idcompte,montant) values (2,1452);
insert into transactioncompte(idcompte,montant) values (2,3421);
insert into transactioncompte(idcompte,montant) values (1,309421);
insert into transactioncompte(idcompte,montant) values (3,35280);
insert into transactioncompte(idcompte,montant) values (2,2561);
insert into transactioncompte(idcompte,montant) values (4,200000);
insert into transactioncompte(idcompte,montant) values (1,400000);

insert into blocage(idutilisateur,idenchere,montant) values(1,2,20000);
insert into blocage(idutilisateur,idenchere,montant) values(1,2,21000);
insert into blocage(idutilisateur,idenchere,montant) values(1,2,25000);

insert into blocage(idutilisateur,idenchere,montant) values(3,2,333);
insert into blocage(idutilisateur,idenchere,montant) values(3,1,333);


insert into demanderecharge(idutilisateur,montant) values(1,2000);
insert into demanderecharge(idutilisateur,montant) values(2,3389);
insert into demanderecharge(idutilisateur,montant) values(3,15900);



-- ********************************************************

 create or replace view V_ENCHERE AS 
 	SELECT e.id,date, description , duree, produit,prix, e.idutilisateur,u.identifiant,e.idcategorie,c.nomcategorie,statut , photo
		FROM enchere e
	 		inner join categorie c 
	 			on e.idcategorie = c.id
					inner join utilisateur u
						on e.idutilisateur = u.id order by e.id;

create or replace view v_listEnchere as select produit , nomcategorie from V_ENCHERE;

create or replace view V_STAT_TOPCATEGORIE as select idcategorie , nomcategorie , sum(e.prix) totalPrix  from V_ENCHERE 
inner join encherissement e on V_ENCHERE.id = e.idenchere
where statut = 1
group by idcategorie , nomcategorie 
order by totalPrix desc 
;

create view  V_STAT_MAXENCHERE as 
select idcategorie , nomcategorie , produit , identifiant , e.prix  from V_ENCHERE 
inner join encherissement e on V_ENCHERE.id = e.idenchere
where statut = 1
order by e.prix desc
;

create or replace view V_STAT_TOPVENDEUR as 
select v.idutilisateur , identifiant , sum(e.prix) prix    from V_ENCHERE v
inner join encherissement e on v.id = e.idenchere
where statut = 1
group by v.idutilisateur, identifiant 
order by prix desc 
;


-- *********************************************************************
create or replace view v_demanderecharge as 
SELECT d.id,d.idutilisateur,u.identifiant,d.date,d.montant,d.statut from demanderecharge d join utilisateur u on d.idutilisateur=u.id order by d.date;

create or replace view v_compte as SELECT c.*,u.identifiant,sum(t.montant) solde from compte c join transactioncompte t on c.id=t.idcompte join utilisateur u on u.id=c.idutilisateur group by c.id,u.identifiant order by c.id;

create or replace view v_historique as select * from v_enchere where statut=1;

create or replace view v_blocage as select b.idutilisateur,b.idenchere,sum(montant) total from blocage b group by b.idutilisateur,b.idenchere;

create or replace view v_enchereexpire as select e.* from enchere e where e.date+e.duree*interval '1 min' <now() and statut=0 ;

