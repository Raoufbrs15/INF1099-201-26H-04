# 🧪 Lab 6 — Automatisation PostgreSQL avec PowerShell & Docker

## 🎯 Objectif

Automatiser le déploiement d'une base de données PostgreSQL avec PowerShell et Docker.

---

## 🛠 Technologies

* Docker
* PostgreSQL
* PowerShell
* SQL

---

## 📁 Structure du projet

```
300150271/
├── DDL.sql
├── DML.sql
├── DCL.sql
├── DQL.sql
├── load-db.ps1
├── execution.log
└── images/
```

---

## 🐳 Mise en place

```powershell
docker run -d --name postgres-immo -e POSTGRES_PASSWORD=postgres -e POSTGRES_DB=ecole -p 5432:5432 postgres
```

```powershell
docker ps
```

---

## ⚙️ Exécution

```powershell
.\load-db.ps1
```

---

## 📊 Vérification

```powershell
docker exec -it postgres-immo psql -U postgres -d ecole
```

```sql
SELECT * FROM client;
```

---

## 📸 Captures

![1](images/1.png)
![2](images/2.png)
![3](images/3.png)
![4](images/4.png)

---

## ✅ Résultat

* Tables créées ✔
* Données insérées ✔
* Permissions appliquées ✔
* Script automatisé ✔

---

## 👨‍🎓 Auteur

Mazigh Bareche
Matricule : 300150271
