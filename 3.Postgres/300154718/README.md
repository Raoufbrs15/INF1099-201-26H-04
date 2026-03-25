# ✈️ TP PostgreSQL — Base de données Airline

<div align="center">

![PostgreSQL](https://img.shields.io/badge/PostgreSQL-16-336791?style=for-the-badge&logo=postgresql&logoColor=white)
![Docker](https://img.shields.io/badge/Docker-Container-2496ED?style=for-the-badge&logo=docker&logoColor=white)
![pgAdmin](https://img.shields.io/badge/pgAdmin-4-336791?style=for-the-badge&logo=postgresql&logoColor=white)

*Déploiement d'une base de données relationnelle pour une compagnie aérienne via Docker*

</div>

---

## 📌 Description

Ce travail consiste à installer **PostgreSQL** dans un conteneur **Docker**, créer une base de données pour une compagnie aérienne, ajouter les tables, insérer des données et tester des requêtes SQL. L'outil **pgAdmin** est utilisé pour visualiser les données.

---

## 🚀 1. Lancement du conteneur PostgreSQL

```bash
docker container run -d `
  --name postgres-airline `
  -e POSTGRES_USER=postgres `
  -e POSTGRES_PASSWORD=postgres `
  -e POSTGRES_DB=airline_db `
  -p 5432:5432 `
  -v postgres_airline_data:/var/lib/postgresql/data `
  postgres:16
```

> 📸 **Capture :** conteneur en cours d'exécution avec `docker container ls`

---

## 🔍 2. Vérification de Docker

```bash
docker version
```

> 📸 **Capture :** Docker en fonctionnement

---

## 🔗 3. Connexion à PostgreSQL

```bash
docker exec -it postgres-airline psql -U postgres -d airline_db
```

> 📸 **Capture :** connexion réussie avec `airline_db=#`

---

## 🏗️ 4. Création des tables

Création des tables pour le système de gestion d'une compagnie aérienne :

| # | Table | Description |
|---|-------|-------------|
| 1 | `passager` | Informations sur les passagers |
| 2 | `adresse` | Adresses associées aux passagers |
| 3 | `reservation` | Réservations effectuées |
| 4 | `paiement` | Détails des paiements |
| 5 | `billet` | Billets émis |
| 6 | `bagage` | Bagages enregistrés |
| 7 | `compagnie` | Compagnies aériennes |
| 8 | `avion` | Flotte d'avions |
| 9 | `vol` | Vols planifiés |
| 10 | `aeroport` | Aéroports de départ/arrivée |
| 11 | `porte` | Portes d'embarquement |

> 📸 **Capture :** résultat de la commande `\dt`

---

## 📊 5. Structure d'une table

```sql
\d passager
```

> 📸 **Capture :** structure de la table `passager`

---

## 📥 6. Insertion des données

```sql
INSERT INTO passager (nom, prenom, telephone, email, numero_passeport)
VALUES ('Tidjet', 'Stephane', '4370001111', 'stephane@email.com', 'P12345678');
```

> 📸 **Capture :** données insérées avec `SELECT * FROM passager;`

---

## 📋 7. Vérification des données

```sql
SELECT * FROM vol;
```

> 📸 **Capture :** données des vols

---

## 🔗 8. Requête JOIN

```sql
SELECT 
    p.nom,
    p.prenom,
    b.numero_billet,
    v.numero_vol
FROM billet b
JOIN reservation r ON b.reservation_id = r.id
JOIN passager p ON r.passager_id = p.id
JOIN vol v ON b.vol_id = v.id;
```

> 📸 **Capture :** résultat de la requête JOIN

---

## 🖥️ 9. Connexion avec pgAdmin

| Paramètre | Valeur |
|-----------|--------|
| **Host** | `localhost` |
| **Port** | `5432` |
| **Username** | `postgres` |
| **Password** | `postgres` |
| **Database** | `airline_db` |

> 📸 **Capture :** connexion réussie

---

## 📂 10. Visualisation des tables dans pgAdmin

**Navigation :**

```
Databases → airline_db → Schemas → public → Tables
```

> 📸 **Capture :** liste des tables

---

## 👀 11. Visualisation des données

**Action :**
> Click droit → **View/Edit Data** → **All Rows**

> 📸 **Capture :** affichage des données

---

## ✅ Conclusion

Ce TP m'a permis de comprendre comment :

- 🐳 Installer **PostgreSQL** avec **Docker**
- 🗄️ Créer une **base de données relationnelle**
- 🏗️ Ajouter des **tables avec des relations**
- 📥 **Insérer des données** et exécuter des **requêtes SQL**
- 🖥️ Utiliser **pgAdmin** pour visualiser et gérer les données facilement

---

<div align="center">

*Réalisé dans le cadre d'un TP sur la gestion de bases de données avec PostgreSQL et Docker*

</div>
