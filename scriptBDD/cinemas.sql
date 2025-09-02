-- Création de la base de données
DROP DATABASE IF EXISTS `cinemas`;
CREATE DATABASE `cinemas`;
USE cinemas;


-- Création des tables
CREATE TABLE acteurs(
   id INT,
   nom_acteur varchar(50),
   PRIMARY KEY(id)
);

CREATE TABLE cinema(
   id INT,
   nom_cine varchar(50),
   tel varchar(20),
   rue varchar(50),
   PRIMARY KEY(id)
);

CREATE TABLE film(
   id INT,
   titre varchar(50),
   pays varchar(50),
   annee INT,
   realisateur varchar(50),
   PRIMARY KEY(id)
);

CREATE TABLE distribution(
   id_film INT,
   id_acteur INT,
   PRIMARY KEY(id_film, id_acteur),
   FOREIGN KEY(id_film) REFERENCES film(id) ON DELETE CASCADE,
   FOREIGN KEY(id_acteur) REFERENCES acteurs(id) ON DELETE CASCADE
);

CREATE TABLE cinesalles(
   id_cine INT,
   salle VARCHAR(4),
   nb_places INT,
   PRIMARY KEY(id_cine, salle),
   FOREIGN KEY(id_cine) REFERENCES cinema(id) ON DELETE CASCADE
);

CREATE TABLE programme(
   id_cine INT,
   salle VARCHAR(4),
   semaine INT,
   id_film INT,
   nb_entrees INT,
   PRIMARY KEY(id_cine, salle, semaine, id_film),
   FOREIGN KEY(id_film) REFERENCES film(id),
   FOREIGN KEY(id_cine, salle) REFERENCES cinesalles(id_cine, salle)
);

-- Insertion des données
INSERT INTO acteurs VALUES('1','Bueno');
INSERT INTO acteurs VALUES('2','Clarkson');
INSERT INTO acteurs VALUES('3','Cleese');
INSERT INTO acteurs VALUES('4','Curtis');
INSERT INTO acteurs VALUES('5','Delamare');
INSERT INTO acteurs VALUES('6','Delon');
INSERT INTO acteurs VALUES('7','Deneuve');
INSERT INTO acteurs VALUES('8','Eastwood');
INSERT INTO acteurs VALUES('9','Gabin');
INSERT INTO acteurs VALUES('10','Gastaldi');
INSERT INTO acteurs VALUES('11','Guers');
INSERT INTO acteurs VALUES('12','Haid');
INSERT INTO acteurs VALUES('13','Hunt');
INSERT INTO acteurs VALUES('14','Kline');
INSERT INTO acteurs VALUES('15','Komorowska');
INSERT INTO acteurs VALUES('16','Le roi');
INSERT INTO acteurs VALUES('17','Mann');
INSERT INTO acteurs VALUES('18','Mercure');
INSERT INTO acteurs VALUES('19','Modine');
INSERT INTO acteurs VALUES('20','Moreau');
INSERT INTO acteurs VALUES('21','Nassiet');
INSERT INTO acteurs VALUES('22','Palin');
INSERT INTO acteurs VALUES('23','Pfeiffer');
INSERT INTO acteurs VALUES('24','Piccoli');
INSERT INTO acteurs VALUES('25','Romand');
INSERT INTO acteurs VALUES('26','Roussel');
INSERT INTO acteurs VALUES('27','Skanzanka');
INSERT INTO acteurs VALUES('28','Spiesser');
INSERT INTO acteurs VALUES('29','Stockwell');
INSERT INTO acteurs VALUES('30','Truffaut');
INSERT INTO acteurs VALUES('31','Vega');
INSERT INTO acteurs VALUES('32','Warren');
INSERT INTO acteurs VALUES('33','Wilson');
INSERT INTO acteurs VALUES('34','Woods');

INSERT INTO cinema VALUES('1','le club','0476467390','phalanstere');
INSERT INTO cinema VALUES('2','les dauphins','0476460454','sault');
INSERT INTO cinema VALUES('3','gaumont','0476461645','alsace lorraine');
INSERT INTO cinema VALUES('4','lux','0476464658','thiers');
INSERT INTO cinema VALUES('5','la nef','0476465325','edouard rey');
INSERT INTO cinema VALUES('6','les 6 rex','0476517200','saint jacques');
INSERT INTO cinema VALUES('7','ugc royal','0476461142','clot bey');
INSERT INTO cinema VALUES('8','le melies','0476430362','strasbourg');
INSERT INTO cinema VALUES('9','pathe grenette','0476515757','grenette');
INSERT INTO cinema VALUES('10','vox','0476515757','place victor hugo');

