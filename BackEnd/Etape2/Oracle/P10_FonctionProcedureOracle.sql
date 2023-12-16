-- Modifier le status utilisateur
CREATE OR REPLACE PROCEDURE P10_ModifierUser(newUserid IN NUMBER, new_status IN VARCHAR2) IS
BEGIN
    UPDATE P10_User SET userstatus = new_status WHERE userid = newUserid;
    EXCEPTION
        WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE('Une erreur est survenue lors de la mise à jour du statut utilisateur.');
END;

--- Retourne l'effet d'une abilité via son nom
CREATE OR REPLACE FUNCTION P10_RetournerAbilityEffet(abilityNom CHAR) RETURN VARCHAR2 IS
    effet VARCHAR2(500);
    plsEffet EXCEPTION;
BEGIN
    SELECT abilityeffect INTO effet FROM P10_Ability WHERE abilityName = abilityNom;
    IF effet IS NULL THEN
        DBMS_OUTPUT.PUT_LINE('Aucun effet trouvé pour cette capacité : ' || abilityNom);
        RAISE plsEffet;
    END IF;
    RETURN effet;
EXCEPTION
    WHEN OTHERS THEN
        RETURN NULL;
END;

-- Retourne les cartes de l'utilisateur
CREATE TYPE P10_RECTableUserCard AS OBJECT(cardName VARCHAR2(500));
CREATE TYPE P10_TableUserCard AS TABLE OF P10_RECTableUserCard;
CREATE OR REPLACE FUNCTION P10_RetournerCartesUtilisateur(utilisateurNom IN VARCHAR2) RETURN P10_TableUserCard PIPELINED IS
BEGIN
    FOR lignes IN (SELECT cardName FROM p10_collection NATURAL JOIN P10_Card NATURAL JOIN p10_User WHERE userName = utilisateurNom) LOOP
        PIPE ROW (P10_RECTableUserCard(lignes.cardName));
    END LOOP;
    RETURN;
EXCEPTION
    WHEN OTHERS THEN
        RETURN;
END;
/

CREATE TYPE P10_RECWeakness AS OBJECT(cardName VARCHAR2(500));
CREATE TYPE P10_TableWeakness AS TABLE OF P10_RECWeakness;
CREATE OR REPLACE FUNCTION P10_RetournerFaiblesses(faiblesse IN VARCHAR2) RETURN P10_TableWeakness PIPELINED IS
    CURSOR curseur IS SELECT cardName FROM P10_Card NATURAL JOIN P10_Weakness WHERE weaknessType = faiblesse;
BEGIN
    IF faiblesse IS NULL OR faiblesse = '' THEN
        DBMS_OUTPUT.PUT_LINE('Le paramètre faiblesse ne peut pas être vide.');
        RETURN;
    END IF;

    FOR lignes IN curseur LOOP
            PIPE ROW(P10_RECWeakness(lignes.cardName));
    END LOOP;
    RETURN;

EXCEPTION
    WHEN OTHERS THEN
        RETURN;
END;
/

/*SELECT P10_RetournerAbilityEffet('Cape Obscure') FROM dual;

SELECT P10_RetournerCartesUtilisateur('ShadowRider') FROM dual;
-- SELECT * FROM P10_TableUserCard('ShadowRider');

SELECT userStatus FROM P10_USER WHERE userId = 1;
CALL P10_ModifierUser(1, 'user');
SELECT userStatus FROM P10_USER WHERE userId = 1;

-- SELECT * FROM USER_ERRORS WHERE NAME = 'P10_RetournerFaiblesses';
-- SELECT P10_RetournerFaiblesses('Feu') FROM dual;
-- SELECT * FROM P10_TableWeakness('Feu');*/

