CREATE TABLE IF NOT EXISTS P10_User(
	userId SERIAL PRIMARY KEY,
	userName varchar(20) NOT NULL,
	userDob DATE NOT NULL,
	userStatus varchar(10) CHECK(userStatus IN ('root','user')),
	userLogin varchar(255) NOT NULL,
	userPass varchar(255) NOT NULL);

CREATE TABLE IF NOT EXISTS P10_Ability(
	abilityId SERIAL PRIMARY KEY,
	abilityName varchar(50),
	abilityEffect TEXT NOT NULL);

CREATE TABLE IF NOT EXISTS P10_Resistance(
	resistanceId SERIAL PRIMARY KEY,
	resistanceType varchar(10) CHECK (resistanceType IN ('Incolore', 'Feu', 'Eau', 'Plante', 'Combat', 'Metal', 'Électrique', 'Psy', 'Obscurité', 'Dragon', 'Colorless', 'Fire', 'Water', 'Grass', 'Fighting', 'Metal', 'Lightning', 'Psychic', 'Darkness')),
	resistanceValue varchar(5) CHECK (resistanceValue IN ('/2','-20','-10','-30')));

CREATE TABLE IF NOT EXISTS P10_Weakness(
	weaknessId SERIAL PRIMARY KEY,
	weaknessType varchar(10) CHECK (weaknessType IN ('Incolore', 'Feu', 'Eau', 'Plante', 'Combat', 'Metal', 'Électrique', 'Psy', 'Obscurité', 'Dragon', 'Colorless', 'Fire', 'Water', 'Grass', 'Fighting', 'Metal', 'Lightning', 'Psychic', 'Darkness')),
	weaknessValue varchar(5) CHECK (weaknessValue IN ('×2','x2','+20','+10','+30')));

CREATE TABLE IF NOT EXISTS P10_Attack(
	attackId SERIAL PRIMARY KEY,
	attackName varchar(50) NOT NULL,
	attackCost varchar(50),
	attackDamage INT,
	attackEffect varchar(255));

CREATE TABLE IF NOT EXISTS P10_Card(
	cardId SERIAL PRIMARY KEY,
	cardCategory varchar(50) DEFAULT 'Pokémon' CHECK (cardCategory IN ('Pokémon','Pokemon','Dresseur','Trainer','Énergie','Energy')),
	cardName varchar(50) NOT NULL,
	cardHP INT,
	cardRarity varchar(50) DEFAULT 'Commune' CHECK (cardRarity IN ('Commune','Common','Uncommon','Peu Commune','Rare','Ultra Rare','Secret Rare','Magnifique','Magnifique rare')),
	cardImg varchar(100) NOT NULL,
	cardType varchar(10) CHECK (cardType IN ('Incolore', 'Feu', 'Eau', 'Plante', 'Combat', 'Metal', 'Électrique', 'Psy', 'Obscurité', 'Dragon', 'Colorless', 'Fire', 'Water', 'Grass', 'Fighting', 'Metal', 'Lightning', 'Psychic', 'Darkness')),
	cardExtension TEXT NOT NULL,
	cardRetreat INT,
	cardLang varchar(20) CHECK(cardLang IN ('fr','en')),
	abilityId INT REFERENCES P10_Ability(abilityId),
	resistanceId INT REFERENCES P10_Resistance(resistanceId),
	weaknessId INT REFERENCES P10_Weakness(weaknessId));

CREATE TABLE IF NOT EXISTS P10_Contient(
	cardId INT REFERENCES P10_Card(cardId),
	attackId INT REFERENCES P10_Attack(attackId));

CREATE TABLE IF NOT EXISTS P10_Collection(
	cardId INT REFERENCES P10_Card(cardId),
	userId INT REFERENCES P10_User(userId));

CREATE TABLE P10_qteCardUser (
	  userId INT PRIMARY KEY REFERENCES P10_User(userId),
	  nbCards INT NOT NULL
);
