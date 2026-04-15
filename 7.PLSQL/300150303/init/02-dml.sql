<<<<<<< HEAD
-- ============================================================
-- 02-dml.sql
-- Data Manipulation Language
-- TP PostgreSQL — Stored Procedures
-- #300150303
-- Prérequis : 01-ddl.sql doit avoir été exécuté
-- ============================================================

-- Étudiants
INSERT INTO etudiants (nom, age, email) VALUES
   ('Dubois', 21, 'lucas.dubois@gmail.com'),
   ('Martin', 23, 'sophie.martin@yahoo.com'),
   ('Nguyen', 20, 'kevin.nguyen@hotmail.com'),
   ('Traoré' 22, 'aminata.traore@gmail.com');

-- Cours
INSERT INTO cours (nom, credits) VALUES
    ('Bases de donnees',        3),
    ('Reseaux informatiques',   3),
    ('Systemes exploitation',   3),
    ('Programmation Web',       3);

CREATE TABLE cours (
    id SERIAL PRIMARY KEY,
    nom TEXT NOT NULL UNIQUE
);

INSERT INTO cours (nom, credits)
=======
INSERT INTO etudiants (nom, age, email)
VALUES ('Test', 20, 'test@email.com');
>>>>>>> d88623c8f4f8c7a8d4053a80c348d046a27eb0ee
