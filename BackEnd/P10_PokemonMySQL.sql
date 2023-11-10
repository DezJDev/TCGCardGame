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
	('Peau Dure','Si ce Pokémon est votre Pokémon Actif et qu’il subit les dégâts d’une attaque de votre adversaire (même si ce Pokémon est mis K.O.), placez 2 marqueurs de dégâts sur le Pokémon Attaquant.'),
	('Free Flight','If this Pokémon has no Energy attached to it, this Pokémon has no Retreat Cost.'),
	('Aura de Ténèbres','Toutes les Énergies attachées à ce Pokémon sont des Énergies Darkness au lieu de leur type habituel.'),
	('Dark Shade','Each of your Team Plasma Pokémon in play gets +20 HP.'),
	('Ancient Power','Each player can’t play any Pokémon from his or her hand to evolve his or her Pokémon.'),
	('Dark Cloak','Each of your Pokémon that has any Darkness Energy attached to it has no Retreat Cost.'),
	('Appel Préhistorique','Une seule fois pendant votre tour (avant votre attaque), si ce Pokémon est dans votre pile de défausse, vous pouvez placer ce Pokémon en dessous de votre deck.'),
	('Viscosité','Le coût de Retraite de chacun des Pokémon de votre adversaire est augmenté de Colorless.'),
	('Voile Lumineux','Tant que ce Pokémon est votre Pokémon Actif, chaque fois que votre adversaire joue une carte Objet de sa main, évitez tous les effets que la carte Objet peut infliger à vos Pokémon.'),
	('Grande Aile','Une seule fois pendant votre tour (avant votre attaque), si ce Pokémon est votre Pokémon Actif, vous pouvez demander à votre adversaire d’échanger son Pokémon Actif avec 1 de ses Pokémon de Banc.'),
	('Zone de Gel','Le coût de Retraite de chacun de vos Pokémon de la Team Plasma en jeu est diminué de ColorlessColorless.'),
	('Sentinelle','Tant que ce Pokémon est votre Pokémon Actif, votre adversaire ne peut pas jouer de cartes Supporter de sa main.'),
	('Inferno Fandango','As often as you like during your turn (before your attack), you may attach a Fire Energy card from your hand to 1 of your Pokémon.'),
	('Cœur Noble','Chaque attaque de ce Pokémon inflige 50 dégâts supplémentaires aux Pokémon Darkness (avant application de la Faiblesse et de la Résistance).'),
	('Damage Swap','As often as you like during your turn (before your attack), you may move 1 damage counter from 1 of your Pokémon to another of your Pokémon.'),
	('Inondation','Si le Pokémon de votre adversaire est mis K.O. par les dégâts d''une attaque de ce Pokémon, récupérez 1 carte Récompense supplémentaire.');

INSERT INTO P10_Attack(attackName,attackCost,attackDamage,attackEffect) VALUES 
	('Serre','IncoloreIncoloreIncolore','60','Le Pokémon Défenseur ne peut pas battre en retraite pendant le prochain tour de votre adversaire.'),
	('Nerve Shot','Fighting','30','Flip a coin. If heads, the Defending Pokémon is now Paralyzed.'),
	('Beigne Dés-évoluante','PsyIncoloreIncolore','60','Faites dés-évoluer le Pokémon Défenseur et mettez sa carte Évolution de plus haut Niveau dans la main de votre adversaire.'),
	('Wing Attack','PsychicColorless','20',null),
	('Lame Folle','ObscuritéObscuritéObscuritéObscurité','60','Inflige 40 dégâts à 2 des Pokémon de Banc de votre adversaire. (N''appliquez ni la Faiblesse ni la Résistance aux Pokémon de Banc.)'),
	('Ultralaser','IncoloreIncolore','30','Lancez une pièce. Si c''est face, défaussez une Énergie attachée au Pokémon Défenseur.'),
	('Coup de Piston','Obscurité','30','Déplacez une Énergie attachée au Pokémon Défenseur vers 1 des Pokémon de Banc de votre adversaire.'),
	('Knock Off','DarknessColorless','20','Flip a coin. If heads, discard a random card from your opponent''s hand.'),
	('Charge','Feu','10',null),
	('Heat Boiler','FireColorlessColorless','60','If this Pokémon is affected by a Special Condition, this attack does 60 more damage.'),
	('Roule-Pierre','CombatIncolore','50','Les dégâts de cette attaque ne sont pas affectés par la Résistance.'),
	('Darkness Fang','DarknessColorlessColorless','70',null),
	('Claque','IncoloreIncolore','20',null),
	('Smack Down','FightingColorless','20','If the Defending Pokémon has Fighting Resistance, this attack does 60 more damage.'),
	('Rock Slide','FightingFightingColorless','60','Does 10 damage to 2 of your opponent''s Benched Pokémon. (Don''t apply Weakness and Resistance for Benched Pokémon.)'),
	('Combo-Griffe','IncoloreIncolore','10','Lancez 3 pièces. Cette attaque inflige 10 dégâts multipliés par le nombre de côtés face.'),
	('Gentle Slap','DarknessColorless','10','Flip a coin. If heads, this attack does 20 more damage.'),
	('Queue Étourdissante','Obscurité',null,'Lancez une pièce. Si c''est face, le Pokémon Défenseur est maintenant Confus.'),
	('Metal Sound','Colorless',null,'The Defending Pokémon is now Confused.'),
	('Anti-Flammes','Eau',null,'Défaussez une Énergie Fire attachée au Pokémon Défenseur.'),
	('Withdraw','Colorless',null,'Flip a coin. If heads, prevent all damage done to this Pokémon by attacks during your opponent''s next turn.'),
	('Smash Turn','WaterColorless','30','You may switch this Pokémon with 1 of your Benched Pokémon.'),
	('Appât Lumineux','Incolore',null,'Échangez le Pokémon Défenseur avec 1 des Pokémon de Banc de votre adversaire.'),
	('Tromp','FightingColorless','20','Does 10 damage to each of your opponent''s Benched Pokémon. (Don''t apply Weakness and Resistance for Benched Pokémon.)'),
	('Appel à la Famille','Incolore',null,'Cherchez 2 Pokémon de base dans votre deck et placez-les sur votre Banc. Mélangez ensuite votre deck.'),
	('Tangle Drag','Colorless',null,'Switch 1 of your opponent''s Benched Pokémon with the Defending Pokémon.'),
	('Bec Enragé','Incolore','30','Lancez 3 pièces. Cette attaque inflige 30 dégâts multipliés par le nombre de côtés face. Ce Pokémon est maintenant Confus.'),
	('Round','ColorlessColorless','20','Does 20 damage times the number of your Pokémon that have the Round attack.'),
	('Rendez-vous Mineur','Incolore',null,'Cherchez 2 cartes Énergie de base dans votre deck, montrez-les, puis ajoutez-les à votre main. Mélangez ensuite votre deck.'),
	('Gnaw','Colorless','20',null),
	('Night Spear','DarknessDarknessColorless','90','Does 30 damage to 1 of your opponent''s Benched Pokémon. (Don''t apply Weakness and Resistance for Benched Pokémon.)'),
	('Rage Massive','EauIncolore','20','Inflige 20 dégâts multipliés par le nombre de marqueurs de dégâts placés sur ce Pokémon.'),
	('Present','Colorless',null,'Flip a coin. If heads, search your deck for a card and put it into your hand. Shuffle your deck afterward.'),
	('Souplesse','EauIncoloreIncolore','30','Lancez 2 pièces. Cette attaque inflige 30 dégâts multipliés par le nombre de côtés face.'),
	('Muddy Water','Colorless','20','Does 20 damage to 1 of your opponent''s Benched Pokémon. (Don''t apply Weakness and Resistance for Benched Pokémon.)'),
	('Lumière Étrange','EauIncoloreIncolore','40','Lancez une pièce. Si c''est face, le Pokémon Défenseur est maintenant Confus.'),
	('Stomp','Colorless','10','Flip a coin. If heads, this attack does 10 more damage.'),
	('Méga-Sangsue','Plante','20','Soignez 20 dégâts infligés à ce Pokémon.'),
	('Body Slam','GrassGrass','20','Flip a coin. If heads, the Defending Pokémon is now Paralyzed.'),
	('Choc Mental','PsyIncolore','20','Lancez une pièce. Si c''est face, le Pokémon Défenseur est maintenant Paralysé.'),
	('Firefighting','Water',null,'Discard a Fire Energy attached to the Defending Pokémon.'),
	('Vendetta','IncoloreIncolore','20','Si l’un de vos Pokémon a été mis K.O. par les dégâts d''une attaque de votre adversaire lors de son dernier tour, cette attaque inflige 70 dégâts supplémentaires.'),
	('Pouvoir Incendiaire','IncoloreIncolore','30','Si de l''Énergie Fire est attachée à ce Pokémon, le Pokémon Défenseur est maintenant Brûlé.'),
	('Bullet Seed','Grass','10','Flip 4 coins. This attack does 10 damage times the number of heads.'),
	('Retour','Incolore','30','Piochez des cartes jusqu''à ce que vous ayez 6 cartes en main.'),
	('Synthesis','Grass',null,'Search your deck for a Grass Energy card and attach it to 1 of your Pokémon. Shuffle your deck afterward.'),
	('Tranchant Sauvage','IncoloreIncoloreIncolore','60','Vous pouvez infliger 20 dégâts supplémentaires. Dans ce cas, ce Pokémon s''inflige 20 dégâts.'),
	('Laser Glace','EauIncolore','20','Lancez une pièce. Si c''est face, le Pokémon Défenseur est maintenant Paralysé.'),
	('Tackle','Colorless','10',null),
	('Bâillement','Incolore',null,'Le Pokémon Défenseur est maintenant Endormi.'),
	('Vent Glace','EauIncoloreIncolore','60','Le Pokémon Défenseur est maintenant Endormi.'),
	('Fiery Dance','Fire','30','Attach a basic Energy card from your discard pile to 1 of your Pokémon.'),
	('Rouleau Compresseur','MétalIncolore','40','Inflige 20 dégâts à 1 des Pokémon de Banc de votre adversaire. (N''appliquez ni la Faiblesse ni la Résistance aux Pokémon de Banc.)'),
	('Smash Kick','Colorless','10',null),
	('Picpic','Incolore','10',null),
	('Guard Press','ColorlessColorless','20','During your opponent''s next turn, any damage done to this Pokémon by attacks is reduced by 20 (after applying Weakness and Resistance).'),
	('Tacle Brutal','IncoloreIncoloreIncolore','90','Lancez une pièce. Si c''est pile, ce Pokémon s''inflige 20 dégâts.'),
	('Yawn','Colorless',null,'The Defending Pokémon is now Asleep.'),
	('Écras''Face','IncoloreIncolore','20',null),
	('Bubble','Colorless',null,'Flip a coin. If heads, the Defending Pokémon is now Paralyzed.'),
	('Chaîne de Glace','Eau',null,'Échangez le Pokémon Défenseur avec 1 des Pokémon de Banc de votre adversaire.'),
	('Bite','Colorless','10',null),
	('Bone Lock','Fighting','30','The Defending Pokémon can''t retreat during your opponent''s next turn.'),
	('Heat Crash','FireFireColorlessColorless','80',null),
	('Griffe','Incolore','10',null),
	('Leaf Blade','GrassColorless','10','Flip a coin. If heads, this attack does 30 more damage.'),
	('Charge Destructrice','FeuIncolore','20','Lancez une pièce jusqu''à ce que vous obteniez un côté pile. Cette attaque inflige 20 dégâts multipliés par le nombre de côtés face.'),
	('Knock Away','Colorless','10','Flip a coin. If heads, this attack does 20 more damage.'),
	('Tête de Fer','MétalMétalIncolore','60','Lancez une pièce jusqu''à ce que vous obteniez un côté pile. Cette attaque inflige 20 dégâts supplémentaires pour chaque côté face.'),
	('Psywave','PsychicPsychicPsychic','30','Does 10 more damage for each Energy attached to the Defending Pokémon.'),
	('Roussi','Feu',null,'Le Pokémon Défenseur est maintenant Brûlé.'),
	('Loud Howl','Colorless',null,'Your opponent switches the Defending Pokémon with 1 of his or her Benched Pokémon.'),
	('Fouets Croisés','Plante','30','Lancez 4 pièces. Cette attaque inflige 30 dégâts multipliés par le nombre de côtés face.'),
	('Lunge','FightingMetal','30','Flip a coin. If tails, this attack does nothing.'),
	('Signes d''Évolution','Incolore',null,'Cherchez dans votre deck 3 Pokémon de différents types qui sont une évolution d''Évoli. Montrez-les puis ajoutez-les à votre main. Mélangez ensuite votre deck.'),
	('Giga Power','ColorlessColorlessColorless','60','You may do 20 more damage. If you do, this Pokémon does 20 damage to itself.'),
	('Tête de Roc','Obscurité','20','Pendant le prochain tour de votre adversaire, tous les dégâts infligés à ce Pokémon par des attaques sont réduits de 20 (après application de la Faiblesse et de la Résistance).'),
	('Strong Bond','Colorless',null,'Search your deck for a Supporter card named Iris, reveal it, and put it into your hand. Shuffle your deck afterward.'),
	('Dragon Pulse','Lightning','40','Discard the top 2 cards of your deck.'),
	('Éclat Plasma','IncoloreIncoloreIncoloreIncolore','120','Défaussez une Énergie Plasma attachée à ce Pokémon. Si vous ne pouvez pas défausser une Énergie Plasma, cette attaque ne fait rien.');

