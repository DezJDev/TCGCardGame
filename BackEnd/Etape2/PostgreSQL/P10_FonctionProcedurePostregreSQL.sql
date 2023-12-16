--- Modifier le status utilisateur
CREATE OR REPLACE PROCEDURE P10_ModifierUser(newUserid INT, new_status VARCHAR) AS $$
BEGIN
    UPDATE P10_User
    SET userstatus = new_status
    WHERE userid = newUserid;
EXCEPTION
    WHEN OTHERS THEN
        RAISE NOTICE 'Une erreur est survenue lors de la mise à jour du statut utilisateur.';
END;
$$ LANGUAGE plpgsql;


--- Retourne l'effet d'une abilité via son nom
CREATE OR REPLACE FUNCTION P10_RetournerAbilityEffet(abilityNom CHAR) RETURNS TEXT AS $$
DECLARE
    effet TEXT;
BEGIN
    SELECT abilityeffect INTO effet FROM P10_Ability WHERE abilityName = abilityNom;

    IF effet IS NULL THEN
        RAISE EXCEPTION 'Aucun effet trouvé pour cette capacité : %', abilityNom;
    END IF;

    RETURN effet;
EXCEPTION
    WHEN OTHERS THEN
        RETURN NULL;
END;
$$ LANGUAGE plpgsql;

--Retourne les cartes de l'utilisateur
CREATE OR REPLACE FUNCTION P10_RetournerCartesUtilisateur(utilisateurNom VARCHAR) RETURNS SETOF VARCHAR AS $$
BEGIN
    RETURN QUERY SELECT cardName FROM P10_Collection NATURAL JOIN P10_Card NATURAL JOIN P10_User WHERE userName = utilisateurNom;
    EXCEPTION
        WHEN others THEN
            RETURN;
    END;
$$ LANGUAGE plpgsql;

--Retourne les cartes d'une faiblesse
CREATE OR REPLACE FUNCTION P10_RetournerFaiblesses(faiblesse VARCHAR) RETURNS SETOF VARCHAR AS $$
DECLARE
    card_row VARCHAR;
    curseur CURSOR FOR SELECT cardname FROM P10_Card NATURAL JOIN P10_Weakness WHERE weaknesstype=faiblesse;
BEGIN
    IF faiblesse IS NULL OR faiblesse = '' THEN
        RAISE EXCEPTION 'Le paramètre faiblesse ne peut pas être vide.';
    END IF;

    OPEN curseur;
    LOOP
        FETCH curseur INTO card_row;
        EXIT WHEN NOT FOUND;
        RETURN NEXT card_row;
    END LOOP;
    CLOSE curseur;

    RETURN;

EXCEPTION
    WHEN others THEN
        RAISE EXCEPTION 'Une erreur s''est produite : %', SQLERRM;
END;
$$ LANGUAGE plpgsql;

-- SELECT P10_RetournerAbilityEffet('Cape Obscure');
-- SELECT P10_RetournerCartesUtilisateur('ShadowRider');
-- SELECT P10_RetournerFaiblesses('Feu');
-- SELECT userId FROM P10_User WHERE userId = 1;
-- CALL P10_ModifierUser(1, 'root');
-- SELECT userId FROM P10_User WHERE userId = 1;

