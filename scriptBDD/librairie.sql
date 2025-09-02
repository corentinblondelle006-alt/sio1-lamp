-- Création de la base de données
DROP DATABASE IF EXISTS `librairie`;
CREATE DATABASE `librairie`;
USE librairie;

-- Table des auteurs
CREATE TABLE auteurs (
    id INT PRIMARY KEY AUTO_INCREMENT,
    nom VARCHAR(50) NOT NULL,
    prenom VARCHAR(50) NOT NULL,
    nationalite VARCHAR(30),
    date_naissance DATE,
    date_deces DATE DEFAULT NULL
);

-- Table des catégories
CREATE TABLE categories (
    id INT PRIMARY KEY AUTO_INCREMENT,
    nom VARCHAR(50) NOT NULL UNIQUE,
    description TEXT
);

-- Table des livres
CREATE TABLE livres (
    id INT PRIMARY KEY AUTO_INCREMENT,
    titre VARCHAR(100) NOT NULL,
    auteur_id INT NOT NULL,
    categorie_id INT NOT NULL,
    prix DECIMAL(6,2),
    stock INT DEFAULT 0,
    date_publication DATE,
    isbn VARCHAR(13) UNIQUE,
    FOREIGN KEY (auteur_id) REFERENCES auteurs(id),
    FOREIGN KEY (categorie_id) REFERENCES categories(id),
    CONSTRAINT chk_prix CHECK (prix >= 0),
    CONSTRAINT chk_stock CHECK (stock >= 0)
);

-- Table des clients
CREATE TABLE clients (
    id INT PRIMARY KEY AUTO_INCREMENT,
    nom VARCHAR(50) NOT NULL,
    prenom VARCHAR(50) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    telephone VARCHAR(15),
    adresse TEXT,
    ville VARCHAR(50),
    code_postal VARCHAR(5),
    date_inscription DATE DEFAULT CURRENT_DATE,
    statut ENUM('actif', 'inactif', 'suspendu') DEFAULT 'actif'
);

-- Table des commandes
CREATE TABLE commandes (
    id INT PRIMARY KEY AUTO_INCREMENT,
    client_id INT NOT NULL,
    date_commande DATE DEFAULT CURRENT_DATE,
    statut ENUM('en_attente', 'confirmee', 'expediee', 'livree', 'annulee') DEFAULT 'en_attente',
    montant_total DECIMAL(8,2) DEFAULT 0,
    FOREIGN KEY (client_id) REFERENCES clients(id)
);

-- Table de liaison commandes-livres
CREATE TABLE commande_livres (
    id INT PRIMARY KEY AUTO_INCREMENT,
    commande_id INT NOT NULL,
    livre_id INT NOT NULL,
    quantite INT NOT NULL CHECK (quantite > 0),
    prix_unitaire DECIMAL(6,2) NOT NULL,
    FOREIGN KEY (commande_id) REFERENCES commandes(id) ON DELETE CASCADE,
    FOREIGN KEY (livre_id) REFERENCES livres(id)
);

-- Insertion des données

-- Auteurs
INSERT INTO auteurs (nom, prenom, nationalite, date_naissance, date_deces) VALUES
('Hugo', 'Victor', 'Française', '1802-02-26', '1885-05-22'),
('Camus', 'Albert', 'Française', '1913-11-07', '1960-01-04'),
('Proust', 'Marcel', 'Française', '1871-07-10', '1922-11-18'),
('Duras', 'Marguerite', 'Française', '1914-04-04', '1996-03-03'),
('Musso', 'Guillaume', 'Française', '1974-06-06', NULL),
('Pancol', 'Katherine', 'Française', '1954-10-22', NULL),
('Tolkien', 'John Ronald Reuel', 'Britannique', '1892-01-03', '1973-09-02'),
('Rowling', 'Joanne Kathleen', 'Britannique', '1965-07-31', NULL),
('Orwell', 'George', 'Britannique', '1903-06-25', '1950-01-21'),
('Christie', 'Agatha', 'Britannique', '1890-09-15', '1976-01-12');

-- Catégories
INSERT INTO categories (nom, description) VALUES
('Roman classique', 'Grandes œuvres de la littérature'),
('Roman contemporain', 'Romans modernes et actuels'),
('Science-fiction', 'Littérature imaginaire et futuriste'),
('Fantastique', 'Œuvres mêlant réel et imaginaire'),
('Policier', 'Romans policiers et thrillers'),
('Jeunesse', 'Livres destinés aux enfants et adolescents'),
('Biographie', 'Récits de vie de personnalités'),
('Histoire', 'Ouvrages historiques et documentaires');

