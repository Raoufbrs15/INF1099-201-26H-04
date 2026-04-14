📦 INF1099 – PostgreSQL avec Docker (Podman) et pgAdmin 4

🎯 Objectif du TP



Ce laboratoire a pour objectif de :



Vérifier l’installation de Docker (via Podman Engine)

Déployer un conteneur PostgreSQL

Créer une base de données appdb

Télécharger et importer la base de données Sakila

Tester les tables avec psql

Se connecter via pgAdmin 4

Exécuter des requêtes SQL

1️⃣ Vérification de Docker

Vérifier la version

docker version

Vérifier les informations système

docker info

1=



✔ Docker fonctionne avec Podman Engine

✔ Architecture : amd64

✔ API Version : 5.7.1



2️⃣ Lancement du conteneur PostgreSQL

docker container run -d `

\--name postgres `

\-e POSTGRES\_USER=postgres `

\-e POSTGRES\_PASSWORD=postgres `

\-e POSTGRES\_DB=appdb `

\-p 5432:5432 `

\-v pgdata:/var/lib/postgresql/data `

postgres:16

2=



3️⃣ Vérification du conteneur

docker container ls

3=



✔ Le conteneur postgres est en état Up

✔ Port exposé : 5432



4️⃣ Vérification des logs

docker container logs postgres



Message attendu :



database system is ready to accept connections



4=



✔ PostgreSQL est prêt



5️⃣ Création du dossier Sakila

mkdir sakila\_pg

cd sakila\_pg



5=



6️⃣ Téléchargement des fichiers Sakila

Invoke-WebRequest `

https://raw.githubusercontent.com/jOOQ/sakila/master/postgres-sakila-db/postgres-sakila-schema.sql `

\-OutFile postgres-sakila-schema.sql



Invoke-WebRequest `

https://raw.githubusercontent.com/jOOQ/sakila/master/postgres-sakila-db/postgres-sakila-insert-data.sql `

\-OutFile postgres-sakila-insert-data.sql

Vérification

dir



6=





✔ Les deux fichiers sont présents



7️⃣ Copier les fichiers dans le conteneur

docker container cp .\\postgres-sakila-schema.sql postgres:/schema.sql

docker container cp .\\postgres-sakila-insert-data.sql postgres:/data.sql



7=



8️⃣ Importer le schéma

docker container exec -it postgres psql -U postgres -d appdb -f /schema.sql



8=



✔ Création des tables réussie



9️⃣ Importer les données

docker container exec -it postgres psql -U postgres -d appdb -f /data.sql



9=



✔ Données insérées avec succès



🔟 Vérification avec psql



Connexion :



docker container exec -it postgres psql -U postgres -d appdb



Lister les tables :



\\dt



10=



✔ 21 tables créées



1️⃣1️⃣ Requêtes de vérification

Compter les films

SELECT COUNT(\*) FROM film;



Résultat : 1000 films



Compter les acteurs

SELECT COUNT(\*) FROM actor;



Résultat : 200 acteurs



11=



1️⃣2️⃣ Installation de pgAdmin 4

choco install pgadmin4 -y



12=



✔ Installation réussie



1️⃣3️⃣ Configuration du serveur dans pgAdmin

General

Name : Postgres Docker

Connection

Host : localhost

Port : 5432

Database : appdb

Username : postgres

Password : postgres



13=



✔ Connexion réussie



1️⃣4️⃣ Vérification des tables dans pgAdmin



Chemin :



Servers → Postgres Docker → Databases → appdb → Schemas → public → Tables



14=



✔ Les 21 tables sont visibles





1️⃣5️⃣ Exécution de requêtes SQL dans pgAdmin

SELECT title

FROM film

WHERE title ILIKE '%Star%';



Résultat :



STAR OPERATION

TURN STAR



15=



✅ Conclusion



Dans ce TP nous avons :



Déployé PostgreSQL avec Docker (Podman)

Importé la base de données Sakila

Vérifié les tables avec psql

Installé et configuré pgAdmin 4

Exécuté des requêtes SQL avec succès



✔ Le système fonctionne correctement

✔ La base contient 1000 films et 200 acteurs



🚀 TP Réussi

👤 Auteur



Nom : Kahil Amine

Numéro étudiant : 300151292

🎓 Programme : INF1099

🏫 Collège Boréal

📅 Année : 2026

