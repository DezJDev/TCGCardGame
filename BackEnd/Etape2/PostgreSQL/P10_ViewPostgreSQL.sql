CREATE OR REPLACE VIEW P10_UtilisateursCartes AS
    SELECT u.userId, u.userName, c.cardId, c.cardCategory, c.cardName, c.cardHP, c.cardRarity, c.cardImg, c.cardType, c.cardExtension, c.cardRetreat, c.cardLang, c.abilityId, c.resistanceId, c.weaknessId
    FROM p10_user u
    JOIN p10_collection coll ON u.userId = coll.userId
    JOIN p10_card c ON coll.cardId = c.cardId;

-- permet de réunir tous les utilisateurs avec les cartes qui leurs sont associées.
-- Grâce à cela, il sera plus simple de demander les cartes d'un joueur à la BDD.
-- On exclut les login et détails sur l'utilisateur qui ne sont pas utiles dans le contexte.
-- exemple d'utilisation:
-- SELECT cardName FROM vueUtilisateursCartes WHERE userId = 5;

CREATE OR REPLACE VIEW P10_CardAndAttacks AS
    SELECT c.cardId, c.cardCategory, c.cardName, c.cardHP, c.cardRarity, c.cardImg, c.cardType,
           c.cardExtension, c.cardRetreat, c.cardLang, c.abilityId, c.resistanceId, c.weaknessId,
           a.attackId, a.attackName, a.attackCost, a.attackDamage, a.attackEffect
    FROM P10_Card c
    JOIN P10_Contient cont ON c.cardId = cont.cardId
    JOIN P10_Attack a ON cont.attackId = a.attackId;

-- Permet de réunir les cartes et les attaques de la BDD.

CREATE OR REPLACE VIEW P10_UserWithoutCard AS
    SELECT *
    FROM P10_User u
    WHERE u.userId NOT IN (
        SELECT cu.userId
        FROM P10_User cu
        JOIN P10_Collection coll ON cu.userId = coll.userId
        JOIN P10_Card card ON coll.cardId = card.cardId
        GROUP BY cu.userId, cu.userName
        HAVING COUNT(card.cardId) >= 1
    );