INSERT INTO film VALUES('1','Annee du soleil calme','Pologne','1989','Krzysztof');
INSERT INTO film VALUES('2','Cop','USA','1989','Harris');
INSERT INTO film VALUES('3','La boca del lobo','Espagne','1989','Lombardi');
INSERT INTO film VALUES('4','La derniere cible','USA','1984','Eastwood');
INSERT INTO film VALUES('5','Un poisson nomme wanda','USA','1989','Crichton');
INSERT INTO film VALUES('6','La baie des anges','France','1962','Demy');
INSERT INTO film VALUES('7','Mon cher sujet','France','1989','Mieville');
INSERT INTO film VALUES('8','Baxter','France','1989','Boivin');
INSERT INTO film VALUES('9','Veuve mais pas trop','USA','1989','Truffaut');
INSERT INTO film VALUES('10','Nikita','France','1989','Besson');
INSERT INTO film VALUES('11','L''amant','France','1991','Annaud');
INSERT INTO film VALUES('12','La belle histoire','France','1991','Lelouch');
INSERT INTO film VALUES('13','Cyrano de Bergerac','France','1989','Rappeneau');
INSERT INTO film VALUES('14','Danse avec les loups','USA','1990','Costner');
INSERT INTO film VALUES('15','Easy Rider','USA','1969','Hopper');
INSERT INTO film VALUES('16','Fisher King','USA','1991','Gilliam');
INSERT INTO film VALUES('17','JFK','USA','1991','Stone');
INSERT INTO film VALUES('18','Les liaisons dangereuses','USA','1988','Frears');
INSERT INTO film VALUES('19','Appocalypse now','USA','1978','Coppola');
INSERT INTO film VALUES('20','Birdy','USA','1984','Parker');
INSERT INTO film VALUES('21','Taxi driver','USA','1976','Scorsese');
INSERT INTO film VALUES('22','Shining','USA','1980','Kubrick');
INSERT INTO film VALUES('23','Sauve qui peut, la vie','Suisse','1979','Godard');
INSERT INTO film VALUES('24','Jules et Jim','France','1961','Truffaut');
INSERT INTO film VALUES('25','Pink Floyd, the wall','USA','1982','Parker');
INSERT INTO film VALUES('26','Rusty James','USA','1983','Coppola');
INSERT INTO film VALUES('27','Midnight express','GB','1978','Parker');
INSERT INTO film VALUES('28','Merci la vie','France','1990','Blier');
INSERT INTO film VALUES('29','Mauvais sang','France','1990','Carax');
INSERT INTO film VALUES('30','Hotel du nord','France','1938','Carne');
INSERT INTO film VALUES('31','Les enfants du paradis','France','1943','Carne');
INSERT INTO film VALUES('32','Le grand bleu','France','1987','Besson');
INSERT INTO film VALUES('33','Les visiteurs','France','1993','C. Clavier');

INSERT INTO cinesalles VALUES('1','1','300');
INSERT INTO cinesalles VALUES('1','2','200');
INSERT INTO cinesalles VALUES('1','3','100');
INSERT INTO cinesalles VALUES('1','4','100');
INSERT INTO cinesalles VALUES('1','5','100');
INSERT INTO cinesalles VALUES('2','1','250');
INSERT INTO cinesalles VALUES('2','2','50');
INSERT INTO cinesalles VALUES('3','1','600');
INSERT INTO cinesalles VALUES('3','2','300');
INSERT INTO cinesalles VALUES('3','3','300');
INSERT INTO cinesalles VALUES('3','4','230');
INSERT INTO cinesalles VALUES('3','5','100');
INSERT INTO cinesalles VALUES('3','6','100');
INSERT INTO cinesalles VALUES('4','1','200');
INSERT INTO cinesalles VALUES('5','1','360');
INSERT INTO cinesalles VALUES('5','2','210');
INSERT INTO cinesalles VALUES('5','3','200');
INSERT INTO cinesalles VALUES('5','4','100');
INSERT INTO cinesalles VALUES('5','5','50');
INSERT INTO cinesalles VALUES('6','1','400');
INSERT INTO cinesalles VALUES('6','2','370');
INSERT INTO cinesalles VALUES('6','3','240');
INSERT INTO cinesalles VALUES('6','4','100');
INSERT INTO cinesalles VALUES('6','5','100');
INSERT INTO cinesalles VALUES('6','6','80');
INSERT INTO cinesalles VALUES('7','1','600');
INSERT INTO cinesalles VALUES('7','2','500');
INSERT INTO cinesalles VALUES('7','3','200');
INSERT INTO cinesalles VALUES('7','4','100');
INSERT INTO cinesalles VALUES('7','5','100');
INSERT INTO cinesalles VALUES('8','1','200');
INSERT INTO cinesalles VALUES('8','2','150');
INSERT INTO cinesalles VALUES('8','3','150');
INSERT INTO cinesalles VALUES('9','1','600');
INSERT INTO cinesalles VALUES('9','2','300');
INSERT INTO cinesalles VALUES('9','3','300');
INSERT INTO cinesalles VALUES('9','4','150');
INSERT INTO cinesalles VALUES('9','5','100');
INSERT INTO cinesalles VALUES('9','6','100');