INSERT INTO P10_Attack(attackName,attackCost,attackDamage,attackEffect) VALUES 
	('Pandemonium Blade','FightingColorlessColorless','60','Does 20 more damage for each of your Benched Pokémon that has any damage counters on it.'),
	('Spectro Maillet','PsyPsyIncoloreIncolore','90','Pendant le prochain tour de votre adversaire, ce Pokémon n''a pas de Faiblesse.'),
	('Bazooka Infernal','PlantePlanteIncolore','100','Défaussez toutes les Énergies Grass attachées à ce Pokémon.'),
	('Enfoncer','ObscuritéIncoloreIncolore','80',null),
	('Roulade','FeuIncolore','20',null),
	('Dynamite Press','FireFireColorlessColorless','80','If this Pokémon has any Plasma Energy attached to it, this attack does 10 more damage for each damage counter on the Defending Pokémon.'),
	('Taurocharge','CombatCombatIncolore','90','Attachez 2 cartes Énergie de base de votre main à vos Pokémon de Banc, de la manière que vous voulez.'),
	('Psyko','PsyIncoloreIncolore','40','Inflige 10 dégâts supplémentaires pour chaque Énergie attachée au Pokémon Défenseur.'),
	('Power Gem','FightingFightingColorlessColorless','80',null),
	('Combo-Griffe','ObscuritéIncolore','10','Lancez 3 pièces. Cette attaque inflige 10 dégâts multipliés par le nombre de côtés face.'),
	('Guard Press','MetalMetalColorless','60','During your opponent''s next turn, any damage done to this Pokémon by attacks is reduced by 20 (after applying Weakness and Resistance).'),
	('Waterfall','WaterWaterColorless','60',null),
	('Dual Splash','WaterWaterColorless',null,'This attack does 50 damage to 2 of your opponent''s Pokémon. (Don''t apply Weakness and Resistance for Benched Pokémon.)'),
	('Feu Follet','PsyIncolore','30',null),
	('Giant Claw','FightingFightingColorless','80','If the Defending Pokémon already has 2 or more damage counters on it, this attack does 40 more damage.'),
	('Feuille Sangsue','PlantePlante','30','Lancez une pièce. Si c''est face, soignez 30 dégâts à ce Pokémon.'),
	('Spiral Drain','ColorlessColorless','20','Heal 20 damage from this Pokémon.'),
	('Bec Vrille','IncoloreIncoloreIncolore','60',null),
	('Hypnoblast','ColorlessColorlessColorless','60','Flip a coin. If heads, the Defending Pokémon is now Asleep.'),
	('Électro-Queue','Électrique','10','Lancez une pièce. Si c''est face, le Pokémon Défenseur est maintenant Paralysé.'),
	('Stun Needle','LightningColorless','30','Flip a coin. If heads, the Defending Pokémon is now Paralyzed.'),
	('Chute de Glacier','EauEauIncolore','90','Défaussez la carte du dessus du deck de votre adversaire.'),
	('Icy Wind','WaterColorless','30','The Defending Pokémon is now Asleep.'),
	('Dard-Nuée','PlantePlanteIncolore','20','Lancez 4 pièces. Cette attaque inflige 20 dégâts multipliés par le nombre de côtés face.'),
	('Peignée','IncoloreIncoloreIncoloreIncolore','80','Lancez une pièce. Si c’est pile, ce Pokémon s’inflige 20 dégâts.'),
	('Canon Graine','PlanteIncoloreIncolore','60',null),
	('Revenge Blast','GrassColorless','30','Does 30 more damage for each Prize card your opponent has taken.'),
	('Quintuple Coup d''Boule','EauEauIncoloreIncolore','40','Lancez 5 pièces. Cette attaque inflige 40 dégâts multipliés par le nombre de côtés face.'),
	('Splatter','WaterColorless',null,'Does 30 damage to one of your oppoent''s Pokémon. (Don''t apply Weakness and Resistance for Benched Pokémon.)'),
	('Heat Wave','FireColorlessColorless','60','The Defending Pokémon is now Burned.'),
	('Coup Déchirant','MétalIncoloreIncolore','80','Ce Pokémon ne peut pas utiliser Coup Déchirant pendant votre prochain tour.'),
	('Dragon Claw','FireFireWaterColorless','90',null),
	('Grosse Vague','EauEauIncoloreIncolore','60',null),
	('Spit Poison','WaterColorless',null,'The Defending Pokémon is now Poisoned.'),
	('Poudreuse d''Escampette','EauEau','40','Vous pouvez reprendre ce Pokémon et toutes les cartes qui lui sont attachées dans votre main.'),
	('Bared Fangs','Water','40','If, before this Pokémon does damage, the Defending Pokémon has no damage counters on it, this attack does nothing.'),
	('Explonuit','ObscuritéIncoloreIncolore','80',null),
	('Vortex Chop','FightingColorlessColorless','60','If the Defending Pokémon has any Resistance, this attack does 30 more damage.'),
	('Fouet Lianes','PlanteIncoloreIncolore','30',null),
	('Flammes de Glace','FeuEauIncoloreIncolore','80','Lancez une pièce. Si c''est face, cette attaque inflige 40 dégâts supplémentaires.'),
	('Coupe','PlanteIncolore','30',null),
	('Rollout','FireWaterColorless','50',null),
	('Fire Tail Slap','FireColorless','50','Discard an Energy attached to this Pokémon.'),
	('Point Poison','PlanteIncoloreIncolore','60','Le Pokémon Défenseur est maintenant Empoisonné.'),
	('Morsure','IncoloreIncoloreIncolore','30',null),
	('Raging Hammer','ColorlessColorlessColorlessColorless','50','Does 10 more damage for each damage counter on this Pokémon.'),
	('Marto-Pied','ObscuritéIncoloreIncolore','50','S''il reste moins de PV à ce Pokémon qu''au Pokémon Défenseur, cette attaque inflige 30 dégâts supplémentaires.'),
	('Shred','FireLightningColorless','90','This attack''s damage isn''t affected by any effects on the Defending Pokémon.');

