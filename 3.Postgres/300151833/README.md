📚 TP 03 - PostgreSQL DB

---

## 🎯 Objectif

Installer PostgreSQL avec Docker, charger la base Sakila et explorer les données avec pgAdmin.

---

## 📥 Téléchargement des fichiers Sakila

```powershell
Invoke-WebRequest https://raw.githubusercontent.com/jOOQ/sakila/master/postgres-sakila-db/postgres-sakila-schema.sql -OutFile schema.sql
Invoke-WebRequest https://raw.githubusercontent.com/jOOQ/sakila/master/postgres-sakila-db/postgres-sakila-insert-data.sql -OutFile data.sql
🚀 Lancement PostgreSQL avec Docker
docker container run -d --name postgres -e POSTGRES_USER=postgres -e POSTGRES_PASSWORD=postgres -e POSTGRES_DB=appdb -p 5432:5432 postgres:16
🔗 Connexion à PostgreSQL
docker container exec -it postgres psql -U postgres -d appdb
📊 Liste des tables (Capture 1)
<img width="477" height="577" alt="3" src="https://github.com/user-attachments/assets/aec71036-06f5-4ebe-ab56-256ce2957903" />

<img width="1078" height="141" alt="Capture d’écran 2026-04-20 165528" src="https://github.com/user-attachments/assets/657842cc-34fd-455b-a0ef-f0001d5c21e3" />

➡️ Dans le terminal PostgreSQL (psql)

📍 Commande utilisée :

\dt

🔍 Exploration de la base Sakila

➡️ Dans pgAdmin (menu à gauche avec les tables)

<img width="1920" height="1012" alt="5" src="https://github.com/user-attachments/assets/02b46e8d-fc61-4e54-89d7-95714fade063" />


🧪 Exercice 1 — Films contenant "Star" 
➡️ Dans pgAdmin → Query Tool
<img width="1261" height="945" alt="6" src="https://github.com/user-attachments/assets/482e541f-32ac-47b0-ae6c-4a4da6430761" />

SELECT title FROM film WHERE title ILIKE '%Star%';

<img width="638" height="772" alt="08" src="https://github.com/user-attachments/assets/b73d5645-c975-4925-94b5-22daf0d4aa4c" />

🧪 Exercice 2 — Nombre d’acteurs (Capture 3)

➡️ Dans pgAdmin → Query Tool

SELECT COUNT(*) FROM actor;

<img width="1261" height="945" alt="6" src="https://github.com/user-attachments/assets/2d3f863d-4c3f-49d4-a964-dff8368076fb" />


🧪 Exercice 3 — Nombre de films 

➡️ Dans pgAdmin → Query Tool

SELECT COUNT(*) FROM film;

🧪 Exercice 4 — Exemple de clients 

📍 Où faire la capture ?
➡️ Dans pgAdmin → Query Tool

SELECT customer_id, first_name, last_name, email
FROM customer
LIMIT 5;

<img width="872" height="754" alt="09" src="https://github.com/user-attachments/assets/c3749609-82f2-4603-8ee4-85fc1a7de252" />

📁 Structure du projet
📁 projet
 ├── README.md
 ├── 📁 images
 │    ├── tables.png
 │    ├── pgadmin.png
 │    ├── star.png
 │    ├── actor.png
 │    ├── film.png
 │    ├── customer.png
