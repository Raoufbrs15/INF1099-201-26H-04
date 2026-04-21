-- ============================================================
-- DCL.sql - Gestion des droits (GRANT / REVOKE)
-- Cours : INF1099 | Domaine : AeroVoyage (Compagnie Aerienne)
-- ============================================================

-- -------------------------------------------------------
-- Creation des utilisateurs
-- -------------------------------------------------------
CREATE USER IF NOT EXISTS 'passager_role'@'localhost'    IDENTIFIED BY 'pass_passager';
CREATE USER IF NOT EXISTS 'agent_role'@'localhost'       IDENTIFIED BY 'pass_agent';
CREATE USER IF NOT EXISTS 'administrateur'@'localhost'   IDENTIFIED BY 'pass_admin';

-- -------------------------------------------------------
-- Role : passager_role
-- Peut consulter les vols, aeroports, portes et ses billets
-- -------------------------------------------------------
GRANT SELECT ON VOL       TO 'passager_role'@'localhost';
GRANT SELECT ON AEROPORT  TO 'passager_role'@'localhost';
GRANT SELECT ON PORTE     TO 'passager_role'@'localhost';
GRANT SELECT ON COMPAGNIE TO 'passager_role'@'localhost';
GRANT SELECT ON BILLET    TO 'passager_role'@'localhost';
GRANT SELECT ON BAGAGE    TO 'passager_role'@'localhost';

-- -------------------------------------------------------
-- Role : agent_role
-- Peut gerer les reservations, billets, paiements et bagages
-- -------------------------------------------------------
GRANT SELECT, INSERT, UPDATE ON RESERVATION TO 'agent_role'@'localhost';
GRANT SELECT, INSERT, UPDATE ON PAIEMENT    TO 'agent_role'@'localhost';
GRANT SELECT, INSERT, UPDATE ON BILLET      TO 'agent_role'@'localhost';
GRANT SELECT, INSERT, UPDATE ON BAGAGE      TO 'agent_role'@'localhost';
GRANT SELECT                 ON PASSAGER    TO 'agent_role'@'localhost';
GRANT SELECT                 ON VOL         TO 'agent_role'@'localhost';

-- -------------------------------------------------------
-- Role : administrateur
-- Acces complet a toutes les tables
-- -------------------------------------------------------
GRANT ALL PRIVILEGES ON PASSAGER    TO 'administrateur'@'localhost';
GRANT ALL PRIVILEGES ON ADRESSE     TO 'administrateur'@'localhost';
GRANT ALL PRIVILEGES ON COMPAGNIE   TO 'administrateur'@'localhost';
GRANT ALL PRIVILEGES ON AEROPORT    TO 'administrateur'@'localhost';
GRANT ALL PRIVILEGES ON PORTE       TO 'administrateur'@'localhost';
GRANT ALL PRIVILEGES ON AVION       TO 'administrateur'@'localhost';
GRANT ALL PRIVILEGES ON VOL         TO 'administrateur'@'localhost';
GRANT ALL PRIVILEGES ON RESERVATION TO 'administrateur'@'localhost';
GRANT ALL PRIVILEGES ON PAIEMENT    TO 'administrateur'@'localhost';
GRANT ALL PRIVILEGES ON BILLET      TO 'administrateur'@'localhost';
GRANT ALL PRIVILEGES ON BAGAGE      TO 'administrateur'@'localhost';

-- -------------------------------------------------------
-- Appliquer les changements
-- -------------------------------------------------------
FLUSH PRIVILEGES;

-- -------------------------------------------------------
-- Exemple de REVOKE (retirer un droit si necessaire)
-- -------------------------------------------------------
-- REVOKE INSERT ON RESERVATION FROM 'agent_role'@'localhost';
