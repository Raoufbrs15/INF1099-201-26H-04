-- ============================================================
-- DCL - Gestion des accès
-- ============================================================

-- Création utilisateurs
CREATE USER employe_user WITH PASSWORD 'emp123';
CREATE USER gestionnaire_user WITH PASSWORD 'gest123';

-- Accès DB
GRANT CONNECT ON DATABASE gestion_bibliotheque TO employe_user, gestionnaire_user;

-- Accès schéma
GRANT USAGE ON SCHEMA bibliotheque TO employe_user, gestionnaire_user;

-- Employé : lecture seule
GRANT SELECT ON ALL TABLES IN SCHEMA bibliotheque TO employe_user;

-- Gestionnaire : tous droits
GRANT SELECT, INSERT, UPDATE, DELETE ON ALL TABLES IN SCHEMA bibliotheque TO gestionnaire_user;
GRANT USAGE, SELECT, UPDATE ON ALL SEQUENCES IN SCHEMA bibliotheque TO gestionnaire_user;

-- Révocation exemple
REVOKE SELECT ON ALL TABLES IN SCHEMA bibliotheque FROM employe_user;

-- Suppression utilisateurs
DROP USER IF EXISTS employe_user;
DROP USER IF EXISTS gestionnaire_user;
