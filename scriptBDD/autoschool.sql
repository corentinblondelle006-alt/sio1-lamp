USE autoschool;

-- ---------------------------------
--        CREATION DES TABLES
-- ---------------------------------

CREATE TABLE Eleve (
	id int auto_increment,
	nom varchar(50) not null,
	date_inscription date not null,
	prenom varchar(50) not null,
	adresse varchar(100) not null,
	ville varchar(80) not null,
	cp char(5) not null,
	credit_horaire int DEFAULT 0,
	PRIMARY KEY (id)
);

CREATE TABLE Vehicule (
	id int auto_increment,
	immatriculation varchar(15) not null,
	modele varchar(30) not null,
	couleur varchar(20) not null,
	PRIMARY KEY (id)
);

CREATE TABLE Lecon (
	date_lecon date not null,
	eleve_id int not null,
	heure char(5) not null,
	duree int DEFAULT 1,
	faite boolean not null,
	vehicule_id int not null,
	PRIMARY KEY (date_lecon, eleve_id),
	FOREIGN KEY(eleve_id) REFERENCES Eleve(id),
	FOREIGN KEY(vehicule_id) REFERENCES Vehicule(id)
);


INSERT INTO Eleve VALUES
(null, 'AUBRY', '2023-05-16', 'Bertrand', '25, rue Randon', 'Grenoble', '38000', 18),
(null, 'BLONDEL', '2023-06-13', 'Xavier', '10, place Martin', 'Echirolles', '38130', 19),
(null, 'BONNET', '2023-06-15', 'Sandrine', '18, rue Bresson', 'Eybens', '38320', 15),
(null, 'DEVOLDER', '2023-07-06', 'Vincent', '65, rue du Palais', 'Grenoble', '38000', 20),
(null, 'DUFOUR', '2023-07-10', 'Charlotte', '25, rue du Parc', 'Seyssins', '38180', 20),
(null, 'GALLE', '2023-07-12', 'Audrey', '5, quai Mounier', 'Grenoble', '38000', 17),
(null, 'GOODWIN', '2023-07-13', 'Laurent', '12, rue de la Paix', 'Grenoble', '38000', 14);

INSERT INTO Vehicule VALUES
(1, 'BA-156-GA', '207', 'Blanche'),
(2, 'FF-462-GH', '207', 'Bleue'),
(3, 'XS-785-LI', '308', 'Blanche'),
(4, 'BX-38-FG', '207', 'Bleue'),
(5, 'JH-131-KN', '308', 'Verte'),
(6, 'AE-84-CH', 'Clio', 'Grise'),
(7, 'BE-253-LN', 'Clio', 'Noire');

INSERT INTO Lecon VALUES
('2023-05-17', 2, '13:00', 1, 1, 3),
('2023-06-14', 1, '12:00', 2, 1, 1),
('2023-06-16', 3, '14:00', 2, 1, 1),
('2023-06-24', 7, '16:00', 1, 1, 7),
('2023-07-13', 6, '10:00', 2, 1, 1),
('2023-07-17', 7, '10:00', 1, 1, 6),
('2023-07-27', 2, '17:00', 1, 1, 4),
('2023-08-12', 4, '12:00', 1, 0, 7),
('2023-08-13', 5, '15:30', 1, 1, 3),
('2023-12-16', 7, '15:30', 1, 0, 2),
('2023-12-19', 6, '14:00', 2, 0, 5);

-- Créer un utilisateur pour l'application (optionnel)
GRANT SELECT, INSERT, UPDATE, DELETE, CREATE, ALTER, DROP, INDEX ON autoschool.* TO 'app_SqlTrainingUser'@'%' IDENTIFIED BY '€tudiantsSio@2027';
FLUSH PRIVILEGES;