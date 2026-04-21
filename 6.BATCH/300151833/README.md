## Types de scripts SQL

| Type | Signification | Exemple |
|------|--------------|---------|
| DDL | Data Definition Language | CREATE TABLE |
| DML | Data Manipulation Language | INSERT |
| DQL | Data Query Language | SELECT |
| DCL | Data Control Language | GRANT |

## Étapes

### 1. Lancer le conteneur PostgreSQL
```powershell
docker container run -d \
  --name postgres-lab \
  -e POSTGRES_PASSWORD=postgres \
  -e POSTGRES_DB=ecole \
  -p 5432:5432 \
  postgres
```

### 2. Vérifier que le conteneur est actif
```powershell
docker container ls
```
![Conteneur actif](./images/6_1.png)

### 3. Exécuter le script PowerShell
```powershell
powershell -ExecutionPolicy Bypass -File ./load-db.ps1
```
![Exécution du script](./images/6_2.png)

### 4. Vérification dans psql
```powershell
docker container exec -it postgres-lab psql -U postgres -d ecole
```
```sql
SELECT * FROM etudiants;
```
![Vérification psql](./images/6_3.png)

## Résultat
Les 5 étudiants sont bien insérés dans la base de données `ecole` :

| id | nom   | age |
|----|-------|-----|
| 1  | Alice | 20  |
| 2  | Bob   | 22  |
| 3  | Clara | 21  |
| 4  | David | 23  |
| 5  | Emma  | 19  |