INSERT INTO distribution VALUES('1','15');
INSERT INTO distribution VALUES('1','33');
INSERT INTO distribution VALUES('1','9');
INSERT INTO distribution VALUES('1','27');
INSERT INTO distribution VALUES('2','8');
INSERT INTO distribution VALUES('2','34');
INSERT INTO distribution VALUES('2','7');
INSERT INTO distribution VALUES('2','32');
INSERT INTO distribution VALUES('2','12');
INSERT INTO distribution VALUES('3','1');
INSERT INTO distribution VALUES('3','31');
INSERT INTO distribution VALUES('4','8');
INSERT INTO distribution VALUES('4','2');
INSERT INTO distribution VALUES('4','13');
INSERT INTO distribution VALUES('4','6');
INSERT INTO distribution VALUES('4','7');
INSERT INTO distribution VALUES('5','3');
INSERT INTO distribution VALUES('5','4');
INSERT INTO distribution VALUES('5','14');
INSERT INTO distribution VALUES('5','22');
INSERT INTO distribution VALUES('6','9');
INSERT INTO distribution VALUES('6','20');
INSERT INTO distribution VALUES('6','17');
INSERT INTO distribution VALUES('6','11');
INSERT INTO distribution VALUES('6','21');
INSERT INTO distribution VALUES('7','16');
INSERT INTO distribution VALUES('7','25');
INSERT INTO distribution VALUES('7','30');
INSERT INTO distribution VALUES('7','26');
INSERT INTO distribution VALUES('8','5');
INSERT INTO distribution VALUES('8','18');
INSERT INTO distribution VALUES('8','24');
INSERT INTO distribution VALUES('8','28');
INSERT INTO distribution VALUES('8','6');
INSERT INTO distribution VALUES('8','10');
INSERT INTO distribution VALUES('9','23');
INSERT INTO distribution VALUES('9','19');
INSERT INTO distribution VALUES('9','29');
INSERT INTO distribution VALUES('9','30');
INSERT INTO distribution VALUES('9','24');

