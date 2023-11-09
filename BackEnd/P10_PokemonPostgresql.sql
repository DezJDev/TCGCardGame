DROP TABLE IF EXISTS P10_Card;
DROP TABLE IF EXISTS P10_Attack;
DROP TABLE IF EXISTS P10_Resistance;
DROP TABLE IF EXISTS P10_Weakness;
DROP TABLE IF EXISTS P10_User;
DROP TABLE IF EXISTS P10_Abitility;
DROP TABLE IF EXISTS P10_Contient;
DROP TABLE IF EXISTS P10_Collection;

CREATE TABLE IF NOT EXISTS P10_User(
	userId SERIAL PRIMARY KEY,
	userName varchar(20) NOT NULL,
	userDob date NOT NULL,
	userStatus varchar(10) NOT NULL CHECK IN ['root','user'],
	userLogin varchar(255) NOT NULL,
	userPass varchar(255) NOT NULL);

CREATE TABLE IF NOT EXISTS P10_Ability(
	abilityId SERIAL PRIMARY KEY,
	abilityName varchar(50) NOT NULL,
	abilityEffect varchar(255) NOT NULL);

CREATE TABLE IF NOT EXISTS P10_Resistance(
	resistanceId SERIAL PRIMARY KEY,
	resistanceType varchar(10) NOT NULL CHECK IN ['Incolore', 'Feu', 'Eau', 'Plante', 'Combat', 'M�tal', '�lectrique', 'Psy', 'Obscurit�', 'Dragon', 'Colorless', 'Fire', 'Water', 'Grass', 'Fighting', 'Metal', 'Lightning', 'Psychic', 'Darkness'],
	resistanceValue varchar(5) NOT NULL CHECK IN ['/2',-20,-10,-30]);

CREATE TABLE IF NOT EXISTS P10_Weakness(
	weaknessId SERIAL PRIMARY KEY,
	weaknessType varchar(10) NOT NULL CHECK IN ['Incolore', 'Feu', 'Eau', 'Plante', 'Combat', 'M�tal', '�lectrique', 'Psy', 'Obscurit�', 'Dragon', 'Colorless', 'Fire', 'Water', 'Grass', 'Fighting', 'Metal', 'Lightning', 'Psychic', 'Darkness'],
	weaknessValue varchar(5) NOT NULL CHECK IN ['x2',+20,+10,+30]);

CREATE TABLE IF NOT EXISTS P10_Attack(
	attackId SERIAL PRIMARY KEY,
	attackName varchar(50) NOT NULL,
	attackCost varchar(50),
	attackDamage varchar(4),
	attackEffect varchar(255),
	attackLang varchar(20) NOT NULL CHECK IN ['fr','en']);

CREATE TABLE IF NOT EXISTS P10_Card(
	cardId SERIAL PRIMARY KEY,
	cardCategory varchar(50) NOT NULL 'Pok�mon' CHECK IN ['Pok�mon','Pokemon','Dresseur','Trainer'],
	cardName varchar(50) NOT NULL,
	cardHP INT,
	cardRarity varchar(50) NOT NULL 'Commune' CHECK IN ['Commune','Common','Uncommon','Peu Commune','Rare','Ultra Rare','Secret Rare','Magnifique','Maginfic'],
	cardImg varchar(20) NOT NULL,
	cardType varchar(10) CHECK IN ['Incolore', 'Feu', 'Eau', 'Plante', 'Combat', 'M�tal', '�lectrique', 'Psy', 'Obscurit�', 'Dragon', 'Colorless', 'Fire', 'Water', 'Grass', 'Fighting', 'Metal', 'Lightning', 'Psychic', 'Darkness'],
	cardExtension varchar(255) NOT NULL,
	cardRetreat INT,
	cardLang varchar(20) NOT NULL CHECK IN ['fr','en'],
	abilityId INT REFERENCES P10_Ability(abilityId) DEFAULT null,
	resistanceId INT REFERENCES P10_Resistance(resistanceId) DEFAULT null,
	weaknessId INT REFERENCES P10_Weakness(weaknessId) DEFAULT null);

CREATE TABLE IF NOT EXISTS P10_Contient(
	cardId INT REFERENCES P10_Card(cardId),
	attackId INT REFERENCES P10_Attack(attackId));

CREATE TABLE IF NOT EXISTS P10_Collection(
	cardId INT REFERENCES P10_Card(cardId),
	userId INT REFERENCES P10_User(userId));


INSERT INTO P10_Ability(abilityName,abilityEffect) VALUES 
	('Pouv.Antique','Aucun joueur ne peut jouer de Pok�mon de sa main pour faire �voluer ses Pok�mon.'),
	('Dual Armor','If this Pok�mon has any Metal Energy attached to it, this Pok�mon�s type is both Fighting and Metal.'),
	('Transfert Plasma','Autant de fois que vous le voulez pendant votre tour (avant votre attaque), vous pouvez d�placer une �nergie Plasma attach�e � 1 de vos Pok�mon vers un autre de vos Pok�mon.'),
	('C�ur Noble','Chaque attaque de ce Pok�mon inflige 50 d�g�ts suppl�mentaires aux Pok�mon Darkness (avant application de la Faiblesse et de la R�sistance).'),
	('Damage Swap','As often as you like during your turn (before your attack), you may move 1 damage counter from 1 of your Pok�mon to another of your Pok�mon.'),
	('Connexion Renforc�e','Les attaques de vos Pok�mon de la Team Plasma (except� Deoxys-EX) infligent 10 d�g�ts suppl�mentaires aux Pok�mon Actifs (avant application de la Faiblesse et de la R�sistance).'),
	('Victorieux','Une seule fois pendant votre tour, apr�s avoir lanc� des pi�ces pour une attaque, vous pouvez ignorer les effets de ces lancers de pi�ce et lancer ces pi�ces � nouveau. Vous ne pouvez pas utiliser la capacit� sp�ciale Victorieux plus d�une fois par tour.'),
	('Dark Trance','As often as you like during your turn (before your attack), you may move a Darkness Energy attached to 1 of your Pok�mon to another of your Pok�mon.'),
	('Coquille Lib�rante','Lorsque vous jouez ce Pok�mon de votre main pour faire �voluer 1 de vos Pok�mon, vous pouvez chercher Munja dans votre deck et le placer sur votre Banc. M�langez ensuite votre deck.'),
	('Aura de T�n�bres','Toutes les �nergies attach�es � ce Pok�mon sont des �nergies Darkness au lieu de leur type habituel.'),
	('Solide Roc','Si des d�g�ts sont inflig�s � ce Pok�mon par des attaques, lancez une pi�ce. Si c�est face, les d�g�ts sont r�duits de 50 (apr�s application de la Faiblesse et de la R�sistance).'),
	('Airhead','If you have 2, 4, or 6 Prize cards left, this Pok�mon can�t attack.'),
	('Aile Impitoyable','Lorsque vous jouez ce Pok�mon de votre main pour faire �voluer 1 de vos Pok�mon, vous pouvez d�fausser toutes les cartes Outil Pok�mon attach�es � chacun des Pok�mon de votre adversaire.'),
	('Sealing Scream','Each player can�t play any ACE SPEC cards from his or her hand.'),
	('Sinister Hand','As often as you like during your turn (before your attack), you may move 1 damage counter from 1 of your opponent�s Pok�mon to another of your opponent�s Pok�mon.'),
	('Cuvette','N�importe quand entre chaque tour, soignez 20 d�g�ts � ce Pok�mon.'),
	('Apesanteur','Si aucune �nergie n�est attach�e � ce Pok�mon, ce Pok�mon n�a pas de co�t de Retraite.');

