# Principales commandes pour gérer vos multi-conteneurs

Les commandes indiquées sont à exécuter dans le terminal intégré à VS Code.

## Les conteneurs

* Démarrer le conteneur : `docker compose up -d --wait`

  - `-d` : permet de démarrer en mode « detach ­­» (en arrière plan), c'est-à-dire que le terminal n'est pas bloqué, on reprend la main
  - `--wait` : attend que tous les services soient considérés comme "prêts" avant de rendre la main


* Reconstruit les services qui ont une section build dans le *docker-compose.yml* : : `docker compose build`

  Utilise normalement le cache Docker pour accélérer le processus 

* Reconstruit les services sans utiliser le cache : `docker compose build --no-cache`

  A utiliser dans les cas suivants : 
  - Problèmes de cache corrompu : si tu suspectes que le cache contient des données incorrectes
  - Pour effectuer une mise à jour forcée des dépendances et s'assurer d'avoir les dernières versions des packages
  - Quand une image se comporte bizarrement et tu veux éliminer les problèmes liés au cache
  - Pour une reconstruction complètement fraîche

* Arrêter tous les conteneurs du multi-conteneur :  `docker compose stop`

* Arrêter et supprimer tous les conteneurs du multi-conteneur :  `docker compose down`

* Obtenir la liste des conteneurs démarrés :
`docker ps`

* Obtenir la liste de tous les conteneurs (démarrés ou non) :
`docker ps -a`

* Obtenir la liste de tous les conteneurs (démarrés ou non) :
`docker ps -a`

## Se connecter aux serveurs

* Se connecter à un conteneur : `docker exec -ti <Nom du conteneur> bash`
  
  *Par exemple,* 
  - *Pour vous connecter à votre serveur web :* `docker exec -ti lampsio1_www bash`
  - *Pour vous connecter à votre serveur de base de données :* `docker exec -ti lampsio1_database bash`

* Une fois connecté au serveur de base de données, la connexion à *__mariadb__* se fait à l'aide de la commande `mariadb -h localhost -u root -p`

  Le mot de passe sera demandé.

  - `-h` : permet de définir l'hôte
  - `-u` : permet d'indiquer le compte utilisateur
  - `-p` : permet d'indiquer le mot de passe. S'il n'est pas renseigné, il est demandé par la suite.  

  **Remarque** : l'image utilisée pour le seveur de bases de données contient le client `mariadb` et non le client `mysql` comme cela peut être le cas sur les packages tels que WampServer, Xampp, ...) . On utilise donc ici la commande mariadb.

## Les images

* Obtenir la liste des images utilisées :
`docker images`

* Obtenir la liste de toutes les images (utilisées ou non) :
`docker images -a`

* Supprime toutes les images dangling c'est à dire qui ne sont référencées par aucun tag (garde toutes les images taguées même si elles ne sont pas utilisées) :
`docker image prune`

* Supprime toutes les images les images non utilisées (images dangling et celles qui ont des tags mais qui ne sont associées à aucun conteneur)  :
`docker image prune -a`

## Les volumes

* Obtenir la liste des volumes utilisés docker:
`docker volume ls`

* Supprimer un volume
`docker volume rm <nom_du_volume>`

* Supprime les volumes inutilisés :
`docker volume prune`

## Supprimer un conteneur à l'intérieur d'un multi-conteneur 

Cela peut s'avérer utiler pour permettre de réinitialiser un des conteneurs sans avoir à tout recréer.

Exemple du conteneur mariadb :

Dans le fichier docker-compose.yml, on trouve :
* le nom du service : *database*
* le nom du volume : *db_data*

Le nom du projet est, quant à lui, défini dans la variable d'environnement COMPOSE_PROJECT_NAME : *lampsio1*


Pour supprimer le conteneur et tout ce qui est associé : 

1. Arrêter le conteneur mariadb : on utilise le nom du service

      `docker-compose stop database`

2. Supprimer le conteneur mariadb : on utilise le nom du service

      `docker-compose rm -f database`

3. Supprimer le volume : on utilise le nom du projet et le nom du volume

      `docker volume rm lampsio1_db_data` 

4. Recréer le conteneur : on utilise le nom du service

      `docker-compose up -d database`

# Ajouter une nouvelle base de données dans mariadb à l'aide d'un script sql

Par exemple, le fichier `script_bdd.sql` contient toutes les instructions permettant de créer la base de données, les tables, les données des tables et éventuellement de créer un compte utilisateur avec des droits limmité à cette base de données.

* Placer le fichier **script_bdd.sql** à la racine du projet

* Exécuter l'une des commandes ci-après : on utilise ici le nom du conteneur (*lampsio1_database*) à l'intérieur du multi-conteneur 

  - Dans un terminal **cmd** ou **git Bash** :

      `docker exec -i lampsio1_database mariadb -u root -psio2027@rostand < ./scriptBDD\bdd.sql`

  - Dans un terminal **Powershell** :

      `type .\script_bdd.sql | docker exec -i lampsio1_database mariadb -u root -psio2027@rostand`
       

En fait, ici on réalise on exécute la commande **mariadb -u root -p < ./script_bdd.sql** dans le conteneur nommé **lampsio1_database**.

