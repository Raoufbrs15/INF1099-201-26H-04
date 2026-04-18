-- ==================================================================================
-- 03-programmation.sql
-- TP PostgreSQL : Fonctions, Procédures Stockées et Triggers
-- Cours : INF1099 | Domaine : AeroVoyage
-- ==================================================================================

-- ============================================================
-- 1️⃣ Procédure : ajouter_passager
-- ============================================================
-- Objectif : Ajouter un passager avec validations et journalisation
-- Validations : age >= 18, email valide, passeport unique
-- ============================================================

CREATE OR REPLACE PROCEDURE ajouter_passager(
    p_nom      TEXT,
    p_email    TEXT,
    p_age      INT,
    p_passeport TEXT
)
LANGUAGE plpgsql
AS $$
BEGIN
    -- Verifier que l'age est >= 18
    IF p_age < 18 THEN
        RAISE EXCEPTION 'Age invalide pour % : doit etre >= 18', p_nom;
    END IF;

    -- Verifier que l'email est valide
    IF p_email !~* '^[^@]+@[^@]+\.[^@]+$' THEN
        RAISE EXCEPTION 'Email invalide pour % : %', p_nom, p_email;
    END IF;

    -- Verifier que le passeport est unique
    IF EXISTS (SELECT 1 FROM passagers WHERE passeport = p_passeport) THEN
        RAISE EXCEPTION 'Passeport deja enregistre : %', p_passeport;
    END IF;

    -- Insertion du passager
    INSERT INTO passagers (nom, email, age, passeport)
    VALUES (p_nom, p_email, p_age, p_passeport);

    -- Journalisation
    INSERT INTO logs (action)
    VALUES ('Ajout passager : ' || p_nom || ' (' || p_email || ')');

    -- Message de succes
    RAISE NOTICE 'Passager ajoute avec succes : %', p_nom;

EXCEPTION
    WHEN others THEN
        RAISE NOTICE 'Erreur lors de l ajout de % : %', p_nom, SQLERRM;
END;
$$;

-- ============================================================
-- 2️⃣ Fonction : nombre_passagers_par_age
-- ============================================================
-- Objectif : Retourne le nombre de passagers dans une tranche d'age
-- ============================================================

CREATE OR REPLACE FUNCTION nombre_passagers_par_age(min_age INT, max_age INT)
RETURNS INT
LANGUAGE plpgsql
AS $$
DECLARE
    total INT;
BEGIN
    SELECT COUNT(*) INTO total
    FROM passagers
    WHERE age BETWEEN min_age AND max_age;

    RETURN total;
END;
$$;

-- ============================================================
-- 3️⃣ Procédure : reserver_vol
-- ============================================================
-- Objectif : Reserver un vol pour un passager
-- Validations : passager existe, vol existe, places disponibles, pas de doublon
-- ============================================================

CREATE OR REPLACE PROCEDURE reserver_vol(
    p_email    TEXT,
    p_vol      TEXT,
    p_classe   TEXT DEFAULT 'Economique'
)
LANGUAGE plpgsql
AS $$
DECLARE
    v_passager_id INT;
    v_vol_id      INT;
    v_places      INT;
BEGIN
    -- Recuperer l'id du passager
    SELECT id INTO v_passager_id FROM passagers WHERE email = p_email;
    IF v_passager_id IS NULL THEN
        RAISE EXCEPTION 'Passager non trouve : %', p_email;
    END IF;

    -- Recuperer l'id du vol et les places disponibles
    SELECT id, places_dispo INTO v_vol_id, v_places FROM vols WHERE numero_vol = p_vol;
    IF v_vol_id IS NULL THEN
        RAISE EXCEPTION 'Vol non trouve : %', p_vol;
    END IF;

    -- Verifier les places disponibles
    IF v_places <= 0 THEN
        RAISE EXCEPTION 'Aucune place disponible sur le vol %', p_vol;
    END IF;

    -- Verifier qu'il n'y a pas de doublon
    IF EXISTS (
        SELECT 1 FROM reservations
        WHERE passager_id = v_passager_id AND vol_id = v_vol_id
    ) THEN
        RAISE EXCEPTION 'Passager % deja inscrit au vol %', p_email, p_vol;
    END IF;

    -- Inserer la reservation
    INSERT INTO reservations (passager_id, vol_id, classe)
    VALUES (v_passager_id, v_vol_id, p_classe);

    -- Mettre a jour les places disponibles
    UPDATE vols SET places_dispo = places_dispo - 1 WHERE id = v_vol_id;

    -- Journalisation
    INSERT INTO logs (action)
    VALUES ('Reservation : ' || p_email || ' -> Vol ' || p_vol || ' (' || p_classe || ')');

    RAISE NOTICE 'Reservation reussie : % -> Vol %', p_email, p_vol;

EXCEPTION
    WHEN others THEN
        RAISE NOTICE 'Erreur reservation : %', SQLERRM;
END;
$$;

-- ============================================================
-- 4️⃣ Trigger : validation avant insertion d'un passager
-- ============================================================
-- Objectif : Valider age et email automatiquement avant INSERT
-- ============================================================

CREATE OR REPLACE FUNCTION valider_passager()
RETURNS trigger AS $$
BEGIN
    IF NEW.age < 18 THEN
        RAISE EXCEPTION 'Age invalide pour % : doit etre >= 18', NEW.nom;
    END IF;

    IF NEW.email !~* '^[^@]+@[^@]+\.[^@]+$' THEN
        RAISE EXCEPTION 'Email invalide pour % : %', NEW.nom, NEW.email;
    END IF;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trg_valider_passager
BEFORE INSERT ON passagers
FOR EACH ROW
EXECUTE FUNCTION valider_passager();

-- ============================================================
-- 5️⃣ Trigger : journalisation automatique
-- ============================================================
-- Objectif : Logger toutes les actions INSERT, UPDATE, DELETE
-- sur les tables passagers et reservations
-- ============================================================

CREATE OR REPLACE FUNCTION log_action()
RETURNS trigger AS $$
BEGIN
    INSERT INTO logs (action)
    VALUES (
        TG_OP || ' sur ' || TG_TABLE_NAME || ' : ' ||
        COALESCE(NEW.nom::text, OLD.nom::text, 'inconnu')
    );
    RETURN COALESCE(NEW, OLD);
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trg_log_passager
AFTER INSERT OR UPDATE OR DELETE ON passagers
FOR EACH ROW
EXECUTE FUNCTION log_action();

CREATE TRIGGER trg_log_reservation
AFTER INSERT OR UPDATE OR DELETE ON reservations
FOR EACH ROW
EXECUTE FUNCTION log_action();