INSERT INTO P10_Attack(attackName,attackCost,attackDamage,attackEffect) VALUES 
	('Rayon Vivifiant','IncoloreIncolore','40','Retirez tous les �tats Sp�ciaux du Pok�mon D�fenseur.'),
	('Tit''sieste','Incolore','n/a','Soignez 20 d�g�ts � ce Pok�mon.'),
	('Appel Foudroyant','�lectrique','30','Attachez une carte �nergie de votre pile de d�fausse � 1 de vos Pok�mon de la Team Plasma sur votre Banc.'),
	('Supersonic','Colorless',null,'The Defending Pok�mon is now Confused.'),
	('�boulement','CombatCombatIncolore','60','Inflige 10 d�g�ts � 2 des Pok�mon de Banc de votre adversaire. (N''appliquez ni la Faiblesse ni la R�sistance aux Pok�mon de Banc.)'),
	('Tight Jaw','PsychicColorless','30','Flip a coin. If heads, the Defending Pok�mon is now Paralyzed.'),
	('Rafale Psy','PsyIncolore','30','Le Pok�mon D�fenseur est maintenant Confus.'),
	('Headbutt','Colorless','10',null),
	('Smash Turn','WaterColorless','30','You may switch this Pok�mon with 1 of your Benched Pok�mon.'),
	('Bataille','Incolore','10',null),
	('Ice Beam','WaterColorless','20','Flip a coin. If heads, the Defending Pok�mon is now Paralyzed.'),
	('Vol Supersonique','PsyIncolore','40','Le Pok�mon D�fenseur ne peut pas battre en retraite pendant le prochain tour de votre adversaire.'),
	('Hurricane Kick','FightingColorlessColorless','60','Does 30 more damage for each Prize card your opponent has taken.'),
	('Triplattaque','IncoloreIncoloreIncolore','50','Lancez 3 pi�ces. Cette attaque inflige 50 d�g�ts multipli�s par le nombre de c�t�s face.'),
	('Ensnarl','ColorlessColorless','20','Does 20 damage times the number of Colorless in the Defending Pok�mon''s Retreat Cost.'),
	('T�te de Fer','M�talM�talIncolore','60','Lancez une pi�ce jusqu''� ce que vous obteniez un c�t� pile. Cette attaque inflige 20 d�g�ts suppl�mentaires pour chaque c�t� face.'),
	('Psywave','PsychicPsychicPsychic','30','Does 10 more damage for each Energy attached to the Defending Pok�mon.'),
	('Dard-Venin','PsyIncolore','20','Lancez une pi�ce. Si c''est face, le Pok�mon D�fenseur est maintenant Empoisonn�.'),
	('Deep Dive','ColorlessColorless',null,'Flip 2 coins. For each heads, heal 40 damage from this Pok�mon.'),
	('Assaut Humide','Eau','10','Lancez une pi�ce jusqu''� ce que vous obteniez un c�t� pile. Cette attaque inflige 10 d�g�ts multipli�s par le nombre de c�t�s face.'),
	('Dragon Claw','ColorlessColorlessColorless','60',null),
	('Force Spirale','PsyIncolore','30','Si de l''�nergie Plasma est attach�e � ce Pok�mon, cette attaque inflige 30 d�g�ts suppl�mentaires pour chaque �nergie attach�e au Pok�mon D�fenseur.'),
	('Mue','Incolore',null,'Soignez 40 d�g�ts � ce Pok�mon.'),
	('Hail','Colorless',null,'This attack does 10 damage to each of your opponent''s Pok�mon. (Don''t apply Weakness and Resistance for Benched Pok�mon.)'),
	('Unstoppable Roll','WaterColorless','10','Flip 2 coins. If both of them are heads, this attack does 30 more damage.'),
	('�nergisant','�lectrique',null,'Attachez une carte �nergie Lightning de votre pile de d�fausse � ce Pok�mon.'),
	('Griffe Acier','M�tal','20',null),
	('Shear','Fighting',null,'Discard the top 5 cards of your deck. If any of those cards are Fighting Energy cards, attach them to this Pok�mon.'),
	('Force Ajout�e','FeuIncolore','30','D�placez toutes les �nergies attach�es � ce Pok�mon vers 1 de vos Pok�mon de Banc.'),
	('Bug Bite','GrassColorless','20',null),
	('Double Morsure','IncoloreIncolore','20','Inflige 10 d�g�ts suppl�mentaires pour chaque marqueur de d�g�ts plac� sur le Pok�mon D�fenseur.'),
	('Dragonblast','PsychicDarknessDarknessColorless','140','Discard 2 Darkness Energy attached to this Pok�mon.'),
	('Punition Obscure','Obscurit�','90','S''il n''y a pas de carte Outil Pok�mon attach�e au Pok�mon D�fenseur, cette attaque ne fait rien.'),
	('Paralyzing Jab','PsychicColorless','20','Flip a coin. If heads, the Defending Pok�mon is now Paralyzed.'),
	('M�ga-Sangsue','Plante','20','Soignez 20 d�g�ts inflig�s � ce Pok�mon.'),
	('Body Slam','GrassGrass','20','Flip a coin. If heads, the Defending Pok�mon is now Paralyzed.'),
	('Tombe de Sable','Combat','10','Le Pok�mon D�fenseur ne peut pas battre en retraite durant le prochain tour de votre adversaire.'),
	('Doom Decree','PsychicColorless',null,'Flip 2 coins. If both of them are heads, the Defending Pok�mon is Knocked Out.'),
	('Armure','Incolore',null,'Pendant le prochain tour de votre adversaire, si ce Pok�mon doit subir les d�g�ts d''une attaque, �vitez les d�g�ts inflig�s � ce Pok�mon si ces d�g�ts sont de 40 ou moins.'),
	('Metal Sound','Colorless',null,'The Defending Pok�mon is now Confused.'),
	('Double Hit','Colorless','20','Flip 2 coins. This attack does 20 damage times the number of heads.'),
	('Charge Destructrice','FeuIncolore','20','Lancez une pi�ce jusqu''� ce que vous obteniez un c�t� pile. Cette attaque inflige 20 d�g�ts multipli�s par le nombre de c�t�s face.'),
	('Triple Laser','ColorlessColorlessColorless',null,'This attack does 30 damage to 3 of your opponent''s Pok�mon. (Don''t apply Weakness and Resistance for Benched Pok�mon.)'),
	('Tranche-Nuit','PlanteIncolore','60','Vous pouvez �changer ce Pok�mon avec 1 de vos Pok�mon de Banc.'),
	('Gnaw','ColorlessColorless','20',null),
	('Lame Folle','Obscurit�Obscurit�Obscurit�Obscurit�','60','Inflige 40 d�g�ts � 2 des Pok�mon de Banc de votre adversaire. (N''appliquez ni la Faiblesse ni la R�sistance aux Pok�mon de Banc.)'),
	('Steel Feelers','Metal','30','Flip 3 coins. This attack does 30 damage times the number of heads.'),
	('Tranch''Herbe','PlantePlante','40',null),
	('Sharp Fang','WaterColorlessColorless','60',null),
	('Coup d''Boule','Obscurit�','10',null),
	('Rollout','Colorless','10',null),
	('Choc Mental','Psy','10','Lancez une pi�ce. Si c''est face, le Pok�mon D�fenseur est maintenant Paralys�.'),
	('Slicing Blade','WaterColorless','30',null),
	('Aiguillon Triple','Plante','10','Lancez 3 pi�ces. Cette attaque inflige 10 d�g�ts multipli�s par le nombre de c�t�s face.'),
	('Sweet Scent','Grass',null,'Heal 20 damage from 1 of your Pok�mon.'),
	('Appel � la Famille','Incolore',null,'Cherchez 2 Pok�mon de base dans votre deck et placez-les sur votre Banc. M�langez ensuite votre deck.'),
	('Mud-Slap','ColorlessColorless','30',null),
	('M�chouille','EauEauIncoloreIncolore','80','D�faussez une �nergie attach�e au Pok�mon D�fenseur.'),
	('Lazy Headbutt','WaterColorless','80','This Pok�mon is now Asleep.'),
	('Jet de Sable','Incolore','20','Si le Pok�mon D�fenseur essaie d''attaquer pendant le prochain tour de votre adversaire, ce dernier lance une pi�ce. Si c�est pile, son attaque ne fait rien.'),
	('An�antissement de Ga�a','FeuEauIncoloreIncolore','100','D�faussez toute carte Stade en jeu.'),
	('Lovestrike','ColorlessColorless','20','Does 40 more damage for each Nidoqueen on your Bench.'),
	('Hexed Mirror','Colorless',null,'Shuffle your hand into your deck. Then, draw a number of cards equal to the number of cards in your opponent''s hand.'),
	('Charge-Os','Obscurit�','30','Lancez une pi�ce jusqu''� ce que vous obteniez un c�t� pile. Cette attaque inflige 30 d�g�ts multipli�s par le nombre de c�t�s face.'),
	('Shadow Punch','PsychicColorlessColorlessColorless','60','This attack''s damage isn''t affected by Resistance.'),
	('Soin','Incolore',null,'D�faussez une �nergie attach�e � ce Pok�mon et soignez tous les d�g�ts de ce Pok�mon.'),
	('Jump On','Lightning','10','Flip a coin. If heads, this attack does 10 more damage.'),
	('Acide','IncoloreIncolore','30','Le Pok�mon D�fenseur ne peut pas battre en retraite pendant le prochain tour de votre adversaire.'),
	('Minor Errand-Running','Colorless',null,'Search your deck for 2 basic Energy cards, reveal them, and put them into your hand. Shuffle your deck afterward.'),
	('Max Milk','ColorlessColorless',null,'Heal all damage from 1 of your Pok�mon. Then, discard all Energy attached to this Pok�mon.'),
	('T�l�portation Explosive','Psy','10','�changez ce Pok�mon avec 1 de vos Pok�mon de Banc.'),
	('Pound','ColorlessColorless','20',null),
	('Danse Enivr�e','EauEauIncolore','70','Vous pouvez d�fausser une �nergie attach�e � ce Pok�mon. Dans ce cas, le Pok�mon D�fenseur est maintenant Confus.'),
	('Water Gun','ColorlessColorless','30',null),
	('Roulade Continue','Incolore','10','Lancez une pi�ce jusqu�� ce que vous obteniez un c�t� pile. Cette attaque inflige 10 d�g�ts multipli�s par le nombre de c�t�s face.'),
	('Air Slash','ColorlessColorlessColorless','60','Discard an Energy attached to this Pok�mon.'),
	('Feu Follet','FeuIncolore','20',null),
	('Searing Flame','Fire','20','The Defending Pok�mon is now Burned.'),
	('Blizzard','EauIncoloreIncolore','60','Inflige 10 d�g�ts � chacun des Pok�mon de Banc de votre adversaire. (N''appliquez ni la Faiblesse ni la R�sistance aux Pok�mon de Banc.)'),
	('Recover','Colorless',null,'Discard an Energy attached to this Pok�mon and heal all damage from this Pok�mon.'),
	('Coup d''Main','Incolore',null,'Cherchez une carte �nergie de base dans votre deck et attachez-la � 1 de vos Pok�mon de Banc. M�langez ensuite votre deck.'),
	('Stoke','Colorless',null,'Flip a coin. If heads, search your deck for a Fire Energy card and attach it to this Pok�mon. Shuffle your deck afterward.'),
	('Flux Draconique','FeuIncoloreIncolore','60','Lancez une pi�ce. Si c''est face, attachez une carte �nergie de base de votre pile de d�fausse � ce Pok�mon.'),
	('Celestial Roar','Colorless',null,'Discard the top 3 cards of your deck. If any of those cards are Energy cards, attach them to this Pok�mon.');

