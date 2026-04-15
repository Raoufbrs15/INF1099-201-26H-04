-- ============================================================
-- 01-ddl.sql
-- Data Definition Language
-- TP PostgreSQL — Stored Procedures
-- #300150303-- ============================================================
-- 01-ddl.sql
-- Data Definition Language
-- TP PostgreSQL — Stored Procedures
-- #300150303
-- ============================================================

-- ============================================================
CREATE TABLE etudiants (
    id SERIAL PRIMARY KEY,
    nom TEXT NOT NULL,
    age INT,
    email TEXT UNIQUE,
    date_creation TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE logs (
    id SERIAL PRIMARY KEY,
    action TEXT,
    date_action TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
