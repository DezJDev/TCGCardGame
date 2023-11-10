DROP TABLE IF EXISTS P10_Card;
DROP TABLE IF EXISTS P10_Attack;
DROP TABLE IF EXISTS P10_Resistance;
DROP TABLE IF EXISTS P10_Weakness;
DROP TABLE IF EXISTS P10_User;
DROP TABLE IF EXISTS P10_Abitility;
DROP TABLE IF EXISTS P10_Contient;
DROP TABLE IF EXISTS P10_Collection;

CREATE TABLE IF NOT EXISTS P10_User(
	userId INT AUTO_INCREMENT PRIMARY KEY,
	userName varchar(20) NOT NULL,
	userDob date NOT NULL,
	userStatus varchar(10) NOT NULL CHECK IN ['root','user'],
	userLogin varchar(255) NOT NULL,
	userPass varchar(255) NOT NULL);

CREATE TABLE IF NOT EXISTS P10_Ability(
	abilityId INT AUTO_INCREMENT PRIMARY KEY,
	abilityName varchar(50) NOT NULL,
	abilityEffect varchar(255) NOT NULL);

CREATE TABLE IF NOT EXISTS P10_Resistance(
	resistanceId INT AUTO_INCREMENT PRIMARY KEY,
	resistanceType varchar(10) NOT NULL CHECK IN ['Incolore', 'Feu', 'Eau', 'Plante', 'Combat', 'Métal', 'Électrique', 'Psy', 'Obscurité', 'Dragon', 'Colorless', 'Fire', 'Water', 'Grass', 'Fighting', 'Metal', 'Lightning', 'Psychic', 'Darkness'],
	resistanceValue varchar(5) NOT NULL CHECK IN ['/2',-20,-10,-30]);

CREATE TABLE IF NOT EXISTS P10_Weakness(
	weaknessId INT AUTO_INCREMENT PRIMARY KEY,
	weaknessType varchar(10) NOT NULL CHECK IN ['Incolore', 'Feu', 'Eau', 'Plante', 'Combat', 'Métal', 'Électrique', 'Psy', 'Obscurité', 'Dragon', 'Colorless', 'Fire', 'Water', 'Grass', 'Fighting', 'Metal', 'Lightning', 'Psychic', 'Darkness'],
	weaknessValue varchar(5) NOT NULL CHECK IN ['x2',+20,+10,+30]);

CREATE TABLE IF NOT EXISTS P10_Attack(
	attackId INT AUTO_INCREMENT PRIMARY KEY,
	attackName varchar(50) NOT NULL,
	attackCost varchar(50),
	attackDamage varchar(4),
	attackEffect varchar(255),
	attackLang varchar(20) NOT NULL CHECK IN ['fr','en']);