INSERT INTO P10_Attack(attackName,attackCost,attackDamage,attackEffect) VALUES 
	('Baffe Sangsue','IncoloreIncoloreIncolore','60','Soignez 30 d�g�ts � ce Pok�mon.'),
	('Saut','IncoloreIncolore','20','Lancez une pi�ce. Si c''est face, cette attaque inflige 10 d�g�ts suppl�mentaires.'),
	('Grondement Tonitruant','�lectrique�lectriqueIncoloreIncolore','90','Si de l''�nergie Plasma est attach�e � ce Pok�mon, d�faussez une �nergie attach�e au Pok�mon D�fenseur.'),
	('Hyper Voice','WaterColorlessColorless','50',null),
	('Extrasenseur','PsyIncoloreIncolore','60','Si vous avez le m�me nombre de cartes dans votre main que votre adversaire, cette attaque inflige 60 d�g�ts suppl�mentaires.'),
	('Calm Mind','Psychic',null,'Heal 30 damage from this Pok�mon.'),
	('Dual Splash','WaterWaterColorless',null,'This attack does 50 damage to 2 of your opponent''s Pok�mon. (Don''t apply Weakness and Resistance for Benched Pok�mon.)'),
	('Verglas','EauIncolore','20',null),
	('Frost Breath','WaterWater','40',null),
	('Lumi-�clat','EauPsyIncolore','150','D�faussez toutes les �nergies attach�es � ce Pok�mon.'),
	('Double Ducts','PsychicColorlessColorlessColorless','80','Flip 2 coins. This attack does 80 damage times the number of heads.'),
	('Aqua Sonic','WaterWaterColorless','70','This attack''s damage isn''t affected by Resistance.'),
	('Blizzard','WaterPsychicColorlessColorless','90','Does 10 damage to each of your opponent''s Benched Pok�mon. (Don''t apply Weakness and Resistance for Benched Pok�mon.)'),
	('Coup Rapide','Obscurit�Obscurit�','40','Lancez une pi�ce. Si c''est pile, cette attaque ne fait rien.'),
	('Vilify','DarknessColorless','30','Discard as many Pok�mon as you like from your hand. This attack does 30 damage times the number of Pok�mon you discarded.'),
	('Tonnerre','�lectriqueIncoloreIncolore','80','D�faussez toutes les �nergies attach�es � ce Pok�mon.'),
	('T�te de Fer','M�talIncoloreIncolore','50','Lancez une pi�ce jusqu''� ce que vous obteniez un c�t� pile. Cette attaque inflige 50 d�g�ts multipli�s par le nombre de c�t�s face.'),
	('Rock Bullet','ColorlessColorlessColorlessColorless','40','Does 20 more damage for each Fighting Energy attached to this Pok�mon.'),
	('Balayage','IncoloreIncoloreIncolore','60',null),
	('Combo-Griffe','IncoloreIncoloreIncolore','30','Lancez 3 pi�ces. Cette attaque inflige 30 d�g�ts multipli�s par le nombre de c�t�s face.'),
	('Dard-Nu�e','PlantePlanteIncolore','20','Lancez 4 pi�ces. Cette attaque inflige 20 d�g�ts multipli�s par le nombre de c�t�s face.'),
	('Morsure','CombatIncoloreIncolore','30',null),
	('Black Magic','PsychicColorlessColorless','40','Does 20 more damage for each of your opponent''s Benched Pok�mon.'),
	('Coup d''Boule','CombatIncoloreIncolore','40',null),
	('Electro Ball','LightningColorless','30',null),
	('Hand Fling','ColorlessColorless','10','Does 10 damage times the number of cards in your hand.'),
	('Flammes de Glace','FeuEauIncoloreIncolore','80','Lancez une pi�ce. Si c''est face, cette attaque inflige 40 d�g�ts suppl�mentaires.'),
	('Protect Charge','MetalMetalColorlessColorless','80','During your opponent''s next turn, any damage done to this Pok�mon by attacks is reduced by 20 (after applying Weakness and Resistance).'),
	('Gyro Ball','MetalColorlessColorless','60','Switch this Pok�mon with 1 of your Benched Pok�mon. Then, your opponent switches the Defending Pok�mon with 1 of his or her Benched Pok�mon.'),
	('Choc Frontal','PlantePlanteIncolore','80','Ce Pok�mon et le Pok�mon D�fenseur sont maintenant Confus.'),
	('Swing Around','WaterColorlessColorlessColorless','60','Flip 2 coins. This attack does 30 more damage for each heads.'),
	('Slash','FightingColorlessColorless','40',null),
	('Coup de Poing Psy','PsyIncoloreIncolore','50',null),
	('Hydro Pump','ColorlessColorlessColorless','60','Does 10 more damage for each Water Energy attached to this Pok�mon.'),
	('Poing Com�te','IncoloreIncolore','20','Lancez 4 pi�ces. Cette attaque inflige 20 d�g�ts multipli�s par le nombre de c�t�s face.'),
	('Corkscrew Punch','DarknessDarknessColorlessColorless','70',null),
	('Flamme Tranchante','FeuIncoloreIncolore','60','Vous pouvez d�fausser une �nergie Fire attach�e � ce Pok�mon. Dans ce cas, cette attaque inflige 30 d�g�ts suppl�mentaires.'),
	('Horn Drill','FightingColorlessColorlessColorless','90',null),
	('Vibrobscur','IncoloreIncolore','20','Inflige 10 d�g�ts suppl�mentaires pour chaque �nergie Darkness attach�e � tous vos Pok�mon.'),
	('Roulade','PsyIncolore','30',null),
	('�clair Fou','�lectrique�lectriqueIncolore','90','Ce Pok�mon s''inflige 10 d�g�ts.'),
	('Electric Tail','Lightning','10','Flip a coin. If heads, the Defending Pok�mon is now Paralyzed.'),
	('Tackle','ColorlessColorless','30',null),
	('Poison Gas','PsychicColorlessColorless','30','The Defending Pok�mon is now Poisoned.'),
	('Razor Shell','WaterWaterColorless','40','Flip a coin. If heads, this attack does 20 more damage.'),
	('Flame Blast','ColorlessColorlessColorless','40','Does 20 more damage for each Fire Energy attached to this Pok�mon.'),
	('Prison de Givre','EauEauIncoloreIncolore','80','Si de l''�nergie Plasma est attach�e � ce Pok�mon, le Pok�mon D�fenseur est maintenant Paralys�.'),
	('Water Gun','Water','10',null),
	('Cotogarde','Plante','30','Pendant le prochain tour de votre adversaire, tous les d�g�ts inflig�s � ce Pok�mon par des attaques sont r�duits de 30 (apr�s application de la Faiblesse et de la R�sistance).'),
	('Firebreathing','FireColorless','10','Flip a coin. If heads, this attack does 20 more damage.'),
	('Feu Glac�','FeuFeuEauIncolore','150','D�faussez 2 �nergies Fire attach�es � ce Pok�mon. Le Pok�mon D�fenseur est maintenant Br�l�.'),
	('Dragon Burst','FireLightning','60','Discard all basic Fire Energy or all basic Lightning Energy attached to this Pok�mon. This attack does 60 damage times the number of Energy cards you discarded.');

INSERT INTO P10_Resistance(resistanceType,resistanceValue) VALUES 
	('Psy','-20'),
	('Psychic','-20'),
	('Eau','-20'),
	('�lectrique','-20'),
	('Lightning','-20'),
	('Combat','-20'),
	('Fighting','-20');

INSERT INTO P10_Weakness(weaknessType,weaknessValue) VALUES 
	('Combat','�2'),
	('Grass','�2'),
	('Plante','�2'),
	('Psy','�2'),
	('Psychic','�2'),
	('Lightning','�2'),
	('M�tal','�2'),
	('Metal','�2'),
	('Dragon','�2'),
	('Feu','�2'),
	('�lectrique','�2'),
	('Fighting','�2'),
	('Eau','�2'),
	('Fire','�2'),
	('Water','�2'),
	('Darkness','�2'),
	('Obscurit�','�2');

