-- ============================================================
-- 02-dml.sql - Insertion des donnees initiales
-- Cours : INF1099 | Domaine : AeroVoyage
-- SGBD : PostgreSQL
-- ============================================================

INSERT INTO passagers (nom, email, age, passeport) VALUES
('Marie Tremblay', 'marie.tremblay@email.com', 34, 'CA123456'),
('Linh Nguyen',    'linh.nguyen@email.com',    28, 'CA234567'),
('Chidi Okonkwo',  'chidi.okonkwo@email.com',  45, 'CA345678'),
('Sofia Martinez', 'sofia.martinez@email.com', 22, 'CA456789');

INSERT INTO vols (numero_vol, destination, date_depart, places_dispo) VALUES
('AC801', 'Toronto',  '2025-06-15', 50),
('TS101', 'Paris',    '2025-06-20', 30),
('AC205', 'Quebec',   '2025-06-18', 80),
('WS302', 'Vancouver','2025-06-25', 60);
