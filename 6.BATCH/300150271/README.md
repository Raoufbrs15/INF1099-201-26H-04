# 🧪 Lab 6 — Automatisation PostgreSQL avec PowerShell & Docker

**INF1099 — Bases de données**
Étudiant : **Mazigh Bareche**
Matricule : **300150271**

---

## 📋 Table des matières

* 🎯 Objectif
* 🛠 Technologies
* 📁 Structure du projet
* 🐳 Mise en place
* ⚙️ Script PowerShell
* 📊 Vérification des données
* 📸 Captures
* ✅ Résultats

---

## 🎯 Objectif

Ce laboratoire consiste à automatiser le déploiement d’une base de données PostgreSQL à l’aide d’un script PowerShell exécuté dans un conteneur Docker.

Les scripts SQL sont exécutés dans l’ordre suivant :

```
DDL → DML → DCL → DQL
```

| Étape | Fichier | Rôle                     |
| ----- | ------- | ------------------------ |
| 1️⃣   | DDL.sql | Création des tables      |
| 2️⃣   | DML.sql | Insertion des données    |
| 3️⃣   | DCL.sql | Gestion des utilisateurs |
| 4️⃣   | DQL.sql | Vérification des données |

---

## 🛠 Technologies

* 🐳 Docker
* 🐘 PostgreSQL
* 💻 PowerShell
* 🧾 SQL

---

## 📁 Structure du projet

```
6.BATCH/
└── 300150271/
    ├── DDL.sql
    ├── DML.sql
    ├── DCL.sql
    ├── DQL.sql
    ├── load-db.ps1
    └── images/
```

🖼️ Capture — Structure du projet
<img width="798" height="383" alt="Screenshot 2026-04-15 190300" src="https://github.com/user-attachments/assets/1589a307-65ba-4178-b352-542b85efe5ee" />

![structure](images/structure.png)

---

## 🐳 Mise en place

### 1. Lancer PostgreSQL avec Docker

```powershell
docker run -d --name postgres-immo -e POSTGRES_PASSWORD=postgres -e POSTGRES_DB=ecole -p 5432:5432 postgres
```

### 2. Vérifier le conteneur

```powershell
docker ps
```

🖼️ Capture — Docker actif

<img width="797" height="142" alt="Screenshot 2026-04-15 190310" src="https://github.com/user-attachments/assets/21f66ef8-8c1f-4207-9853-55b3f84ab072" />

![docker](images/docker.png)

---

## ⚙️ Script PowerShell

Le script `load-db.ps1` permet d’exécuter automatiquement tous les fichiers SQL.

### Exécution

```powershell
.\load-db.ps1
```

🖼️ Capture — Exécution du script
<img width="800" height="623" alt="Screenshot 2026-04-15 160407" src="https://github.com/user-attachments/assets/5e9a621b-0c1a-43a9-9012-d5e4ea62c716" />

![script](images/script.png)

---

## 📊 Vérification des données

Connexion à PostgreSQL :

```powershell
docker exec -it postgres-immo psql -U postgres -d ecole
```

Requête :

```sql
SELECT * FROM client;
```

🖼️ Capture — Résultat PostgreSQL
<img width="799" height="193" alt="Screenshot 2026-04-15 190406" src="https://github.com/user-attachments/assets/361f6ec6-bd93-4f52-8718-0f143985a305" />

![postgres](images/postgres.png)

---

## 📸 Captures

* Structure du projet
* Docker actif
* Exécution du script
* Résultat PostgreSQL

---

## ✅ Résultats

* ✔ Tables créées
* ✔ Données insérées
* ✔ Permissions appliquées
* ✔ Script automatisé
* ✔ Résultat validé

---

## 🏁 Conclusion

Ce laboratoire montre comment automatiser complètement la création et l’utilisation d’une base de données PostgreSQL avec Docker et PowerShell.

Cette approche permet :

* d’éviter les erreurs manuelles
* d’automatiser les tâches
* de gagner du temps

---

## 👨‍🎓 Auteur

Mazigh Bareche
INF1099 — Bases de données
