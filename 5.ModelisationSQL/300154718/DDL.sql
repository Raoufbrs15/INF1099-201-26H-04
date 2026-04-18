-- ============================================================
-- DDL.sql - Definition des tables
-- Cours : INF1099 | Domaine : AeroVoyage (Compagnie Aerienne)
-- ============================================================

-- Supprimer les tables si elles existent deja (ordre inverse des FK)
DROP TABLE IF EXISTS BAGAGE;
DROP TABLE IF EXISTS BILLET;
DROP TABLE IF EXISTS PAIEMENT;
DROP TABLE IF EXISTS RESERVATION;
DROP TABLE IF EXISTS ADRESSE;
DROP TABLE IF EXISTS VOL;
DROP TABLE IF EXISTS PORTE;
DROP TABLE IF EXISTS AVION;
DROP TABLE IF EXISTS AEROPORT;
DROP TABLE IF EXISTS COMPAGNIE;
DROP TABLE IF EXISTS PASSAGER;

-- -------------------------------------------------------
-- Table PASSAGER
-- -------------------------------------------------------
CREATE TABLE PASSAGER (
    id               INT          PRIMARY KEY AUTO_INCREMENT,
    nom              VARCHAR(100) NOT NULL,
    prenom           VARCHAR(100) NOT NULL,
    telephone        VARCHAR(20),
    email            VARCHAR(150) NOT NULL UNIQUE,
    numero_passeport VARCHAR(20)  NOT NULL UNIQUE
);

-- -------------------------------------------------------
-- Table ADRESSE
-- -------------------------------------------------------
CREATE TABLE ADRESSE (
    id           INT          PRIMARY KEY AUTO_INCREMENT,
    passager_id  INT          NOT NULL,
    numero_rue   VARCHAR(10),
    rue          VARCHAR(150),
    ville        VARCHAR(100),
    province     VARCHAR(100),
    code_postal  VARCHAR(10),
    pays         VARCHAR(100),
    CONSTRAINT fk_adresse_passager FOREIGN KEY (passager_id)
        REFERENCES PASSAGER(id)
);

-- -------------------------------------------------------
-- Table COMPAGNIE
-- -------------------------------------------------------
CREATE TABLE COMPAGNIE (
    id             INT          PRIMARY KEY AUTO_INCREMENT,
    nom_compagnie  VARCHAR(150) NOT NULL,
    code_iata      VARCHAR(3)   NOT NULL UNIQUE,
    telephone      VARCHAR(20)
);

-- -------------------------------------------------------
-- Table AEROPORT
-- -------------------------------------------------------
CREATE TABLE AEROPORT (
    id             INT          PRIMARY KEY AUTO_INCREMENT,
    nom_aeroport   VARCHAR(200) NOT NULL,
    code_iata      VARCHAR(3)   NOT NULL UNIQUE,
    ville          VARCHAR(100),
    pays           VARCHAR(100)
);

-- -------------------------------------------------------
-- Table PORTE
-- -------------------------------------------------------
CREATE TABLE PORTE (
    id           INT         PRIMARY KEY AUTO_INCREMENT,
    aeroport_id  INT         NOT NULL,
    numero_porte VARCHAR(10) NOT NULL,
    terminal     VARCHAR(10),
    CONSTRAINT fk_porte_aeroport FOREIGN KEY (aeroport_id)
        REFERENCES AEROPORT(id)
);

-- -------------------------------------------------------
-- Table AVION
-- -------------------------------------------------------
CREATE TABLE AVION (
    id             INT          PRIMARY KEY AUTO_INCREMENT,
    compagnie_id   INT          NOT NULL,
    modele         VARCHAR(100) NOT NULL,
    capacite       INT          NOT NULL,
    immatriculation VARCHAR(20) NOT NULL UNIQUE,
    CONSTRAINT fk_avion_compagnie FOREIGN KEY (compagnie_id)
        REFERENCES COMPAGNIE(id)
);

-- -------------------------------------------------------
-- Table VOL
-- -------------------------------------------------------
CREATE TABLE VOL (
    id                  INT          PRIMARY KEY AUTO_INCREMENT,
    numero_vol          VARCHAR(20)  NOT NULL UNIQUE,
    date_vol            DATE         NOT NULL,
    heure_depart        VARCHAR(5)   NOT NULL,
    heure_arrivee       VARCHAR(5)   NOT NULL,
    statut_vol          VARCHAR(30)  NOT NULL DEFAULT 'Planifie',
    avion_id            INT          NOT NULL,
    aeroport_depart_id  INT          NOT NULL,
    aeroport_arrivee_id INT          NOT NULL,
    porte_depart_id     INT,
    CONSTRAINT fk_vol_avion           FOREIGN KEY (avion_id)            REFERENCES AVION(id),
    CONSTRAINT fk_vol_aeroport_dep    FOREIGN KEY (aeroport_depart_id)  REFERENCES AEROPORT(id),
    CONSTRAINT fk_vol_aeroport_arr    FOREIGN KEY (aeroport_arrivee_id) REFERENCES AEROPORT(id),
    CONSTRAINT fk_vol_porte           FOREIGN KEY (porte_depart_id)     REFERENCES PORTE(id)
);

-- -------------------------------------------------------
-- Table RESERVATION
-- -------------------------------------------------------
CREATE TABLE RESERVATION (
    id                 INT         PRIMARY KEY AUTO_INCREMENT,
    passager_id        INT         NOT NULL,
    date_reservation   DATE        NOT NULL,
    statut_reservation VARCHAR(30) NOT NULL DEFAULT 'Confirmee',
    CONSTRAINT fk_reservation_passager FOREIGN KEY (passager_id)
        REFERENCES PASSAGER(id)
);

-- -------------------------------------------------------
-- Table PAIEMENT
-- -------------------------------------------------------
CREATE TABLE PAIEMENT (
    id              INT            PRIMARY KEY AUTO_INCREMENT,
    reservation_id  INT            NOT NULL,
    date_paiement   DATE           NOT NULL,
    montant         DECIMAL(10,2)  NOT NULL,
    mode_paiement   VARCHAR(50),
    statut_paiement VARCHAR(30)    NOT NULL DEFAULT 'En attente',
    CONSTRAINT fk_paiement_reservation FOREIGN KEY (reservation_id)
        REFERENCES RESERVATION(id)
);

-- -------------------------------------------------------
-- Table BILLET
-- -------------------------------------------------------
CREATE TABLE BILLET (
    id             INT          PRIMARY KEY AUTO_INCREMENT,
    reservation_id INT          NOT NULL,
    vol_id         INT          NOT NULL,
    numero_billet  VARCHAR(20)  NOT NULL UNIQUE,
    classe         VARCHAR(20)  NOT NULL DEFAULT 'Economique',
    siege          VARCHAR(5),
    CONSTRAINT fk_billet_reservation FOREIGN KEY (reservation_id)
        REFERENCES RESERVATION(id),
    CONSTRAINT fk_billet_vol FOREIGN KEY (vol_id)
        REFERENCES VOL(id)
);

-- -------------------------------------------------------
-- Table BAGAGE
-- -------------------------------------------------------
CREATE TABLE BAGAGE (
    id            INT           PRIMARY KEY AUTO_INCREMENT,
    billet_id     INT           NOT NULL,
    numero_bagage VARCHAR(20)   NOT NULL UNIQUE,
    poids_kg      DECIMAL(5,2)  NOT NULL,
    type_bagage   VARCHAR(30)   NOT NULL DEFAULT 'Cabine',
    CONSTRAINT fk_bagage_billet FOREIGN KEY (billet_id)
        REFERENCES BILLET(id)
);