CREATE TABLE IF NOT EXISTS P10_Card(
	cardId INT AUTO_INCREMENT PRIMARY KEY,
	cardCategory varchar(50) NOT NULL 'Pokémon' CHECK IN ['Pokémon','Pokemon','Dresseur','Trainer'],
	cardName varchar(50) NOT NULL,
	cardHP INT,
	cardRarity varchar(50) NOT NULL 'Commune' CHECK IN ['Commune','Common','Uncommon','Peu Commune','Rare','Ultra Rare','Secret Rare','Magnifique','Maginfic'],
	cardImg varchar(20) NOT NULL,
	cardType varchar(10) CHECK IN ['Incolore', 'Feu', 'Eau', 'Plante', 'Combat', 'Métal', 'Électrique', 'Psy', 'Obscurité', 'Dragon', 'Colorless', 'Fire', 'Water', 'Grass', 'Fighting', 'Metal', 'Lightning', 'Psychic', 'Darkness'],
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
	('Appel Préhistorique','Une seule fois pendant votre tour (avant votre attaque), si ce Pokémon est dans votre pile de défausse, vous pouvez placer ce Pokémon en dessous de votre deck.'),
	('Empty Shell','If this Pokémon is Knocked Out, your opponent can’t take any Prize cards for it.'),
	('Écran Mental','Si vous avez Créhelf et Créfadet en jeu, chacun de vos Pokémon n’a pas de Faiblesse.'),
	('Sporprise','Lorsque vous jouez ce Pokémon de votre main pour faire évoluer 1 de vos Pokémon, vous pouvez utiliser cette capacité spéciale. Dans ce cas, le Pokémon Actif de votre adversaire est maintenant Confus et Empoisonné.'),
	('Corniaud','S’il vous reste 2, 4 ou 6 cartes Récompense, ce Pokémon ne peut pas attaquer.'),
	('Mur Électromagnétique','Tant que ce Pokémon est votre Pokémon Actif, chaque fois que votre adversaire attache une Énergie de sa main à 1 de ses Pokémon, placez 3 marqueurs de dégâts sur le Pokémon auquel l’Énergie a été attachée.'),
	('Shift Gear','As often as you would like during your turn (before your attack), you may move a Metal Energy attached to 1 of your Pokémon to another of your Pokémon.'),
	('Rough Skin','If this Pokémon is your Active Pokémon and is damaged by an opponent’s attack (even if this Pokémon is Knocked Out), put 2 damage counters on the Attacking Pokémon.'),
	('Free Flight','If this Pokémon has no Energy attached to it, this Pokémon has no Retreat Cost.'),
	('Ancient Scream','Your Pokémon’s attacks do 10 more damage to the Active Pokémon (before applying Weakness and Resistance).');

INSERT INTO P10_Attack(attackName,attackCost,attackDamage,attackEffect) VALUES 
	('Appel à la Famille','Eau',null,'Cherchez 2 Pokémon de base dans votre deck et placez-les sur votre Banc. Mélangez ensuite votre deck.'),
	('Big Yawn','Colorless',null,'Both this Pokémon and the Defending Pokémon are now Asleep.'),
	('Tornade','IncoloreIncolore','20',null),
	('Fast Swipe','Colorless',null,'Discard a random card from your opponent''s hand.'),
	('Spirale Épuisante','PlanteIncolore','20','Soignez 10 dégâts à ce Pokémon.'),
	('Share','Grass',null,'Heal 40 damage from 1 of your Benched Pokémon.'),
	('Dernière Chance','Incolore','20','S''il reste 10 PV à ce Pokémon, cette attaque inflige 70 dégâts supplémentaires.'),
	('Energy Assist','Lightning',null,'Attach 2 basic Energy cards from your discard pile to 1 of your Benched Pokémon.'),
	('Chip Away','Fighting','40','This attack''s damage isn''t affected by any effects on the Defending Pokémon.'),
	('Balayage','ÉlectriqueIncolore','20',null),
	('Cursed Drop','Psychic',null,'Put 3 damage counters on your opponent''s Pokémon in any way you like.'),
	('Danse-Plume','Incolore',null,'Pendant votre prochain tour, chaque attaque de ce Pokémon inflige 40 dégâts supplémentaires (avant application de la Faiblesse et de la Résistance).'),
	('Ice Chain','Water',null,'Switch the Defending Pokémon with 1 of your opponent''s Benched Pokémon.'),
	('Whimsy Tackle','ColorlessColorless','30','Flip a coin. If tails, this attack does nothing.'),
	('Pistolectrique','Incolore','20','Vous pouvez défausser une Énergie Lightning attachée à ce Pokémon. Dans ce cas, cette attaque inflige 40 dégâts supplémentaires.'),
	('Righteous Edge','Metal','30','Discard a Special Energy attached to the Defending Pokémon.'),
	('Flammèche','FeuIncolore','30','Défaussez une Énergie attachée à ce Pokémon.'),
	('Ocroupi','Incolore','20','Inflige 20 dégâts à 1 des Pokémon de Banc de votre adversaire. (N''appliquez ni la Faiblesse ni la Résistance aux Pokémon de Banc.)'),
	('Blizzard','WaterColorlessColorless','60','Does 10 damage to each of your opponent''s Benched Pokémon. (Don''t apply Weakness and Resistance for Benched Pokémon.)'),
	('Étincelle Surprise','Électrique',null,'Cette attaque inflige 30 dégâts à 1 des Pokémon de votre adversaire. (N''appliquez ni la Faiblesse ni la Résistance aux Pokémon de Banc.)'),
	('Mur de Fer','Métal',null,'Lancez une pièce. Si c''est face, évitez tous les effets d''attaques (y compris les dégâts) infligés à ce Pokémon pendant le prochain tour de votre adversaire.'),
	('Strafe','ColorlessColorlessColorless','50','You may switch this Pokémon with 1 of your Benched Pokémon.'),
	('Chaîne de Glace','Eau',null,'Échangez le Pokémon Défenseur avec 1 des Pokémon de Banc de votre adversaire.'),
	('Bite','Colorless','10',null),
	('Grosse Baffe','Incolore','40','Lancez une pièce pour chaque Énergie attachée à ce Pokémon. Cette attaque inflige 40 dégâts multipliés par le nombre de côtés face.'),
	('Push Down','DarknessColorless','20','Your opponent switches the Defending Pokémon with 1 of his or her Benched Pokémon.'),
	('Tranch''Herbe','PlantePlante','40',null),
	('Sharp Fang','WaterColorlessColorless','60',null),
	('Attachement Profond','Incolore',null,'Cherchez une carte Supporter nommée Iris dans votre deck, montrez-la, puis ajoutez-la à votre main. Mélangez ensuite votre deck.'),
	('Psy Bolt','Psychic','10','Flip a coin. If heads, the Defending Pokémon is now Paralyzed.'),
	('Choc Mental','Incolore',null,'Lancez une pièce. Si c''est face, le Pokémon Défenseur est maintenant Paralysé.'),
	('X Ball','ColorlessColorless','20','Does 20 damage times the amount of Energy attached to this Pokémon and the Defending Pokémon.'),
	('Lignes Magnétiques','IncoloreIncolore','30','Vous pouvez déplacer une Énergie attachée au Pokémon Défenseur vers 1 des Pokémon de Banc de votre adversaire.'),
	('Cut Down','ColorlessColorless','30','Flip a coin. If heads, discard an Energy attached to the Defending Pokémon.'),
	('Piqûre Psy','PsyIncoloreIncolore','30',null),
	('Bubble','Water','10','Flip a coin. If heads, the Defending Pokémon is now Paralyzed.'),
	('Bluff','CombatIncolore','30','Lancez une pièce. Si c''est face, le Pokémon Défenseur est maintenant Paralysé.'),
	('Pound','FightingFighting','30',null),
	('Botte Secrète','PlanteIncolore','20','Lancez une pièce. Si c''est face, cette attaque inflige 30 dégâts supplémentaires.'),
	('X-Scissor','GrassColorless','30','Flip a coin. If heads, this attack does 40 more damage.'),
	('Cadeau','Incolore',null,'Lancez une pièce. Si c''est face, cherchez une carte dans votre deck puis ajoutez-la à votre main. Mélangez ensuite votre deck.'),
	('Outrage','ColorlessColorless','20','Does 10 more damage for each damage counter on this Pokémon.'),
	('Tit''sieste','Incolore','n/a','Soignez 20 dégâts à ce Pokémon.'),
	('Shred','GrassPsychicColorless','90','This attack''s damage isn''t affected by any effects on the Defending Pokémon.'),
	('Regard Hypnotique','Plante',null,'Le Pokémon Défenseur est maintenant Endormi.'),
	('Sleep Powder','GrassColorless','20','The Defending Pokémon is now Asleep.'),
	('Draw In','Fire',null,'Attach 2 Fire Energy cards from your discard pile to this Pokémon.'),
	('Flame Burst','Fire','20','Does 20 damage to 2 of your opponent''s Benched Pokémon. (Don''t apply Weakness and Resistance for Benched Pokémon.)'),
	('Hypnotic Gaze','Colorless',null,'The Defending Pokémon is now Asleep.'),
	('Électrojectile','ÉlectriqueIncoloreIncolore','70','Inflige 20 dégâts à 1 des Pokémon de Banc de votre adversaire. (N''appliquez ni la Faiblesse ni la Résistance aux Pokémon de Banc.)'),
	('Quick Attack','Colorless','10','Flip a coin. If heads, this attack does 20 more damage.'),
	('Gifles Sans Fin','CombatIncolore','20','Lancez une pièce jusqu''à ce que vous obteniez un côté pile. Cette attaque inflige 20 dégâts multipliés par le nombre de côtés face.'),
	('Flame Charge','Colorless',null,'Search your deck for a Fire Energy card and attach it to this Pokémon. Shuffle your deck afterward.'),
	('Tir de Précision','Eau',null,'Cette attaque inflige 30 dégâts à 1 des Pokémon de votre adversaire. (N''appliquez ni la Faiblesse ni la Résistance aux Pokémon de Banc.)'),
	('Flame Cloak','Colorless','10','Flip a coin. If heads, attach a Fire Energy card from your discard pile to this Pokémon.'),
	('Provoc','Incolore',null,'Échangez 1 des Pokémon de Banc de votre adversaire avec le Pokémon Défenseur.'),
	('Dragon Pulse','Lightning','40','Discard the top 2 cards of your deck.'),
	('Ronge','Incolore','20',null),
	('Aurora Beam','WaterColorlessColorless','80',null),
	('Grêle','Eau',null,'Lancez une pièce. Si c''est face, cette attaque inflige 10 dégâts à chacun des Pokémon de votre adversaire. (N''appliquez ni la Faiblesse ni la Résistance aux Pokémon de Banc.)'),
	('Electrigun','Colorless','20','You may discard a Lightning Energy attached to this Pokémon. If you do, this attack does 40 more damage.'),
	('Coup d''Boule','Incolore','10',null),
	('Blockade','Colorless','10','Your opponent can''t play any Supporter cards from his or her hand during his or her next turn.'),
	('Voracité','Métal',null,'Pour chacun de vos Fermite en jeu, défaussez la carte du dessus du deck de votre adversaire.'),
	('Gear Grind','MetalColorlessColorless','80','Flip 2 coins. This attack does 80 damage times the number of heads.'),
	('Energy Press','MetalColorless','20','Does 20 more damage for each Energy attached to the Defending Pokémon.'),
	('Creepy Wind','Psychic',null,'Flip a coin. If heads, the Defending Pokémon is now Confused.'),
	('Coup d''Aileron','Eau','10','Lancez 2 pièces. Cette attaque inflige 10 dégâts multipliés par le nombre de côtés face.'),
	('Double Spin','Colorless','10','Flip 2 coins. This attack does 10 damage times the number of heads.'),
	('Clutch','ColorlessColorlessColorless','60','The Defending Pokémon can''t retreat during your opponent''s next turn.'),
	('Repli','Incolore',null,'Lancez une pièce. Si c''est face, évitez tous les dégâts infligés à ce Pokémon par des attaques pendant le prochain tour de votre adversaire.'),
	('Wing Dance','ColorlessColorless','30','Flip a coin. If heads, prevent all effects of attacks, including damage, done to this Pokémon during your opponent''s next turn.'),
	('Beigne Dés-évoluante','PsyIncoloreIncolore','60','Faites dés-évoluer le Pokémon Défenseur et mettez sa carte Évolution de plus haut Niveau dans la main de votre adversaire.'),
	('Wing Attack','PsychicColorless','20',null),
	('Vibration','Incolore','10',null),
	('Take Down','ColorlessColorless','30','This Pokémon does 10 damage to itself.'),
	('Verdict Fatal','PsyIncolore',null,'Lancez 2 pièces. Si vous obtenez 2 côtés face, le Pokémon Défenseur est mis K.O.'),
	('Static Shock','Colorless','20',null),
	('Shout','Colorless',null,'Flip a coin. If heads, discard a random card from your opponent''s hand.'),
	('Collision','IncoloreIncolore','20',null),
	('Coup Double','Incolore','20','Lancez 2 pièces. Cette attaque inflige 20 dégâts multipliés par le nombre de côtés face.'),
	('Double Slap','Colorless','20','Flip 2 coins. This attack does 20 damage times the number of heads.'),
	('Tackle','Grass','10',null);

INSERT INTO P10_Attack(attackName,attackCost,attackDamage,attackEffect) VALUES 
	('Attaque Imprudente','IncoloreIncolore','40','Ce Pokémon s''inflige 20 dégâts.'),
	('Shot in the Dark','WaterColorless','20','Flip 2 coins. If either of them is tails, this attack does nothing.'),
	('Biting Fang','ColorlessColorless','30','Flip a coin. If heads, this attack does 20 more damage.'),
	('Double Stab','GrassGrassColorless','40','Flip 2 coins. This attack does 40 damage times the number of heads.'),
	('Frappe Atlas','CombatCombatIncolore','60',null),
	('Quick Attack','LightningColorless','30','Flip a coin. If heads, this attack does 20 more damage.'),
	('Swing Around','FightingFightingColorless','60','Flip 2 coins. This attack does 30 more damage for each heads.'),
	('Explosion Magnétique','ÉlectriqueIncoloreIncolore','50',null),
	('Anneau Hydro','EauIncolore','40','Échangez ce Pokémon avec 1 de vos Pokémon de Banc.'),
	('Frost Vanish','WaterWater','40','You may return this Pokémon and all cards attached to it to your hand.'),
	('Dard-Nuée','ÉlectriqueIncoloreIncolore','40','Lancez 4 pièces. Cette attaque inflige 40 dégâts multipliés par le nombre de côtés face.'),
	('Steel Bullet','MetalMetalColorless','100','This attack''s damage isn''t affected by Weakness, Resistance, or any other effects on the Defending Pokémon.'),
	('Spirale Épuisante','EauIncoloreIncolore','60','Soignez 20 dégâts à ce Pokémon.'),
	('Frost Prison','WaterWaterColorlessColorless','80','If this Pokémon has any Plasma Energy attached to it, the Defending Pokémon is now Paralyzed.'),
	('Canon Électrique','ÉlectriqueÉlectriqueIncolore','60','Vous pouvez défausser toutes les Énergies Lightning attachées à ce Pokémon. Dans ce cas, cette attaque inflige 60 dégâts supplémentaires.'),
	('Mégafouet','IncoloreIncolore',null,'Inflige 10 dégâts pour chaque Énergie attachée à ce Pokémon à 1 des Pokémon de votre adversaire. (N''appliquez ni la Faiblesse ni la Résistance aux Pokémon de Banc.)'),
	('Dimension Heal','GrassWaterColorlessColorless','80','Heal from this Pokémon 20 damage for each Plasma Energy attached to this Pokémon.'),
	('Poudreuse d''Escampette','EauEau','40','Vous pouvez reprendre ce Pokémon et toutes les cartes qui lui sont attachées dans votre main.'),
	('Bared Fangs','Water','40','If, before this Pokémon does damage, the Defending Pokémon has no damage counters on it, this attack does nothing.'),
	('Vibra Soin','IncoloreIncoloreIncolore',null,'Soignez 50 dégâts à 1 de vos Pokémon.'),
	('Bite','DarknessColorlessColorless','30',null),
	('Choc Frontal','PlantePlanteIncolore','80','Ce Pokémon et le Pokémon Défenseur sont maintenant Confus.'),
	('Dracogriffe','CombatMétal','20',null),
	('Psydrive','PsychicPsychicColorless','120','Discard an Energy attached to this Pokémon.'),
	('Pif Paf','MétalIncoloreIncolore','60','Si le Pokémon Défenseur a déjà des marqueurs de dégâts, cette attaque inflige 30 dégâts supplémentaires.'),
	('Slicing Blade','DarknessColorlessColorless','70',null),
	('Lancer Tournant','CombatCombatIncolore','90','Pendant le prochain tour de votre adversaire, tous les dégâts infligés à ce Pokémon par des attaques sont augmentés de 20 (après application de la Faiblesse et de la Résistance).'),
	('Energy Bloom','GrassGrassColorless','80','Heal 20 damage from each of your Pokémon that has any Energy attached to it.'),
	('Vent Glace','EauIncolore','30','Le Pokémon Défenseur est maintenant Endormi.'),
	('Glaciate','WaterWaterColorless',null,'This attack does 30 damage to each of your opponent''s Pokémon. (Don''t apply Weakness and Resistance for Benched Pokémon.)'),
	('Saut','IncoloreIncolore','20','Lancez une pièce. Si c''est face, cette attaque inflige 10 dégâts supplémentaires.'),
	('Dragon Pulse','GrassPsychicColorlessColorless','130','Discard the top 3 cards of your deck.'),
	('Queue Battoir','Électrique','10',null),
	('Poison Powder','GrassGrassColorless','50','The Defending Pokémon is now Poisoned.'),
	('Flare','FireColorless','20',null),
	('Fury Swipes','ColorlessColorlessColorless','40','Flip 3 coins. This attack does 40 damage times the number of heads.'),
	('Double Slap','ColorlessColorless','20','Flip 2 coins. This attack does 20 damage times the number of heads.'),
	('Shock Bolt','LightningLightningColorless','90','Flip a coin. If tails, discard all Lightning Energy attached to this Pokémon.'),
	('Enfoncer','CombatCombatIncolore','60',null),
	('Thunder','LightningColorlessColorless','90','Flip a coin. If tails, this Pokémon does 30 damage to itself.'),
	('Bulles d''O','EauEau','40','Lancez une pièce. Si c''est face, le Pokémon Défenseur est maintenant Paralysé.'),
	('Heat Blast','FireColorlessColorless','60',null),
	('Griffoboost','FeuEauIncolore','60','Pendant votre prochain tour, chaque attaque de ce Pokémon inflige 30 dégâts supplémentaires (avant application de la Faiblesse et de la Résistance).'),
	('Shred','FireLightningColorless','90','This attack''s damage isn''t affected by any effects on the Defending Pokémon.'),
	('Para-Dard','ÉlectriqueIncolore','30','Lancez une pièce. Si c''est face, le Pokémon Défenseur est maintenant Paralysé.'),
	('Ice Entomb','WaterWaterColorlessColorless','60','The Defending Pokémon is now Paralyzed. This Pokémon can''t use Ice Entomb during your next turn.'),
	('Verglas','IncoloreIncoloreIncolore','30',null),
	('Pin Missile','LightningColorlessColorless','40','Flip 4 coins. This attack does 40 damage times the number of heads.'),
	('Stomp','GrassColorlessColorless','60','Flip a coin. If heads, this attack does 30 more damage.'),
	('Force Poigne','IncoloreIncolore','30',null),
	('Iron Breaker','MetalMetalColorless','80','The Defending Pokémon can''t attack during your opponent''s next turn.'),
	('Wind Blast','ColorlessColorlessColorless',null,'This attack does 40 damage to 1 of your opponent''s Benched Pokémon. (Don''t apply Weakness and Resistance for Benched Pokémon.)'),
	('Cascade','EauEauIncolore','60',null),
	('Air Slash','WaterColorlessColorless','70','Discard an Energy attached to this Pokémon.'),
	('Spectro Maillet','PsyPsyIncoloreIncolore','90','Pendant le prochain tour de votre adversaire, ce Pokémon n''a pas de Faiblesse.'),
	('Tir de Boue','EauIncolore','20',null),
	('Magie Noire','PsyIncoloreIncolore','40','Inflige 20 dégâts supplémentaires pour chaque Pokémon de Banc de votre adversaire.'),
	('Electro Ball','LightningColorlessColorless','60',null),
	('Hyper Voice','ColorlessColorlessColorless','30',null),
	('Force','ObscuritéIncoloreIncolore','50',null),
	('Psybeam','PsychicColorless','20','The Defending Pokémon is now Confused.'),
	('Razor Leaf','GrassColorlessColorless','30',null);

INSERT INTO P10_Resistance(resistanceType,resistanceValue) VALUES 
	('Combat','-20'),
	('Eau','-20'),
	('Psy','-20'),
	('Psychic','-20'),
	('Fighting','-20'),
	('Water','-20');

INSERT INTO P10_Weakness(weaknessType,weaknessValue) VALUES 
	('Électrique','×2'),
	('Lightning','×2'),
	('Fighting','×2'),
	('Feu','×2'),
	('Fire','×2'),
	('Psy','×2'),
	('Combat','×2'),
	('Psychic','×2'),
	('Metal','×2'),
	('Eau','×2'),
	('Dragon','×2'),
	('Métal','×2'),
	('Grass','×2'),
	('Water','×2'),
	('Darkness','×2'),
	('Plante','×2'),
	('Obscurité','×2');

INSERT INTO P10_Card(cardCategory,cardName,cardHP,cardRarity,cardImg,cardType,cardExtensioncardRetreat,cardLang,abilityId,resistanceId,weaknessId) VALUES
	('Pokémon','Lokhlass','100','Rare','https://assets.tcgdex.net/fr/bw/bw4/25/high.webp','Eau','Destinées Futures',2,'fr',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Électrique' AND weaknessValue = '×2'),null),
	('Pokemon','Slowpoke','70','Common','https://assets.tcgdex.net/en/bw/bw5/23/high.webp','Water','Dark Explorers',3,'en',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Lightning' AND weaknessValue = '×2'),null),
	('Énergie','Énergie Plasma',null,'Peu Commune','https://assets.tcgdex.net/fr/bw/bw9/106/high.webp',null,'Glaciation Plasma',null,'fr',(SELECT abilityId FROM P10_Ability WHERE abilityEffect = 'Cette carte fournit de l''Énergie Colorless.'),null,null),
	('Trainer','Super Rod',null,'Uncommon','https://assets.tcgdex.net/en/bw/bw3/95/high.webp',null,'Noble Victories',null,'en',null,null,null),
	('Pokémon','Poichigeon','50','Commune','https://assets.tcgdex.net/fr/bw/bwp/BW15/high.webp','Incolore','Promo BW',1,'fr',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Électrique' AND weaknessValue = '×2'),(SELECT resistanceId FROM P10_Resistance WHERE resistanceType = 'Combat' AND resistanceValue = '-20')),
	('Pokemon','Watchog','90','Uncommon','https://assets.tcgdex.net/en/bw/bw8/112/high.webp','Colorless','Plasma Storm',1,'en',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Fighting' AND weaknessValue = '×2'),null),
	('Pokémon','Lilia','80','Peu Commune','https://assets.tcgdex.net/fr/bw/bw10/3/high.webp','Plante','Explosion Plasma',2,'fr',(SELECT abilityId FROM P10_Ability WHERE abilityName = 'Appel Préhistorique' AND abilityEffect = 'Une seule fois pendant votre tour (avant votre attaque), si ce Pokémon est dans votre pile de défausse, vous pouvez placer ce Pokémon en dessous de votre deck.'),(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Feu' AND weaknessValue = '×2'),(SELECT resistanceId FROM P10_Resistance WHERE resistanceType = 'Eau' AND resistanceValue = '-20')),
	('Pokemon','Shuckle','80','Uncommon','https://assets.tcgdex.net/en/bw/bw11/3/high.webp','Grass','Legendary Treasures',1,'en',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Fire' AND weaknessValue = '×2'),null),
	('Pokémon','Machopeur','90','Peu Commune','https://assets.tcgdex.net/fr/bw/bw10/48/high.webp','Combat','Explosion Plasma',3,'fr',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Psy' AND weaknessValue = '×2'),null),
	('Pokemon','Manectric','90','Rare','https://assets.tcgdex.net/en/bw/bw6/44/high.webp','Lightning','Dragons Exalted',1,'en',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Fighting' AND weaknessValue = '×2'),null),
	('Pokémon','Scalproie','90','Rare','https://assets.tcgdex.net/fr/bw/bw5/72/high.webp','Obscurité','Explorateurs Obscurs',1,'fr',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Combat' AND weaknessValue = '×2'),(SELECT resistanceId FROM P10_Resistance WHERE resistanceType = 'Psy' AND resistanceValue = '-20')),
	('Pokemon','Conkeldurr','140','Rare','https://assets.tcgdex.net/en/bw/bw3/65/high.webp','Fighting','Noble Victories',3,'en',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Psychic' AND weaknessValue = '×2'),null),
	('Pokémon','Élektek','80','Commune','https://assets.tcgdex.net/fr/bw/bw7/53/high.webp','Électrique','Frontières Franchies',2,'fr',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Combat' AND weaknessValue = '×2'),null),
	('Pokemon','Shedinja','60','Rare','https://assets.tcgdex.net/en/bw/bw6/48/high.webp','Psychic','Dragons Exalted',0,'en',(SELECT abilityId FROM P10_Ability WHERE abilityName = 'Empty Shell' AND abilityEffect = 'If this Pokémon is Knocked Out, your opponent can’t take any Prize cards for it.'),null,null),
	('Pokémon','Lakmécygne','90','Rare','https://assets.tcgdex.net/fr/bw/bw1/37/high.webp','Eau','Noir & Blanc',1,'fr',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Électrique' AND weaknessValue = '×2'),(SELECT resistanceId FROM P10_Resistance WHERE resistanceType = 'Combat' AND resistanceValue = '-20')),
	('Pokemon','Cryogonal','80','Rare','https://assets.tcgdex.net/en/bw/bw3/33/high.webp','Water','Noble Victories',1,'en',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Metal' AND weaknessValue = '×2'),null),
	('Dresseur','Coupe Victoire',null,'Commune','https://assets.tcgdex.net/fr/bw/bwp/BW29/high.webp',null,'Promo BW',null,'fr',(SELECT abilityId FROM P10_Ability WHERE abilityEffect = 'Lancez une pièce. Si c’est face, cherchez un Pokémon dans votre deck, montrez-le, puis ajoutez-le à votre main. Mélangez ensuite votre deck.'),null,null),
	('Pokemon','Spinda','70','Common','https://assets.tcgdex.net/en/bw/bw7/115/high.webp','Colorless','Boundaries Crossed',1,'en',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Fighting' AND weaknessValue = '×2'),null),
	('Pokémon','Voltali','90','Commune','https://assets.tcgdex.net/fr/bw/bwp/BW91/high.webp','Électrique','Promo BW',null,'fr',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Combat' AND weaknessValue = '×2'),null),
	('Pokemon','Cobalion-EX','180','Ultra Rare','https://assets.tcgdex.net/en/bw/bw8/133/high.webp','Metal','Plasma Storm',2,'en',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Fire' AND weaknessValue = '×2'),(SELECT resistanceId FROM P10_Resistance WHERE resistanceType = 'Psychic' AND resistanceValue = '-20')),
	('Pokémon','Gruikui','70','Commune','https://assets.tcgdex.net/fr/bw/bwp/BW02/high.webp','Feu','Promo BW',2,'fr',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Eau' AND weaknessValue = '×2'),null),
	('Trainer','Cedric Juniper',null,'Uncommon','https://assets.tcgdex.net/en/bw/bw11/110/high.webp',null,'Legendary Treasures',null,'en',null,null,null),
	('Pokémon','Aquali','110','Commune','https://assets.tcgdex.net/fr/bw/bwp/BW89/high.webp','Eau','Promo BW',2,'fr',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Électrique' AND weaknessValue = '×2'),null),
	('Pokemon','Articuno-EX','170','Ultra Rare','https://assets.tcgdex.net/en/bw/bw8/132/high.webp','Water','Plasma Storm',1,'en',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Metal' AND weaknessValue = '×2'),(SELECT resistanceId FROM P10_Resistance WHERE resistanceType = 'Fighting' AND resistanceValue = '-20')),
	('Pokémon','Pharamp','140','Commune','https://assets.tcgdex.net/fr/bw/bwp/BW67/high.webp','Électrique','Promo BW',2,'fr',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Combat' AND weaknessValue = '×2'),null),
	('Trainer','Plasma Frigate',null,'Uncommon','https://assets.tcgdex.net/en/bw/bw8/124/high.webp',null,'Plasma Storm',null,'en',null,null,null),
	('Pokémon','Noacier','90','Peu Commune','https://assets.tcgdex.net/fr/bw/bw2/73/high.webp','Métal','Pouvoirs Émergents',3,'fr',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Feu' AND weaknessValue = '×2'),(SELECT resistanceId FROM P10_Resistance WHERE resistanceType = 'Psy' AND resistanceValue = '-20')),
	('Pokemon','Palkia-EX','180','Rare','https://assets.tcgdex.net/en/bw/bw10/66/high.webp','Dragon','Plasma Blast',2,'en',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Dragon' AND weaknessValue = '×2'),null),
	('Pokémon','Hexagel','80','Rare','https://assets.tcgdex.net/fr/bw/bw3/33/high.webp','Eau','Nobles Victoires',1,'fr',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Métal' AND weaknessValue = '×2'),null),
	('Pokemon','Basculin','80','Uncommon','https://assets.tcgdex.net/en/bw/bw4/30/high.webp','Water','Next Destinies',1,'en',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Lightning' AND weaknessValue = '×2'),null),
	('Pokémon','Nanméouïe','90','Peu Commune','https://assets.tcgdex.net/fr/bw/bw2/83/high.webp','Incolore','Pouvoirs Émergents',2,'fr',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Combat' AND weaknessValue = '×2'),null),
	('Pokemon','Deino','60','Common','https://assets.tcgdex.net/en/bw/bw9/75/high.webp','Darkness','Plasma Freeze',2,'en',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Fighting' AND weaknessValue = '×2'),(SELECT resistanceId FROM P10_Resistance WHERE resistanceType = 'Psychic' AND resistanceValue = '-20')),
	('Pokémon','Blizzaroi','120','Peu Commune','https://assets.tcgdex.net/fr/bw/bw10/26/high.webp','Eau','Explosion Plasma',2,'fr',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Métal' AND weaknessValue = '×2'),null),
	('Pokemon','Gyarados','130','Rare','https://assets.tcgdex.net/en/bw/bw6/24/high.webp','Water','Dragons Exalted',3,'en',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Lightning' AND weaknessValue = '×2'),null),
	('Pokémon','Coupenotte','50','Commune','https://assets.tcgdex.net/fr/bw/bw10/67/high.webp','Dragon','Explosion Plasma',1,'fr',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Dragon' AND weaknessValue = '×2'),null),
	('Pokemon','Elgyem','60','Common','https://assets.tcgdex.net/en/bw/bw4/61/high.webp','Psychic','Next Destinies',1,'en',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Psychic' AND weaknessValue = '×2'),null),
	('Pokémon','Tarsal','60','Commune','https://assets.tcgdex.net/fr/bw/bw8/59/high.webp','Psy','Tempète Plasma',1,'fr',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Psy' AND weaknessValue = '×2'),null),
	('Pokemon','Mewtwo-EX','170','Rare','https://assets.tcgdex.net/en/bw/bw11/54/high.webp','Psychic','Legendary Treasures',2,'en',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Psychic' AND weaknessValue = '×2'),null),
	('Pokémon','Tarinorme','110','Rare','https://assets.tcgdex.net/fr/bw/bw6/82/high.webp','Métal','Dragons Éxaltés',4,'fr',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Feu' AND weaknessValue = '×2'),(SELECT resistanceId FROM P10_Resistance WHERE resistanceType = 'Psy' AND resistanceValue = '-20')),
	('Pokemon','Bisharp','90','Uncommon','https://assets.tcgdex.net/en/bw/bw9/74/high.webp','Darkness','Plasma Freeze',1,'en',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Fighting' AND weaknessValue = '×2'),(SELECT resistanceId FROM P10_Resistance WHERE resistanceType = 'Psychic' AND resistanceValue = '-20')),
	('Pokémon','Créfollet','60','Rare','https://assets.tcgdex.net/fr/bw/bw10/37/high.webp','Psy','Explosion Plasma',1,'fr',(SELECT abilityId FROM P10_Ability WHERE abilityName = 'Écran Mental' AND abilityEffect = 'Si vous avez Créhelf et Créfadet en jeu, chacun de vos Pokémon n’a pas de Faiblesse.'),(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Psy' AND weaknessValue = '×2'),null),
	('Pokemon','Tympole','50','Common','https://assets.tcgdex.net/en/bw/bw6/34/high.webp','Water','Dragons Exalted',1,'en',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Grass' AND weaknessValue = '×2'),null),
	('Pokémon','Hariyama','120','Rare','https://assets.tcgdex.net/fr/bw/bw9/63/high.webp','Combat','Glaciation Plasma',3,'fr',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Psy' AND weaknessValue = '×2'),null),
	('Pokemon','Timburr','60','Common','https://assets.tcgdex.net/en/bw/bw1/58/high.webp','Fighting','Black & White',1,'en',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Psychic' AND weaknessValue = '×2'),null),
	('Pokémon','Gaulet','90','Rare','https://assets.tcgdex.net/fr/bw/bw4/9/high.webp','Plante','Destinées Futures',2,'fr',(SELECT abilityId FROM P10_Ability WHERE abilityName = 'Sporprise' AND abilityEffect = 'Lorsque vous jouez ce Pokémon de votre main pour faire évoluer 1 de vos Pokémon, vous pouvez utiliser cette capacité spéciale. Dans ce cas, le Pokémon Actif de votre adversaire est maintenant Confus et Empoisonné.'),(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Feu' AND weaknessValue = '×2'),(SELECT resistanceId FROM P10_Resistance WHERE resistanceType = 'Eau' AND resistanceValue = '-20')),
	('Pokemon','Sceptile','130','Rare','https://assets.tcgdex.net/en/bw/bw9/8/high.webp','Grass','Plasma Freeze',2,'en',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Fire' AND weaknessValue = '×2'),(SELECT resistanceId FROM P10_Resistance WHERE resistanceType = 'Water' AND resistanceValue = '-20')),
	('Pokémon','Cadoizo','80','Peu Commune','https://assets.tcgdex.net/fr/bw/bw7/38/high.webp','Eau','Frontières Franchies',1,'fr',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Métal' AND weaknessValue = '×2'),null),
	('Pokemon','Kyurem','130','Rare','https://assets.tcgdex.net/en/bw/bw3/34/high.webp','Water','Noble Victories',2,'en',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Metal' AND weaknessValue = '×2'),null),
	('Pokémon','Miaouss','60','Commune','https://assets.tcgdex.net/fr/bw/bwp/BW35/high.webp','Incolore','Promo BW',1,'fr',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Combat' AND weaknessValue = '×2'),null),
	('Trainer','Tool Scrapper',null,'Uncommon','https://assets.tcgdex.net/en/bw/bw6/116/high.webp',null,'Dragons Exalted',null,'en',null,null,null),
	('Dresseur','Ghetis',null,'Rare','https://assets.tcgdex.net/fr/bw/bw9/101/high.webp',null,'Glaciation Plasma',null,'fr',(SELECT abilityId FROM P10_Ability WHERE abilityEffect = 'Votre adversaire montre sa main et mélange toutes les cartes Objet qui s''y trouvent avec son deck. Ensuite, piochez un nombre de cartes égal au nombre de cartes Objet que votre adversaire a mélangées avec son deck.'),null,null),
	('Pokemon','Giratina-EX','180','Rare','https://assets.tcgdex.net/en/bw/bw6/92/high.webp','Dragon','Dragons Exalted',3,'en',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Dragon' AND weaknessValue = '×2'),null),
	('Pokémon','Minidraco','40','Rare','https://assets.tcgdex.net/fr/bw/dv1/2/high.webp','Dragon','Coffre des Dragons',1,'fr',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Dragon' AND weaknessValue = '×2'),null),
	('Pokemon','Ivysaur','90','Uncommon','https://assets.tcgdex.net/en/bw/bw5/2/high.webp','Grass','Dark Explorers',3,'en',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Fire' AND weaknessValue = '×2'),(SELECT resistanceId FROM P10_Resistance WHERE resistanceType = 'Water' AND resistanceValue = '-20')),
	('Pokémon','Pyronille','70','Commune','https://assets.tcgdex.net/fr/bw/bw3/19/high.webp','Feu','Nobles Victoires',2,'fr',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Eau' AND weaknessValue = '×2'),null),
	('Pokemon','Charmander','70','Common','https://assets.tcgdex.net/en/bw/bw7/18/high.webp','Fire','Boundaries Crossed',2,'en',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Water' AND weaknessValue = '×2'),null),
	('Pokémon','Flagadoss','100','Peu Commune','https://assets.tcgdex.net/fr/bw/bw5/24/high.webp','Eau','Explorateurs Obscurs',3,'fr',(SELECT abilityId FROM P10_Ability WHERE abilityName = 'Corniaud' AND abilityEffect = 'S’il vous reste 2, 4 ou 6 cartes Récompense, ce Pokémon ne peut pas attaquer.'),(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Électrique' AND weaknessValue = '×2'),null),
	('Pokemon','Simisear','90','Uncommon','https://assets.tcgdex.net/en/bw/bw1/22/high.webp','Fire','Black & White',1,'en',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Water' AND weaknessValue = '×2'),null),
	('Pokémon','Machoc','60','Commune','https://assets.tcgdex.net/fr/bw/bw10/47/high.webp','Combat','Explosion Plasma',3,'fr',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Psy' AND weaknessValue = '×2'),null),
	('Pokemon','Gothita','60','Common','https://assets.tcgdex.net/en/bw/bw2/43/high.webp','Psychic','Emerging Powers',1,'en',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Psychic' AND weaknessValue = '×2'),null),
	('Pokémon','Pharamp','140','Rare','https://assets.tcgdex.net/fr/bw/bw6/40/high.webp','Électrique','Dragons Éxaltés',2,'fr',(SELECT abilityId FROM P10_Ability WHERE abilityName = 'Mur Électromagnétique' AND abilityEffect = 'Tant que ce Pokémon est votre Pokémon Actif, chaque fois que votre adversaire attache une Énergie de sa main à 1 de ses Pokémon, placez 3 marqueurs de dégâts sur le Pokémon auquel l’Énergie a été attachée.'),(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Combat' AND weaknessValue = '×2'),null),
	('Pokemon','Zebstrika','90','Rare','https://assets.tcgdex.net/en/bw/bw3/36/high.webp','Lightning','Noble Victories',1,'en',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Fighting' AND weaknessValue = '×2'),null),
	('Pokémon','Makuhita','80','Commune','https://assets.tcgdex.net/fr/bw/bw9/62/high.webp','Combat','Glaciation Plasma',3,'fr',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Psy' AND weaknessValue = '×2'),null),
	('Pokemon','Zebstrika','100','Rare','https://assets.tcgdex.net/en/bw/bw7/57/high.webp','Lightning','Boundaries Crossed',1,'en',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Fighting' AND weaknessValue = '×2'),null),
	('Pokémon','Octillery','90','Peu Commune','https://assets.tcgdex.net/fr/bw/bw10/19/high.webp','Eau','Explosion Plasma',1,'fr',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Électrique' AND weaknessValue = '×2'),null),
	('Pokemon','Torkoal','90','Uncommon','https://assets.tcgdex.net/en/bw/bw5/18/high.webp','Fire','Dark Explorers',2,'en',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Water' AND weaknessValue = '×2'),null),
	('Pokémon','Drakkarmin','100','Commune','https://assets.tcgdex.net/fr/bw/bwp/BW80/high.webp','Dragon','Promo BW',2,'fr',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Dragon' AND weaknessValue = '×2'),null),
	('Pokemon','Rayquaza','120','Secret Rare','https://assets.tcgdex.net/en/bw/bw6/128/high.webp','Dragon','Dragons Exalted',3,'en',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Dragon' AND weaknessValue = '×2'),null),
	('Pokémon','Mygavolt','80','Peu Commune','https://assets.tcgdex.net/fr/bw/bw2/34/high.webp','Électrique','Pouvoirs Émergents',0,'fr',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Combat' AND weaknessValue = '×2'),null),
	('Pokemon','Walrein','140','Rare','https://assets.tcgdex.net/en/bw/bw6/31/high.webp','Water','Dragons Exalted',4,'en',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Metal' AND weaknessValue = '×2'),null),
	('Pokémon','Polarhume','70','Commune','https://assets.tcgdex.net/fr/bw/bw8/40/high.webp','Eau','Tempète Plasma',2,'fr',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Métal' AND weaknessValue = '×2'),null),
	('Pokemon','Jolteon','90','Uncommon','https://assets.tcgdex.net/en/bw/bw5/37/high.webp','Lightning','Dark Explorers',0,'en',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Fighting' AND weaknessValue = '×2'),null),
	('Pokémon','Draby','50','Rare','https://assets.tcgdex.net/fr/bw/dv1/6/high.webp','Dragon','Coffre des Dragons',1,'fr',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Dragon' AND weaknessValue = '×2'),null),
	('Pokemon','Exeggutor','100','Rare','https://assets.tcgdex.net/en/bw/bw9/5/high.webp','Grass','Plasma Freeze',2,'en',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Fire' AND weaknessValue = '×2'),(SELECT resistanceId FROM P10_Resistance WHERE resistanceType = 'Water' AND resistanceValue = '-20')),
	('Pokémon','Fermite','70','Peu Commune','https://assets.tcgdex.net/fr/bw/bw3/83/high.webp','Métal','Nobles Victoires',1,'fr',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Feu' AND weaknessValue = '×2'),(SELECT resistanceId FROM P10_Resistance WHERE resistanceType = 'Psy' AND resistanceValue = '-20')),
	('Pokemon','Klinklang','140','Rare','https://assets.tcgdex.net/en/bw/bw1/76/high.webp','Metal','Black & White',3,'en',(SELECT abilityId FROM P10_Ability WHERE abilityName = 'Shift Gear' AND abilityEffect = 'As often as you would like during your turn (before your attack), you may move a Metal Energy attached to 1 of your Pokémon to another of your Pokémon.'),(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Fire' AND weaknessValue = '×2'),(SELECT resistanceId FROM P10_Resistance WHERE resistanceType = 'Psychic' AND resistanceValue = '-20')),
	('Dresseur','Ville Gelée',null,'Peu Commune','https://assets.tcgdex.net/fr/bw/bw9/100/high.webp',null,'Glaciation Plasma',null,'fr',(SELECT abilityId FROM P10_Ability WHERE abilityEffect = 'Chaque fois qu''un joueur attache une Énergie de sa main à 1 de ses Pokémon (excepté les Pokémon de la Team Plasma), placez 2 marqueurs de dégâts sur le Pokémon auquel l''Énergie a été attachée.'),null,null),
	('Pokemon','Cobalion','120','Rare','https://assets.tcgdex.net/en/bw/bw11/91/high.webp','Metal','Legendary Treasures',2,'en',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Fire' AND weaknessValue = '×2'),(SELECT resistanceId FROM P10_Resistance WHERE resistanceType = 'Psychic' AND resistanceValue = '-20')),
	('Pokémon','Raikou-EX','170','Rare','https://assets.tcgdex.net/fr/bw/bw5/38/high.webp','Électrique','Explorateurs Obscurs',1,'fr',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Combat' AND weaknessValue = '×2'),null),
	('Pokemon','Drifloon','70','Common','https://assets.tcgdex.net/en/bw/bw10/34/high.webp','Psychic','Plasma Blast',2,'en',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Darkness' AND weaknessValue = '×2'),null),
	('Pokémon','Hypotrempe','60','Commune','https://assets.tcgdex.net/fr/bw/bw9/18/high.webp','Eau','Glaciation Plasma',1,'fr',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Électrique' AND weaknessValue = '×2'),null),
	('Pokemon','Foongus','40','Common','https://assets.tcgdex.net/en/bw/bw6/17/high.webp','Grass','Dragons Exalted',1,'en',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Fire' AND weaknessValue = '×2'),(SELECT resistanceId FROM P10_Resistance WHERE resistanceType = 'Water' AND resistanceValue = '-20')),
	('Dresseur','Casque Brut',null,'Peu Commune','https://assets.tcgdex.net/fr/bw/bw7/133/high.webp',null,'Frontières Franchies',null,'fr',(SELECT abilityId FROM P10_Ability WHERE abilityEffect = 'Si le Pokémon auquel cette carte est attachée est votre Pokémon Actif et qu’il subit les dégâts d’une attaque de votre adversaire (même si le Pokémon est mis K.O.), placez 2 marqueurs de dégâts sur le Pokémon Attaquant.'),null,null),
	('Pokemon','Druddigon','100','Uncommon','https://assets.tcgdex.net/en/bw/bw11/106/high.webp','Colorless','Legendary Treasures',2,'en',(SELECT abilityId FROM P10_Ability WHERE abilityName = 'Rough Skin' AND abilityEffect = 'If this Pokémon is your Active Pokémon and is damaged by an opponent’s attack (even if this Pokémon is Knocked Out), put 2 damage counters on the Attacking Pokémon.'),null,null),
	('Pokémon','Carabaffe','80','Peu Commune','https://assets.tcgdex.net/fr/bw/bw7/30/high.webp','Eau','Frontières Franchies',2,'fr',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Plante' AND weaknessValue = '×2'),null),
	('Pokemon','Swanna','90','Rare','https://assets.tcgdex.net/en/bw/bw2/27/high.webp','Water','Emerging Powers',1,'en',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Lightning' AND weaknessValue = '×2'),(SELECT resistanceId FROM P10_Resistance WHERE resistanceType = 'Fighting' AND resistanceValue = '-20')),
	('Pokémon','Golemastoc','130','Rare','https://assets.tcgdex.net/fr/bw/bw6/59/high.webp','Psy','Dragons Éxaltés',4,'fr',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Obscurité' AND weaknessValue = '×2'),null),
	('Pokemon','Zubat','40','Common','https://assets.tcgdex.net/en/bw/bw8/53/high.webp','Psychic','Plasma Storm',1,'en',(SELECT abilityId FROM P10_Ability WHERE abilityName = 'Free Flight' AND abilityEffect = 'If this Pokémon has no Energy attached to it, this Pokémon has no Retreat Cost.'),(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Lightning' AND weaknessValue = '×2'),(SELECT resistanceId FROM P10_Resistance WHERE resistanceType = 'Fighting' AND resistanceValue = '-20')),
	('Pokémon','Tritonde','60','Commune','https://assets.tcgdex.net/fr/bw/bw3/22/high.webp','Eau','Nobles Victoires',1,'fr',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Plante' AND weaknessValue = '×2'),null),
	('Pokemon','Larvesta','80','Common','https://assets.tcgdex.net/en/bw/bw3/20/high.webp','Fire','Noble Victories',2,'en',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Water' AND weaknessValue = '×2'),null),
	('Pokémon','Sidérella','130','Rare','https://assets.tcgdex.net/fr/bw/bw6/57/high.webp','Psy','Dragons Éxaltés',2,'fr',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Psy' AND weaknessValue = '×2'),null),
	('Pokemon','Electrode','80','Uncommon','https://assets.tcgdex.net/en/bw/bw7/52/high.webp','Lightning','Boundaries Crossed',0,'en',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Fighting' AND weaknessValue = '×2'),null),
	('Dresseur','Éclat de Victoire',null,'Rare','https://assets.tcgdex.net/fr/bw/bw8/130/high.webp',null,'Tempète Plasma',null,'fr',(SELECT abilityId FROM P10_Ability WHERE abilityEffect = 'Si cette carte est attachée à Victini-EX, Victini-EX peut utiliser ses attaques indépendamment de la quantité ou du type d’Énergie qui lui est attachée.'),null,null),
	('Pokemon','Whismur','70','Common','https://assets.tcgdex.net/en/bw/bw8/105/high.webp','Colorless','Plasma Storm',2,'en',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Fighting' AND weaknessValue = '×2'),null),
	('Pokémon','Munna','70','Commune','https://assets.tcgdex.net/fr/bw/bw4/58/high.webp','Psy','Destinées Futures',2,'fr',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Psy' AND weaknessValue = '×2'),null),
	('Pokemon','Aerodactyl','90','Rare','https://assets.tcgdex.net/en/bw/bw5/53/high.webp','Fighting','Dark Explorers',1,'en',(SELECT abilityId FROM P10_Ability WHERE abilityName = 'Ancient Scream' AND abilityEffect = 'Your Pokémon’s attacks do 10 more damage to the Active Pokémon (before applying Weakness and Resistance).'),(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Grass' AND weaknessValue = '×2'),null),
	('Pokémon','Diamat','90','Peu Commune','https://assets.tcgdex.net/fr/bw/bw3/78/high.webp','Obscurité','Nobles Victoires',2,'fr',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Combat' AND weaknessValue = '×2'),(SELECT resistanceId FROM P10_Resistance WHERE resistanceType = 'Psy' AND resistanceValue = '-20')),
	('Pokemon','Gothorita','80','Uncommon','https://assets.tcgdex.net/en/bw/bw11/71/high.webp','Psychic','Legendary Treasures',1,'en',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Psychic' AND weaknessValue = '×2'),null),
	('Pokémon','Bulbizarre','60','Commune','https://assets.tcgdex.net/fr/bw/bw5/1/high.webp','Plante','Explorateurs Obscurs',2,'fr',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Feu' AND weaknessValue = '×2'),(SELECT resistanceId FROM P10_Resistance WHERE resistanceType = 'Eau' AND resistanceValue = '-20')),
	('Pokemon','Bulbasaur','60','Common','https://assets.tcgdex.net/en/bw/bw5/1/high.webp','Grass','Dark Explorers',2,'en',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Fire' AND weaknessValue = '×2'),(SELECT resistanceId FROM P10_Resistance WHERE resistanceType = 'Water' AND resistanceValue = '-20'));

INSERT INTO P10_Contient(cardId, attackId) VALUES
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/fr/bw/bw4/25/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Appel à la Famille' AND attackCost = 'Eau' AND attackDamage = null))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/fr/bw/bw4/25/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Attaque Imprudente' AND attackCost = 'IncoloreIncolore' AND attackDamage = '40'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/en/bw/bw5/23/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Big Yawn' AND attackCost = 'Colorless' AND attackDamage = null))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/en/bw/bw5/23/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Shot in the Dark' AND attackCost = 'WaterColorless' AND attackDamage = '20'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/fr/bw/bwp/BW15/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Tornade' AND attackCost = 'IncoloreIncolore' AND attackDamage = '20'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/en/bw/bw8/112/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Fast Swipe' AND attackCost = 'Colorless' AND attackDamage = null))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/en/bw/bw8/112/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Biting Fang' AND attackCost = 'ColorlessColorless' AND attackDamage = '30'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/fr/bw/bw10/3/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Spirale Épuisante' AND attackCost = 'PlanteIncolore' AND attackDamage = '20'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/en/bw/bw11/3/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Share' AND attackCost = 'Grass' AND attackDamage = null))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/en/bw/bw11/3/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Double Stab' AND attackCost = 'GrassGrassColorless' AND attackDamage = '40'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/fr/bw/bw10/48/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Dernière Chance' AND attackCost = 'Incolore' AND attackDamage = '20'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/fr/bw/bw10/48/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Frappe Atlas' AND attackCost = 'CombatCombatIncolore' AND attackDamage = '60'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/en/bw/bw6/44/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Energy Assist' AND attackCost = 'Lightning' AND attackDamage = null))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/en/bw/bw6/44/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Quick Attack' AND attackCost = 'LightningColorless' AND attackDamage = '30'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/en/bw/bw3/65/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Chip Away' AND attackCost = 'Fighting' AND attackDamage = '40'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/en/bw/bw3/65/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Swing Around' AND attackCost = 'FightingFightingColorless' AND attackDamage = '60'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/fr/bw/bw7/53/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Balayage' AND attackCost = 'ÉlectriqueIncolore' AND attackDamage = '20'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/fr/bw/bw7/53/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Explosion Magnétique' AND attackCost = 'ÉlectriqueIncoloreIncolore' AND attackDamage = '50'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/en/bw/bw6/48/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Cursed Drop' AND attackCost = 'Psychic' AND attackDamage = null))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/fr/bw/bw1/37/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Danse-Plume' AND attackCost = 'Incolore' AND attackDamage = null))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/fr/bw/bw1/37/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Anneau Hydro' AND attackCost = 'EauIncolore' AND attackDamage = '40'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/en/bw/bw3/33/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Ice Chain' AND attackCost = 'Water' AND attackDamage = null))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/en/bw/bw3/33/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Frost Vanish' AND attackCost = 'WaterWater' AND attackDamage = '40'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/en/bw/bw7/115/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Whimsy Tackle' AND attackCost = 'ColorlessColorless' AND attackDamage = '30'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/fr/bw/bwp/BW91/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Pistolectrique' AND attackCost = 'Incolore' AND attackDamage = '20'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/fr/bw/bwp/BW91/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Dard-Nuée' AND attackCost = 'ÉlectriqueIncoloreIncolore' AND attackDamage = '40'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/en/bw/bw8/133/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Righteous Edge' AND attackCost = 'Metal' AND attackDamage = '30'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/en/bw/bw8/133/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Steel Bullet' AND attackCost = 'MetalMetalColorless' AND attackDamage = '100'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/fr/bw/bwp/BW02/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Flammèche' AND attackCost = 'FeuIncolore' AND attackDamage = '30'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/fr/bw/bwp/BW89/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Ocroupi' AND attackCost = 'Incolore' AND attackDamage = '20'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/fr/bw/bwp/BW89/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Spirale Épuisante' AND attackCost = 'EauIncoloreIncolore' AND attackDamage = '60'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/en/bw/bw8/132/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Blizzard' AND attackCost = 'WaterColorlessColorless' AND attackDamage = '60'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/en/bw/bw8/132/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Frost Prison' AND attackCost = 'WaterWaterColorlessColorless' AND attackDamage = '80'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/fr/bw/bwp/BW67/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Étincelle Surprise' AND attackCost = 'Électrique' AND attackDamage = null))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/fr/bw/bwp/BW67/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Canon Électrique' AND attackCost = 'ÉlectriqueÉlectriqueIncolore' AND attackDamage = '60'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/fr/bw/bw2/73/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Mur de Fer' AND attackCost = 'Métal' AND attackDamage = null))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/fr/bw/bw2/73/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Mégafouet' AND attackCost = 'IncoloreIncolore' AND attackDamage = null))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/en/bw/bw10/66/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Strafe' AND attackCost = 'ColorlessColorlessColorless' AND attackDamage = '50'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/en/bw/bw10/66/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Dimension Heal' AND attackCost = 'GrassWaterColorlessColorless' AND attackDamage = '80'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/fr/bw/bw3/33/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Chaîne de Glace' AND attackCost = 'Eau' AND attackDamage = null))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/fr/bw/bw3/33/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Poudreuse d''Escampette' AND attackCost = 'EauEau' AND attackDamage = '40'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/en/bw/bw4/30/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Bite' AND attackCost = 'Colorless' AND attackDamage = '10'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/en/bw/bw4/30/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Bared Fangs' AND attackCost = 'Water' AND attackDamage = '40'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/fr/bw/bw2/83/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Grosse Baffe' AND attackCost = 'Incolore' AND attackDamage = '40'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/fr/bw/bw2/83/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Vibra Soin' AND attackCost = 'IncoloreIncoloreIncolore' AND attackDamage = null))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/en/bw/bw9/75/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Push Down' AND attackCost = 'DarknessColorless' AND attackDamage = '20'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/en/bw/bw9/75/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Bite' AND attackCost = 'DarknessColorlessColorless' AND attackDamage = '30'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/fr/bw/bw10/26/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Tranch''Herbe' AND attackCost = 'PlantePlante' AND attackDamage = '40'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/fr/bw/bw10/26/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Choc Frontal' AND attackCost = 'PlantePlanteIncolore' AND attackDamage = '80'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/en/bw/bw6/24/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Sharp Fang' AND attackCost = 'WaterColorlessColorless' AND attackDamage = '60'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/en/bw/bw6/24/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Swing Around' AND attackCost = 'WaterColorlessColorlessColorless' AND attackDamage = '60'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/fr/bw/bw10/67/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Attachement Profond' AND attackCost = 'Incolore' AND attackDamage = null))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/fr/bw/bw10/67/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Dracogriffe' AND attackCost = 'CombatMétal' AND attackDamage = '20'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/en/bw/bw4/61/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Psy Bolt' AND attackCost = 'Psychic' AND attackDamage = '10'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/fr/bw/bw8/59/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Choc Mental' AND attackCost = 'Incolore' AND attackDamage = null))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/en/bw/bw11/54/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'X Ball' AND attackCost = 'ColorlessColorless' AND attackDamage = '20'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/en/bw/bw11/54/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Psydrive' AND attackCost = 'PsychicPsychicColorless' AND attackDamage = '120'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/fr/bw/bw6/82/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Lignes Magnétiques' AND attackCost = 'IncoloreIncolore' AND attackDamage = '30'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/fr/bw/bw6/82/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Pif Paf' AND attackCost = 'MétalIncoloreIncolore' AND attackDamage = '60'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/en/bw/bw9/74/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Cut Down' AND attackCost = 'ColorlessColorless' AND attackDamage = '30'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/en/bw/bw9/74/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Slicing Blade' AND attackCost = 'DarknessColorlessColorless' AND attackDamage = '70'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/fr/bw/bw10/37/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Piqûre Psy' AND attackCost = 'PsyIncoloreIncolore' AND attackDamage = '30'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/en/bw/bw6/34/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Bubble' AND attackCost = 'Water' AND attackDamage = '10'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/fr/bw/bw9/63/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Bluff' AND attackCost = 'CombatIncolore' AND attackDamage = '30'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/fr/bw/bw9/63/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Lancer Tournant' AND attackCost = 'CombatCombatIncolore' AND attackDamage = '90'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/en/bw/bw1/58/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Pound' AND attackCost = 'FightingFighting' AND attackDamage = '30'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/fr/bw/bw4/9/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Botte Secrète' AND attackCost = 'PlanteIncolore' AND attackDamage = '20'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/en/bw/bw9/8/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'X-Scissor' AND attackCost = 'GrassColorless' AND attackDamage = '30'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/en/bw/bw9/8/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Energy Bloom' AND attackCost = 'GrassGrassColorless' AND attackDamage = '80'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/fr/bw/bw7/38/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Cadeau' AND attackCost = 'Incolore' AND attackDamage = null))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/fr/bw/bw7/38/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Vent Glace' AND attackCost = 'EauIncolore' AND attackDamage = '30'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/en/bw/bw3/34/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Outrage' AND attackCost = 'ColorlessColorless' AND attackDamage = '20'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/en/bw/bw3/34/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Glaciate' AND attackCost = 'WaterWaterColorless' AND attackDamage = null))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/fr/bw/bwp/BW35/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Tit''sieste' AND attackCost = 'Incolore' AND attackDamage = 'n/a'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/fr/bw/bwp/BW35/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Saut' AND attackCost = 'IncoloreIncolore' AND attackDamage = '20'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/en/bw/bw6/92/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Shred' AND attackCost = 'GrassPsychicColorless' AND attackDamage = '90'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/en/bw/bw6/92/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Dragon Pulse' AND attackCost = 'GrassPsychicColorlessColorless' AND attackDamage = '130'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/fr/bw/dv1/2/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Regard Hypnotique' AND attackCost = 'Plante' AND attackDamage = null))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/fr/bw/dv1/2/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Queue Battoir' AND attackCost = 'Électrique' AND attackDamage = '10'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/en/bw/bw5/2/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Sleep Powder' AND attackCost = 'GrassColorless' AND attackDamage = '20'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/en/bw/bw5/2/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Poison Powder' AND attackCost = 'GrassGrassColorless' AND attackDamage = '50'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/fr/bw/bw3/19/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Flammèche' AND attackCost = 'Feu' AND attackDamage = '20'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/en/bw/bw7/18/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Draw In' AND attackCost = 'Fire' AND attackDamage = null))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/en/bw/bw7/18/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Flare' AND attackCost = 'FireColorless' AND attackDamage = '20'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/en/bw/bw1/22/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Flame Burst' AND attackCost = 'Fire' AND attackDamage = '20'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/en/bw/bw1/22/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Fury Swipes' AND attackCost = 'ColorlessColorlessColorless' AND attackDamage = '40'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/fr/bw/bw10/47/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Balayage' AND attackCost = 'CombatIncolore' AND attackDamage = '30'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/en/bw/bw2/43/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Hypnotic Gaze' AND attackCost = 'Colorless' AND attackDamage = null))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/en/bw/bw2/43/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Double Slap' AND attackCost = 'ColorlessColorless' AND attackDamage = '20'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/fr/bw/bw6/40/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Électrojectile' AND attackCost = 'ÉlectriqueIncoloreIncolore' AND attackDamage = '70'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/en/bw/bw3/36/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Quick Attack' AND attackCost = 'Colorless' AND attackDamage = '10'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/en/bw/bw3/36/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Shock Bolt' AND attackCost = 'LightningLightningColorless' AND attackDamage = '90'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/fr/bw/bw9/62/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Gifles Sans Fin' AND attackCost = 'CombatIncolore' AND attackDamage = '20'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/fr/bw/bw9/62/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Enfoncer' AND attackCost = 'CombatCombatIncolore' AND attackDamage = '60'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/en/bw/bw7/57/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Flame Charge' AND attackCost = 'Colorless' AND attackDamage = null))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/en/bw/bw7/57/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Thunder' AND attackCost = 'LightningColorlessColorless' AND attackDamage = '90'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/fr/bw/bw10/19/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Tir de Précision' AND attackCost = 'Eau' AND attackDamage = null))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/fr/bw/bw10/19/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Bulles d''O' AND attackCost = 'EauEau' AND attackDamage = '40'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/en/bw/bw5/18/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Flame Cloak' AND attackCost = 'Colorless' AND attackDamage = '10'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/en/bw/bw5/18/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Heat Blast' AND attackCost = 'FireColorlessColorless' AND attackDamage = '60'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/fr/bw/bwp/BW80/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Provoc' AND attackCost = 'Incolore' AND attackDamage = null))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/fr/bw/bwp/BW80/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Griffoboost' AND attackCost = 'FeuEauIncolore' AND attackDamage = '60'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/en/bw/bw6/128/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Dragon Pulse' AND attackCost = 'Lightning' AND attackDamage = '40'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/en/bw/bw6/128/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Shred' AND attackCost = 'FireLightningColorless' AND attackDamage = '90'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/fr/bw/bw2/34/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Ronge' AND attackCost = 'Incolore' AND attackDamage = '20'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/fr/bw/bw2/34/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Para-Dard' AND attackCost = 'ÉlectriqueIncolore' AND attackDamage = '30'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/en/bw/bw6/31/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Aurora Beam' AND attackCost = 'WaterColorlessColorless' AND attackDamage = '80'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/en/bw/bw6/31/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Ice Entomb' AND attackCost = 'WaterWaterColorlessColorless' AND attackDamage = '60'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/fr/bw/bw8/40/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Grêle' AND attackCost = 'Eau' AND attackDamage = null))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/fr/bw/bw8/40/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Verglas' AND attackCost = 'IncoloreIncoloreIncolore' AND attackDamage = '30'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/en/bw/bw5/37/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Electrigun' AND attackCost = 'Colorless' AND attackDamage = '20'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/en/bw/bw5/37/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Pin Missile' AND attackCost = 'LightningColorlessColorless' AND attackDamage = '40'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/fr/bw/dv1/6/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Coup d''Boule' AND attackCost = 'Incolore' AND attackDamage = '10'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/fr/bw/dv1/6/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Dracogriffe' AND attackCost = 'FeuEau' AND attackDamage = '20'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/en/bw/bw9/5/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Blockade' AND attackCost = 'Colorless' AND attackDamage = '10'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/en/bw/bw9/5/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Stomp' AND attackCost = 'GrassColorlessColorless' AND attackDamage = '60'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/fr/bw/bw3/83/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Voracité' AND attackCost = 'Métal' AND attackDamage = null))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/fr/bw/bw3/83/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Force Poigne' AND attackCost = 'IncoloreIncolore' AND attackDamage = '30'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/en/bw/bw1/76/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Gear Grind' AND attackCost = 'MetalColorlessColorless' AND attackDamage = '80'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/en/bw/bw11/91/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Energy Press' AND attackCost = 'MetalColorless' AND attackDamage = '20'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/en/bw/bw11/91/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Iron Breaker' AND attackCost = 'MetalMetalColorless' AND attackDamage = '80'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/en/bw/bw10/34/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Creepy Wind' AND attackCost = 'Psychic' AND attackDamage = null))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/en/bw/bw10/34/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Wind Blast' AND attackCost = 'ColorlessColorlessColorless' AND attackDamage = null))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/fr/bw/bw9/18/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Coup d''Aileron' AND attackCost = 'Eau' AND attackDamage = '10'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/en/bw/bw6/17/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Double Spin' AND attackCost = 'Colorless' AND attackDamage = '10'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/en/bw/bw11/106/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Clutch' AND attackCost = 'ColorlessColorlessColorless' AND attackDamage = '60'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/fr/bw/bw7/30/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Repli' AND attackCost = 'Incolore' AND attackDamage = null))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/fr/bw/bw7/30/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Cascade' AND attackCost = 'EauEauIncolore' AND attackDamage = '60'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/en/bw/bw2/27/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Wing Dance' AND attackCost = 'ColorlessColorless' AND attackDamage = '30'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/en/bw/bw2/27/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Air Slash' AND attackCost = 'WaterColorlessColorless' AND attackDamage = '70'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/fr/bw/bw6/59/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Beigne Dés-évoluante' AND attackCost = 'PsyIncoloreIncolore' AND attackDamage = '60'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/fr/bw/bw6/59/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Spectro Maillet' AND attackCost = 'PsyPsyIncoloreIncolore' AND attackDamage = '90'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/en/bw/bw8/53/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Wing Attack' AND attackCost = 'PsychicColorless' AND attackDamage = '20'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/fr/bw/bw3/22/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Vibration' AND attackCost = 'Incolore' AND attackDamage = '10'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/fr/bw/bw3/22/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Tir de Boue' AND attackCost = 'EauIncolore' AND attackDamage = '20'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/en/bw/bw3/20/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Take Down' AND attackCost = 'ColorlessColorless' AND attackDamage = '30'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/fr/bw/bw6/57/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Verdict Fatal' AND attackCost = 'PsyIncolore' AND attackDamage = null))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/fr/bw/bw6/57/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Magie Noire' AND attackCost = 'PsyIncoloreIncolore' AND attackDamage = '40'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/en/bw/bw7/52/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Static Shock' AND attackCost = 'Colorless' AND attackDamage = '20'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/en/bw/bw7/52/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Electro Ball' AND attackCost = 'LightningColorlessColorless' AND attackDamage = '60'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/en/bw/bw8/105/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Shout' AND attackCost = 'Colorless' AND attackDamage = null))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/en/bw/bw8/105/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Hyper Voice' AND attackCost = 'ColorlessColorlessColorless' AND attackDamage = '30'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/fr/bw/bw4/58/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Collision' AND attackCost = 'IncoloreIncolore' AND attackDamage = '20'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/en/bw/bw5/53/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Wing Attack' AND attackCost = 'ColorlessColorlessColorless' AND attackDamage = '40'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/fr/bw/bw3/78/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Coup Double' AND attackCost = 'Incolore' AND attackDamage = '20'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/fr/bw/bw3/78/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Force' AND attackCost = 'ObscuritéIncoloreIncolore' AND attackDamage = '50'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/en/bw/bw11/71/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Double Slap' AND attackCost = 'Colorless' AND attackDamage = '20'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/en/bw/bw11/71/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Psybeam' AND attackCost = 'PsychicColorless' AND attackDamage = '20'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/en/bw/bw5/1/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Tackle' AND attackCost = 'Grass' AND attackDamage = '10'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/en/bw/bw5/1/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Razor Leaf' AND attackCost = 'GrassColorlessColorless' AND attackDamage = '30'))