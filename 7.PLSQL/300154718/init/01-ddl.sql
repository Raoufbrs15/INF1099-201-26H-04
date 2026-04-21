-- ============================================================
-- 01-ddl.sql - Definition des tables
-- Cours : INF1099 | Domaine : AeroVoyage
-- SGBD : PostgreSQL
-- ============================================================

DROP TABLE IF EXISTS inscriptions;
DROP TABLE IF EXISTS logs;
DROP TABLE IF EXISTS reservations;
DROP TABLE IF EXISTS vols;
DROP TABLE IF EXISTS passagers;

CREATE TABLE passagers (
    id             SERIAL PRIMARY KEY,
    nom            TEXT NOT NULL,
    email          TEXT UNIQUE,
    age            INT,
    passeport      TEXT UNIQUE,
    date_creation  TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE vols (
    id             SERIAL PRIMARY KEY,
    numero_vol     TEXT UNIQUE NOT NULL,
    destination    TEXT NOT NULL,
    date_depart    DATE NOT NULL,
    places_dispo   INT DEFAULT 100
);

CREATE TABLE reservations (
    id             SERIAL PRIMARY KEY,
    passager_id    INT REFERENCES passagers(id),
    vol_id         INT REFERENCES vols(id),
    classe         TEXT DEFAULT 'Economique',
    date_resa      TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE logs (
    id             SERIAL PRIMARY KEY,
    action         TEXT,
    date_action    TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
