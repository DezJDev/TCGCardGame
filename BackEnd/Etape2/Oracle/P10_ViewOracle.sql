CREATE OR REPLACE VIEW P10_UserAndCards AS
    SELECT userId, userName, userDob, userStatus, userLogin, userPass,
           cardId, cardCategory, cardName, cardHP, cardRarity, cardImg, cardType, cardExtension, cardRetreat, cardLang,
           abilityId, resistanceId, weaknessId
    FROM P10_User NATURAL JOIN P10_Collection NATURAL JOIN P10_Card pokemon;

CREATE OR REPLACE VIEW P10_UserWithoutCard AS
    SELECT * FROM P10_User WHERE userId NOT IN (SELECT userId FROM P10_User NATURAL JOIN P10_Collection NATURAL JOIN P10_Card
    GROUP BY userId, userName HAVING COUNT(CARDID) >= 1);

CREATE OR REPLACE VIEW P10_CardAndAttacks AS
    SELECT cardId, cardCategory, cardName, cardHP, cardRarity, cardImg, cardType,
           cardExtension, cardRetreat, cardLang, abilityId, resistanceId, weaknessId,
           attackId,attackName, attackCost, attackDamage, attackEffect
    FROM P10_Card NATURAL JOIN P10_Contient NATURAL JOIN P10_Attack;

/*SELECT * FROM P10_CardAndAttacks;
SELECT * FROM P10_UserAndCards;
SELECT * FROM P10_UserWithoutCard;*/