INSERT INTO programme VALUES('1','1','1','1','100');
INSERT INTO programme VALUES('1','2','1','2','20');
INSERT INTO programme VALUES('1','3','1','6','800');
INSERT INTO programme VALUES('1','4','1','7','245');
INSERT INTO programme VALUES('1','5','1','8','840');
INSERT INTO programme VALUES('2','1','1','1','250');
INSERT INTO programme VALUES('2','2','1','8','150');
INSERT INTO programme VALUES('3','1','1','2','600');
INSERT INTO programme VALUES('3','2','1','1','1300');
INSERT INTO programme VALUES('3','3','1','5','1402');
INSERT INTO programme VALUES('3','4','1','9','730');
INSERT INTO programme VALUES('3','5','1','4','100');
INSERT INTO programme VALUES('3','6','1','3','40');
INSERT INTO programme VALUES('5','1','1','2','1502');
INSERT INTO programme VALUES('5','2','1','8','210');
INSERT INTO programme VALUES('5','3','1','9','1200');
INSERT INTO programme VALUES('5','4','1','1','850');
INSERT INTO programme VALUES('5','5','1','5','1560');
INSERT INTO programme VALUES('6','1','1','4','400');
INSERT INTO programme VALUES('6','2','1','2','370');
INSERT INTO programme VALUES('6','3','1','6','240');
INSERT INTO programme VALUES('6','4','1','8','100');
INSERT INTO programme VALUES('6','5','1','9','100');
INSERT INTO programme VALUES('6','6','1','7','80');
INSERT INTO programme VALUES('7','1','1','5','600');
INSERT INTO programme VALUES('7','2','1','8','500');
INSERT INTO programme VALUES('7','3','1','7','200');
INSERT INTO programme VALUES('7','4','1','3','100');
INSERT INTO programme VALUES('7','5','1','2','100');
INSERT INTO programme VALUES('8','1','1','4','200');
INSERT INTO programme VALUES('8','2','1','2','150');
INSERT INTO programme VALUES('8','3','1','8','150');
INSERT INTO programme VALUES('9','1','1','7','600');
INSERT INTO programme VALUES('9','2','1','5','300');
INSERT INTO programme VALUES('9','3','1','3','300');
INSERT INTO programme VALUES('9','4','1','1','150');
INSERT INTO programme VALUES('9','5','1','6','100');
INSERT INTO programme VALUES('9','6','1','8','100');
INSERT INTO programme VALUES('1','1','2','1','130');
INSERT INTO programme VALUES('1','2','2','2','50');
INSERT INTO programme VALUES('1','3','2','6','550');
INSERT INTO programme VALUES('1','4','2','7','200');
INSERT INTO programme VALUES('1','5','2','8','100');
INSERT INTO programme VALUES('2','1','2','1','220');
INSERT INTO programme VALUES('2','2','2','8','50');
INSERT INTO programme VALUES('3','1','2','2','520');
INSERT INTO programme VALUES('3','2','2','1','1600');
INSERT INTO programme VALUES('3','3','2','5','2402');
INSERT INTO programme VALUES('3','4','2','9','930');
INSERT INTO programme VALUES('3','5','2','4','100');
INSERT INTO programme VALUES('3','6','2','3','80');
INSERT INTO programme VALUES('5','1','2','2','1012');
INSERT INTO programme VALUES('5','2','2','8','110');
INSERT INTO programme VALUES('5','3','2','9','1200');
INSERT INTO programme VALUES('5','4','2','1','850');
INSERT INTO programme VALUES('5','5','2','5','1820');
INSERT INTO programme VALUES('6','1','2','4','230');
INSERT INTO programme VALUES('6','2','2','2','123');
INSERT INTO programme VALUES('6','3','2','6','312');
INSERT INTO programme VALUES('6','4','2','8','57');
INSERT INTO programme VALUES('6','5','2','9','212');
INSERT INTO programme VALUES('6','6','2','7','180');
INSERT INTO programme VALUES('7','1','2','5','1200');
INSERT INTO programme VALUES('7','2','2','8','241');
INSERT INTO programme VALUES('7','3','2','7','242');
INSERT INTO programme VALUES('7','4','2','3','141');
INSERT INTO programme VALUES('7','5','2','2','120');
INSERT INTO programme VALUES('8','1','2','4','234');
INSERT INTO programme VALUES('8','2','2','2','121');
INSERT INTO programme VALUES('8','3','2','8','150');
INSERT INTO programme VALUES('9','1','2','7','600');
INSERT INTO programme VALUES('9','2','2','5','540');
INSERT INTO programme VALUES('9','3','2','3','289');
INSERT INTO programme VALUES('9','4','2','1','230');
INSERT INTO programme VALUES('9','5','2','6','123');
INSERT INTO programme VALUES('9','6','2','8','54');
INSERT INTO programme VALUES('1','1','3','1','110');
INSERT INTO programme VALUES('1','2','3','3','60');
INSERT INTO programme VALUES('1','3','3','6','730');
INSERT INTO programme VALUES('1','4','3','7','214');
INSERT INTO programme VALUES('1','5','3','8','276');
INSERT INTO programme VALUES('2','1','3','1','250');
INSERT INTO programme VALUES('2','2','3','9','150');
INSERT INTO programme VALUES('3','1','3','2','348');
INSERT INTO programme VALUES('3','2','3','1','1120');
INSERT INTO programme VALUES('3','3','3','5','1347');
INSERT INTO programme VALUES('3','4','3','9','678');
INSERT INTO programme VALUES('3','5','3','4','149');
INSERT INTO programme VALUES('3','6','3','3','118');
INSERT INTO programme VALUES('5','1','3','2','816');
INSERT INTO programme VALUES('5','2','3','8','168');
INSERT INTO programme VALUES('5','3','3','9','1316');
INSERT INTO programme VALUES('5','4','3','1','850');
INSERT INTO programme VALUES('5','5','3','5','1710');
INSERT INTO programme VALUES('6','1','3','4','342');
INSERT INTO programme VALUES('6','2','3','2','219');
INSERT INTO programme VALUES('6','3','3','6','380');
INSERT INTO programme VALUES('6','4','3','5','412');
INSERT INTO programme VALUES('6','5','3','9','234');
INSERT INTO programme VALUES('6','6','3','7','129');
INSERT INTO programme VALUES('7','1','3','5','843');
INSERT INTO programme VALUES('7','2','3','8','213');
INSERT INTO programme VALUES('7','3','3','7','245');
INSERT INTO programme VALUES('7','4','3','3','168');
INSERT INTO programme VALUES('7','5','3','2','102');
INSERT INTO programme VALUES('8','1','3','4','345');
INSERT INTO programme VALUES('8','2','3','2','141');
INSERT INTO programme VALUES('8','3','3','8','50');
INSERT INTO programme VALUES('9','1','3','7','832');
INSERT INTO programme VALUES('9','2','3','5','356');
INSERT INTO programme VALUES('9','3','3','3','450');
INSERT INTO programme VALUES('9','4','3','1','215');
INSERT INTO programme VALUES('9','5','3','6','234');
INSERT INTO programme VALUES('9','6','3','8','100');
INSERT INTO programme VALUES('1','1','4','9','210');
INSERT INTO programme VALUES('1','2','4','3','100');
INSERT INTO programme VALUES('1','3','4','6','600');
INSERT INTO programme VALUES('1','4','4','7','189');
INSERT INTO programme VALUES('1','5','4','2','210');
INSERT INTO programme VALUES('2','1','4','1','214');
INSERT INTO programme VALUES('2','2','4','6','310');
INSERT INTO programme VALUES('3','1','4','7','390');
INSERT INTO programme VALUES('3','2','4','1','1076');
INSERT INTO programme VALUES('3','3','4','5','1007');
INSERT INTO programme VALUES('3','4','4','9','610');
INSERT INTO programme VALUES('3','5','4','4','234');
INSERT INTO programme VALUES('3','6','4','3','289');
INSERT INTO programme VALUES('5','1','4','2','816');
INSERT INTO programme VALUES('5','2','4','3','345');
INSERT INTO programme VALUES('5','3','4','9','1009');
INSERT INTO programme VALUES('5','4','4','1','750');
INSERT INTO programme VALUES('5','5','4','5','910');
INSERT INTO programme VALUES('6','1','4','4','284');
INSERT INTO programme VALUES('6','2','4','1','320');
INSERT INTO programme VALUES('6','3','4','6','413');
INSERT INTO programme VALUES('6','4','4','5','349');
INSERT INTO programme VALUES('6','5','4','9','274');
INSERT INTO programme VALUES('7','1','4','7','358');
INSERT INTO programme VALUES('7','1','4','5','528');
INSERT INTO programme VALUES('7','2','4','8','101');
INSERT INTO programme VALUES('7','3','4','7','278');
INSERT INTO programme VALUES('7','4','4','6','389');
INSERT INTO programme VALUES('7','5','4','2','62');
INSERT INTO programme VALUES('8','1','4','4','418');
INSERT INTO programme VALUES('8','2','4','2','106');
INSERT INTO programme VALUES('8','3','4','9','261');
INSERT INTO programme VALUES('9','1','4','7','548');
INSERT INTO programme VALUES('9','2','4','5','219');
INSERT INTO programme VALUES('9','3','4','3','240');
INSERT INTO programme VALUES('9','4','4','1','319');
INSERT INTO programme VALUES('9','5','4','6','289');
INSERT INTO programme VALUES('9','6','4','4','381');
INSERT INTO programme VALUES('9','2','5','5','400');
INSERT INTO programme VALUES('8','3','5','9','400');

GRANT SELECT, INSERT, UPDATE, DELETE, INDEX ON cinemas.* TO 'app_SqlTrainingUser'@'%' IDENTIFIED BY '€tudiantsSio@2027';
FLUSH PRIVILEGES;