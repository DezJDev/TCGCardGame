-- DROP TABLE P10_Card CASCADE CONSTRAINTS;
-- DROP TABLE P10_Ability CASCADE CONSTRAINTS;
-- DROP TABLE P10_Attack CASCADE CONSTRAINTS;
-- DROP TABLE P10_Resistance CASCADE CONSTRAINTS;
-- DROP TABLE P10_Weakness CASCADE CONSTRAINTS;
-- DROP TABLE P10_User CASCADE CONSTRAINTS;
-- DROP TABLE P10_Contient CASCADE CONSTRAINTS;
-- DROP TABLE P10_Collection CASCADE CONSTRAINTS;

-- DROP SEQUENCE seq_ability;
-- DROP SEQUENCE seq_resistance;
-- DROP SEQUENCE seq_weakness;
-- DROP SEQUENCE seq_attack;
-- DROP SEQUENCE seq_card;
-- DROP SEQUENCE seq_user;

CREATE SEQUENCE seq_ability;
CREATE SEQUENCE seq_resistance;
CREATE SEQUENCE seq_weakness;
CREATE SEQUENCE seq_attack;
CREATE SEQUENCE seq_card;
CREATE SEQUENCE seq_user;

CREATE TABLE P10_User(
	userId NUMBER DEFAULT seq_user.nextval PRIMARY KEY,
	userName VARCHAR2(20),
	userDob DATE,
	userStatus VARCHAR2(10) DEFAULT 'user',
	userLogin VARCHAR2(255),
	userPass VARCHAR2(255),
	CONSTRAINT CheckStatus CHECK (userStatus IN ('root', 'user')));

CREATE TABLE P10_Ability(
	abilityId NUMBER DEFAULT seq_ability.nextval PRIMARY KEY,
	abilityName VARCHAR2(50),
	abilityEffect varchar2(500) NOT NULL);

CREATE TABLE P10_Resistance(
	resistanceId NUMBER DEFAULT seq_resistance.nextval PRIMARY KEY,
	resistanceType VARCHAR2(20) NOT NULL,
	resistanceValue VARCHAR2(5) DEFAULT '-20',
	CONSTRAINT CheckTypeResistance CHECK (resistanceType IN ('Incolore', 'Feu', 'Eau', 'Plante', 'Combat', 'Metal', 'Électrique', 'Psy', 'Obscurité', 'Dragon', 'Colorless', 'Fire', 'Water', 'Grass', 'Fighting', 'Metal', 'Lightning', 'Psychic', 'Darkness')),
	CONSTRAINT CheckValueResistance CHECK (resistanceValue IN ('/2','-10','-20','-30')));

CREATE TABLE P10_Weakness(
	weaknessId NUMBER DEFAULT seq_weakness.nextval PRIMARY KEY,
	weaknessType VARCHAR2(20) NOT NULL,
	weaknessValue VARCHAR2(5) DEFAULT '×2',
	CONSTRAINT CheckTypeWeakness CHECK (weaknessType IN ('Incolore', 'Feu', 'Eau', 'Plante', 'Combat', 'Metal', 'Électrique', 'Psy', 'Obscurité', 'Dragon', 'Colorless', 'Fire', 'Water', 'Grass', 'Fighting', 'Metal', 'Lightning', 'Psychic', 'Darkness')),
	CONSTRAINT CheckValueWeakness CHECK (weaknessValue IN ('×2','x2','+10','+20','+30')));

CREATE TABLE P10_Attack(
	attackId NUMBER DEFAULT seq_attack.nextval PRIMARY KEY,
	attackName VARCHAR2(50) NOT NULL,
	attackCost VARCHAR2(50),
	attackDamage VARCHAR2(4),
	attackEffect VARCHAR2(255),
	attackLang VARCHAR2(20) DEFAULT 'fr',
	CONSTRAINT checkLang CHECK (attackLang IN ('fr','en')));

CREATE TABLE P10_Card(
	cardId NUMBER DEFAULT seq_card.nextval PRIMARY KEY,
	cardCategory VARCHAR2(50) DEFAULT 'Pokémon',
	cardName VARCHAR2(50),
	cardHP NUMBER,
	cardRarity VARCHAR2(50) DEFAULT 'Commune',
	cardImg VARCHAR2(100),
	cardType VARCHAR2(20),
	cardExtension VARCHAR2(255),
	cardRetreat NUMBER DEFAULT 1,
	cardLang VARCHAR2(20) DEFAULT 'fr',
	abilityId NUMBER REFERENCES P10_Ability(abilityId),
	resistanceId NUMBER REFERENCES P10_Resistance(resistanceId),
	weaknessId NUMBER REFERENCES P10_Weakness(weaknessId),
	CONSTRAINT CheckRarity CHECK (cardRarity IN ('Commune','Common','Uncommon','Peu Commune','Rare','Ultra Rare','Secret Rare','Magnifique','Magnifique rare')),
	CONSTRAINT CheckCategory CHECK (cardCategory IN ('Pokémon','Pokemon','Dresseur','Trainer', 'Énergie', 'Energy')));

CREATE TABLE P10_Contient(
	cardId NUMBER REFERENCES P10_Card(cardId),
	attackId NUMBER REFERENCES P10_Attack(attackId));

CREATE TABLE P10_Collection(
	cardId NUMBER REFERENCES P10_Card(cardId),
	userId NUMBER REFERENCES P10_User(userId));