-- Livres
INSERT INTO livres (titre, auteur_id, categorie_id, prix, stock, date_publication, isbn) VALUES
('Les Misérables', 1, 1, 12.90, 15, '1862-01-01', '9782070409228'),
('Notre-Dame de Paris', 1, 1, 10.50, 8, '1831-01-01', '9782070409235'),
('L''Étranger', 2, 1, 8.90, 12, '1942-01-01', '9782070360024'),
('La Peste', 2, 1, 9.50, 10, '1947-01-01', '9782070360031'),
('Du côté de chez Swann', 3, 1, 11.20, 5, '1913-01-01', '9782070409242'),
('L''Amant', 4, 1, 7.80, 6, '1984-01-01', '9782070379941'),
('Sauve-moi', 5, 2, 19.90, 25, '2005-01-01', '9782845634923'),
('Et après...', 5, 2, 18.50, 20, '2004-01-01', '9782845634930'),
('Les Yeux jaunes des crocodiles', 6, 2, 21.90, 18, '2006-01-01', '9782226172617'),
('La Valse lente des tortues', 6, 2, 22.50, 15, '2008-01-01', '9782226172624'),
('Le Seigneur des Anneaux', 7, 4, 29.90, 12, '1954-07-29', '9782070612888'),
('Bilbo le Hobbit', 7, 4, 16.90, 20, '1937-09-21', '9782070612895'),
('Harry Potter à l''école des sorciers', 8, 6, 17.90, 30, '1997-06-26', '9782070541270'),
('Harry Potter et la Chambre des secrets', 8, 6, 18.50, 25, '1998-07-02', '9782070541287'),
('1984', 9, 3, 9.90, 22, '1949-06-08', '9782070368228'),
('La Ferme des animaux', 9, 3, 8.50, 18, '1945-08-17', '9782070375189'),
('Le Crime de l''Orient-Express', 10, 5, 7.90, 14, '1934-01-01', '9782253004615'),
('Dix Petits Nègres', 10, 5, 8.20, 16, '1939-11-06', '9782253004622'),
('Les écureuils de Central Park sont tristes le lundi', 6, 2, 25.90, 3, '2010-01-01', '9782226208316');

-- Clients
INSERT INTO clients (nom, prenom, email, telephone, adresse, ville, code_postal, date_inscription, statut) VALUES
('Martin', 'Jean', 'jean.martin@email.fr', '0123456789', '15 rue de la Paix', 'Paris', '75001', '2023-01-15', 'actif'),
('Dubois', 'Marie', 'marie.dubois@email.fr', '0123456790', '8 avenue Victor Hugo', 'Lyon', '69001', '2023-02-20', 'actif'),
('Durand', 'Pierre', 'pierre.durand@email.fr', '0123456791', '22 boulevard Saint-Michel', 'Marseille', '13001', '2023-03-10', 'actif'),
('Moreau', 'Sophie', 'sophie.moreau@email.fr', '0123456792', '5 place de la République', 'Toulouse', '31000', '2023-04-05', 'actif'),
('Petit', 'Paul', 'paul.petit@email.fr', '0123456793', '12 rue des Lilas', 'Nice', '06000', '2023-05-12', 'inactif'),
('Rousseau', 'Julie', 'julie.rousseau@email.fr', '0123456794', '30 avenue de la Liberté', 'Strasbourg', '67000', '2023-06-18', 'actif'),
('Blanc', 'Thomas', 'thomas.blanc@email.fr', '0123456795', '7 rue du Commerce', 'Bordeaux', '33000', '2023-07-22', 'actif'),
('Fournier', 'Emma', 'emma.fournier@email.fr', '0123456796', '18 place Bellecour', 'Lyon', '69002', '2023-08-30', 'suspendu'),
('Garcia', 'Lucas', 'lucas.garcia@email.fr', '0123456797', '25 rue de Rivoli', 'Paris', '75004', '2023-09-14', 'actif'),
('Bernard', 'Léa', 'lea.bernard@email.fr', '0123456798', '3 avenue Jean Jaurès', 'Lille', '59000', '2023-10-08', 'actif');

-- Commandes
INSERT INTO commandes (client_id, date_commande, statut, montant_total) VALUES
(1, '2024-01-15', 'livree', 45.80),
(2, '2024-01-18', 'livree', 29.90),
(3, '2024-01-22', 'expediee', 67.50),
(1, '2024-02-01', 'confirmee', 38.40),
(4, '2024-02-05', 'livree', 22.80),
(5, '2024-02-10', 'annulee', 20.00),
(6, '2024-02-15', 'livree', 55.70),
(7, '2024-02-20', 'expediee', 41.30),
(2, '2024-02-25', 'en_attente', 73.60),
(9, '2024-03-01', 'confirmee', 34.90);

-- Détails des commandes
INSERT INTO commande_livres (commande_id, livre_id, quantite, prix_unitaire) VALUES
-- Commande 1 (Jean Martin)
(1, 1, 2, 12.90),
(1, 3, 2, 8.90),
(1, 15, 1, 9.90),

-- Commande 2 (Marie Dubois)
(2, 11, 1, 29.90),

-- Commande 3 (Pierre Durand)
(3, 13, 2, 17.90),
(3, 5, 1, 11.20),
(3, 17, 2, 7.90),
(3, 6, 2, 7.80),

-- Commande 4 (Jean Martin)
(4, 9, 1, 21.90),
(4, 16, 2, 8.50),

-- Commande 5 (Sophie Moreau)
(5, 4, 1, 9.50),
(5, 2, 1, 10.50),

-- Commande 7 (Julie Rousseau)
(7, 12, 2, 16.90),
(7, 8, 1, 18.50),

-- Commande 8 (Thomas Blanc)
(8, 7, 1, 19.90),
(8, 10, 1, 22.50),

-- Commande 9 (Marie Dubois)
(9, 14, 3, 18.50),
(9, 15, 1, 9.90),

-- Commande 10 (Lucas Garcia)
(10, 18, 3, 8.20),
(10, 17, 1, 7.90);

-- Créer un utilisateur pour l'application (optionnel)
GRANT SELECT, INSERT, UPDATE, DELETE, CREATE, ALTER, DROP, INDEX ON librairie.* TO 'app_SqlTrainingUser'@'%' IDENTIFIED BY '€tudiantsSio@2027';
FLUSH PRIVILEGES;

