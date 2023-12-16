CREATE OR REPLACE VIEW P10_UtilisateursCartes AS
    SELECT userId ,userName, cardId, cardCategory, cardName, cardHP, cardRarity, cardImg, cardType, cardExtension, cardRetreat, cardLang, abilityId, resistanceId, weaknessId FROM p10_user user NATURAL JOIN p10_collection NATURAL JOIN p10_card pokemon;

-- permet de réunir tous les utilisateurs avec les carte qui leurs sont associé. Grâce à ça il sera plus simple de demmandé les carte d'un joueur
-- a la bdd. On exclu les login et détails sur l'utilisateur qui ne sont pas utils dans le contexte.
--  exemple d'utilisation:
-- SELECT cardName FROM vueUtilisateursCartes WHERE userId = 5;


CREATE OR REPLACE VIEW P10_CardAndAttacks AS
    SELECT cardId, cardCategory, cardName, cardHP, cardRarity, cardImg, cardType,
           cardExtension, cardRetreat, cardLang, abilityId, resistanceId, weaknessId,
           attackId,attackName, attackCost, attackDamage, attackEffect
    FROM P10_Card NATURAL JOIN P10_Contient NATURAL JOIN P10_Attack;

-- Permet de réunir les cartes et les attaques de la bdd

CREATE OR REPLACE VIEW P10_UserWithoutCard AS
    SELECT * FROM P10_User WHERE userId NOT IN (SELECT userId FROM P10_User NATURAL JOIN P10_Collection NATURAL JOIN P10_Card
    GROUP BY userId, userName HAVING COUNT(CARDID) >= 1);

-- *Retourne les utilisateurs sans carte

