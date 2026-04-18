-- ============================================================
-- test.sql - Tests des procedures, fonctions et triggers
-- Cours : INF1099 | Domaine : AeroVoyage
-- ============================================================

-- Test 1 : Insertion valide d'un passager
CALL ajouter_passager('Pierre Bouchard', 'pierre.bouchard@email.com', 40, 'CA999001');

-- Test 2 : Insertion invalide (age < 18)
DO $$
BEGIN
    BEGIN
        CALL ajouter_passager('Junior Doe', 'junior@email.com', 15, 'CA999002');
    EXCEPTION
        WHEN others THEN
            RAISE NOTICE 'Erreur attendue OK : age invalide';
    END;
END;
$$;

-- Test 3 : Insertion invalide (email invalide)
DO $$
BEGIN
    BEGIN
        CALL ajouter_passager('Bad Email', 'bademail', 25, 'CA999003');
    EXCEPTION
        WHEN others THEN
            RAISE NOTICE 'Erreur attendue OK : email invalide';
    END;
END;
$$;

-- Test 4 : Reservation valide
CALL reserver_vol('marie.tremblay@email.com', 'AC801', 'Economique');

-- Test 5 : Reservation sur un vol inexistant
DO $$
BEGIN
    BEGIN
        CALL reserver_vol('linh.nguyen@email.com', 'XX999', 'Affaires');
    EXCEPTION
        WHEN others THEN
            RAISE NOTICE 'Erreur attendue OK : vol inexistant';
    END;
END;
$$;

-- Test 6 : Fonction nombre de passagers par tranche d'age
SELECT nombre_passagers_par_age(18, 35) AS passagers_18_35;
SELECT nombre_passagers_par_age(36, 60) AS passagers_36_60;

-- Test 7 : Verifier les logs
SELECT * FROM logs ORDER BY date_action;

-- Test 8 : Verifier les reservations
SELECT
    p.nom AS passager,
    v.numero_vol,
    v.destination,
    r.classe,
    r.date_resa
FROM reservations r
JOIN passagers p ON p.id = r.passager_id
JOIN vols v      ON v.id = r.vol_id;