INSERT INTO P10_Resistance(resistanceType,resistanceValue) VALUES 
	('Fighting','-20'),
	('Psy','-20'),
	('Psychic','-20'),
	('Lightning','-20'),
	('Combat','-20'),
	('Eau','-20'),
	('Water','-20');

INSERT INTO P10_Weakness(weaknessType,weaknessValue) VALUES 
	('Psychic','×2'),
	('Obscurité','×2'),
	('Lightning','×2'),
	('Combat','×2'),
	('Feu','×2'),
	('Fighting','×2'),
	('Eau','×2'),
	('Water','×2'),
	('Plante','×2'),
	('Psy','×2'),
	('Grass','×2'),
	('Fire','×2'),
	('Électrique','×2'),
	('Métal','×2'),
	('Metal','×2'),
	('Dragon','×2');

INSERT INTO P10_Card(cardCategory,cardName,cardHP,cardRarity,cardImg,cardType,cardExtensioncardRetreat,cardLang,abilityId,resistanceId,weaknessId) VALUES
	('Pokémon','Drakkarmin','100','Rare','https://assets.tcgdex.net/fr/bw/bw3/89/high.webp','Incolore','Nobles Victoires',2,'fr',(SELECT abilityId FROM P10_Ability WHERE abilityName = 'Peau Dure' AND abilityEffect = 'Si ce Pokémon est votre Pokémon Actif et qu’il subit les dégâts d’une attaque de votre adversaire (même si ce Pokémon est mis K.O.), placez 2 marqueurs de dégâts sur le Pokémon Attaquant.'),null,null),
	('Pokemon','Gallade','140','Rare','https://assets.tcgdex.net/en/bw/bw11/81/high.webp','Fighting','Legendary Treasures',2,'en',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Psychic' AND weaknessValue = '×2'),null),
	('Pokémon','Golemastoc','130','Rare','https://assets.tcgdex.net/fr/bw/bw6/59/high.webp','Psy','Dragons Éxaltés',4,'fr',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Obscurité' AND weaknessValue = '×2'),null),
	('Pokemon','Zubat','40','Common','https://assets.tcgdex.net/en/bw/bw8/53/high.webp','Psychic','Plasma Storm',1,'en',(SELECT abilityId FROM P10_Ability WHERE abilityName = 'Free Flight' AND abilityEffect = 'If this Pokémon has no Energy attached to it, this Pokémon has no Retreat Cost.'),(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Lightning' AND weaknessValue = '×2'),(SELECT resistanceId FROM P10_Resistance WHERE resistanceType = 'Fighting' AND resistanceValue = '-20')),
	('Pokémon','Trioxhydre','150','Magnifique rare','https://assets.tcgdex.net/fr/bw/bw4/103/high.webp','Obscurité','Destinées Futures',3,'fr',(SELECT abilityId FROM P10_Ability WHERE abilityName = 'Aura de Ténèbres' AND abilityEffect = 'Toutes les Énergies attachées à ce Pokémon sont des Énergies Darkness au lieu de leur type habituel.'),(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Combat' AND weaknessValue = '×2'),(SELECT resistanceId FROM P10_Resistance WHERE resistanceType = 'Psy' AND resistanceValue = '-20')),
	('Trainer','Plume Fossil',null,'Uncommon','https://assets.tcgdex.net/en/bw/bw3/93/high.webp',null,'Noble Victories',null,'en',null,null,null),
	('Pokémon','Genesect','110','Commune','https://assets.tcgdex.net/fr/bw/bwp/BW101/high.webp','Plante','Promo BW',2,'fr',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Feu' AND weaknessValue = '×2'),null),
	('Energy','Metal Energy',null,'Common','https://assets.tcgdex.net/en/bw/bw1/112/high.webp',null,'Black & White',null,'en',null,null,null),
	('Pokémon','Crocorible','140','Rare','https://assets.tcgdex.net/fr/bw/bw9/70/high.webp','Obscurité','Glaciation Plasma',3,'fr',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Combat' AND weaknessValue = '×2'),(SELECT resistanceId FROM P10_Resistance WHERE resistanceType = 'Psy' AND resistanceValue = '-20')),
	('Pokemon','Purrloin','60','Common','https://assets.tcgdex.net/en/bw/bw2/64/high.webp','Darkness','Emerging Powers',1,'en',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Fighting' AND weaknessValue = '×2'),(SELECT resistanceId FROM P10_Resistance WHERE resistanceType = 'Psychic' AND resistanceValue = '-20')),
	('Pokémon','Gruikui','60','Commune','https://assets.tcgdex.net/fr/bw/bw1/15/high.webp','Feu','Noir & Blanc',1,'fr',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Eau' AND weaknessValue = '×2'),null),
	('Pokemon','Heatran-EX','180','Rare','https://assets.tcgdex.net/en/bw/bw9/13/high.webp','Fire','Plasma Freeze',3,'en',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Water' AND weaknessValue = '×2'),null),
	('Pokémon','Terrakium-EX','180','Rare','https://assets.tcgdex.net/fr/bw/bw6/71/high.webp','Combat','Dragons Éxaltés',3,'fr',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Plante' AND weaknessValue = '×2'),null),
	('Pokemon','Umbreon','100','Rare','https://assets.tcgdex.net/en/bw/bw9/64/high.webp','Darkness','Plasma Freeze',1,'en',(SELECT abilityId FROM P10_Ability WHERE abilityName = 'Dark Shade' AND abilityEffect = 'Each of your Team Plasma Pokémon in play gets +20 HP.'),(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Fighting' AND weaknessValue = '×2'),(SELECT resistanceId FROM P10_Resistance WHERE resistanceType = 'Psychic' AND resistanceValue = '-20')),
	('Pokémon','Kirlia','80','Peu Commune','https://assets.tcgdex.net/fr/bw/bw4/56/high.webp','Psy','Destinées Futures',1,'fr',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Psy' AND weaknessValue = '×2'),null),
	('Pokemon','Boldore','90','Uncommon','https://assets.tcgdex.net/en/bw/bw2/51/high.webp','Fighting','Emerging Powers',3,'en',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Grass' AND weaknessValue = '×2'),null),
	('Dresseur','Casque Brut',null,'Magnifique rare','https://assets.tcgdex.net/fr/bw/bw7/153/high.webp',null,'Frontières Franchies',null,'fr',(SELECT abilityId FROM P10_Ability WHERE abilityEffect = 'Si le Pokémon auquel cette carte est attachée est votre Pokémon Actif et qu''il subit les dégâts d''une attaque de votre adversaire (même si le Pokémon est mis K.O.), placez 2 marqueurs de dégâts sur le Pokémon Attaquant.'),null,null),
	('Pokemon','Archeops','130','Secret Rare','https://assets.tcgdex.net/en/bw/bw5/110/high.webp','Fighting','Dark Explorers',2,'en',(SELECT abilityId FROM P10_Ability WHERE abilityName = 'Ancient Power' AND abilityEffect = 'Each player can’t play any Pokémon from his or her hand to evolve his or her Pokémon.'),(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Grass' AND weaknessValue = '×2'),null),
	('Dresseur','Recherche Informatique',null,'Rare','https://assets.tcgdex.net/fr/bw/bw7/137/high.webp',null,'Frontières Franchies',null,'fr',(SELECT abilityId FROM P10_Ability WHERE abilityEffect = 'Défaussez 2 cartes de votre main. (Si vous ne pouvez pas défausser 2 cartes, vous ne pouvez pas jouer cette carte.) Cherchez une carte dans votre deck puis ajoutez-la à votre main. Mélangez ensuite votre deck.'),null,null),
	('Trainer','Life Dew',null,'Rare','https://assets.tcgdex.net/en/bw/bw9/107/high.webp',null,'Plasma Freeze',null,'en',null,null,null),
	('Pokémon','Teddiursa','70','Commune','https://assets.tcgdex.net/fr/bw/bw10/75/high.webp','Incolore','Explosion Plasma',2,'fr',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Combat' AND weaknessValue = '×2'),null),
	('Pokemon','Sandile','70','Common','https://assets.tcgdex.net/en/bw/bw9/68/high.webp','Darkness','Plasma Freeze',2,'en',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Fighting' AND weaknessValue = '×2'),(SELECT resistanceId FROM P10_Resistance WHERE resistanceType = 'Psychic' AND resistanceValue = '-20')),
	('Pokémon','Chacripan','50','Commune','https://assets.tcgdex.net/fr/bw/bw8/82/high.webp','Obscurité','Tempète Plasma',1,'fr',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Combat' AND weaknessValue = '×2'),(SELECT resistanceId FROM P10_Resistance WHERE resistanceType = 'Psy' AND resistanceValue = '-20')),
	('Pokemon','Klang','80','Uncommon','https://assets.tcgdex.net/en/bw/bw2/75/high.webp','Metal','Emerging Powers',1,'en',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Fire' AND weaknessValue = '×2'),(SELECT resistanceId FROM P10_Resistance WHERE resistanceType = 'Psychic' AND resistanceValue = '-20')),
	('Pokémon','Psykokwak','70','Commune','https://assets.tcgdex.net/fr/bw/bw7/33/high.webp','Eau','Frontières Franchies',3,'fr',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Électrique' AND weaknessValue = '×2'),null),
	('Pokemon','Wartortle','80','Uncommon','https://assets.tcgdex.net/en/bw/bw7/30/high.webp','Water','Boundaries Crossed',2,'en',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Grass' AND weaknessValue = '×2'),null),
	('Dresseur','Sbire de la Team Plasma',null,'Peu Commune','https://assets.tcgdex.net/fr/bw/bw8/125/high.webp',null,'Tempète Plasma',null,'fr',(SELECT abilityId FROM P10_Ability WHERE abilityEffect = 'Défaussez une carte de la Team Plasma de votre main. (Si vous ne pouvez pas défausser une carte de la Team Plasma, vous ne pouvez pas jouer cette carte.) Piochez 4 cartes.'),null,null),
	('Pokemon','Kyogre-EX','170','Ultra Rare','https://assets.tcgdex.net/en/bw/bw5/104/high.webp','Water','Dark Explorers',4,'en',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Lightning' AND weaknessValue = '×2'),null),
	('Pokémon','Mélancolux','80','Peu Commune','https://assets.tcgdex.net/fr/bw/bw3/59/high.webp','Psy','Nobles Victoires',1,'fr',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Obscurité' AND weaknessValue = '×2'),null),
	('Pokemon','Groudon-EX','180','Rare','https://assets.tcgdex.net/en/bw/bw5/54/high.webp','Fighting','Dark Explorers',4,'en',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Water' AND weaknessValue = '×2'),(SELECT resistanceId FROM P10_Resistance WHERE resistanceType = 'Lightning' AND resistanceValue = '-20')),
	('Pokémon','Shaymin','70','Rare','https://assets.tcgdex.net/fr/bw/bw7/10/high.webp','Plante','Frontières Franchies',1,'fr',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Feu' AND weaknessValue = '×2'),null),
	('Pokemon','Cascoon','80','Uncommon','https://assets.tcgdex.net/en/bw/bw6/9/high.webp','Grass','Dragons Exalted',3,'en',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Fire' AND weaknessValue = '×2'),null),
	('Pokémon','Dodrio','90','Rare','https://assets.tcgdex.net/fr/bw/bw8/100/high.webp','Incolore','Tempète Plasma',1,'fr',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Électrique' AND weaknessValue = '×2'),(SELECT resistanceId FROM P10_Resistance WHERE resistanceType = 'Combat' AND resistanceValue = '-20')),
	('Trainer','Skyarrow Bridge',null,'Uncommon','https://assets.tcgdex.net/en/bw/bw4/91/high.webp',null,'Next Destinies',null,'en',null,null,null),
	('Dresseur','Multi Exp',null,'Peu Commune','https://assets.tcgdex.net/fr/bw/bw4/87/high.webp',null,'Destinées Futures',null,'fr',(SELECT abilityId FROM P10_Ability WHERE abilityEffect = 'Lorsque votre Pokémon Actif est mis K.O. par les dégâts d’une attaque de votre adversaire, vous pouvez déplacer 1 carte Énergie de base qui était attachée au Pokémon mis K.O. vers le Pokémon auquel cette carte est attachée.'),null,null),
	('Pokemon','Wigglytuff','90','Rare','https://assets.tcgdex.net/en/bw/bw4/79/high.webp','Colorless','Next Destinies',2,'en',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Fighting' AND weaknessValue = '×2'),null),
	('Pokémon','Pachirisu','70','Commune','https://assets.tcgdex.net/fr/bw/bw9/37/high.webp','Électrique','Glaciation Plasma',1,'fr',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Combat' AND weaknessValue = '×2'),null),
	('Pokemon','Galvantula','80','Uncommon','https://assets.tcgdex.net/en/bw/bw2/34/high.webp','Lightning','Emerging Powers',0,'en',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Fighting' AND weaknessValue = '×2'),null),
	('Dresseur','Nikolaï',null,'Ultra Rare','https://assets.tcgdex.net/fr/bw/bw8/135/high.webp',null,'Tempète Plasma',null,'fr',(SELECT abilityId FROM P10_Ability WHERE abilityEffect = 'Mélangez votre main avec votre deck. Ensuite, piochez un nombre de cartes égal au nombre de Pokémon de Banc (les vôtres et ceux de votre adversaire).'),null,null),
	('Pokemon','Darkrai-EX','180','Ultra Rare','https://assets.tcgdex.net/en/bw/bw5/107/high.webp','Darkness','Dark Explorers',2,'en',(SELECT abilityId FROM P10_Ability WHERE abilityName = 'Dark Cloak' AND abilityEffect = 'Each of your Pokémon that has any Darkness Energy attached to it has no Retreat Cost.'),(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Fighting' AND weaknessValue = '×2'),(SELECT resistanceId FROM P10_Resistance WHERE resistanceType = 'Psychic' AND resistanceValue = '-20')),
	('Pokémon','Polagriffe','130','Rare','https://assets.tcgdex.net/fr/bw/bw8/41/high.webp','Eau','Tempète Plasma',4,'fr',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Métal' AND weaknessValue = '×2'),null),
	('Pokemon','Delibird','80','Uncommon','https://assets.tcgdex.net/en/bw/bw7/38/high.webp','Water','Boundaries Crossed',1,'en',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Metal' AND weaknessValue = '×2'),null),
	('Pokémon','Carapagos','90','Peu Commune','https://assets.tcgdex.net/fr/bw/bw10/27/high.webp','Eau','Explosion Plasma',3,'fr',(SELECT abilityId FROM P10_Ability WHERE abilityName = 'Appel Préhistorique' AND abilityEffect = 'Une seule fois pendant votre tour (avant votre attaque), si ce Pokémon est dans votre pile de défausse, vous pouvez placer ce Pokémon en dessous de votre deck.'),(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Plante' AND weaknessValue = '×2'),null),
	('Pokemon','Vaporeon','110','Uncommon','https://assets.tcgdex.net/en/bw/bw5/25/high.webp','Water','Dark Explorers',2,'en',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Lightning' AND weaknessValue = '×2'),null),
	('Pokémon','Moyade','100','Rare','https://assets.tcgdex.net/fr/bw/bw7/45/high.webp','Eau','Frontières Franchies',3,'fr',(SELECT abilityId FROM P10_Ability WHERE abilityName = 'Viscosité' AND abilityEffect = 'Le coût de Retraite de chacun des Pokémon de votre adversaire est augmenté de Colorless.'),(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Électrique' AND weaknessValue = '×2'),null),
	('Pokemon','Blitzle','60','Common','https://assets.tcgdex.net/en/bw/bw1/41/high.webp','Lightning','Black & White',1,'en',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Fighting' AND weaknessValue = '×2'),null),
	('Pokémon','Maracachi','80','Peu Commune','https://assets.tcgdex.net/fr/bw/bw1/11/high.webp','Plante','Noir & Blanc',2,'fr',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Feu' AND weaknessValue = '×2'),(SELECT resistanceId FROM P10_Resistance WHERE resistanceType = 'Eau' AND resistanceValue = '-20')),
	('Pokemon','Shelmet','60','Common','https://assets.tcgdex.net/en/bw/bw5/10/high.webp','Grass','Dark Explorers',3,'en',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Fire' AND weaknessValue = '×2'),null),
	('Pokémon','Chovsourir','60','Commune','https://assets.tcgdex.net/fr/bw/bw2/36/high.webp','Psy','Pouvoirs Émergents',1,'fr',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Psy' AND weaknessValue = '×2'),null),
	('Pokemon','Psyduck','70','Common','https://assets.tcgdex.net/en/bw/bw7/33/high.webp','Water','Boundaries Crossed',3,'en',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Lightning' AND weaknessValue = '×2'),null),
	('Pokémon','Frison','100','Rare','https://assets.tcgdex.net/fr/bw/bw1/91/high.webp','Incolore','Noir & Blanc',2,'fr',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Combat' AND weaknessValue = '×2'),null),
	('Trainer','Plume Fossil',null,'Uncommon','https://assets.tcgdex.net/en/bw/bw10/82/high.webp',null,'Plasma Blast',null,'en',null,null,null),
	('Pokémon','Feuiloutan','90','Rare','https://assets.tcgdex.net/fr/bw/bw2/2/high.webp','Plante','Pouvoirs Émergents',2,'fr',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Feu' AND weaknessValue = '×2'),(SELECT resistanceId FROM P10_Resistance WHERE resistanceType = 'Eau' AND resistanceValue = '-20')),
	('Pokemon','Skiploom','60','Uncommon','https://assets.tcgdex.net/en/bw/bw6/2/high.webp','Grass','Dragons Exalted',0,'en',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Fire' AND weaknessValue = '×2'),(SELECT resistanceId FROM P10_Resistance WHERE resistanceType = 'Water' AND resistanceValue = '-20')),
	('Pokémon','Togekiss','140','Rare','https://assets.tcgdex.net/fr/bw/bw8/104/high.webp','Incolore','Tempète Plasma',1,'fr',(SELECT abilityId FROM P10_Ability WHERE abilityName = 'Voile Lumineux' AND abilityEffect = 'Tant que ce Pokémon est votre Pokémon Actif, chaque fois que votre adversaire joue une carte Objet de sa main, évitez tous les effets que la carte Objet peut infliger à vos Pokémon.'),(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Électrique' AND weaknessValue = '×2'),(SELECT resistanceId FROM P10_Resistance WHERE resistanceType = 'Combat' AND resistanceValue = '-20')),
	('Pokemon','Shaymin-EX','110','Ultra Rare','https://assets.tcgdex.net/en/bw/bw4/94/high.webp','Grass','Next Destinies',1,'en',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Fire' AND weaknessValue = '×2'),(SELECT resistanceId FROM P10_Resistance WHERE resistanceType = 'Fighting' AND resistanceValue = '-20')),
	('Pokémon','Gueriaigle','100','Rare','https://assets.tcgdex.net/fr/bw/bw8/116/high.webp','Incolore','Tempète Plasma',2,'fr',(SELECT abilityId FROM P10_Ability WHERE abilityName = 'Grande Aile' AND abilityEffect = 'Une seule fois pendant votre tour (avant votre attaque), si ce Pokémon est votre Pokémon Actif, vous pouvez demander à votre adversaire d’échanger son Pokémon Actif avec 1 de ses Pokémon de Banc.'),(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Électrique' AND weaknessValue = '×2'),(SELECT resistanceId FROM P10_Resistance WHERE resistanceType = 'Combat' AND resistanceValue = '-20')),
	('Trainer','Frozen City',null,'Uncommon','https://assets.tcgdex.net/en/bw/bw9/100/high.webp',null,'Plasma Freeze',null,'en',null,null,null),
	('Pokémon','Cochignon','100','Peu Commune','https://assets.tcgdex.net/fr/bw/bw8/27/high.webp','Eau','Tempète Plasma',3,'fr',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Métal' AND weaknessValue = '×2'),null),
	('Pokemon','Basculin','80','Uncommon','https://assets.tcgdex.net/en/bw/bw2/25/high.webp','Water','Emerging Powers',1,'en',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Lightning' AND weaknessValue = '×2'),null),
	('Pokémon','Togepi','40','Commune','https://assets.tcgdex.net/fr/bw/bw8/102/high.webp','Incolore','Tempète Plasma',1,'fr',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Combat' AND weaknessValue = '×2'),null),
	('Trainer','Dark Patch',null,'Uncommon','https://assets.tcgdex.net/en/bw/bw5/93/high.webp',null,'Dark Explorers',null,'en',null,null,null),
	('Pokémon','Givrali','90','Rare','https://assets.tcgdex.net/fr/bw/bw9/23/high.webp','Eau','Glaciation Plasma',2,'fr',(SELECT abilityId FROM P10_Ability WHERE abilityName = 'Zone de Gel' AND abilityEffect = 'Le coût de Retraite de chacun de vos Pokémon de la Team Plasma en jeu est diminué de ColorlessColorless.'),(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Métal' AND weaknessValue = '×2'),null),
	('Pokemon','Volcarona','110','Rare','https://assets.tcgdex.net/en/bw/bw3/21/high.webp','Fire','Noble Victories',1,'en',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Water' AND weaknessValue = '×2'),null),
	('Pokémon','Lançargot','100','Rare','https://assets.tcgdex.net/fr/bw/bw10/61/high.webp','Métal','Explosion Plasma',3,'fr',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Feu' AND weaknessValue = '×2'),(SELECT resistanceId FROM P10_Resistance WHERE resistanceType = 'Psy' AND resistanceValue = '-20')),
	('Pokemon','Blitzle','70','Common','https://assets.tcgdex.net/en/bw/bw7/56/high.webp','Lightning','Boundaries Crossed',1,'en',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Fighting' AND weaknessValue = '×2'),null),
	('Pokémon','Tylton','40','Commune','https://assets.tcgdex.net/fr/bw/bw6/105/high.webp','Incolore','Dragons Éxaltés',1,'fr',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Électrique' AND weaknessValue = '×2'),(SELECT resistanceId FROM P10_Resistance WHERE resistanceType = 'Combat' AND resistanceValue = '-20')),
	('Pokemon','Druddigon','110','Rare','https://assets.tcgdex.net/en/bw/bw8/94/high.webp','Dragon','Plasma Storm',1,'en',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Dragon' AND weaknessValue = '×2'),null),
	('Pokémon','Mastouffe','140','Rare','https://assets.tcgdex.net/fr/bw/bw7/122/high.webp','Incolore','Frontières Franchies',3,'fr',(SELECT abilityId FROM P10_Ability WHERE abilityName = 'Sentinelle' AND abilityEffect = 'Tant que ce Pokémon est votre Pokémon Actif, votre adversaire ne peut pas jouer de cartes Supporter de sa main.'),(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Combat' AND weaknessValue = '×2'),null),
	('Pokemon','Togepi','40','Common','https://assets.tcgdex.net/en/bw/bw8/102/high.webp','Colorless','Plasma Storm',1,'en',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Fighting' AND weaknessValue = '×2'),null),
	('Pokémon','Mamanbo','100','Peu Commune','https://assets.tcgdex.net/fr/bw/bw1/38/high.webp','Eau','Noir & Blanc',2,'fr',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Électrique' AND weaknessValue = '×2'),null),
	('Pokemon','Frillish','80','Uncommon','https://assets.tcgdex.net/en/bw/bw4/34/high.webp','Water','Next Destinies',2,'en',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Lightning' AND weaknessValue = '×2'),null),
	('Pokémon','Hexagel','80','Rare','https://assets.tcgdex.net/fr/bw/bw3/33/high.webp','Eau','Nobles Victoires',1,'fr',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Métal' AND weaknessValue = '×2'),null),
	('Pokemon','Basculin','80','Uncommon','https://assets.tcgdex.net/en/bw/bw4/30/high.webp','Water','Next Destinies',1,'en',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Lightning' AND weaknessValue = '×2'),null),
	('Pokémon','Zoroark','100','Rare','https://assets.tcgdex.net/fr/bw/bw2/67/high.webp','Obscurité','Pouvoirs Émergents',2,'fr',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Combat' AND weaknessValue = '×2'),(SELECT resistanceId FROM P10_Resistance WHERE resistanceType = 'Psy' AND resistanceValue = '-20')),
	('Pokemon','Marowak','100','Rare','https://assets.tcgdex.net/en/bw/bw6/61/high.webp','Fighting','Dragons Exalted',1,'en',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Water' AND weaknessValue = '×2'),(SELECT resistanceId FROM P10_Resistance WHERE resistanceType = 'Lightning' AND resistanceValue = '-20')),
	('Pokémon','Axoloto','70','Commune','https://assets.tcgdex.net/fr/bw/bw9/21/high.webp','Eau','Glaciation Plasma',2,'fr',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Plante' AND weaknessValue = '×2'),null),
	('Pokemon','Emboar','150','Rare','https://assets.tcgdex.net/en/bw/bw1/20/high.webp','Fire','Black & White',4,'en',(SELECT abilityId FROM P10_Ability WHERE abilityName = 'Inferno Fandango' AND abilityEffect = 'As often as you like during your turn (before your attack), you may attach a Fire Energy card from your hand to 1 of your Pokémon.'),(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Water' AND weaknessValue = '×2'),null),
	('Pokémon','Feuillajou','60','Commune','https://assets.tcgdex.net/fr/bw/bw1/7/high.webp','Plante','Noir & Blanc',1,'fr',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Feu' AND weaknessValue = '×2'),(SELECT resistanceId FROM P10_Resistance WHERE resistanceType = 'Eau' AND resistanceValue = '-20')),
	('Pokemon','Snivy','60','Common','https://assets.tcgdex.net/en/bw/bw11/6/high.webp','Grass','Legendary Treasures',1,'en',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Fire' AND weaknessValue = '×2'),(SELECT resistanceId FROM P10_Resistance WHERE resistanceType = 'Water' AND resistanceValue = '-20')),
	('Pokémon','Kyurem Blanc','130','Rare','https://assets.tcgdex.net/fr/bw/bw7/102/high.webp','Dragon','Frontières Franchies',2,'fr',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Dragon' AND weaknessValue = '×2'),null),
	('Energy','Double Colorless Energy',null,'Uncommon','https://assets.tcgdex.net/en/bw/bw4/92/high.webp',null,'Next Destinies',null,'en',null,null,null),
	('Pokémon','Massko','80','Peu Commune','https://assets.tcgdex.net/fr/bw/bw9/7/high.webp','Plante','Glaciation Plasma',1,'fr',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Feu' AND weaknessValue = '×2'),(SELECT resistanceId FROM P10_Resistance WHERE resistanceType = 'Eau' AND resistanceValue = '-20')),
	('Pokemon','Shelgon','80','Rare','/high.webp','Dragon','Dragon Vault',3,'en',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Dragon' AND weaknessValue = '×2'),null),
	('Pokémon','Cobaltium','120','Commune','https://assets.tcgdex.net/fr/bw/bwp/BW72/high.webp','Métal','Promo BW',3,'fr',(SELECT abilityId FROM P10_Ability WHERE abilityName = 'Cœur Noble' AND abilityEffect = 'Chaque attaque de ce Pokémon inflige 50 dégâts supplémentaires aux Pokémon Darkness (avant application de la Faiblesse et de la Résistance).'),(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Feu' AND weaknessValue = '×2'),(SELECT resistanceId FROM P10_Resistance WHERE resistanceType = 'Psy' AND resistanceValue = '-20')),
	('Pokemon','Reuniclus','90','Secret Rare','https://assets.tcgdex.net/en/bw/bw6/126/high.webp','Psychic','Dragons Exalted',2,'en',(SELECT abilityId FROM P10_Ability WHERE abilityName = 'Damage Swap' AND abilityEffect = 'As often as you like during your turn (before your attack), you may move 1 damage counter from 1 of your Pokémon to another of your Pokémon.'),(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Psychic' AND weaknessValue = '×2'),null),
	('Pokémon','Goupix','60','Commune','https://assets.tcgdex.net/fr/bw/bw6/18/high.webp','Feu','Dragons Éxaltés',1,'fr',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Eau' AND weaknessValue = '×2'),null),
	('Pokemon','Monferno','80','Uncommon','https://assets.tcgdex.net/en/bw/bw8/16/high.webp','Fire','Plasma Storm',1,'en',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Water' AND weaknessValue = '×2'),null),
	('Pokémon','Roserade','90','Peu Commune','https://assets.tcgdex.net/fr/bw/bw6/14/high.webp','Plante','Dragons Éxaltés',1,'fr',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Feu' AND weaknessValue = '×2'),(SELECT resistanceId FROM P10_Resistance WHERE resistanceType = 'Eau' AND resistanceValue = '-20')),
	('Pokemon','Axew','50','Rare','/high.webp','Dragon','Dragon Vault',1,'en',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Dragon' AND weaknessValue = '×2'),null),
	('Pokémon','Évoli','60','Commune','https://assets.tcgdex.net/fr/bw/bw9/90/high.webp','Incolore','Glaciation Plasma',1,'fr',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Combat' AND weaknessValue = '×2'),null),
	('Pokemon','Regigigas-EX','180','Rare','https://assets.tcgdex.net/en/bw/bw4/82/high.webp','Colorless','Next Destinies',4,'en',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Fighting' AND weaknessValue = '×2'),null),
	('Pokémon','Baggaïd','90','Rare','https://assets.tcgdex.net/fr/bw/bw4/74/high.webp','Obscurité','Destinées Futures',2,'fr',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Combat' AND weaknessValue = '×2'),(SELECT resistanceId FROM P10_Resistance WHERE resistanceType = 'Psy' AND resistanceValue = '-20')),
	('Pokemon','Axew','50','Common','https://assets.tcgdex.net/en/bw/bw10/67/high.webp','Dragon','Plasma Blast',1,'en',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Dragon' AND weaknessValue = '×2'),null),
	('Pokémon','Entei-EX','180','Ultra Rare','https://assets.tcgdex.net/fr/bw/bw5/103/high.webp','Feu','Explorateurs Obscurs',3,'fr',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Eau' AND weaknessValue = '×2'),null),
	('Pokemon','Rayquaza','120','Rare','https://assets.tcgdex.net/en/bw/bw11/93/high.webp','Dragon','Legendary Treasures',3,'en',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Dragon' AND weaknessValue = '×2'),null),
	('Pokémon','Lugia ex','180','Rare','https://assets.tcgdex.net/fr/bw/bwp/BW83/high.webp','Incolore','Promo BW',2,'fr',(SELECT abilityId FROM P10_Ability WHERE abilityName = 'Inondation' AND abilityEffect = 'Si le Pokémon de votre adversaire est mis K.O. par les dégâts d''une attaque de ce Pokémon, récupérez 1 carte Récompense supplémentaire.'),(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Électrique' AND weaknessValue = '×2'),(SELECT resistanceId FROM P10_Resistance WHERE resistanceType = 'Combat' AND resistanceValue = '-20')),
	('Trainer','Scramble Switch',null,'Rare','https://assets.tcgdex.net/en/bw/bw8/129/high.webp',null,'Plasma Storm',null,'en',null,null,null),
	('Pokémon','Mélancolux','80','Peu Commune','https://assets.tcgdex.net/fr/bw/bw3/59/high.webp','Psy','Nobles Victoires',1,'fr',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Obscurité' AND weaknessValue = '×2'),null),
	('Pokemon','Groudon-EX','180','Rare','https://assets.tcgdex.net/en/bw/bw5/54/high.webp','Fighting','Dark Explorers',4,'en',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Water' AND weaknessValue = '×2'),(SELECT resistanceId FROM P10_Resistance WHERE resistanceType = 'Lightning' AND resistanceValue = '-20'));

INSERT INTO P10_Contient(cardId, attackId) VALUES
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/fr/bw/bw3/89/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Serre' AND attackCost = 'IncoloreIncoloreIncolore' AND attackDamage = '60'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/en/bw/bw11/81/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Nerve Shot' AND attackCost = 'Fighting' AND attackDamage = '30'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/en/bw/bw11/81/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Pandemonium Blade' AND attackCost = 'FightingColorlessColorless' AND attackDamage = '60'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/fr/bw/bw6/59/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Beigne Dés-évoluante' AND attackCost = 'PsyIncoloreIncolore' AND attackDamage = '60'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/fr/bw/bw6/59/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Spectro Maillet' AND attackCost = 'PsyPsyIncoloreIncolore' AND attackDamage = '90'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/en/bw/bw8/53/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Wing Attack' AND attackCost = 'PsychicColorless' AND attackDamage = '20'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/fr/bw/bw4/103/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Lame Folle' AND attackCost = 'ObscuritéObscuritéObscuritéObscurité' AND attackDamage = '60'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/fr/bw/bwp/BW101/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Ultralaser' AND attackCost = 'IncoloreIncolore' AND attackDamage = '30'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/fr/bw/bwp/BW101/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Bazooka Infernal' AND attackCost = 'PlantePlanteIncolore' AND attackDamage = '100'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/fr/bw/bw9/70/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Coup de Piston' AND attackCost = 'Obscurité' AND attackDamage = '30'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/fr/bw/bw9/70/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Enfoncer' AND attackCost = 'ObscuritéIncoloreIncolore' AND attackDamage = '80'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/en/bw/bw2/64/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Knock Off' AND attackCost = 'DarknessColorless' AND attackDamage = '20'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/fr/bw/bw1/15/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Charge' AND attackCost = 'Feu' AND attackDamage = '10'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/fr/bw/bw1/15/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Roulade' AND attackCost = 'FeuIncolore' AND attackDamage = '20'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/en/bw/bw9/13/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Heat Boiler' AND attackCost = 'FireColorlessColorless' AND attackDamage = '60'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/en/bw/bw9/13/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Dynamite Press' AND attackCost = 'FireFireColorlessColorless' AND attackDamage = '80'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/fr/bw/bw6/71/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Roule-Pierre' AND attackCost = 'CombatIncolore' AND attackDamage = '50'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/fr/bw/bw6/71/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Taurocharge' AND attackCost = 'CombatCombatIncolore' AND attackDamage = '90'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/en/bw/bw9/64/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Darkness Fang' AND attackCost = 'DarknessColorlessColorless' AND attackDamage = '70'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/fr/bw/bw4/56/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Claque' AND attackCost = 'IncoloreIncolore' AND attackDamage = '20'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/fr/bw/bw4/56/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Psyko' AND attackCost = 'PsyIncoloreIncolore' AND attackDamage = '40'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/en/bw/bw2/51/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Smack Down' AND attackCost = 'FightingColorless' AND attackDamage = '20'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/en/bw/bw2/51/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Power Gem' AND attackCost = 'FightingFightingColorlessColorless' AND attackDamage = '80'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/en/bw/bw5/110/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Rock Slide' AND attackCost = 'FightingFightingColorless' AND attackDamage = '60'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/fr/bw/bw10/75/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Combo-Griffe' AND attackCost = 'IncoloreIncolore' AND attackDamage = '10'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/en/bw/bw9/68/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Gentle Slap' AND attackCost = 'DarknessColorless' AND attackDamage = '10'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/fr/bw/bw8/82/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Queue Étourdissante' AND attackCost = 'Obscurité' AND attackDamage = null))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/fr/bw/bw8/82/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Combo-Griffe' AND attackCost = 'ObscuritéIncolore' AND attackDamage = '10'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/en/bw/bw2/75/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Metal Sound' AND attackCost = 'Colorless' AND attackDamage = null))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/en/bw/bw2/75/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Guard Press' AND attackCost = 'MetalMetalColorless' AND attackDamage = '60'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/fr/bw/bw7/33/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Anti-Flammes' AND attackCost = 'Eau' AND attackDamage = null))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/en/bw/bw7/30/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Withdraw' AND attackCost = 'Colorless' AND attackDamage = null))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/en/bw/bw7/30/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Waterfall' AND attackCost = 'WaterWaterColorless' AND attackDamage = '60'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/en/bw/bw5/104/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Smash Turn' AND attackCost = 'WaterColorless' AND attackDamage = '30'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/en/bw/bw5/104/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Dual Splash' AND attackCost = 'WaterWaterColorless' AND attackDamage = null))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/fr/bw/bw3/59/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Appât Lumineux' AND attackCost = 'Incolore' AND attackDamage = null))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/fr/bw/bw3/59/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Feu Follet' AND attackCost = 'PsyIncolore' AND attackDamage = '30'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/en/bw/bw5/54/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Tromp' AND attackCost = 'FightingColorless' AND attackDamage = '20'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/en/bw/bw5/54/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Giant Claw' AND attackCost = 'FightingFightingColorless' AND attackDamage = '80'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/fr/bw/bw7/10/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Appel à la Famille' AND attackCost = 'Incolore' AND attackDamage = null))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/fr/bw/bw7/10/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Feuille Sangsue' AND attackCost = 'PlantePlante' AND attackDamage = '30'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/en/bw/bw6/9/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Tangle Drag' AND attackCost = 'Colorless' AND attackDamage = null))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/en/bw/bw6/9/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Spiral Drain' AND attackCost = 'ColorlessColorless' AND attackDamage = '20'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/fr/bw/bw8/100/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Bec Enragé' AND attackCost = 'Incolore' AND attackDamage = '30'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/fr/bw/bw8/100/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Bec Vrille' AND attackCost = 'IncoloreIncoloreIncolore' AND attackDamage = '60'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/en/bw/bw4/79/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Round' AND attackCost = 'ColorlessColorless' AND attackDamage = '20'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/en/bw/bw4/79/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Hypnoblast' AND attackCost = 'ColorlessColorlessColorless' AND attackDamage = '60'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/fr/bw/bw9/37/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Rendez-vous Mineur' AND attackCost = 'Incolore' AND attackDamage = null))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/fr/bw/bw9/37/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Électro-Queue' AND attackCost = 'Électrique' AND attackDamage = '10'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/en/bw/bw2/34/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Gnaw' AND attackCost = 'Colorless' AND attackDamage = '20'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/en/bw/bw2/34/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Stun Needle' AND attackCost = 'LightningColorless' AND attackDamage = '30'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/en/bw/bw5/107/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Night Spear' AND attackCost = 'DarknessDarknessColorless' AND attackDamage = '90'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/fr/bw/bw8/41/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Rage Massive' AND attackCost = 'EauIncolore' AND attackDamage = '20'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/fr/bw/bw8/41/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Chute de Glacier' AND attackCost = 'EauEauIncolore' AND attackDamage = '90'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/en/bw/bw7/38/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Present' AND attackCost = 'Colorless' AND attackDamage = null))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/en/bw/bw7/38/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Icy Wind' AND attackCost = 'WaterColorless' AND attackDamage = '30'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/fr/bw/bw10/27/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Souplesse' AND attackCost = 'EauIncoloreIncolore' AND attackDamage = '30'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/en/bw/bw5/25/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Muddy Water' AND attackCost = 'Colorless' AND attackDamage = '20'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/en/bw/bw5/25/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Spiral Drain' AND attackCost = 'WaterColorlessColorless' AND attackDamage = '60'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/fr/bw/bw7/45/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Lumière Étrange' AND attackCost = 'EauIncoloreIncolore' AND attackDamage = '40'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/en/bw/bw1/41/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Stomp' AND attackCost = 'Colorless' AND attackDamage = '10'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/fr/bw/bw1/11/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Méga-Sangsue' AND attackCost = 'Plante' AND attackDamage = '20'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/fr/bw/bw1/11/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Dard-Nuée' AND attackCost = 'PlantePlanteIncolore' AND attackDamage = '20'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/en/bw/bw5/10/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Body Slam' AND attackCost = 'GrassGrass' AND attackDamage = '20'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/fr/bw/bw2/36/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Choc Mental' AND attackCost = 'PsyIncolore' AND attackDamage = '20'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/en/bw/bw7/33/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Firefighting' AND attackCost = 'Water' AND attackDamage = null))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/fr/bw/bw1/91/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Vendetta' AND attackCost = 'IncoloreIncolore' AND attackDamage = '20'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/fr/bw/bw1/91/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Peignée' AND attackCost = 'IncoloreIncoloreIncoloreIncolore' AND attackDamage = '80'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/fr/bw/bw2/2/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Pouvoir Incendiaire' AND attackCost = 'IncoloreIncolore' AND attackDamage = '30'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/fr/bw/bw2/2/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Canon Graine' AND attackCost = 'PlanteIncoloreIncolore' AND attackDamage = '60'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/en/bw/bw6/2/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Bullet Seed' AND attackCost = 'Grass' AND attackDamage = '10'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/fr/bw/bw8/104/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Retour' AND attackCost = 'Incolore' AND attackDamage = '30'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/en/bw/bw4/94/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Synthesis' AND attackCost = 'Grass' AND attackDamage = null))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/en/bw/bw4/94/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Revenge Blast' AND attackCost = 'GrassColorless' AND attackDamage = '30'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/fr/bw/bw8/116/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Tranchant Sauvage' AND attackCost = 'IncoloreIncoloreIncolore' AND attackDamage = '60'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/fr/bw/bw8/27/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Laser Glace' AND attackCost = 'EauIncolore' AND attackDamage = '20'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/fr/bw/bw8/27/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Quintuple Coup d''Boule' AND attackCost = 'EauEauIncoloreIncolore' AND attackDamage = '40'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/en/bw/bw2/25/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Tackle' AND attackCost = 'Colorless' AND attackDamage = '10'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/en/bw/bw2/25/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Splatter' AND attackCost = 'WaterColorless' AND attackDamage = null))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/fr/bw/bw8/102/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Bâillement' AND attackCost = 'Incolore' AND attackDamage = null))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/fr/bw/bw9/23/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Vent Glace' AND attackCost = 'EauIncoloreIncolore' AND attackDamage = '60'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/en/bw/bw3/21/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Fiery Dance' AND attackCost = 'Fire' AND attackDamage = '30'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/en/bw/bw3/21/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Heat Wave' AND attackCost = 'FireColorlessColorless' AND attackDamage = '60'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/fr/bw/bw10/61/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Rouleau Compresseur' AND attackCost = 'MétalIncolore' AND attackDamage = '40'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/fr/bw/bw10/61/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Coup Déchirant' AND attackCost = 'MétalIncoloreIncolore' AND attackDamage = '80'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/en/bw/bw7/56/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Smash Kick' AND attackCost = 'Colorless' AND attackDamage = '10'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/fr/bw/bw6/105/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Picpic' AND attackCost = 'Incolore' AND attackDamage = '10'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/en/bw/bw8/94/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Guard Press' AND attackCost = 'ColorlessColorless' AND attackDamage = '20'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/en/bw/bw8/94/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Dragon Claw' AND attackCost = 'FireFireWaterColorless' AND attackDamage = '90'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/fr/bw/bw7/122/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Tacle Brutal' AND attackCost = 'IncoloreIncoloreIncolore' AND attackDamage = '90'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/en/bw/bw8/102/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Yawn' AND attackCost = 'Colorless' AND attackDamage = null))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/fr/bw/bw1/38/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Écras''Face' AND attackCost = 'IncoloreIncolore' AND attackDamage = '20'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/fr/bw/bw1/38/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Grosse Vague' AND attackCost = 'EauEauIncoloreIncolore' AND attackDamage = '60'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/en/bw/bw4/34/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Bubble' AND attackCost = 'Colorless' AND attackDamage = null))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/en/bw/bw4/34/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Spit Poison' AND attackCost = 'WaterColorless' AND attackDamage = null))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/fr/bw/bw3/33/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Chaîne de Glace' AND attackCost = 'Eau' AND attackDamage = null))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/fr/bw/bw3/33/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Poudreuse d''Escampette' AND attackCost = 'EauEau' AND attackDamage = '40'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/en/bw/bw4/30/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Bite' AND attackCost = 'Colorless' AND attackDamage = '10'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/en/bw/bw4/30/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Bared Fangs' AND attackCost = 'Water' AND attackDamage = '40'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/fr/bw/bw2/67/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Combo-Griffe' AND attackCost = 'Obscurité' AND attackDamage = '20'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/fr/bw/bw2/67/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Explonuit' AND attackCost = 'ObscuritéIncoloreIncolore' AND attackDamage = '80'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/en/bw/bw6/61/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Bone Lock' AND attackCost = 'Fighting' AND attackDamage = '30'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/en/bw/bw6/61/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Vortex Chop' AND attackCost = 'FightingColorlessColorless' AND attackDamage = '60'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/fr/bw/bw9/21/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Souplesse' AND attackCost = 'EauIncolore' AND attackDamage = '20'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/en/bw/bw1/20/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Heat Crash' AND attackCost = 'FireFireColorlessColorless' AND attackDamage = '80'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/fr/bw/bw1/7/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Griffe' AND attackCost = 'Incolore' AND attackDamage = '10'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/fr/bw/bw1/7/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Fouet Lianes' AND attackCost = 'PlanteIncoloreIncolore' AND attackDamage = '30'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/en/bw/bw11/6/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Leaf Blade' AND attackCost = 'GrassColorless' AND attackDamage = '10'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/fr/bw/bw7/102/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Charge Destructrice' AND attackCost = 'FeuIncolore' AND attackDamage = '20'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/fr/bw/bw7/102/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Flammes de Glace' AND attackCost = 'FeuEauIncoloreIncolore' AND attackDamage = '80'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/fr/bw/bw9/7/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Écras''Face' AND attackCost = 'Incolore' AND attackDamage = '20'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/fr/bw/bw9/7/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Coupe' AND attackCost = 'PlanteIncolore' AND attackDamage = '30'))
	((SELECT cardId FROM P10_Card WHERE cardImg = '/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Knock Away' AND attackCost = 'Colorless' AND attackDamage = '10'))
	((SELECT cardId FROM P10_Card WHERE cardImg = '/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Rollout' AND attackCost = 'FireWaterColorless' AND attackDamage = '50'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/fr/bw/bwp/BW72/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Tête de Fer' AND attackCost = 'MétalMétalIncolore' AND attackDamage = '60'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/en/bw/bw6/126/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Psywave' AND attackCost = 'PsychicPsychicPsychic' AND attackDamage = '30'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/fr/bw/bw6/18/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Roussi' AND attackCost = 'Feu' AND attackDamage = null))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/en/bw/bw8/16/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Loud Howl' AND attackCost = 'Colorless' AND attackDamage = null))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/en/bw/bw8/16/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Fire Tail Slap' AND attackCost = 'FireColorless' AND attackDamage = '50'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/fr/bw/bw6/14/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Fouets Croisés' AND attackCost = 'Plante' AND attackDamage = '30'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/fr/bw/bw6/14/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Point Poison' AND attackCost = 'PlanteIncoloreIncolore' AND attackDamage = '60'))
	((SELECT cardId FROM P10_Card WHERE cardImg = '/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Lunge' AND attackCost = 'FightingMetal' AND attackDamage = '30'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/fr/bw/bw9/90/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Signes d''Évolution' AND attackCost = 'Incolore' AND attackDamage = null))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/fr/bw/bw9/90/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Morsure' AND attackCost = 'IncoloreIncoloreIncolore' AND attackDamage = '30'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/en/bw/bw4/82/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Giga Power' AND attackCost = 'ColorlessColorlessColorless' AND attackDamage = '60'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/en/bw/bw4/82/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Raging Hammer' AND attackCost = 'ColorlessColorlessColorlessColorless' AND attackDamage = '50'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/fr/bw/bw4/74/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Tête de Roc' AND attackCost = 'Obscurité' AND attackDamage = '20'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/fr/bw/bw4/74/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Marto-Pied' AND attackCost = 'ObscuritéIncoloreIncolore' AND attackDamage = '50'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/en/bw/bw10/67/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Strong Bond' AND attackCost = 'Colorless' AND attackDamage = null))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/en/bw/bw10/67/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Dragon Claw' AND attackCost = 'FightingMetal' AND attackDamage = '20'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/en/bw/bw11/93/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Dragon Pulse' AND attackCost = 'Lightning' AND attackDamage = '40'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/en/bw/bw11/93/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Shred' AND attackCost = 'FireLightningColorless' AND attackDamage = '90'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/fr/bw/bwp/BW83/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Éclat Plasma' AND attackCost = 'IncoloreIncoloreIncoloreIncolore' AND attackDamage = '120'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/fr/bw/bw3/59/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Appât Lumineux' AND attackCost = 'Incolore' AND attackDamage = null))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/fr/bw/bw3/59/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Feu Follet' AND attackCost = 'PsyIncolore' AND attackDamage = '30'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/en/bw/bw5/54/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Tromp' AND attackCost = 'FightingColorless' AND attackDamage = '20'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/en/bw/bw5/54/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Giant Claw' AND attackCost = 'FightingFightingColorless' AND attackDamage = '80'))