INSERT INTO P10_Card(cardCategory,cardName,cardHP,cardRarity,cardImg,cardType,cardExtensioncardRetreat,cardLang,abilityId,resistanceId,weaknessId) VALUES
	('Pok�mon','Nanm�ou�e','90','Peu Commune','https://assets.tcgdex.net/fr/bw/bw6/108/high.webp','Incolore','Dragons �xalt�s',2,'fr',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Combat' AND weaknessValue = '�2'),null),
	('Trainer','Xtransceiver',null,'Uncommon','https://assets.tcgdex.net/en/bw/bw3/96/high.webp',null,'Noble Victories',null,'en',null,null,null),
	('Pok�mon','Miaouss','60','Commune','https://assets.tcgdex.net/fr/bw/bwp/BW35/high.webp','Incolore','Promo BW',1,'fr',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Combat' AND weaknessValue = '�2'),null),
	('Trainer','Tool Scrapper',null,'Uncommon','https://assets.tcgdex.net/en/bw/bw6/116/high.webp',null,'Dragons Exalted',null,'en',null,null,null),
	('Pok�mon','Fulguris-EX','170','Rare','https://assets.tcgdex.net/fr/bw/bw9/38/high.webp','�lectrique','Glaciation Plasma',1,'fr',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Combat' AND weaknessValue = '�2'),null),
	('Pokemon','Palpitoad','80','Uncommon','https://assets.tcgdex.net/en/bw/bw6/35/high.webp','Water','Dragons Exalted',1,'en',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Grass' AND weaknessValue = '�2'),null),
	('Pok�mon','A�ropt�ryx','130','Rare','https://assets.tcgdex.net/fr/bw/bw3/67/high.webp','Combat','Nobles Victoires',2,'fr',(SELECT abilityId FROM P10_Ability WHERE abilityName = 'Pouv.Antique' AND abilityEffect = 'Aucun joueur ne peut jouer de Pok�mon de sa main pour faire �voluer ses Pok�mon.'),(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Plante' AND weaknessValue = '�2'),null),
	('Pokemon','Sableye','70','Uncommon','https://assets.tcgdex.net/en/bw/bw11/61/high.webp','Psychic','Legendary Treasures',1,'en',null,null,null),
	('Pok�mon','Groret','110','Rare','https://assets.tcgdex.net/fr/bw/bw7/60/high.webp','Psy','Fronti�res Franchies',2,'fr',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Psy' AND weaknessValue = '�2'),null),
	('Pokemon','Elgyem','60','Common','https://assets.tcgdex.net/en/bw/bw3/54/high.webp','Psychic','Noble Victories',1,'en',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Psychic' AND weaknessValue = '�2'),null),
	('Dresseur','Sbire de la Team Plasma',null,'Peu Commune','https://assets.tcgdex.net/fr/bw/bw8/125/high.webp',null,'Temp�te Plasma',null,'fr',(SELECT abilityId FROM P10_Ability WHERE abilityEffect = 'D�faussez une carte de la Team Plasma de votre main. (Si vous ne pouvez pas d�fausser une carte de la Team Plasma, vous ne pouvez pas jouer cette carte.) Piochez 4 cartes.'),null,null),
	('Pokemon','Kyogre-EX','170','Ultra Rare','https://assets.tcgdex.net/en/bw/bw5/104/high.webp','Water','Dark Explorers',4,'en',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Lightning' AND weaknessValue = '�2'),null),
	('Pok�mon','Sorb�b�','60','Commune','https://assets.tcgdex.net/fr/bw/bw4/31/high.webp','Eau','Destin�es Futures',1,'fr',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'M�tal' AND weaknessValue = '�2'),null),
	('Pokemon','Vanillish','80','Uncommon','https://assets.tcgdex.net/en/bw/bw3/28/high.webp','Water','Noble Victories',2,'en',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Metal' AND weaknessValue = '�2'),null),
	('Pok�mon','Latios-EX','170','Rare','https://assets.tcgdex.net/fr/bw/bw9/86/high.webp','Dragon','Glaciation Plasma',2,'fr',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Dragon' AND weaknessValue = '�2'),null),
	('Pokemon','Lucario','100','Rare','https://assets.tcgdex.net/en/bw/bw8/78/high.webp','Fighting','Plasma Storm',2,'en',(SELECT abilityId FROM P10_Ability WHERE abilityName = 'Dual Armor' AND abilityEffect = 'If this Pok�mon has any Metal Energy attached to it, this Pok�mon�s type is both Fighting and Metal.'),(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Psychic' AND weaknessValue = '�2'),null),
	('Pok�mon','Porygon-Z','130','Rare','https://assets.tcgdex.net/fr/bw/bw10/74/high.webp','Incolore','Explosion Plasma',1,'fr',(SELECT abilityId FROM P10_Ability WHERE abilityName = 'Transfert Plasma' AND abilityEffect = 'Autant de fois que vous le voulez pendant votre tour (avant votre attaque), vous pouvez d�placer une �nergie Plasma attach�e � 1 de vos Pok�mon vers un autre de vos Pok�mon.'),(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Combat' AND weaknessValue = '�2'),null),
	('Pokemon','Garbodor','110','Rare','https://assets.tcgdex.net/en/bw/bw8/67/high.webp','Psychic','Plasma Storm',3,'en',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Psychic' AND weaknessValue = '�2'),null),
	('Pok�mon','Cobaltium','120','Commune','https://assets.tcgdex.net/fr/bw/bwp/BW72/high.webp','M�tal','Promo BW',3,'fr',(SELECT abilityId FROM P10_Ability WHERE abilityName = 'C�ur Noble' AND abilityEffect = 'Chaque attaque de ce Pok�mon inflige 50 d�g�ts suppl�mentaires aux Pok�mon Darkness (avant application de la Faiblesse et de la R�sistance).'),(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Feu' AND weaknessValue = '�2'),(SELECT resistanceId FROM P10_Resistance WHERE resistanceType = 'Psy' AND resistanceValue = '-20')),
	('Pokemon','Reuniclus','90','Secret Rare','https://assets.tcgdex.net/en/bw/bw6/126/high.webp','Psychic','Dragons Exalted',2,'en',(SELECT abilityId FROM P10_Ability WHERE abilityName = 'Damage Swap' AND abilityEffect = 'As often as you like during your turn (before your attack), you may move 1 damage counter from 1 of your Pok�mon to another of your Pok�mon.'),(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Psychic' AND weaknessValue = '�2'),null),
	('Pok�mon','Nidoran (femelle)','60','Commune','https://assets.tcgdex.net/fr/bw/bw9/40/high.webp','Psy','Glaciation Plasma',1,'fr',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Psy' AND weaknessValue = '�2'),null),
	('Pokemon','Azumarill','90','Uncommon','https://assets.tcgdex.net/en/bw/bw7/37/high.webp','Water','Boundaries Crossed',1,'en',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Lightning' AND weaknessValue = '�2'),null),
	('Pok�mon','Magicarpe','30','Commune','https://assets.tcgdex.net/fr/bw/bw6/23/high.webp','Eau','Dragons �xalt�s',1,'fr',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = '�lectrique' AND weaknessValue = '�2'),null),
	('Pokemon','Kyurem','130','Common','/high.webp','Dragon','Dragon Vault',null,'en',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Dragon' AND weaknessValue = '�2'),null),
	('Pok�mon','Deoxys ex','170','Rare','https://assets.tcgdex.net/fr/bw/bwp/BW82/high.webp','Psy','Promo BW',2,'fr',(SELECT abilityId FROM P10_Ability WHERE abilityName = 'Connexion Renforc�e' AND abilityEffect = 'Les attaques de vos Pok�mon de la Team Plasma (except� Deoxys-EX) infligent 10 d�g�ts suppl�mentaires aux Pok�mon Actifs (avant application de la Faiblesse et de la R�sistance).'),(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Psy' AND weaknessValue = '�2'),null),
	('Trainer','Great Ball',null,'Uncommon','https://assets.tcgdex.net/en/bw/bw7/129/high.webp',null,'Boundaries Crossed',null,'en',null,null,null),
	('Pok�mon','Baggiguane','70','Peu Commune','https://assets.tcgdex.net/fr/bw/bw4/73/high.webp','Obscurit�','Destin�es Futures',2,'fr',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Combat' AND weaknessValue = '�2'),(SELECT resistanceId FROM P10_Resistance WHERE resistanceType = 'Psy' AND resistanceValue = '-20')),
	('Pokemon','Weavile','90','Rare','https://assets.tcgdex.net/en/bw/bw9/66/high.webp','Darkness','Plasma Freeze',1,'en',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Fighting' AND weaknessValue = '�2'),(SELECT resistanceId FROM P10_Resistance WHERE resistanceType = 'Psychic' AND resistanceValue = '-20')),
	('Pok�mon','Batracn�','80','Peu Commune','https://assets.tcgdex.net/fr/bw/bw5/32/high.webp','Eau','Explorateurs Obscurs',2,'fr',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Plante' AND weaknessValue = '�2'),null),
	('Pokemon','Spheal','60','Common','https://assets.tcgdex.net/en/bw/bw6/29/high.webp','Water','Dragons Exalted',2,'en',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Metal' AND weaknessValue = '�2'),null),
	('Pok�mon','Pikachu','60','Magnifique rare','https://assets.tcgdex.net/fr/bw/bw1/115/high.webp','�lectrique','Noir & Blanc',1,'fr',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Combat' AND weaknessValue = '�2'),null),
	('Trainer','Potion',null,'Common','https://assets.tcgdex.net/en/bw/bw1/100/high.webp',null,'Black & White',null,'en',null,null,null),
	('Pok�mon','Galegon','90','Peu Commune','https://assets.tcgdex.net/fr/bw/bw10/58/high.webp','M�tal','Explosion Plasma',4,'fr',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Feu' AND weaknessValue = '�2'),(SELECT resistanceId FROM P10_Resistance WHERE resistanceType = 'Psy' AND resistanceValue = '-20')),
	('Pokemon','Gigalith','140','Rare','https://assets.tcgdex.net/en/bw/bw2/53/high.webp','Fighting','Emerging Powers',4,'en',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Grass' AND weaknessValue = '�2'),null),
	('Pok�mon','Victini','60','Rare','https://assets.tcgdex.net/fr/bw/bw3/14/high.webp','Feu','Nobles Victoires',1,'fr',(SELECT abilityId FROM P10_Ability WHERE abilityName = 'Victorieux' AND abilityEffect = 'Une seule fois pendant votre tour, apr�s avoir lanc� des pi�ces pour une attaque, vous pouvez ignorer les effets de ces lancers de pi�ce et lancer ces pi�ces � nouveau. Vous ne pouvez pas utiliser la capacit� sp�ciale Victorieux plus d�une fois par tour.'),(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Eau' AND weaknessValue = '�2'),null),
	('Pokemon','Dwebble','60','Common','https://assets.tcgdex.net/en/bw/bw11/13/high.webp','Grass','Legendary Treasures',2,'en',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Fire' AND weaknessValue = '�2'),null),
	('Pok�mon','Miradar','90','Rare','https://assets.tcgdex.net/fr/bw/bw8/113/high.webp','Incolore','Temp�te Plasma',1,'fr',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Combat' AND weaknessValue = '�2'),null),
	('Pokemon','Hydreigon','150','Rare','https://assets.tcgdex.net/en/bw/bw11/99/high.webp','Dragon','Legendary Treasures',3,'en',(SELECT abilityId FROM P10_Ability WHERE abilityName = 'Dark Trance' AND abilityEffect = 'As often as you like during your turn (before your attack), you may move a Darkness Energy attached to 1 of your Pok�mon to another of your Pok�mon.'),(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Dragon' AND weaknessValue = '�2'),null),
	('Pok�mon','Dimoret','90','Rare','https://assets.tcgdex.net/fr/bw/bw4/70/high.webp','Obscurit�','Destin�es Futures',1,'fr',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Combat' AND weaknessValue = '�2'),(SELECT resistanceId FROM P10_Resistance WHERE resistanceType = 'Psy' AND resistanceValue = '-20')),
	('Pokemon','Croagunk','60','Common','https://assets.tcgdex.net/en/bw/bw7/64/high.webp','Psychic','Boundaries Crossed',1,'en',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Psychic' AND weaknessValue = '�2'),null),
	('Pok�mon','Maracachi','80','Peu Commune','https://assets.tcgdex.net/fr/bw/bw1/11/high.webp','Plante','Noir & Blanc',2,'fr',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Feu' AND weaknessValue = '�2'),(SELECT resistanceId FROM P10_Resistance WHERE resistanceType = 'Eau' AND resistanceValue = '-20')),
	('Pokemon','Shelmet','60','Common','https://assets.tcgdex.net/en/bw/bw5/10/high.webp','Grass','Dark Explorers',3,'en',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Fire' AND weaknessValue = '�2'),null),
	('Pok�mon','Masca�man','70','Commune','https://assets.tcgdex.net/fr/bw/bw1/63/high.webp','Combat','Noir & Blanc',2,'fr',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Eau' AND weaknessValue = '�2'),(SELECT resistanceId FROM P10_Resistance WHERE resistanceType = '�lectrique' AND resistanceValue = '-20')),
	('Pokemon','Gothitelle','130','Rare','https://assets.tcgdex.net/en/bw/bw6/57/high.webp','Psychic','Dragons Exalted',2,'en',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Psychic' AND weaknessValue = '�2'),null),
	('Pok�mon','Nodulithe','60','Commune','https://assets.tcgdex.net/fr/bw/bw2/49/high.webp','Combat','Pouvoirs �mergents',2,'fr',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Plante' AND weaknessValue = '�2'),null),
	('Pokemon','Magneton','80','Uncommon','https://assets.tcgdex.net/en/bw/bw8/44/high.webp','Lightning','Plasma Storm',2,'en',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Fighting' AND weaknessValue = '�2'),null),
	('Dresseur','Ghetis',null,'Ultra Rare','https://assets.tcgdex.net/fr/bw/bw9/115/high.webp',null,'Glaciation Plasma',null,'fr',(SELECT abilityId FROM P10_Ability WHERE abilityEffect = 'Votre adversaire montre sa main et m�lange toutes les cartes Objet qui s''y trouvent avec son deck. Ensuite, piochez un nombre de cartes �gal au nombre de cartes Objet que votre adversaire a m�lang�es avec son deck.'),null,null),
	('Pokemon','Ambipom','80','Rare','https://assets.tcgdex.net/en/bw/bw6/100/high.webp','Colorless','Dragons Exalted',1,'en',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Fighting' AND weaknessValue = '�2'),null),
	('Pok�mon','Latios-EX','170','Ultra Rare','https://assets.tcgdex.net/fr/bw/bw9/113/high.webp','Dragon','Glaciation Plasma',2,'fr',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Dragon' AND weaknessValue = '�2'),null),
	('Pokemon','Aipom','60','Common','https://assets.tcgdex.net/en/bw/bw6/99/high.webp','Colorless','Dragons Exalted',1,'en',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Fighting' AND weaknessValue = '�2'),null),
	('Pok�mon','Kyurem Blanc','130','Rare','https://assets.tcgdex.net/fr/bw/bwp/BW59/high.webp','Dragon','Promo BW',2,'fr',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Dragon' AND weaknessValue = '�2'),null),
	('Pokemon','Registeel-EX','180','Ultra Rare','https://assets.tcgdex.net/en/bw/bw6/122/high.webp','Metal','Dragons Exalted',4,'en',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Fire' AND weaknessValue = '�2'),(SELECT resistanceId FROM P10_Resistance WHERE resistanceType = 'Psychic' AND resistanceValue = '-20')),
	('Pok�mon','Ninjask','60','Peu Commune','https://assets.tcgdex.net/fr/bw/bw6/11/high.webp','Plante','Dragons �xalt�s',1,'fr',(SELECT abilityId FROM P10_Ability WHERE abilityName = 'Coquille Lib�rante' AND abilityEffect = 'Lorsque vous jouez ce Pok�mon de votre main pour faire �voluer 1 de vos Pok�mon, vous pouvez chercher Munja dans votre deck et le placer sur votre Banc. M�langez ensuite votre deck.'),(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Feu' AND weaknessValue = '�2'),null),
	('Pokemon','Sewaddle','50','Common','https://assets.tcgdex.net/en/bw/bw11/10/high.webp','Grass','Legendary Treasures',1,'en',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Fire' AND weaknessValue = '�2'),null),
	('Pok�mon','Trioxhydre','150','Rare','https://assets.tcgdex.net/fr/bw/bw3/79/high.webp','Obscurit�','Nobles Victoires',3,'fr',(SELECT abilityId FROM P10_Ability WHERE abilityName = 'Aura de T�n�bres' AND abilityEffect = 'Toutes les �nergies attach�es � ce Pok�mon sont des �nergies Darkness au lieu de leur type habituel.'),(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Combat' AND weaknessValue = '�2'),(SELECT resistanceId FROM P10_Resistance WHERE resistanceType = 'Psy' AND resistanceValue = '-20')),
	('Pokemon','Ferrothorn','90','Rare','https://assets.tcgdex.net/en/bw/bw2/72/high.webp','Metal','Emerging Powers',2,'en',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Fire' AND weaknessValue = '�2'),(SELECT resistanceId FROM P10_Resistance WHERE resistanceType = 'Psychic' AND resistanceValue = '-20')),
	('Pok�mon','Blizzaroi','120','Peu Commune','https://assets.tcgdex.net/fr/bw/bw10/26/high.webp','Eau','Explosion Plasma',2,'fr',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'M�tal' AND weaknessValue = '�2'),null),
	('Pokemon','Gyarados','130','Rare','https://assets.tcgdex.net/en/bw/bw6/24/high.webp','Water','Dragons Exalted',3,'en',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Lightning' AND weaknessValue = '�2'),null),
	('Pok�mon','Baggiguane','60','Commune','https://assets.tcgdex.net/fr/bw/bw8/85/high.webp','Obscurit�','Temp�te Plasma',2,'fr',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Combat' AND weaknessValue = '�2'),(SELECT resistanceId FROM P10_Resistance WHERE resistanceType = 'Psy' AND resistanceValue = '-20')),
	('Pokemon','Sandshrew','70','Common','https://assets.tcgdex.net/en/bw/bw7/78/high.webp','Fighting','Boundaries Crossed',2,'en',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Water' AND weaknessValue = '�2'),(SELECT resistanceId FROM P10_Resistance WHERE resistanceType = 'Lightning' AND resistanceValue = '-20')),
	('Pok�mon','M�tang','90','Peu Commune','https://assets.tcgdex.net/fr/bw/bw9/51/high.webp','Psy','Glaciation Plasma',2,'fr',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Psy' AND weaknessValue = '�2'),null),
	('Pokemon','Keldeo','110','Rare','https://assets.tcgdex.net/en/bw/bw7/47/high.webp','Water','Boundaries Crossed',1,'en',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Grass' AND weaknessValue = '�2'),null),
	('Pok�mon','Aspicot','50','Commune','https://assets.tcgdex.net/fr/bw/bw9/1/high.webp','Plante','Glaciation Plasma',1,'fr',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Feu' AND weaknessValue = '�2'),null),
	('Pokemon','Surskit','50','Common','https://assets.tcgdex.net/en/bw/bw10/1/high.webp','Grass','Plasma Blast',1,'en',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Fire' AND weaknessValue = '�2'),null),
	('Pok�mon','Kangourex','100','Commune','https://assets.tcgdex.net/fr/bw/bw10/71/high.webp','Incolore','Explosion Plasma',2,'fr',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Combat' AND weaknessValue = '�2'),null),
	('Pokemon','Krokorok','90','Uncommon','https://assets.tcgdex.net/en/bw/bw5/65/high.webp','Darkness','Dark Explorers',3,'en',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Fighting' AND weaknessValue = '�2'),(SELECT resistanceId FROM P10_Resistance WHERE resistanceType = 'Psychic' AND resistanceValue = '-20')),
	('Pok�mon','M�gapagos','140','Rare','https://assets.tcgdex.net/fr/bw/bw3/26/high.webp','Eau','Nobles Victoires',4,'fr',(SELECT abilityId FROM P10_Ability WHERE abilityName = 'Solide Roc' AND abilityEffect = 'Si des d�g�ts sont inflig�s � ce Pok�mon par des attaques, lancez une pi�ce. Si c�est face, les d�g�ts sont r�duits de 50 (apr�s application de la Faiblesse et de la R�sistance).'),(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Plante' AND weaknessValue = '�2'),null),
	('Pokemon','Slowbro','100','Uncommon','https://assets.tcgdex.net/en/bw/bw5/24/high.webp','Water','Dark Explorers',3,'en',(SELECT abilityId FROM P10_Ability WHERE abilityName = 'Airhead' AND abilityEffect = 'If you have 2, 4, or 6 Prize cards left, this Pok�mon can�t attack.'),(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Lightning' AND weaknessValue = '�2'),null),
	('Pok�mon','Nidoran (femelle)','60','Commune','https://assets.tcgdex.net/fr/bw/bw9/40/high.webp','Psy','Glaciation Plasma',1,'fr',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Psy' AND weaknessValue = '�2'),null),
	('Pokemon','Azumarill','90','Uncommon','https://assets.tcgdex.net/en/bw/bw7/37/high.webp','Water','Boundaries Crossed',1,'en',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Lightning' AND weaknessValue = '�2'),null),
	('Pok�mon','Pyroli','90','Commune','https://assets.tcgdex.net/fr/bw/bwp/BW88/high.webp','Feu','Promo BW',1,'fr',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Eau' AND weaknessValue = '�2'),null),
	('Trainer','Potion',null,'Common','https://assets.tcgdex.net/en/bw/bw7/132/high.webp',null,'Boundaries Crossed',null,'en',null,null,null),
	('Pok�mon','Drattak','150','Rare','https://assets.tcgdex.net/fr/bw/bw10/64/high.webp','Dragon','Explosion Plasma',4,'fr',(SELECT abilityId FROM P10_Ability WHERE abilityName = 'Aile Impitoyable' AND abilityEffect = 'Lorsque vous jouez ce Pok�mon de votre main pour faire �voluer 1 de vos Pok�mon, vous pouvez d�fausser toutes les cartes Outil Pok�mon attach�es � chacun des Pok�mon de votre adversaire.'),(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Dragon' AND weaknessValue = '�2'),null),
	('Pokemon','Nidoking','140','Rare','https://assets.tcgdex.net/en/bw/bw9/58/high.webp','Fighting','Plasma Freeze',3,'en',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Water' AND weaknessValue = '�2'),(SELECT resistanceId FROM P10_Resistance WHERE resistanceType = 'Lightning' AND resistanceValue = '-20')),
	('Dresseur','N',null,'Peu Commune','https://assets.tcgdex.net/fr/bw/bw5/96/high.webp',null,'Explorateurs Obscurs',null,'fr',(SELECT abilityId FROM P10_Ability WHERE abilityEffect = 'Chaque joueur m�lange sa main avec son deck. Ensuite, chaque joueur pioche une carte pour chacune des cartes R�compense qu�il lui reste.'),null,null),
	('Pokemon','Spiritomb','80','Uncommon','https://assets.tcgdex.net/en/bw/bw11/87/high.webp','Darkness','Legendary Treasures',1,'en',(SELECT abilityId FROM P10_Ability WHERE abilityName = 'Sealing Scream' AND abilityEffect = 'Each player can�t play any ACE SPEC cards from his or her hand.'),null,null),
	('Pok�mon','Vaututrice','90','Rare','https://assets.tcgdex.net/fr/bw/bw2/69/high.webp','Obscurit�','Pouvoirs �mergents',1,'fr',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = '�lectrique' AND weaknessValue = '�2'),(SELECT resistanceId FROM P10_Resistance WHERE resistanceType = 'Combat' AND resistanceValue = '-20')),
	('Pokemon','Dusknoir','130','Rare','https://assets.tcgdex.net/en/bw/bw7/63/high.webp','Psychic','Boundaries Crossed',3,'en',(SELECT abilityId FROM P10_Ability WHERE abilityName = 'Sinister Hand' AND abilityEffect = 'As often as you like during your turn (before your attack), you may move 1 damage counter from 1 of your opponent�s Pok�mon to another of your opponent�s Pok�mon.'),(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Darkness' AND weaknessValue = '�2'),null),
	('Pok�mon','M�ios','60','Peu Commune','https://assets.tcgdex.net/fr/bw/bw1/56/high.webp','Psy','Noir & Blanc',1,'fr',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Psy' AND weaknessValue = '�2'),null),
	('Pokemon','Joltik','40','Common','https://assets.tcgdex.net/en/bw/bw8/50/high.webp','Lightning','Plasma Storm',1,'en',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Fighting' AND weaknessValue = '�2'),null),
	('Pok�mon','Ohmassacre','140','Rare','https://assets.tcgdex.net/fr/bw/bw3/41/high.webp','�lectrique','Nobles Victoires',3,'fr',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Combat' AND weaknessValue = '�2'),null),
	('Pokemon','Pachirisu','70','Common','https://assets.tcgdex.net/en/bw/bw9/37/high.webp','Lightning','Plasma Freeze',1,'en',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Fighting' AND weaknessValue = '�2'),null),
	('Dresseur','R�cup�ration d��nergie Sup�rieure',null,'Peu Commune','https://assets.tcgdex.net/fr/bw/bw9/103/high.webp',null,'Glaciation Plasma',null,'fr',(SELECT abilityId FROM P10_Ability WHERE abilityEffect = 'D�faussez 2 cartes de votre main. (Si vous ne pouvez pas d�fausser 2 cartes, vous ne pouvez pas jouer cette carte.) Ajoutez 4 cartes �nergie de base de votre pile de d�fausse � votre main. (Vous ne pouvez pas choisir une carte que vous avez d�fauss�e du fait de l''effet de cette carte.)'),null,null),
	('Pokemon','Miltank','100','Uncommon','https://assets.tcgdex.net/en/bw/bw9/93/high.webp','Colorless','Plasma Freeze',3,'en',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Fighting' AND weaknessValue = '�2'),null),
	('Pok�mon','Fun�cire','50','Commune','https://assets.tcgdex.net/fr/bw/bw3/58/high.webp','Psy','Nobles Victoires',1,'fr',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Obscurit�' AND weaknessValue = '�2'),null),
	('Pokemon','Trubbish','70','Common','https://assets.tcgdex.net/en/bw/bw6/53/high.webp','Psychic','Dragons Exalted',2,'en',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Psychic' AND weaknessValue = '�2'),null),
	('Pok�mon','Ludicolo','130','Rare','https://assets.tcgdex.net/fr/bw/bw8/31/high.webp','Eau','Temp�te Plasma',3,'fr',(SELECT abilityId FROM P10_Ability WHERE abilityName = 'Cuvette' AND abilityEffect = 'N�importe quand entre chaque tour, soignez 20 d�g�ts � ce Pok�mon.'),(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = '�lectrique' AND weaknessValue = '�2'),null),
	('Pokemon','Dewott','90','Uncommon','https://assets.tcgdex.net/en/bw/bw1/29/high.webp','Water','Black & White',1,'en',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Lightning' AND weaknessValue = '�2'),null),
	('Pok�mon','Rondoudou','60','Commune','https://assets.tcgdex.net/fr/bw/bwp/BW65/high.webp','Incolore','Promo BW',1,'fr',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Combat' AND weaknessValue = '�2'),null),
	('Pokemon','Tranquill','80','Uncommon','https://assets.tcgdex.net/en/bw/bw7/124/high.webp','Colorless','Boundaries Crossed',1,'en',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Lightning' AND weaknessValue = '�2'),(SELECT resistanceId FROM P10_Resistance WHERE resistanceType = 'Fighting' AND resistanceValue = '-20')),
	('Pok�mon','M�lancolux','70','Peu Commune','https://assets.tcgdex.net/fr/bw/bw8/22/high.webp','Feu','Temp�te Plasma',1,'fr',(SELECT abilityId FROM P10_Ability WHERE abilityName = 'Apesanteur' AND abilityEffect = 'Si aucune �nergie n�est attach�e � ce Pok�mon, ce Pok�mon n�a pas de co�t de Retraite.'),(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Eau' AND weaknessValue = '�2'),null),
	('Pokemon','Simisear','90','Uncommon','https://assets.tcgdex.net/en/bw/bw8/20/high.webp','Fire','Plasma Storm',2,'en',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Water' AND weaknessValue = '�2'),null),
	('Pok�mon','Artikodin-EX','170','Rare','https://assets.tcgdex.net/fr/bw/bw8/25/high.webp','Eau','Temp�te Plasma',1,'fr',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'M�tal' AND weaknessValue = '�2'),(SELECT resistanceId FROM P10_Resistance WHERE resistanceType = 'Combat' AND resistanceValue = '-20')),
	('Pokemon','Staryu','60','Common','https://assets.tcgdex.net/en/bw/bw4/23/high.webp','Water','Next Destinies',1,'en',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Lightning' AND weaknessValue = '�2'),null),
	('Dresseur','Ros�e de Vie',null,'Rare','https://assets.tcgdex.net/fr/bw/bw9/107/high.webp',null,'Glaciation Plasma',null,'fr',(SELECT abilityId FROM P10_Ability WHERE abilityEffect = 'Si le Pok�mon auquel cette carte est attach�e est mis K.O., votre adversaire r�cup�re 1 carte R�compense de moins.'),null,null),
	('Trainer','N',null,'Uncommon','https://assets.tcgdex.net/en/bw/bw5/96/high.webp',null,'Dark Explorers',null,'en',null,null,null),
	('Pok�mon','Farfaduvet','80','Peu Commune','https://assets.tcgdex.net/fr/bw/bw2/11/high.webp','Plante','Pouvoirs �mergents',0,'fr',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Feu' AND weaknessValue = '�2'),(SELECT resistanceId FROM P10_Resistance WHERE resistanceType = 'Eau' AND resistanceValue = '-20')),
	('Pokemon','Growlithe','80','Common','https://assets.tcgdex.net/en/bw/bw4/10/high.webp','Fire','Next Destinies',3,'en',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Water' AND weaknessValue = '�2'),null),
	('Pok�mon','Kyurem Blanc ex','180','Rare','https://assets.tcgdex.net/fr/bw/bwp/BW63/high.webp','Dragon','Promo BW',3,'fr',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Dragon' AND weaknessValue = '�2'),null),
	('Pokemon','Rayquaza-EX','170','Ultra Rare','https://assets.tcgdex.net/en/bw/bw6/123/high.webp','Dragon','Dragons Exalted',1,'en',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Dragon' AND weaknessValue = '�2'),null);

INSERT INTO P10_Contient(cardId, attackId) VALUES
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/fr/bw/bw6/108/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Rayon Vivifiant' AND attackCost = 'IncoloreIncolore' AND attackDamage = '40'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/fr/bw/bw6/108/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Baffe Sangsue' AND attackCost = 'IncoloreIncoloreIncolore' AND attackDamage = '60'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/fr/bw/bwp/BW35/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Tit''sieste' AND attackCost = 'Incolore' AND attackDamage = 'n/a'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/fr/bw/bwp/BW35/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Saut' AND attackCost = 'IncoloreIncolore' AND attackDamage = '20'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/fr/bw/bw9/38/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Appel Foudroyant' AND attackCost = '�lectrique' AND attackDamage = '30'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/fr/bw/bw9/38/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Grondement Tonitruant' AND attackCost = '�lectrique�lectriqueIncoloreIncolore' AND attackDamage = '90'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/en/bw/bw6/35/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Supersonic' AND attackCost = 'Colorless' AND attackDamage = null))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/en/bw/bw6/35/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Hyper Voice' AND attackCost = 'WaterColorlessColorless' AND attackDamage = '50'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/fr/bw/bw3/67/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = '�boulement' AND attackCost = 'CombatCombatIncolore' AND attackDamage = '60'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/en/bw/bw11/61/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Tight Jaw' AND attackCost = 'PsychicColorless' AND attackDamage = '30'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/fr/bw/bw7/60/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Rafale Psy' AND attackCost = 'PsyIncolore' AND attackDamage = '30'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/fr/bw/bw7/60/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Extrasenseur' AND attackCost = 'PsyIncoloreIncolore' AND attackDamage = '60'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/en/bw/bw3/54/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Headbutt' AND attackCost = 'Colorless' AND attackDamage = '10'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/en/bw/bw3/54/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Calm Mind' AND attackCost = 'Psychic' AND attackDamage = null))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/en/bw/bw5/104/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Smash Turn' AND attackCost = 'WaterColorless' AND attackDamage = '30'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/en/bw/bw5/104/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Dual Splash' AND attackCost = 'WaterWaterColorless' AND attackDamage = null))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/fr/bw/bw4/31/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Bataille' AND attackCost = 'Incolore' AND attackDamage = '10'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/fr/bw/bw4/31/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Verglas' AND attackCost = 'EauIncolore' AND attackDamage = '20'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/en/bw/bw3/28/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Ice Beam' AND attackCost = 'WaterColorless' AND attackDamage = '20'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/en/bw/bw3/28/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Frost Breath' AND attackCost = 'WaterWater' AND attackDamage = '40'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/fr/bw/bw9/86/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Vol Supersonique' AND attackCost = 'PsyIncolore' AND attackDamage = '40'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/fr/bw/bw9/86/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Lumi-�clat' AND attackCost = 'EauPsyIncolore' AND attackDamage = '150'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/en/bw/bw8/78/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Hurricane Kick' AND attackCost = 'FightingColorlessColorless' AND attackDamage = '60'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/fr/bw/bw10/74/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Triplattaque' AND attackCost = 'IncoloreIncoloreIncolore' AND attackDamage = '50'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/en/bw/bw8/67/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Ensnarl' AND attackCost = 'ColorlessColorless' AND attackDamage = '20'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/en/bw/bw8/67/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Double Ducts' AND attackCost = 'PsychicColorlessColorlessColorless' AND attackDamage = '80'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/fr/bw/bwp/BW72/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'T�te de Fer' AND attackCost = 'M�talM�talIncolore' AND attackDamage = '60'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/en/bw/bw6/126/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Psywave' AND attackCost = 'PsychicPsychicPsychic' AND attackDamage = '30'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/fr/bw/bw9/40/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Dard-Venin' AND attackCost = 'PsyIncolore' AND attackDamage = '20'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/en/bw/bw7/37/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Deep Dive' AND attackCost = 'ColorlessColorless' AND attackDamage = null))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/en/bw/bw7/37/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Aqua Sonic' AND attackCost = 'WaterWaterColorless' AND attackDamage = '70'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/fr/bw/bw6/23/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Assaut Humide' AND attackCost = 'Eau' AND attackDamage = '10'))
	((SELECT cardId FROM P10_Card WHERE cardImg = '/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Dragon Claw' AND attackCost = 'ColorlessColorlessColorless' AND attackDamage = '60'))
	((SELECT cardId FROM P10_Card WHERE cardImg = '/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Blizzard' AND attackCost = 'WaterPsychicColorlessColorless' AND attackDamage = '90'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/fr/bw/bwp/BW82/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Force Spirale' AND attackCost = 'PsyIncolore' AND attackDamage = '30'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/fr/bw/bw4/73/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Mue' AND attackCost = 'Incolore' AND attackDamage = null))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/fr/bw/bw4/73/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Coup Rapide' AND attackCost = 'Obscurit�Obscurit�' AND attackDamage = '40'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/en/bw/bw9/66/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Hail' AND attackCost = 'Colorless' AND attackDamage = null))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/en/bw/bw9/66/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Vilify' AND attackCost = 'DarknessColorless' AND attackDamage = '30'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/en/bw/bw6/29/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Unstoppable Roll' AND attackCost = 'WaterColorless' AND attackDamage = '10'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/fr/bw/bw1/115/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = '�nergisant' AND attackCost = '�lectrique' AND attackDamage = null))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/fr/bw/bw1/115/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Tonnerre' AND attackCost = '�lectriqueIncoloreIncolore' AND attackDamage = '80'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/fr/bw/bw10/58/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Griffe Acier' AND attackCost = 'M�tal' AND attackDamage = '20'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/fr/bw/bw10/58/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'T�te de Fer' AND attackCost = 'M�talIncoloreIncolore' AND attackDamage = '50'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/en/bw/bw2/53/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Shear' AND attackCost = 'Fighting' AND attackDamage = null))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/en/bw/bw2/53/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Rock Bullet' AND attackCost = 'ColorlessColorlessColorlessColorless' AND attackDamage = '40'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/fr/bw/bw3/14/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Force Ajout�e' AND attackCost = 'FeuIncolore' AND attackDamage = '30'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/en/bw/bw11/13/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Bug Bite' AND attackCost = 'GrassColorless' AND attackDamage = '20'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/fr/bw/bw8/113/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Double Morsure' AND attackCost = 'IncoloreIncolore' AND attackDamage = '20'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/fr/bw/bw8/113/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Balayage' AND attackCost = 'IncoloreIncoloreIncolore' AND attackDamage = '60'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/en/bw/bw11/99/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Dragonblast' AND attackCost = 'PsychicDarknessDarknessColorless' AND attackDamage = '140'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/fr/bw/bw4/70/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Punition Obscure' AND attackCost = 'Obscurit�' AND attackDamage = '90'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/fr/bw/bw4/70/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Combo-Griffe' AND attackCost = 'IncoloreIncoloreIncolore' AND attackDamage = '30'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/en/bw/bw7/64/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Paralyzing Jab' AND attackCost = 'PsychicColorless' AND attackDamage = '20'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/fr/bw/bw1/11/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'M�ga-Sangsue' AND attackCost = 'Plante' AND attackDamage = '20'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/fr/bw/bw1/11/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Dard-Nu�e' AND attackCost = 'PlantePlanteIncolore' AND attackDamage = '20'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/en/bw/bw5/10/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Body Slam' AND attackCost = 'GrassGrass' AND attackDamage = '20'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/fr/bw/bw1/63/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Tombe de Sable' AND attackCost = 'Combat' AND attackDamage = '10'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/fr/bw/bw1/63/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Morsure' AND attackCost = 'CombatIncoloreIncolore' AND attackDamage = '30'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/en/bw/bw6/57/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Doom Decree' AND attackCost = 'PsychicColorless' AND attackDamage = null))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/en/bw/bw6/57/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Black Magic' AND attackCost = 'PsychicColorlessColorless' AND attackDamage = '40'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/fr/bw/bw2/49/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Armure' AND attackCost = 'Incolore' AND attackDamage = null))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/fr/bw/bw2/49/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Coup d''Boule' AND attackCost = 'CombatIncoloreIncolore' AND attackDamage = '40'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/en/bw/bw8/44/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Metal Sound' AND attackCost = 'Colorless' AND attackDamage = null))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/en/bw/bw8/44/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Electro Ball' AND attackCost = 'LightningColorless' AND attackDamage = '30'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/en/bw/bw6/100/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Double Hit' AND attackCost = 'Colorless' AND attackDamage = '20'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/en/bw/bw6/100/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Hand Fling' AND attackCost = 'ColorlessColorless' AND attackDamage = '10'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/fr/bw/bw9/113/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Vol Supersonique' AND attackCost = 'PsyIncolore' AND attackDamage = '40'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/fr/bw/bw9/113/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Lumi-�clat' AND attackCost = 'EauPsyIncolore' AND attackDamage = '150'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/en/bw/bw6/99/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Double Hit' AND attackCost = 'Colorless' AND attackDamage = '10'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/fr/bw/bwp/BW59/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Charge Destructrice' AND attackCost = 'FeuIncolore' AND attackDamage = '20'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/fr/bw/bwp/BW59/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Flammes de Glace' AND attackCost = 'FeuEauIncoloreIncolore' AND attackDamage = '80'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/en/bw/bw6/122/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Triple Laser' AND attackCost = 'ColorlessColorlessColorless' AND attackDamage = null))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/en/bw/bw6/122/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Protect Charge' AND attackCost = 'MetalMetalColorlessColorless' AND attackDamage = '80'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/fr/bw/bw6/11/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Tranche-Nuit' AND attackCost = 'PlanteIncolore' AND attackDamage = '60'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/en/bw/bw11/10/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Gnaw' AND attackCost = 'ColorlessColorless' AND attackDamage = '20'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/fr/bw/bw3/79/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Lame Folle' AND attackCost = 'Obscurit�Obscurit�Obscurit�Obscurit�' AND attackDamage = '60'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/en/bw/bw2/72/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Steel Feelers' AND attackCost = 'Metal' AND attackDamage = '30'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/en/bw/bw2/72/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Gyro Ball' AND attackCost = 'MetalColorlessColorless' AND attackDamage = '60'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/fr/bw/bw10/26/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Tranch''Herbe' AND attackCost = 'PlantePlante' AND attackDamage = '40'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/fr/bw/bw10/26/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Choc Frontal' AND attackCost = 'PlantePlanteIncolore' AND attackDamage = '80'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/en/bw/bw6/24/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Sharp Fang' AND attackCost = 'WaterColorlessColorless' AND attackDamage = '60'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/en/bw/bw6/24/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Swing Around' AND attackCost = 'WaterColorlessColorlessColorless' AND attackDamage = '60'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/fr/bw/bw8/85/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Coup d''Boule' AND attackCost = 'Obscurit�' AND attackDamage = '10'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/fr/bw/bw8/85/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Balayage' AND attackCost = 'IncoloreIncolore' AND attackDamage = '20'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/en/bw/bw7/78/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Rollout' AND attackCost = 'Colorless' AND attackDamage = '10'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/en/bw/bw7/78/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Slash' AND attackCost = 'FightingColorlessColorless' AND attackDamage = '40'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/fr/bw/bw9/51/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Choc Mental' AND attackCost = 'Psy' AND attackDamage = '10'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/fr/bw/bw9/51/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Coup de Poing Psy' AND attackCost = 'PsyIncoloreIncolore' AND attackDamage = '50'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/en/bw/bw7/47/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Slicing Blade' AND attackCost = 'WaterColorless' AND attackDamage = '30'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/en/bw/bw7/47/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Hydro Pump' AND attackCost = 'ColorlessColorlessColorless' AND attackDamage = '60'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/fr/bw/bw9/1/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Aiguillon Triple' AND attackCost = 'Plante' AND attackDamage = '10'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/en/bw/bw10/1/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Sweet Scent' AND attackCost = 'Grass' AND attackDamage = null))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/fr/bw/bw10/71/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Appel � la Famille' AND attackCost = 'Incolore' AND attackDamage = null))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/fr/bw/bw10/71/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Poing Com�te' AND attackCost = 'IncoloreIncolore' AND attackDamage = '20'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/en/bw/bw5/65/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Mud-Slap' AND attackCost = 'ColorlessColorless' AND attackDamage = '30'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/en/bw/bw5/65/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Corkscrew Punch' AND attackCost = 'DarknessDarknessColorlessColorless' AND attackDamage = '70'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/fr/bw/bw3/26/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'M�chouille' AND attackCost = 'EauEauIncoloreIncolore' AND attackDamage = '80'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/en/bw/bw5/24/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Lazy Headbutt' AND attackCost = 'WaterColorless' AND attackDamage = '80'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/fr/bw/bw9/40/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Dard-Venin' AND attackCost = 'PsyIncolore' AND attackDamage = '20'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/en/bw/bw7/37/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Deep Dive' AND attackCost = 'ColorlessColorless' AND attackDamage = null))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/en/bw/bw7/37/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Aqua Sonic' AND attackCost = 'WaterWaterColorless' AND attackDamage = '70'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/fr/bw/bwp/BW88/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Jet de Sable' AND attackCost = 'Incolore' AND attackDamage = '20'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/fr/bw/bwp/BW88/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Flamme Tranchante' AND attackCost = 'FeuIncoloreIncolore' AND attackDamage = '60'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/fr/bw/bw10/64/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'An�antissement de Ga�a' AND attackCost = 'FeuEauIncoloreIncolore' AND attackDamage = '100'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/en/bw/bw9/58/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Lovestrike' AND attackCost = 'ColorlessColorless' AND attackDamage = '20'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/en/bw/bw9/58/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Horn Drill' AND attackCost = 'FightingColorlessColorlessColorless' AND attackDamage = '90'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/en/bw/bw11/87/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Hexed Mirror' AND attackCost = 'Colorless' AND attackDamage = null))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/fr/bw/bw2/69/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Charge-Os' AND attackCost = 'Obscurit�' AND attackDamage = '30'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/fr/bw/bw2/69/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Vibrobscur' AND attackCost = 'IncoloreIncolore' AND attackDamage = '20'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/en/bw/bw7/63/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Shadow Punch' AND attackCost = 'PsychicColorlessColorlessColorless' AND attackDamage = '60'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/fr/bw/bw1/56/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Soin' AND attackCost = 'Incolore' AND attackDamage = null))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/fr/bw/bw1/56/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Roulade' AND attackCost = 'PsyIncolore' AND attackDamage = '30'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/en/bw/bw8/50/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Jump On' AND attackCost = 'Lightning' AND attackDamage = '10'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/fr/bw/bw3/41/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Acide' AND attackCost = 'IncoloreIncolore' AND attackDamage = '30'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/fr/bw/bw3/41/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = '�clair Fou' AND attackCost = '�lectrique�lectriqueIncolore' AND attackDamage = '90'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/en/bw/bw9/37/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Minor Errand-Running' AND attackCost = 'Colorless' AND attackDamage = null))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/en/bw/bw9/37/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Electric Tail' AND attackCost = 'Lightning' AND attackDamage = '10'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/en/bw/bw9/93/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Max Milk' AND attackCost = 'ColorlessColorless' AND attackDamage = null))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/en/bw/bw9/93/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Tackle' AND attackCost = 'ColorlessColorless' AND attackDamage = '30'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/fr/bw/bw3/58/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'T�l�portation Explosive' AND attackCost = 'Psy' AND attackDamage = '10'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/en/bw/bw6/53/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Pound' AND attackCost = 'ColorlessColorless' AND attackDamage = '20'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/en/bw/bw6/53/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Poison Gas' AND attackCost = 'PsychicColorlessColorless' AND attackDamage = '30'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/fr/bw/bw8/31/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Danse Enivr�e' AND attackCost = 'EauEauIncolore' AND attackDamage = '70'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/en/bw/bw1/29/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Water Gun' AND attackCost = 'ColorlessColorless' AND attackDamage = '30'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/en/bw/bw1/29/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Razor Shell' AND attackCost = 'WaterWaterColorless' AND attackDamage = '40'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/fr/bw/bwp/BW65/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Roulade Continue' AND attackCost = 'Incolore' AND attackDamage = '10'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/en/bw/bw7/124/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Air Slash' AND attackCost = 'ColorlessColorlessColorless' AND attackDamage = '60'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/fr/bw/bw8/22/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Feu Follet' AND attackCost = 'FeuIncolore' AND attackDamage = '20'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/en/bw/bw8/20/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Searing Flame' AND attackCost = 'Fire' AND attackDamage = '20'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/en/bw/bw8/20/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Flame Blast' AND attackCost = 'ColorlessColorlessColorless' AND attackDamage = '40'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/fr/bw/bw8/25/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Blizzard' AND attackCost = 'EauIncoloreIncolore' AND attackDamage = '60'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/fr/bw/bw8/25/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Prison de Givre' AND attackCost = 'EauEauIncoloreIncolore' AND attackDamage = '80'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/en/bw/bw4/23/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Recover' AND attackCost = 'Colorless' AND attackDamage = null))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/en/bw/bw4/23/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Water Gun' AND attackCost = 'Water' AND attackDamage = '10'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/fr/bw/bw2/11/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Coup d''Main' AND attackCost = 'Incolore' AND attackDamage = null))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/fr/bw/bw2/11/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Cotogarde' AND attackCost = 'Plante' AND attackDamage = '30'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/en/bw/bw4/10/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Stoke' AND attackCost = 'Colorless' AND attackDamage = null))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/en/bw/bw4/10/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Firebreathing' AND attackCost = 'FireColorless' AND attackDamage = '10'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/fr/bw/bwp/BW63/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Flux Draconique' AND attackCost = 'FeuIncoloreIncolore' AND attackDamage = '60'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/fr/bw/bwp/BW63/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Feu Glac�' AND attackCost = 'FeuFeuEauIncolore' AND attackDamage = '150'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/en/bw/bw6/123/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Celestial Roar' AND attackCost = 'Colorless' AND attackDamage = null))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/en/bw/bw6/123/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Dragon Burst' AND attackCost = 'FireLightning' AND attackDamage = '60'))