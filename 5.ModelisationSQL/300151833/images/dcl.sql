## 🔐 DCL — Contrôle des accès

### Matrice des permissions

| Permission | employe_user | gestionnaire_user |
|------------|:------------:|:-----------------:|
| SELECT | ✅ | ✅ |
| INSERT | ❌ | ✅ |
| UPDATE | ❌ | ✅ |
| DELETE | ❌ | ✅ |
| SEQUENCES | ❌ | ✅ |

---

### Étape 8 : Créer les utilisateurs

```sql
-- Employé : lecture seule
CREATE USER employe_user WITH PASSWORD 'emp123';

-- Gestionnaire : accès complet
CREATE USER gestionnaire_user WITH PASSWORD 'gest123';
```

---

### Étape 9 : Donner les droits (GRANT)

```sql
-- Connexion à la base
GRANT CONNECT ON DATABASE gestion_bibliotheque TO employe_user, gestionnaire_user;

-- Accès au schéma
GRANT USAGE ON SCHEMA bibliotheque TO employe_user, gestionnaire_user;

-- Employé : lecture seule
GRANT SELECT ON ALL TABLES IN SCHEMA bibliotheque TO employe_user;

-- Gestionnaire : lecture + écriture complète
GRANT SELECT, INSERT, UPDATE, DELETE ON ALL TABLES IN SCHEMA bibliotheque TO gestionnaire_user;
GRANT USAGE, SELECT, UPDATE ON ALL SEQUENCES IN SCHEMA bibliotheque TO gestionnaire_user;
```

---

### Étape 10 : Tester les droits de l'employé

```sql
\q
psql -U employe_user -d gestion_bibliotheque
```

```sql
SELECT * FROM bibliotheque.Emprunt;                                     -- ✅ OK
INSERT INTO bibliotheque.Auteur (Nom, Prenom) VALUES ('Test', 'User'); -- ❌ Doit échouer
```

**Output attendu :**

```
ERROR:  permission denied for table auteur
```

---

### Étape 11 : Tester les droits du gestionnaire

```sql
\q
psql -U gestionnaire_user -d gestion_bibliotheque
```

```sql
INSERT INTO bibliotheque.Categorie (Nom_Categorie) VALUES ('Biographie');          -- ✅ OK
UPDATE bibliotheque.Livre SET Annee_Publication = 1863 WHERE ID_Livre = 1;         -- ✅ OK
SELECT * FROM bibliotheque.Categorie;                                               -- ✅ OK
```

---

### Étape 12 : Retirer les droits (REVOKE)

```sql
\q
psql -U postgres -d gestion_bibliotheque
```

```sql
REVOKE SELECT ON ALL TABLES IN SCHEMA bibliotheque FROM employe_user;
```

**Vérifier :**

```sql
\c - employe_user
SELECT * FROM bibliotheque.Emprunt; -- ❌ Doit échouer
```

**Output attendu :**

```
ERROR:  permission denied for table emprunt
```

---

### Étape 13 : Supprimer les utilisateurs (DROP USER)

```sql
\c - postgres
```

```sql
DROP USER employe_user;
DROP USER gestionnaire_user;
```
