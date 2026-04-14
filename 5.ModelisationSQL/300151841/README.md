 <div align="center">

# 🎮 TP Modélisation SQL
### Gestion de tournois e-sport

![PostgreSQL](https://img.shields.io/badge/PostgreSQL-16-336791?style=for-the-badge&logo=postgresql&logoColor=white)
![Docker](https://img.shields.io/badge/Docker-Podman-2496ED?style=for-the-badge&logo=docker&logoColor=white)
![SQL](https://img.shields.io/badge/SQL-DDL%20%7C%20DML%20%7C%20DCL-00f5a0?style=for-the-badge&logo=databricks&logoColor=white)
![Cours](https://img.shields.io/badge/Cours-INF1099-a855f7?style=for-the-badge)

> Conception et implémentation d'une base de données relationnelle pour la gestion de tournois e-sport.

**Auteur :** Massinissa Mameri &nbsp;|&nbsp; **Schéma :** `esport` &nbsp;|&nbsp; **SGBD :** PostgreSQL 16

</div>

---

## 📋 Table des matières

- [🎯 Aperçu du projet](#-aperçu-du-projet)
- [🔄 Normalisation](#-normalisation)
- [🚀 Démarrage rapide](#-démarrage-rapide)
- [🏗️ DDL — Définition des structures](#️-ddl--définition-des-structures)
- [📝 DML — Manipulation des données](#-dml--manipulation-des-données)
- [🔎 Requêtes SELECT](#-requêtes-select)
- [🔐 DCL — Gestion des accès](#-dcl--gestion-des-accès)
- [🎯 Conclusion](#-conclusion)

---

## 🎯 Aperçu du projet

La base de données permet de gérer :

| Entité | Description |
|--------|-------------|
| 🎮 **Jeux** | Les jeux e-sport utilisés dans les compétitions |
| 🏆 **Tournois** | Les tournois organisés |
| ⚔️ **Matchs** | Les matchs disputés par round et date |
| 👥 **Équipes** | Les équipes participantes |
| 🕹️ **Joueurs** | Les joueurs avec pseudo et email |
| 📊 **Scores** | Les scores par équipe et par match |
| 🔗 **Compositions** | La composition des équipes (`team_member`) |

**Concepts appliqués :** modélisation · normalisation · gestion des droits d'accès SQL

---

## 🔄 Normalisation

### 1️⃣ Première Forme Normale (1FN)

- Attributs **atomiques** — aucune répétition de colonnes
- Une **clé primaire unique** par table
- Entités : `game`, `tournament`, `match`, `team`, `player`

### 2️⃣ Deuxième Forme Normale (2FN)

Dépendances partielles éliminées par séparation des entités :

| Entité A | Relation | Entité B |
|----------|----------|----------|
| `Game` | est utilisé dans | `Tournament` |
| `Tournament` | contient | `Match` |
| `Match` | implique | `Team` |
| `Team` | possède | `Player` |

### 3️⃣ Troisième Forme Normale (3FN)

Dépendances transitives supprimées — relations assurées par **clés étrangères**.

**Tables finales :**

| Table | Description | Clé primaire |
|-------|-------------|--------------|
| `game` | Jeux e-sport | `game_id` |
| `tournament` | Tournois | `tournament_id` |
| `match` | Matchs | `match_id` |
| `team` | Équipes | `team_id` |
| `player` | Joueurs | `player_id` |
| `match_team` | Participation des équipes aux matchs | `(match_id, team_id)` |
| `team_member` | Composition des équipes | `(team_id, player_id)` |

---

## 🚀 Démarrage rapide

> ⚠️ **Ordre d'exécution obligatoire :** `ddl.sql` → `dml.sql` → `dcl.sql`

### Étape 1 — Entrer dans le conteneur

```bash
podman exec -it postgres bash
```

### Étape 2 — Se connecter à PostgreSQL

```bash
psql -U postgres
```

![wait](https://github.com/CollegeBoreal/INF1099-201-26H-04/blob/main/5.ModelisationSQL/300151841/images/2_connexion_postgres.png.png)

### Étape 3 — Créer la base de données

```sql
CREATE DATABASE esport_tournament;
\c esport_tournament
```
![wait](https://github.com/CollegeBoreal/INF1099-201-26H-04/blob/main/5.ModelisationSQL/300151841/images/2_creation_database.png.png)

### Étape 4 — Exécuter les scripts

```sql
\i ddl.sql
\i dml.sql
\i dcl.sql
```

---

## 🏗️ DDL — Définition des structures

### Création du schéma

```sql
CREATE SCHEMA esport;
```

![](https://github.com/CollegeBoreal/INF1099-201-26H-04/blob/main/5.ModelisationSQL/300151841/images/3_creation_schema.png.png)

### Exemple — Table `game`

```sql
CREATE TABLE esport.game (
    game_id   SERIAL PRIMARY KEY,
    game_name VARCHAR(100) NOT NULL
);
```

![](https://github.com/CollegeBoreal/INF1099-201-26H-04/blob/main/5.ModelisationSQL/300151841/images/4_table_game.png.png)

### Vérification en cours de création

![](https://github.com/CollegeBoreal/INF1099-201-26H-04/blob/main/5.ModelisationSQL/300151841/images/5_verification_tables.png.png)
### ✅ Toutes les tables créées (7 tables)

 ![](https://github.com/CollegeBoreal/INF1099-201-26H-04/blob/main/5.ModelisationSQL/300151841/images/6_all_tables_created.png.png)

---

## 📝 DML — Manipulation des données

### Exemple d'insertion

```sql
INSERT INTO esport.game (game_name)
VALUES ('League of Legends');

INSERT INTO esport.team (team_name)
VALUES ('Team Alpha'), ('Team Bravo'), ('Team Delta');

INSERT INTO esport.player (pseudo, email)
VALUES ('Shadow', 'shadow@email.com'),
       ('Blaze',  'blaze@email.com');
```

### Données insérées — jeux, équipes, joueurs

![](https://github.com/CollegeBoreal/INF1099-201-26H-04/blob/main/5.ModelisationSQL/300151841/images/7_insert_data.png.png)


![](https://github.com/CollegeBoreal/INF1099-201-26H-04/blob/main/5.ModelisationSQL/300151841/images/8_insert_data.png.png)
---

## 🔎 Requêtes SELECT

### Afficher les matchs et leurs tournois

```sql
SELECT
    m.match_id,
    t.tournament_name,
    m.round,
    m.match_datetime
FROM esport.match m
JOIN esport.tournament t ON m.tournament_id = t.tournament_id;
```

![](https://github.com/CollegeBoreal/INF1099-201-26H-04/blob/main/5.ModelisationSQL/300151841/images/9_select_matches.png.png)

### Afficher les scores

```sql
SELECT
    m.match_id,
    t.team_name,
    mt.score
FROM esport.match_team mt
JOIN esport.match m ON mt.match_id = m.match_id
JOIN esport.team  t ON mt.team_id  = t.team_id;
```
![](https://github.com/CollegeBoreal/INF1099-201-26H-04/blob/main/5.ModelisationSQL/300151841/images/10_scores_matchs.png.png)
---

## 🔐 DCL — Gestion des accès

### Utilisateurs créés

| Utilisateur | Rôle | SELECT | INSERT | UPDATE | DELETE |
|-------------|------|:------:|:------:|:------:|:------:|
| `player_user` | Lecture seule | ✅ | ❌ | ❌ | ❌ |
| `admin_user` | Accès complet | ✅ | ✅ | ✅ | ✅ |

### Création des utilisateurs

```sql
CREATE USER player_user WITH PASSWORD 'player123';
CREATE USER admin_user  WITH PASSWORD 'admin123';
```

![](https://github.com/CollegeBoreal/INF1099-201-26H-04/blob/main/5.ModelisationSQL/300151841/images/11_create_users.png.png)

### Attribution des permissions

```sql
-- Connexion et accès au schéma
GRANT CONNECT ON DATABASE esport_tournament TO player_user, admin_user;
GRANT USAGE ON SCHEMA esport TO player_user, admin_user;

-- player_user : lecture seule
GRANT SELECT ON ALL TABLES IN SCHEMA esport TO player_user;

-- admin_user : accès complet
GRANT SELECT, INSERT, UPDATE, DELETE
    ON ALL TABLES IN SCHEMA esport TO admin_user;

-- Séquences pour admin_user
GRANT USAGE, SELECT, UPDATE ON ALL SEQUENCES IN SCHEMA esport TO admin_user;
```
![](https://github.com/CollegeBoreal/INF1099-201-26H-04/blob/main/5.ModelisationSQL/300151841/images/12_grant_permissions.png.png)


### ✅ Test — `player_user` (lecture seule)

`SELECT` autorisé · `INSERT` refusé avec `permission denied`

![](https://github.com/CollegeBoreal/INF1099-201-26H-04/blob/main/5.ModelisationSQL/300151841/images/13_test_player_user.png.png)

### ✅ Test — `admin_user` (accès complet)

`INSERT`, `UPDATE` et `SELECT` fonctionnent sans restriction

![](https://github.com/CollegeBoreal/INF1099-201-26H-04/blob/main/5.ModelisationSQL/300151841/images/14_test_admin_user.png.png)

### ⛔ Révocation d'un droit

```sql
REVOKE SELECT ON ALL TABLES IN SCHEMA esport FROM player_user;
```

![](https://github.com/CollegeBoreal/INF1099-201-26H-04/blob/main/5.ModelisationSQL/300151841/images/15_revoke_select.png.png)

### 🔒 Test après révocation

`player_user` ne peut plus lire les tables — `ERROR: permission denied`


![](https://github.com/CollegeBoreal/INF1099-201-26H-04/blob/main/5.ModelisationSQL/300151841/images/16_test_revoke_player.png.png)
---

## 🎯 Conclusion

Ce projet a permis de mettre en pratique les concepts fondamentaux des bases de données relationnelles :

- ✅ **Modélisation de données** — diagramme ER, entités et relations
- ✅ **Normalisation** — 1FN, 2FN, 3FN appliquées
- ✅ **Création de structures SQL** — DDL complet avec clés primaires et étrangères
- ✅ **Manipulation des données** — insertions, requêtes JOIN
- ✅ **Gestion des permissions** — GRANT, REVOKE, utilisateurs différenciés
- ✅ **Environnement Docker/Podman** — portabilité et reproductibilité

---

<div align="center">

**INF1099 — Bases de données · PostgreSQL 16 · Massinissa Mameri**

</div>
