DROP TABLE IF EXISTS P10_Card;
DROP TABLE IF EXISTS P10_Attack;
DROP TABLE IF EXISTS P10_Resistance;
DROP TABLE IF EXISTS P10_Weakness;
DROP TABLE IF EXISTS P10_User;
DROP TABLE IF EXISTS P10_Abitility;

CREATE TABLE IF NOT EXISTS P10_User(
	userId INT AUTO_INCREMENT PRIMARY KEY,
	userName varchar(20) NOT NULL,
	userDob date NOT NULL,
	userStatus varchar(10) NOT NULL DEFAULT 'user' CHECK IN ['root','user'],
	userLogin varchar(255) NOT NULL,
	userPass varchar(255) NOT NULL);

CREATE TABLE IF NOT EXISTS P10_Ability(
	abilityId INT AUTO_INCREMENT PRIMARY KEY,
	abilityName varchar(50) NOT NULL,
	abilityEffect varchar(255) NOT NULL);

CREATE TABLE IF NOT EXISTS P10_Resistance(
	resistanceId INT AUTO_INCREMENT PRIMARY KEY,
	resistanceType varchar(10) NOT NULL CHECK IN ['Incolore', 'Feu', 'Eau', 'Plante', 'Combat', 'Métal', 'Électrique', 'Psy', 'Obscurité', 'Dragon', 'Colorless', 'Fire', 'Water', 'Grass', 'Fighting', 'Metal', 'Lightning', 'Psychic', 'Darkness'],
	resistanceValue varchar(5) NOT NULL DEFAULT '-20' CHECK IN ['/2',-20,-10,-30]);

CREATE TABLE IF NOT EXISTS P10_Weakness(
	weaknessId INT AUTO_INCREMENT PRIMARY KEY,
	weaknessType varchar(10) NOT NULL CHECK IN ['Incolore', 'Feu', 'Eau', 'Plante', 'Combat', 'Métal', 'Électrique', 'Psy', 'Obscurité', 'Dragon', 'Colorless', 'Fire', 'Water', 'Grass', 'Fighting', 'Metal', 'Lightning', 'Psychic', 'Darkness'],
	weaknessValue varchar(5) NOT NULL DEFAULT 'x2' CHECK IN ['x2',+20,+10,+30]);

CREATE TABLE IF NOT EXISTS P10_Attack(
	attackId INT AUTO_INCREMENT PRIMARY KEY,
	attackName varchar(50) NOT NULL,
	attackCost varchar(50),
	attackDamage varchar(4),
	attackEffect varchar(255),
	attackLang varchar(20) NOT NULL DEFAULT 'fr' CHECK IN ['fr','en']);

CREATE TABLE IF NOT EXISTS P10_Card(
	cardId INT AUTO_INCREMENT PRIMARY KEY,
	cardCategory varchar(50) NOT NULL DEFAULT 'Pokémon' CHECK IN ['Pokémon','Pokemon','Dresseur','Trainer'],
	cardName varchar(50) NOT NULL,
	cardHP INT,
	cardRarity varchar(50) NOT NULL DEFAULT 'Commune' CHECK IN ['Commune','Common','Uncommon','Peu Commune','Rare','Ultra Rare','Secret Rare','Magnifique','Maginfic'],
	cardImg varchar(20) NOT NULL,
	cardType varchar(10) CHECK IN ['Incolore', 'Feu', 'Eau', 'Plante', 'Combat', 'Métal', 'Électrique', 'Psy', 'Obscurité', 'Dragon', 'Colorless', 'Fire', 'Water', 'Grass', 'Fighting', 'Metal', 'Lightning', 'Psychic', 'Darkness'],
	cardExtension varchar(255) NOT NULL,
	cardRetreat INT,
	cardLang varchar(20) NOT NULL DEFAULT 'fr' CHECK IN ['fr','en'],
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
	('Cri Préhistorique','Les attaques de vos Pokémon infligent 10 dégâts supplémentaires aux Pokémon Actifs (avant application de la Faiblesse et de la Résistance).'),
	('Solide Roc','Si des dégâts sont infligés à ce Pokémon par des attaques, lancez une pièce. Si c’est face, les dégâts sont réduits de 50 (après application de la Faiblesse et de la Résistance).'),
	('Airhead','If you have 2, 4, or 6 Prize cards left, this Pokémon can’t attack.'),
	('Solid Rock','If any damage is done to this Pokémon by attacks, flip a coin. If heads, reduce that damage by 50 (after applying Weakness and Resistance).'),
	('Stickiness','The Retreat Cost of each of your opponent’s Pokémon in play is Colorless more.'),
	('Time Recall','Each of your evolved Pokémon can use any attack from its previous Evolutions. (You still need the necessary Energy to use each attack.)'),
	('Main Sinistre','Autant de fois que vous le voulez pendant votre tour (avant votre attaque), vous pouvez déplacer 1 marqueur de dégâts de l’un des Pokémon de votre adversaire vers un autre des Pokémon de votre adversaire.'),
	('Soin Royal','N’importe quand entre chaque tour, soignez 10 dégâts à chacun de vos Pokémon.'),
	('Boom Final','Lorsque ce Pokémon est mis K.O. par les dégâts d’une attaque de votre adversaire, défaussez les 3 cartes du dessus du deck de votre adversaire.'),
	('Aile Impitoyable','Lorsque vous jouez ce Pokémon de votre main pour faire évoluer 1 de vos Pokémon, vous pouvez défausser toutes les cartes Outil Pokémon attachées à chacun des Pokémon de votre adversaire.'),
	('Recherche Plasma','Une seule fois pendant votre tour (avant votre attaque), vous pouvez chercher une carte de la Team Plasma dans votre deck, la montrer et l''ajouter à votre main. Mélangez ensuite votre deck. Vous ne pouvez pas utiliser une capacité spéciale du même nom pendant votre tour.'),
	('Plasma Search','Once during your turn (before your attack), you may search your deck for a Team Plasma card, reveal it, and put it into your hand. Shuffle your deck afterward. You may not use an Ability with the same name during your turn.'),
	('Dark Trance','As often as you like during your turn (before your attack), you may move a Darkness Energy attached to 1 of your Pokémon to another of your Pokémon.'),
	('Sturdy','If this Pokémon has full HP and would be Knocked Out by damage from an attack, this Pokémon is not Knocked Out and its remaining HP becomes 10 instead.'),
	('Révélation Solaire','Évitez tous les effets des attaques de votre adversaire, excepté les dégâts, infligés à chacun de vos Pokémon auquel de l’Énergie est attachée.'),
	('Psychic Mirage','Each basic Psychic Energy attached to your Psychic Pokémon provides PsychicPsychic Energy. You can''t apply more than 1 Psychic Mirage Ability at a time.'),
	('Bouclier Faiblesse','Si de l''Énergie Psychic est attachée à ce Pokémon, ce Pokémon n''a pas de Faiblesse.'),
	('Premonition','Once during your turn (before your attack), you may look at the top 2 cards of your deck and put them back on top of your deck in any order.');

INSERT INTO P10_Attack(attackName,attackCost,attackDamage,attackEffect) VALUES 
	('Coup Double','Incolore','20','Lancez 2 pièces. Cette attaque inflige 20 dégâts multipliés par le nombre de côtés face.'),
	('Tail Trickery','Darkness',null,'The Defending Pokémon is now Confused.'),
	('Smack','Psychic','30',null),
	('Mâchouille','EauEauIncoloreIncolore','80','Défaussez une Énergie attachée au Pokémon Défenseur.'),
	('Lazy Headbutt','WaterColorless','80','This Pokémon is now Asleep.'),
	('Roulade Obstinée','EauIncolore','10','Lancez 2 pièces. Si vous obtenez 2 côtés face, cette attaque inflige 30 dégâts supplémentaires.'),
	('Crunch','WaterWaterColorlessColorless','80','Discard an Energy attached to the Defending Pokémon.'),
	('Enveloppe Douce','PsyIncolore','30','Le Pokémon Défenseur ne peut pas battre en retraite pendant le prochain tour de votre adversaire.'),
	('Eerie Light','WaterColorlessColorless','40','Flip a coin. If heads, the Defending Pokémon is now Confused.'),
	('Dard-Venin','Plante',null,'Lancez une pièce. Si c''est face, le Pokémon Défenseur est maintenant Empoisonné.'),
	('Wind Whisk','GrassColorlessColorless','60','Switch this Pokémon with 1 of your Benched Pokémon.'),
	('Transfert de Camelote','Incolore',null,'Ajoutez un Pokémon de la Team Plasma, une carte Dresseur de la Team Plasma et une carte Énergie de la Team Plasma de votre pile de défausse à votre main.'),
	('Tranch''Herbe','PlantePlante','40',null),
	('Sharp Fang','WaterColorlessColorless','60',null),
	('Synchropeine','Psy','20','Inflige 20 dégâts à chacun des Pokémon de Banc de votre adversaire ayant un type en commun avec le Pokémon Défenseur.  (N''appliquez ni la Faiblesse ni la Résistance aux Pokémon de Banc.)'),
	('Outrage','ColorlessColorless','20','Does 10 more damage for each damage counter on this Pokémon.'),
	('Course Effrénée','Incolore','n/a','Échangez ce Pokémon avec 1 de vos Pokémon de Banc.'),
	('Incessant Peck','ColorlessColorless','10','Flip a coin until you get tails. This attack does 20 more damage for each heads.'),
	('Collecte','Incolore',null,'Piochez une carte.'),
	('Flame Charge','Colorless',null,'Search your deck for a Fire Energy card and attach it to this Pokémon. Shuffle your deck afterward.'),
	('Dragon Stream','FireColorlessColorless','60','Flip a coin. If heads, attach a basic Energy card from your discard pile to this Pokémon.'),
	('Ultrason','Incolore',null,'Le Pokémon Défenseur est maintenant Confus.'),
	('Dazzle Dance','Colorless',null,'Flip a coin. If heads, the Defending Pokémon is now Confused.'),
	('Collision','Incolore','10',null),
	('Double Kick','Colorless','10','Flip 2 coins. This attack does 10 damage times the number of heads.'),
	('Explosion de Lumière','Électrique','10','Lancez une pièce. Si c''est face, le Pokémon Défenseur est maintenant Confus.'),
	('Pound','Colorless','10',null),
	('Berceuse','Incolore',null,'Le Pokémon Défenseur est maintenant Endormi.'),
	('Guard Press','Darkness','10','During your opponent''s next turn, any damage done to this Pokémon by attacks is reduced by 10 (after applying Weakness and Resistance).'),
	('Poing Ombre','PsyIncoloreIncoloreIncolore','60','Les dégâts de cette attaque ne sont pas affectés par la Résistance.'),
	('Dig','FightingColorless','30','Flip a coin. If heads, prevent all effects of attacks, including damage, done to this Pokémon during your opponent''s next turn.'),
	('Pression de Garde','Obscurité','10','Pendant le prochain tour de votre adversaire, tous les dégâts infligés à ce Pokémon par des attaques sont réduits de 10 (après application de la Faiblesse et de la Résistance).'),
	('Phytomixeur','PlanteIncolore','60','Déplacez autant d’Énergies Grass attachées à vos Pokémon que vous voulez vers vos autres Pokémon, de la manière que vous voulez.'),
	('Synthesis','Grass',null,'Search your deck for a Grass Energy card and attach it to 1 of your Pokémon. Shuffle your deck afterward.'),
	('Smog Envahissant','PsyIncolore',null,'Cette attaque inflige 20 dégâts à chacun des Pokémon de votre adversaire. (N''appliquez ni la Faiblesse ni la Résistance aux Pokémon de Banc.)'),
	('Gentle Wrap','PsychicColorless','20','The Defending Pokémon can''t retreat during your opponent''s next turn.'),
	('Anéantissement de Gaïa','FeuEauIncoloreIncolore','100','Défaussez toute carte Stade en jeu.'),
	('Lovestrike','ColorlessColorless','20','Does 40 more damage for each Nidoqueen on your Bench.'),
	('Contrôleur d''Esprit','PsyIncoloreIncoloreIncolore','60','Le Pokémon Défenseur est maintenant Confus.'),
	('Hypnosis','Colorless',null,'The Defending Pokémon is now Asleep.'),
	('Danse Éblouissante','Plante','10','Le Pokémon Défenseur est maintenant Confus.'),
	('Mega Drain','Grass','20','Heal 20 damage from this Pokémon.'),
	('Ronge','Incolore','10',null),
	('Sheer Cold','WaterColorlessColorless','50','The Defending Pokémon can''t attack during your opponent''s next turn.'),
	('Culbute Surprise','PsyPsyIncolore','60',null),
	('Mind Bend','PsychicColorlessColorlessColorless','60','The Defending Pokémon is now Confused.'),
	('Grosse Baffe','Incolore','40','Lancez une pièce pour chaque Énergie attachée à ce Pokémon. Cette attaque inflige 40 dégâts multipliés par le nombre de côtés face.'),
	('Push Down','DarknessColorless','20','Your opponent switches the Defending Pokémon with 1 of his or her Benched Pokémon.'),
	('Roussi','Feu',null,'Lancez une pièce. Si c''est face, le Pokémon Défenseur est maintenant Brûlé.'),
	('Double Draw','Colorless',null,'Draw 2 cards.'),
	('Double Morsure','IncoloreIncolore','20','Inflige 10 dégâts supplémentaires pour chaque marqueur de dégâts placé sur le Pokémon Défenseur.'),
	('Dragonblast','PsychicDarknessDarknessColorless','140','Discard 2 Darkness Energy attached to this Pokémon.'),
	('Stone Edge','FightingFightingColorless','70','Flip a coin. If heads, this attack does 20 more damage.'),
	('Hit Back','Psychic','30','If this Pokémon has no damage counters on it, this attack does nothing.'),
	('Dual Draw','Colorless',null,'Each player draws 2 cards.'),
	('Chip Away','Fighting','40','This attack''s damage isn''t affected by any effects on the Defending Pokémon.'),
	('Cru-Aile','IncoloreIncolore','40',null),
	('Gust','ColorlessColorless','20',null),
	('Max Milk','ColorlessColorless',null,'Heal all damage from 1 of your Pokémon. Then, discard all Energy attached to this Pokémon.'),
	('Supersonic','Colorless',null,'The Defending Pokémon is now Confused.'),
	('Saut','Électrique','10','Lancez une pièce. Si c''est face, cette attaque inflige 10 dégâts supplémentaires.'),
	('Thunder Wave','Lightning','10','Flip a coin. If heads, the Defending Pokémon is now Paralyzed.'),
	('Griffe','Incolore','10',null),
	('Call for Family','Colorless',null,'Search your deck for 2 Basic Pokémon and put them onto your Bench. Shuffle your deck afterward.'),
	('Ailes Gelées','EauIncoloreIncolore','60','Défaussez une Énergie spéciale attachée au Pokémon Défenseur.'),
	('Razor Shell','WaterColorless','20','Flip a coin. If heads, this attack does 20 more damage.'),
	('Balayage','CombatIncolore','30',null),
	('Hypnotic Gaze','Colorless',null,'The Defending Pokémon is now Asleep.'),
	('Pression Énergétique','MétalIncolore','20','Inflige 20 dégâts supplémentaires pour chaque Énergie attachée au Pokémon Défenseur.'),
	('Jet Headbutt','Colorless','40',null),
	('Flux Draconique','FeuIncoloreIncolore','60','Lancez une pièce. Si c''est face, attachez une carte Énergie de base de votre pile de défausse à ce Pokémon.'),
	('Mind Shock','PsychicPsychicColorlessColorless','60','This attack''s damage isn''t affected by Weakness or Resistance.'),
	('Coup d''Poing Éclair','IncoloreIncolore','10','Lancez une pièce. Si c''est face, cette attaque inflige 20 dégâts supplémentaires.'),
	('Rock Tumble','FightingColorless','50','This attack''s damage isn''t affected by Resistance.'),
	('Cyclone','IncoloreIncolore','30','Vous pouvez demander à votre adversaire d''échanger le Pokémon Défenseur avec 1 de ses Pokémon de Banc.'),
	('Rock Throw','Fighting','20',null),
	('Triple Laser','IncoloreIncoloreIncolore',null,'Cette attaque inflige 30 dégâts à 3 des Pokémon de votre adversaire. (N''appliquez ni la Faiblesse ni la Résistance aux Pokémon de Banc.)'),
	('Patrouille','Incolore',null,'Regardez les 3 cartes du dessus de votre deck et replacez-les sur le dessus de votre deck dans l''ordre de votre choix.'),
	('Smack ''n'' Slack','Colorless','10','This Pokémon is now Asleep.'),
	('Tunnel','CombatIncolore','30','Lancez une pièce. Si c''est face, évitez tous les effets d''attaques (y compris les dégâts) infligés à ce Pokémon pendant le prochain tour de votre adversaire.'),
	('Chuck','ColorlessColorless','40','Discard as many Pokémon Tool cards as you like from your hand. This attack does 40 damage times the number of cards you discarded.');

INSERT INTO P10_Attack(attackName,attackCost,attackDamage,attackEffect) VALUES 
	('Catapu-Main','IncoloreIncolore','10','Inflige 10 dégâts multipliés par le nombre de cartes dans votre main.'),
	('Assist','DarknessColorlessColorless',null,'Flip a coin. If heads, choose 1 of your Benched Pokémon''s attacks and use it as this attack.'),
	('Mental Shock','PsychicColorlessColorless','60','Flip a coin. If heads, the Defending Pokémon is now Confused. If tails, discard an Energy attached to the Defending Pokémon.'),
	('Détricanon','PsyPsyIncolore','60','Le Pokémon Défenseur est maintenant Empoisonné.'),
	('Morsure','IncoloreIncolore','30',null),
	('Choc Frontal','PlantePlanteIncolore','80','Ce Pokémon et le Pokémon Défenseur sont maintenant Confus.'),
	('Swing Around','WaterColorlessColorlessColorless','60','Flip 2 coins. This attack does 30 more damage for each heads.'),
	('Piqûre Psy','PsyIncolore','40',null),
	('Bolt Strike','LightningLightningColorless','120','This Pokémon does 40 damage to itself.'),
	('Crochet','CombatIncolore','30',null),
	('Griffe','IncoloreIncolore','20',null),
	('Heat Crash','FireFireColorless','50',null),
	('Ice Burn','FireFireWaterColorless','150','Discard 2 Fire Energy attached to this Pokémon. The Defending Pokémon is now Burned.'),
	('Mégaphone','EauIncoloreIncolore','50',null),
	('Leech Seed','GrassColorless','20','Heal 10 damage from this Pokémon.'),
	('Étincelle Surprise','ÉlectriqueIncoloreIncolore','n/a','Cette attaque inflige 40 dégâts à 1 des Pokémon de votre adversaire. (N''appliquez ni la Faiblesse ni la Résistance aux Pokémon de Banc.)'),
	('Smash Kick','ColorlessColorless','20',null),
	('Picpic','IncoloreIncolore','20',null),
	('Headbutt','PsychicColorlessColorless','30',null),
	('Earthquake','FightingColorlessColorless','70','Does 10 damage to each of your Benched Pokémon. (Don''t apply Weakness and Resistance for Benched Pokémon.)'),
	('Coup d''Boule','PsyIncoloreIncolore','30',null),
	('Revenge Blast','GrassColorless','30','Does 30 more damage for each Prize card your opponent has taken.'),
	('Toxic Secretion','PsychicColorlessColorlessColorless','60','The Defending Pokémon is now Poisoned. Put 2 damage counters instead of 1 on that Pokémon between turns.'),
	('Horn Drill','FightingColorlessColorlessColorless','90',null),
	('Dream Eater','PsychicPsychic','60','If the Defending Pokémon is not Asleep, this attack does nothing.'),
	('Embuscade','PlanteIncolore','20','Lancez une pièce. Si c''est face, cette attaque inflige 30 dégâts supplémentaires.'),
	('Pin Missile','GrassGrassColorless','20','Flip 4 coins. This attack does 20 damage times the number of heads.'),
	('Icicle Crash','WaterWaterColorlessColorless','80','This attack''s damage isn''t affected by Resistance.'),
	('Vibra Soin','IncoloreIncoloreIncolore',null,'Soignez 50 dégâts à 1 de vos Pokémon.'),
	('Bite','DarknessColorlessColorless','30',null),
	('Charbon Mutant','FeuIncolore','20',null),
	('Leaf Wallop','GrassColorless','40','During your next turn, this Pokémon''s Leaf Wallop attack does 40 more damage (before applying Weakness and Resistance).'),
	('Balayage','IncoloreIncoloreIncolore','60',null),
	('Rapace','IncoloreIncoloreIncolore','90','Ce Pokémon s''inflige 30 dégâts.'),
	('Tackle','ColorlessColorless','30',null),
	('Hyper Voice','ColorlessColorlessColorless','50',null),
	('Choc Statique','ÉlectriqueIncolore','20',null),
	('Cage d’Ombre','PsyIncolore','20','Le Pokémon Défenseur ne peut pas battre en retraite pendant le prochain tour de votre adversaire.'),
	('Static Shock','Lightning','20',null),
	('Tempêtegrêle','EauEauIncoloreIncolore','120','Ce Pokémon ne peut pas utiliser Tempêtegrêle pendant votre prochain tour.'),
	('Double Slap','ColorlessColorless','20','Flip 2 coins. This attack does 20 damage times the number of heads.'),
	('Brise-Fer','MétalMétalIncolore','80','Le Pokémon Défenseur ne peut pas attaquer pendant le prochain tour de votre adversaire.'),
	('Sand Tomb','WaterFightingColorless','80','The Defending Pokémon can''t retreat during your opponent''s next turn.'),
	('Feu Glacé','FeuFeuEauIncolore','150','Défaussez 2 Énergies Fire attachées à ce Pokémon. Le Pokémon Défenseur est maintenant Brûlé.'),
	('Pump-up Smash','FightingFightingColorless','90','Attach 2 basic Energy cards from your hand to your Benched Pokémon in any way you like.'),
	('Rafle Plongeante','ObscuritéIncoloreIncolore','70','Défaussez au hasard une carte de la main de votre adversaire.'),
	('Acrobatics','ColorlessColorless','20','Flip 2 coins. This attack does 20 more damage for each heads.'),
	('Recharge Protectrice','MétalMétalIncoloreIncolore','80','Pendant le prochain tour de votre adversaire, tous les dégâts infligés à ce Pokémon par des attaques sont réduits de 20 (après application de la Faiblesse et de la Résistance).'),
	('Séisme','CombatIncoloreIncolore','70','Inflige 10 dégâts à chacun de vos Pokémon de Banc. (N''appliquez ni la Faiblesse ni la Résistance aux Pokémon de Banc.)'),
	('Lock Up','PsychicPsychic','40','The Defending Pokémon can''t retreat during your opponent''s next turn.');

INSERT INTO P10_Resistance(resistanceType,resistanceValue) VALUES 
	('Psychic','-20'),
	('Eau','-20'),
	('Water','-20'),
	('Fighting','-20'),
	('Combat','-20'),
	('Lightning','-20'),
	('Psy','-20'),
	('Électrique','-20');

INSERT INTO P10_Weakness(weaknessType,weaknessValue) VALUES 
	('Combat','×2'),
	('Fighting','×2'),
	('Plante','×2'),
	('Psychic','×2'),
	('Lightning','×2'),
	('Métal','×2'),
	('Grass','×2'),
	('Psy','×2'),
	('Feu','×2'),
	('Fire','×2'),
	('Eau','×2'),
	('Water','×2'),
	('Dragon','×2'),
	('Électrique','×2'),
	('Obscurité','×2'),
	('Metal','×2'),
	('Darkness','×2');

INSERT INTO Card(cardCatergory,cardName,cardHP,cardRarity,cardImg,cardType,cardExtensioncardRetreat,cardLang,abilityId,resistanceId,weaknessId) VALUES
	('Pokémon','Capidextre','80','Rare','https://assets.tcgdex.net/fr/bw/bw6/100/high.webp','Incolore','Dragons Éxaltés',1,'fr',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Combat' AND weaknessValue = '×2'),null),
	('Pokemon','Liepard','80','Rare','https://assets.tcgdex.net/en/bw/bw7/91/high.webp','Darkness','Boundaries Crossed',1,'en',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Fighting' AND weaknessValue = '×2'),(SELECT resistanceId FROM P10_Resistance WHERE resistanceType = 'Psychic' AND resistanceValue = '-20')),
	('Pokémon','Ptéra','90','Rare','https://assets.tcgdex.net/fr/bw/bw5/53/high.webp','Combat','Explorateurs Obscurs',1,'fr',(SELECT abilityId FROM P10_Ability WHERE abilityName = 'Cri Préhistorique' AND abilityEffect = 'Les attaques de vos Pokémon infligent 10 dégâts supplémentaires aux Pokémon Actifs (avant application de la Faiblesse et de la Résistance).'),(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Plante' AND weaknessValue = '×2'),null),
	('Pokemon','Gothitelle','120','Rare','https://assets.tcgdex.net/en/bw/bw2/48/high.webp','Psychic','Emerging Powers',1,'en',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Psychic' AND weaknessValue = '×2'),null),
	('Pokémon','Mégapagos','140','Rare','https://assets.tcgdex.net/fr/bw/bw3/26/high.webp','Eau','Nobles Victoires',4,'fr',(SELECT abilityId FROM P10_Ability WHERE abilityName = 'Solide Roc' AND abilityEffect = 'Si des dégâts sont infligés à ce Pokémon par des attaques, lancez une pièce. Si c’est face, les dégâts sont réduits de 50 (après application de la Faiblesse et de la Résistance).'),(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Plante' AND weaknessValue = '×2'),null),
	('Pokemon','Slowbro','100','Uncommon','https://assets.tcgdex.net/en/bw/bw5/24/high.webp','Water','Dark Explorers',3,'en',(SELECT abilityId FROM P10_Ability WHERE abilityName = 'Airhead' AND abilityEffect = 'If you have 2, 4, or 6 Prize cards left, this Pokémon can’t attack.'),(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Lightning' AND weaknessValue = '×2'),null),
	('Pokémon','Obalie','60','Commune','https://assets.tcgdex.net/fr/bw/bw6/29/high.webp','Eau','Dragons Éxaltés',2,'fr',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Métal' AND weaknessValue = '×2'),null),
	('Pokemon','Carracosta','140','Rare','https://assets.tcgdex.net/en/bw/bw3/26/high.webp','Water','Noble Victories',4,'en',(SELECT abilityId FROM P10_Ability WHERE abilityName = 'Solid Rock' AND abilityEffect = 'If any damage is done to this Pokémon by attacks, flip a coin. If heads, reduce that damage by 50 (after applying Weakness and Resistance).'),(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Grass' AND weaknessValue = '×2'),null),
	('Pokémon','Miasmax','100','Peu Commune','https://assets.tcgdex.net/fr/bw/bw3/49/high.webp','Psy','Nobles Victoires',3,'fr',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Psy' AND weaknessValue = '×2'),null),
	('Pokemon','Jellicent','100','Rare','https://assets.tcgdex.net/en/bw/bw7/45/high.webp','Water','Boundaries Crossed',3,'en',(SELECT abilityId FROM P10_Ability WHERE abilityName = 'Stickiness' AND abilityEffect = 'The Retreat Cost of each of your opponent’s Pokémon in play is Colorless more.'),(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Lightning' AND weaknessValue = '×2'),null),
	('Pokémon','Cacnea','70','Commune','https://assets.tcgdex.net/fr/bw/bw9/9/high.webp','Plante','Glaciation Plasma',2,'fr',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Feu' AND weaknessValue = '×2'),(SELECT resistanceId FROM P10_Resistance WHERE resistanceType = 'Eau' AND resistanceValue = '-20')),
	('Pokemon','Celebi-EX','110','Rare','https://assets.tcgdex.net/en/bw/bw7/9/high.webp','Grass','Boundaries Crossed',1,'en',(SELECT abilityId FROM P10_Ability WHERE abilityName = 'Time Recall' AND abilityEffect = 'Each of your evolved Pokémon can use any attack from its previous Evolutions. (You still need the necessary Energy to use each attack.)'),(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Fire' AND weaknessValue = '×2'),(SELECT resistanceId FROM P10_Resistance WHERE resistanceType = 'Water' AND resistanceValue = '-20')),
	('Pokémon','Rattatac','70','Rare','https://assets.tcgdex.net/fr/bw/bw9/88/high.webp','Incolore','Glaciation Plasma',0,'fr',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Combat' AND weaknessValue = '×2'),null),
	('Trainer','Energy Retrieval',null,'Uncommon','https://assets.tcgdex.net/en/bw/bw10/80/high.webp',null,'Plasma Blast',null,'en',null,null,null),
	('Pokémon','Blizzaroi','120','Peu Commune','https://assets.tcgdex.net/fr/bw/bw10/26/high.webp','Eau','Explosion Plasma',2,'fr',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Métal' AND weaknessValue = '×2'),null),
	('Pokemon','Gyarados','130','Rare','https://assets.tcgdex.net/en/bw/bw6/24/high.webp','Water','Dragons Exalted',3,'en',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Lightning' AND weaknessValue = '×2'),null),
	('Pokémon','Neitram','80','Rare','https://assets.tcgdex.net/fr/bw/bw3/56/high.webp','Psy','Nobles Victoires',1,'fr',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Psy' AND weaknessValue = '×2'),null),
	('Pokemon','Zekrom','130','Rare','https://assets.tcgdex.net/en/bw/bw11/51/high.webp','Lightning','Legendary Treasures',2,'en',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Fighting' AND weaknessValue = '×2'),null),
	('Pokémon','Riolu','60','Commune','https://assets.tcgdex.net/fr/bw/bwp/BW33/high.webp','Combat','Promo BW',1,'fr',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Psy' AND weaknessValue = '×2'),null),
	('Pokemon','Rufflet','50','Common','https://assets.tcgdex.net/en/bw/bw8/115/high.webp','Colorless','Plasma Storm',1,'en',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Lightning' AND weaknessValue = '×2'),(SELECT resistanceId FROM P10_Resistance WHERE resistanceType = 'Fighting' AND resistanceValue = '-20')),
	('Dresseur','Pierrallégée',null,'Peu Commune','https://assets.tcgdex.net/fr/bw/bw9/99/high.webp',null,'Glaciation Plasma',null,'fr',(SELECT abilityId FROM P10_Ability WHERE abilityEffect = 'Le Pokémon auquel cette carte est attachée n''a pas de coût de Retraite.'),null,null),
	('Trainer','Cover Fossil',null,'Uncommon','https://assets.tcgdex.net/en/bw/bw3/90/high.webp',null,'Noble Victories',null,'en',null,null,null),
	('Pokémon','Flamajou','70','Commune','https://assets.tcgdex.net/fr/bw/bw2/18/high.webp','Feu','Pouvoirs Émergents',1,'fr',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Eau' AND weaknessValue = '×2'),null),
	('Pokemon','Pignite','100','Uncommon','https://assets.tcgdex.net/en/bw/bw1/17/high.webp','Fire','Black & White',3,'en',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Water' AND weaknessValue = '×2'),null),
	('Dresseur','Hyper Ball',null,'Magnifique rare','https://assets.tcgdex.net/fr/bw/bw9/122/high.webp',null,'Glaciation Plasma',null,'fr',(SELECT abilityId FROM P10_Ability WHERE abilityEffect = 'Défaussez 2 cartes de votre main. (Si vous ne pouvez pas défausser 2 cartes, vous ne pouvez pas jouer cette carte.) Cherchez un Pokémon dans votre deck, montrez-le, puis ajoutez-le à votre main. Mélangez ensuite votre deck.'),null,null),
	('Pokemon','White Kyurem-EX','180','Rare','https://assets.tcgdex.net/en/bw/bw7/103/high.webp','Dragon','Boundaries Crossed',3,'en',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Dragon' AND weaknessValue = '×2'),null),
	('Pokémon','Batracné','80','Peu Commune','https://assets.tcgdex.net/fr/bw/bw6/35/high.webp','Eau','Dragons Éxaltés',1,'fr',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Plante' AND weaknessValue = '×2'),null),
	('Pokemon','Psyduck','60','Common','https://assets.tcgdex.net/en/bw/bw7/32/high.webp','Water','Boundaries Crossed',1,'en',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Lightning' AND weaknessValue = '×2'),null),
	('Pokémon','Doudouvet','50','Commune','https://assets.tcgdex.net/fr/bw/bw7/14/high.webp','Plante','Frontières Franchies',1,'fr',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Feu' AND weaknessValue = '×2'),(SELECT resistanceId FROM P10_Resistance WHERE resistanceType = 'Eau' AND resistanceValue = '-20')),
	('Pokemon','Deerling','60','Common','https://assets.tcgdex.net/en/bw/bw1/13/high.webp','Grass','Black & White',1,'en',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Fire' AND weaknessValue = '×2'),(SELECT resistanceId FROM P10_Resistance WHERE resistanceType = 'Water' AND resistanceValue = '-20')),
	('Pokémon','Luxio','80','Commune','https://assets.tcgdex.net/fr/bw/bwp/BW34/high.webp','Électrique','Promo BW',1,'fr',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Combat' AND weaknessValue = '×2'),null),
	('Pokemon','Buneary','60','Common','https://assets.tcgdex.net/en/bw/bw7/116/high.webp','Colorless','Boundaries Crossed',1,'en',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Fighting' AND weaknessValue = '×2'),null),
	('Pokémon','Tylton','40','Peu Commune','https://assets.tcgdex.net/fr/bw/bw6/104/high.webp','Incolore','Dragons Éxaltés',1,'fr',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Électrique' AND weaknessValue = '×2'),(SELECT resistanceId FROM P10_Resistance WHERE resistanceType = 'Combat' AND resistanceValue = '-20')),
	('Pokemon','Deino','60','Common','https://assets.tcgdex.net/en/bw/bw6/94/high.webp','Dragon','Dragons Exalted',2,'en',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Dragon' AND weaknessValue = '×2'),null),
	('Pokémon','Noctunoir','130','Rare','https://assets.tcgdex.net/fr/bw/bw7/63/high.webp','Psy','Frontières Franchies',3,'fr',(SELECT abilityId FROM P10_Ability WHERE abilityName = 'Main Sinistre' AND abilityEffect = 'Autant de fois que vous le voulez pendant votre tour (avant votre attaque), vous pouvez déplacer 1 marqueur de dégâts de l’un des Pokémon de votre adversaire vers un autre des Pokémon de votre adversaire.'),(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Obscurité' AND weaknessValue = '×2'),null),
	('Pokemon','Excadrill','120','Rare','https://assets.tcgdex.net/en/bw/bw2/57/high.webp','Fighting','Emerging Powers',2,'en',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Water' AND weaknessValue = '×2'),(SELECT resistanceId FROM P10_Resistance WHERE resistanceType = 'Lightning' AND resistanceValue = '-20')),
	('Pokémon','Solochi','60','Commune','https://assets.tcgdex.net/fr/bw/bw6/94/high.webp','Dragon','Dragons Éxaltés',2,'fr',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Dragon' AND weaknessValue = '×2'),null),
	('Trainer','Rare Candy',null,'Uncommon','https://assets.tcgdex.net/en/bw/bw10/85/high.webp',null,'Plasma Blast',null,'en',null,null,null),
	('Pokémon','Majaspic','130','Rare','https://assets.tcgdex.net/fr/bw/bw1/6/high.webp','Plante','Noir & Blanc',1,'fr',(SELECT abilityId FROM P10_Ability WHERE abilityName = 'Soin Royal' AND abilityEffect = 'N’importe quand entre chaque tour, soignez 10 dégâts à chacun de vos Pokémon.'),(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Feu' AND weaknessValue = '×2'),(SELECT resistanceId FROM P10_Resistance WHERE resistanceType = 'Eau' AND resistanceValue = '-20')),
	('Pokemon','Shaymin-EX','110','Rare','https://assets.tcgdex.net/en/bw/bw4/5/high.webp','Grass','Next Destinies',1,'en',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Fire' AND weaknessValue = '×2'),(SELECT resistanceId FROM P10_Resistance WHERE resistanceType = 'Fighting' AND resistanceValue = '-20')),
	('Pokémon','Smogogo','100','Rare','https://assets.tcgdex.net/fr/bw/bw8/58/high.webp','Psy','Tempète Plasma',2,'fr',(SELECT abilityId FROM P10_Ability WHERE abilityName = 'Boom Final' AND abilityEffect = 'Lorsque ce Pokémon est mis K.O. par les dégâts d’une attaque de votre adversaire, défaussez les 3 cartes du dessus du deck de votre adversaire.'),(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Psy' AND weaknessValue = '×2'),null),
	('Pokemon','Muk','110','Rare','https://assets.tcgdex.net/en/bw/bw4/53/high.webp','Psychic','Next Destinies',4,'en',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Psychic' AND weaknessValue = '×2'),null),
	('Pokémon','Drattak','150','Rare','https://assets.tcgdex.net/fr/bw/bw10/64/high.webp','Dragon','Explosion Plasma',4,'fr',(SELECT abilityId FROM P10_Ability WHERE abilityName = 'Aile Impitoyable' AND abilityEffect = 'Lorsque vous jouez ce Pokémon de votre main pour faire évoluer 1 de vos Pokémon, vous pouvez défausser toutes les cartes Outil Pokémon attachées à chacun des Pokémon de votre adversaire.'),(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Dragon' AND weaknessValue = '×2'),null),
	('Pokemon','Nidoking','140','Rare','https://assets.tcgdex.net/en/bw/bw9/58/high.webp','Fighting','Plasma Freeze',3,'en',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Water' AND weaknessValue = '×2'),(SELECT resistanceId FROM P10_Resistance WHERE resistanceType = 'Lightning' AND resistanceValue = '-20')),
	('Pokémon','Métalosse','140','Rare','https://assets.tcgdex.net/fr/bw/bw9/52/high.webp','Psy','Glaciation Plasma',2,'fr',(SELECT abilityId FROM P10_Ability WHERE abilityName = 'Recherche Plasma' AND abilityEffect = 'Une seule fois pendant votre tour (avant votre attaque), vous pouvez chercher une carte de la Team Plasma dans votre deck, la montrer et l''ajouter à votre main. Mélangez ensuite votre deck. Vous ne pouvez pas utiliser une capacité spéciale du même nom pendant votre tour.'),(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Psy' AND weaknessValue = '×2'),null),
	('Pokemon','Munna','70','Uncommon','https://assets.tcgdex.net/en/bw/bw1/48/high.webp','Psychic','Black & White',2,'en',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Psychic' AND weaknessValue = '×2'),null),
	('Pokémon','Maracachi','90','Peu Commune','https://assets.tcgdex.net/fr/bw/bw8/11/high.webp','Plante','Tempète Plasma',1,'fr',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Feu' AND weaknessValue = '×2'),(SELECT resistanceId FROM P10_Resistance WHERE resistanceType = 'Eau' AND resistanceValue = '-20')),
	('Pokemon','Maractus','80','Uncommon','https://assets.tcgdex.net/en/bw/bw1/11/high.webp','Grass','Black & White',2,'en',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Fire' AND weaknessValue = '×2'),(SELECT resistanceId FROM P10_Resistance WHERE resistanceType = 'Water' AND resistanceValue = '-20')),
	('Pokémon','Statitik','40','Commune','https://assets.tcgdex.net/fr/bw/bw2/33/high.webp','Électrique','Pouvoirs Émergents',1,'fr',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Combat' AND weaknessValue = '×2'),null),
	('Pokemon','Beartic','130','Rare','https://assets.tcgdex.net/en/bw/bw2/30/high.webp','Water','Emerging Powers',3,'en',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Metal' AND weaknessValue = '×2'),null),
	('Pokémon','Qulbutoké','90','Peu Commune','https://assets.tcgdex.net/fr/bw/bw7/58/high.webp','Psy','Frontières Franchies',2,'fr',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Psy' AND weaknessValue = '×2'),null),
	('Pokemon','Metagross','140','Rare','https://assets.tcgdex.net/en/bw/bw9/52/high.webp','Psychic','Plasma Freeze',2,'en',(SELECT abilityId FROM P10_Ability WHERE abilityName = 'Plasma Search' AND abilityEffect = 'Once during your turn (before your attack), you may search your deck for a Team Plasma card, reveal it, and put it into your hand. Shuffle your deck afterward. You may not use an Ability with the same name during your turn.'),(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Psychic' AND weaknessValue = '×2'),null),
	('Pokémon','Drattak','150','Rare','https://assets.tcgdex.net/fr/bw/bw10/64/high.webp','Dragon','Explosion Plasma',4,'fr',(SELECT abilityId FROM P10_Ability WHERE abilityName = 'Aile Impitoyable' AND abilityEffect = 'Lorsque vous jouez ce Pokémon de votre main pour faire évoluer 1 de vos Pokémon, vous pouvez défausser toutes les cartes Outil Pokémon attachées à chacun des Pokémon de votre adversaire.'),(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Dragon' AND weaknessValue = '×2'),null),
	('Pokemon','Nidoking','140','Rare','https://assets.tcgdex.net/en/bw/bw9/58/high.webp','Fighting','Plasma Freeze',3,'en',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Water' AND weaknessValue = '×2'),(SELECT resistanceId FROM P10_Resistance WHERE resistanceType = 'Lightning' AND resistanceValue = '-20')),
	('Pokémon','Nanméouïe','90','Peu Commune','https://assets.tcgdex.net/fr/bw/bw2/83/high.webp','Incolore','Pouvoirs Émergents',2,'fr',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Combat' AND weaknessValue = '×2'),null),
	('Pokemon','Deino','60','Common','https://assets.tcgdex.net/en/bw/bw9/75/high.webp','Darkness','Plasma Freeze',2,'en',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Fighting' AND weaknessValue = '×2'),(SELECT resistanceId FROM P10_Resistance WHERE resistanceType = 'Psychic' AND resistanceValue = '-20')),
	('Pokémon','Funécire','60','Commune','https://assets.tcgdex.net/fr/bw/bw9/14/high.webp','Feu','Glaciation Plasma',1,'fr',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Eau' AND weaknessValue = '×2'),null),
	('Pokemon','Virizion','110','Rare','https://assets.tcgdex.net/en/bw/bw3/13/high.webp','Grass','Noble Victories',1,'en',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Fire' AND weaknessValue = '×2'),(SELECT resistanceId FROM P10_Resistance WHERE resistanceType = 'Water' AND resistanceValue = '-20')),
	('Pokémon','Miradar','90','Rare','https://assets.tcgdex.net/fr/bw/bw8/113/high.webp','Incolore','Tempète Plasma',1,'fr',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Combat' AND weaknessValue = '×2'),null),
	('Pokemon','Hydreigon','150','Rare','https://assets.tcgdex.net/en/bw/bw11/99/high.webp','Dragon','Legendary Treasures',3,'en',(SELECT abilityId FROM P10_Ability WHERE abilityName = 'Dark Trance' AND abilityEffect = 'As often as you like during your turn (before your attack), you may move a Darkness Energy attached to 1 of your Pokémon to another of your Pokémon.'),(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Dragon' AND weaknessValue = '×2'),null),
	('Dresseur','Fossile Plume',null,'Peu Commune','https://assets.tcgdex.net/fr/bw/bw3/93/high.webp',null,'Nobles Victoires',null,'fr',(SELECT abilityId FROM P10_Ability WHERE abilityEffect = 'Regardez les 7 cartes du dessous de votre deck. Vous pouvez montrer un Arkéapti que vous y trouvez et le placer sur votre Banc. Mélangez les autres cartes avec votre deck.'),null,null),
	('Pokemon','Crustle','100','Rare','https://assets.tcgdex.net/en/bw/bw7/85/high.webp','Fighting','Boundaries Crossed',3,'en',(SELECT abilityId FROM P10_Ability WHERE abilityName = 'Sturdy' AND abilityEffect = 'If this Pokémon has full HP and would be Knocked Out by damage from an attack, this Pokémon is not Knocked Out and its remaining HP becomes 10 instead.'),(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Grass' AND weaknessValue = '×2'),null),
	('Pokémon','Mentali','90','Rare','https://assets.tcgdex.net/fr/bw/bw5/48/high.webp','Psy','Explorateurs Obscurs',1,'fr',(SELECT abilityId FROM P10_Ability WHERE abilityName = 'Révélation Solaire' AND abilityEffect = 'Évitez tous les effets des attaques de votre adversaire, excepté les dégâts, infligés à chacun de vos Pokémon auquel de l’Énergie est attachée.'),(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Psy' AND weaknessValue = '×2'),null),
	('Pokemon','Nidoran♂','60','Common','https://assets.tcgdex.net/en/bw/bw9/43/high.webp','Psychic','Plasma Freeze',1,'en',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Psychic' AND weaknessValue = '×2'),null),
	('Dresseur','Mont Foré',null,'Peu Commune','https://assets.tcgdex.net/fr/bw/bw5/101/high.webp',null,'Explorateurs Obscurs',null,'fr',(SELECT abilityId FROM P10_Ability WHERE abilityEffect = 'Une seule fois pendant le tour de chaque joueur, ce joueur peut lancer une pièce. Si c’est face, le joueur place un Pokémon Recréé de sa main sur son Banc.'),null,null),
	('Pokemon','Hoothoot','60','Common','https://assets.tcgdex.net/en/bw/bw9/91/high.webp','Colorless','Plasma Freeze',1,'en',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Lightning' AND weaknessValue = '×2'),(SELECT resistanceId FROM P10_Resistance WHERE resistanceType = 'Fighting' AND resistanceValue = '-20')),
	('Pokémon','Scalproie','90','Rare','https://assets.tcgdex.net/fr/bw/bw5/72/high.webp','Obscurité','Explorateurs Obscurs',1,'fr',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Combat' AND weaknessValue = '×2'),(SELECT resistanceId FROM P10_Resistance WHERE resistanceType = 'Psy' AND resistanceValue = '-20')),
	('Pokemon','Conkeldurr','140','Rare','https://assets.tcgdex.net/en/bw/bw3/65/high.webp','Fighting','Noble Victories',3,'en',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Psychic' AND weaknessValue = '×2'),null),
	('Pokémon','Gueriaigle','100','Rare','https://assets.tcgdex.net/fr/bw/bw2/88/high.webp','Incolore','Pouvoirs Émergents',1,'fr',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Électrique' AND weaknessValue = '×2'),(SELECT resistanceId FROM P10_Resistance WHERE resistanceType = 'Combat' AND resistanceValue = '-20')),
	('Pokemon','Pidove','50','Common','https://assets.tcgdex.net/en/bw/bw2/80/high.webp','Colorless','Emerging Powers',1,'en',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Lightning' AND weaknessValue = '×2'),(SELECT resistanceId FROM P10_Resistance WHERE resistanceType = 'Fighting' AND resistanceValue = '-20')),
	('Dresseur','Récupération d’Énergie Supérieure',null,'Peu Commune','https://assets.tcgdex.net/fr/bw/bw9/103/high.webp',null,'Glaciation Plasma',null,'fr',(SELECT abilityId FROM P10_Ability WHERE abilityEffect = 'Défaussez 2 cartes de votre main. (Si vous ne pouvez pas défausser 2 cartes, vous ne pouvez pas jouer cette carte.) Ajoutez 4 cartes Énergie de base de votre pile de défausse à votre main. (Vous ne pouvez pas choisir une carte que vous avez défaussée du fait de l''effet de cette carte.)'),null,null),
	('Pokemon','Miltank','100','Uncommon','https://assets.tcgdex.net/en/bw/bw9/93/high.webp','Colorless','Plasma Freeze',3,'en',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Fighting' AND weaknessValue = '×2'),null),
	('Dresseur','Carolina',null,'Peu Commune','https://assets.tcgdex.net/fr/bw/bw7/134/high.webp',null,'Frontières Franchies',null,'fr',(SELECT abilityId FROM P10_Ability WHERE abilityEffect = 'Cherchez une carte Dresseur dans votre deck, montrez-la, puis ajoutez-la à votre main. Mélangez ensuite votre deck.'),null,null),
	('Pokemon','Loudred','90','Uncommon','https://assets.tcgdex.net/en/bw/bw8/106/high.webp','Colorless','Plasma Storm',3,'en',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Fighting' AND weaknessValue = '×2'),null),
	('Pokémon','Lixy','60','Commune','https://assets.tcgdex.net/fr/bw/bw4/42/high.webp','Électrique','Destinées Futures',1,'fr',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Combat' AND weaknessValue = '×2'),null),
	('Pokemon','Tynamo','40','Common','https://assets.tcgdex.net/en/bw/bw3/38/high.webp','Lightning','Noble Victories',1,'en',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Fighting' AND weaknessValue = '×2'),null),
	('Pokémon','Ténéfix','70','Rare','https://assets.tcgdex.net/fr/bw/bw9/49/high.webp','Psy','Glaciation Plasma',1,'fr',null,null,null),
	('Pokemon','Emolga','70','Uncommon','https://assets.tcgdex.net/en/bw/bw6/45/high.webp','Lightning','Dragons Exalted',0,'en',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Lightning' AND weaknessValue = '×2'),(SELECT resistanceId FROM P10_Resistance WHERE resistanceType = 'Fighting' AND resistanceValue = '-20')),
	('Pokémon','Kyurem-EX','180','Rare','https://assets.tcgdex.net/fr/bw/bw4/38/high.webp','Eau','Destinées Futures',3,'fr',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Métal' AND weaknessValue = '×2'),null),
	('Pokemon','Basculin','70','Uncommon','https://assets.tcgdex.net/en/bw/bw1/35/high.webp','Water','Black & White',1,'en',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Lightning' AND weaknessValue = '×2'),null),
	('Pokémon','Statitik','30','Commune','https://assets.tcgdex.net/fr/bw/bw5/41/high.webp','Électrique','Explorateurs Obscurs',1,'fr',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Combat' AND weaknessValue = '×2'),null),
	('Pokemon','Oshawott','60','Common','https://assets.tcgdex.net/en/bw/bw11/37/high.webp','Water','Legendary Treasures',1,'en',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Lightning' AND weaknessValue = '×2'),null),
	('Pokémon','Machoc','60','Commune','https://assets.tcgdex.net/fr/bw/bw10/47/high.webp','Combat','Explosion Plasma',3,'fr',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Psy' AND weaknessValue = '×2'),null),
	('Pokemon','Gothita','60','Common','https://assets.tcgdex.net/en/bw/bw2/43/high.webp','Psychic','Emerging Powers',1,'en',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Psychic' AND weaknessValue = '×2'),null),
	('Pokémon','Cobaltium','120','Ultra Rare','https://assets.tcgdex.net/fr/bw/bw3/100/high.webp','Métal','Nobles Victoires',2,'fr',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Feu' AND weaknessValue = '×2'),(SELECT resistanceId FROM P10_Resistance WHERE resistanceType = 'Psy' AND resistanceValue = '-20')),
	('Pokemon','Garchomp','140','Rare','https://assets.tcgdex.net/en/bw/bw6/91/high.webp','Dragon','Dragons Exalted',0,'en',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Dragon' AND weaknessValue = '×2'),null),
	('Dresseur','Huile',null,'Peu Commune','https://assets.tcgdex.net/fr/bw/bw8/121/high.webp',null,'Tempète Plasma',null,'fr',(SELECT abilityId FROM P10_Ability WHERE abilityEffect = 'Montrez la carte du dessus de votre deck. Si la carte est une carte Énergie de base, attachez-la à 1 de vos Pokémon. Si ce n’est pas une carte Énergie de base, remettez-la sur le dessus de votre deck.'),null,null),
	('Trainer','Shadow Triad',null,'Uncommon','https://assets.tcgdex.net/en/bw/bw9/102/high.webp',null,'Plasma Freeze',null,'en',null,null,null),
	('Pokémon','Kyurem Blanc EX','180','Ultra Rare','https://assets.tcgdex.net/fr/bw/bw7/146/high.webp','Dragon','Frontières Franchies',3,'fr',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Dragon' AND weaknessValue = '×2'),null),
	('Pokemon','Gardevoir','110','Secret Rare','https://assets.tcgdex.net/en/bw/bw5/109/high.webp','Psychic','Dark Explorers',2,'en',(SELECT abilityId FROM P10_Ability WHERE abilityName = 'Psychic Mirage' AND abilityEffect = 'Each basic Psychic Energy attached to your Psychic Pokémon provides PsychicPsychic Energy. You can''t apply more than 1 Psychic Mirage Ability at a time.'),(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Psychic' AND weaknessValue = '×2'),null),
	('Pokémon','Lewsor','60','Commune','https://assets.tcgdex.net/fr/bw/bwp/BW55/high.webp','Psy','Promo BW',1,'fr',(SELECT abilityId FROM P10_Ability WHERE abilityName = 'Bouclier Faiblesse' AND abilityEffect = 'Si de l''Énergie Psychic est attachée à ce Pokémon, ce Pokémon n''a pas de Faiblesse.'),(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Psy' AND weaknessValue = '×2'),null),
	('Pokemon','Terrakion-EX','180','Ultra Rare','https://assets.tcgdex.net/en/bw/bw6/121/high.webp','Fighting','Dragons Exalted',3,'en',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Grass' AND weaknessValue = '×2'),null),
	('Pokémon','Corboss','110','Rare','https://assets.tcgdex.net/fr/bw/bw6/73/high.webp','Obscurité','Dragons Éxaltés',2,'fr',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Électrique' AND weaknessValue = '×2'),(SELECT resistanceId FROM P10_Resistance WHERE resistanceType = 'Combat' AND resistanceValue = '-20')),
	('Pokemon','Archen','80','Uncommon','https://assets.tcgdex.net/en/bw/bw3/66/high.webp','Fighting','Noble Victories',1,'en',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Grass' AND weaknessValue = '×2'),null),
	('Pokémon','Registeel-EX','180','Rare','https://assets.tcgdex.net/fr/bw/bw6/81/high.webp','Métal','Dragons Éxaltés',4,'fr',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Feu' AND weaknessValue = '×2'),(SELECT resistanceId FROM P10_Resistance WHERE resistanceType = 'Psy' AND resistanceValue = '-20')),
	('Pokemon','Lunatone','90','Uncommon','https://assets.tcgdex.net/en/bw/bw8/73/high.webp','Fighting','Plasma Storm',3,'en',(SELECT abilityId FROM P10_Ability WHERE abilityName = 'Premonition' AND abilityEffect = 'Once during your turn (before your attack), you may look at the top 2 cards of your deck and put them back on top of your deck in any order.'),(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Grass' AND weaknessValue = '×2'),null),
	('Pokémon','Ratentif','60','Commune','https://assets.tcgdex.net/fr/bw/bw7/118/high.webp','Incolore','Frontières Franchies',1,'fr',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Combat' AND weaknessValue = '×2'),null),
	('Pokemon','Slakoth','60','Common','https://assets.tcgdex.net/en/bw/bw6/101/high.webp','Colorless','Dragons Exalted',2,'en',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Fighting' AND weaknessValue = '×2'),null),
	('Pokémon','Minotaupe','120','Rare','https://assets.tcgdex.net/fr/bw/bw2/57/high.webp','Combat','Pouvoirs Émergents',2,'fr',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Eau' AND weaknessValue = '×2'),(SELECT resistanceId FROM P10_Resistance WHERE resistanceType = 'Électrique' AND resistanceValue = '-20')),
	('Pokemon','Cofagrigus','100','Rare','https://assets.tcgdex.net/en/bw/bw5/52/high.webp','Psychic','Dark Explorers',2,'en',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Darkness' AND weaknessValue = '×2'),null);

INSERT INTO P10_Contient(cardId, attackId) VALUES
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/fr/bw/bw6/100/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Coup Double' AND attackCost = 'Incolore' AND attackDamage = '20'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/fr/bw/bw6/100/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Catapu-Main' AND attackCost = 'IncoloreIncolore' AND attackDamage = '10'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/en/bw/bw7/91/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Tail Trickery' AND attackCost = 'Darkness' AND attackDamage = null))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/en/bw/bw7/91/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Assist' AND attackCost = 'DarknessColorlessColorless' AND attackDamage = null))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/en/bw/bw2/48/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Smack' AND attackCost = 'Psychic' AND attackDamage = '30'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/en/bw/bw2/48/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Mental Shock' AND attackCost = 'PsychicColorlessColorless' AND attackDamage = '60'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/fr/bw/bw3/26/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Mâchouille' AND attackCost = 'EauEauIncoloreIncolore' AND attackDamage = '80'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/en/bw/bw5/24/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Lazy Headbutt' AND attackCost = 'WaterColorless' AND attackDamage = '80'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/fr/bw/bw6/29/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Roulade Obstinée' AND attackCost = 'EauIncolore' AND attackDamage = '10'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/en/bw/bw3/26/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Crunch' AND attackCost = 'WaterWaterColorlessColorless' AND attackDamage = '80'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/fr/bw/bw3/49/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Enveloppe Douce' AND attackCost = 'PsyIncolore' AND attackDamage = '30'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/fr/bw/bw3/49/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Détricanon' AND attackCost = 'PsyPsyIncolore' AND attackDamage = '60'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/en/bw/bw7/45/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Eerie Light' AND attackCost = 'WaterColorlessColorless' AND attackDamage = '40'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/fr/bw/bw9/9/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Dard-Venin' AND attackCost = 'Plante' AND attackDamage = null))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/en/bw/bw7/9/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Wind Whisk' AND attackCost = 'GrassColorlessColorless' AND attackDamage = '60'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/fr/bw/bw9/88/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Transfert de Camelote' AND attackCost = 'Incolore' AND attackDamage = null))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/fr/bw/bw9/88/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Morsure' AND attackCost = 'IncoloreIncolore' AND attackDamage = '30'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/fr/bw/bw10/26/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Tranch''Herbe' AND attackCost = 'PlantePlante' AND attackDamage = '40'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/fr/bw/bw10/26/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Choc Frontal' AND attackCost = 'PlantePlanteIncolore' AND attackDamage = '80'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/en/bw/bw6/24/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Sharp Fang' AND attackCost = 'WaterColorlessColorless' AND attackDamage = '60'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/en/bw/bw6/24/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Swing Around' AND attackCost = 'WaterColorlessColorlessColorless' AND attackDamage = '60'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/fr/bw/bw3/56/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Synchropeine' AND attackCost = 'Psy' AND attackDamage = '20'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/fr/bw/bw3/56/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Piqûre Psy' AND attackCost = 'PsyIncolore' AND attackDamage = '40'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/en/bw/bw11/51/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Outrage' AND attackCost = 'ColorlessColorless' AND attackDamage = '20'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/en/bw/bw11/51/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Bolt Strike' AND attackCost = 'LightningLightningColorless' AND attackDamage = '120'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/fr/bw/bwp/BW33/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Course Effrénée' AND attackCost = 'Incolore' AND attackDamage = 'n/a'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/fr/bw/bwp/BW33/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Crochet' AND attackCost = 'CombatIncolore' AND attackDamage = '30'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/en/bw/bw8/115/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Incessant Peck' AND attackCost = 'ColorlessColorless' AND attackDamage = '10'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/fr/bw/bw2/18/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Collecte' AND attackCost = 'Incolore' AND attackDamage = null))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/fr/bw/bw2/18/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Griffe' AND attackCost = 'IncoloreIncolore' AND attackDamage = '20'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/en/bw/bw1/17/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Flame Charge' AND attackCost = 'Colorless' AND attackDamage = null))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/en/bw/bw1/17/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Heat Crash' AND attackCost = 'FireFireColorless' AND attackDamage = '50'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/en/bw/bw7/103/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Dragon Stream' AND attackCost = 'FireColorlessColorless' AND attackDamage = '60'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/en/bw/bw7/103/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Ice Burn' AND attackCost = 'FireFireWaterColorless' AND attackDamage = '150'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/fr/bw/bw6/35/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Ultrason' AND attackCost = 'Incolore' AND attackDamage = null))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/fr/bw/bw6/35/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Mégaphone' AND attackCost = 'EauIncoloreIncolore' AND attackDamage = '50'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/en/bw/bw7/32/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Dazzle Dance' AND attackCost = 'Colorless' AND attackDamage = null))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/fr/bw/bw7/14/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Collision' AND attackCost = 'Incolore' AND attackDamage = '10'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/en/bw/bw1/13/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Double Kick' AND attackCost = 'Colorless' AND attackDamage = '10'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/en/bw/bw1/13/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Leech Seed' AND attackCost = 'GrassColorless' AND attackDamage = '20'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/fr/bw/bwp/BW34/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Explosion de Lumière' AND attackCost = 'Électrique' AND attackDamage = '10'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/fr/bw/bwp/BW34/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Étincelle Surprise' AND attackCost = 'ÉlectriqueIncoloreIncolore' AND attackDamage = 'n/a'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/en/bw/bw7/116/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Pound' AND attackCost = 'Colorless' AND attackDamage = '10'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/en/bw/bw7/116/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Smash Kick' AND attackCost = 'ColorlessColorless' AND attackDamage = '20'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/fr/bw/bw6/104/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Berceuse' AND attackCost = 'Incolore' AND attackDamage = null))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/fr/bw/bw6/104/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Picpic' AND attackCost = 'IncoloreIncolore' AND attackDamage = '20'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/en/bw/bw6/94/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Guard Press' AND attackCost = 'Darkness' AND attackDamage = '10'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/en/bw/bw6/94/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Headbutt' AND attackCost = 'PsychicColorlessColorless' AND attackDamage = '30'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/fr/bw/bw7/63/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Poing Ombre' AND attackCost = 'PsyIncoloreIncoloreIncolore' AND attackDamage = '60'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/en/bw/bw2/57/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Dig' AND attackCost = 'FightingColorless' AND attackDamage = '30'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/en/bw/bw2/57/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Earthquake' AND attackCost = 'FightingColorlessColorless' AND attackDamage = '70'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/fr/bw/bw6/94/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Pression de Garde' AND attackCost = 'Obscurité' AND attackDamage = '10'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/fr/bw/bw6/94/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Coup d''Boule' AND attackCost = 'PsyIncoloreIncolore' AND attackDamage = '30'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/fr/bw/bw1/6/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Phytomixeur' AND attackCost = 'PlanteIncolore' AND attackDamage = '60'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/en/bw/bw4/5/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Synthesis' AND attackCost = 'Grass' AND attackDamage = null))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/en/bw/bw4/5/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Revenge Blast' AND attackCost = 'GrassColorless' AND attackDamage = '30'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/fr/bw/bw8/58/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Smog Envahissant' AND attackCost = 'PsyIncolore' AND attackDamage = null))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/en/bw/bw4/53/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Gentle Wrap' AND attackCost = 'PsychicColorless' AND attackDamage = '20'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/en/bw/bw4/53/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Toxic Secretion' AND attackCost = 'PsychicColorlessColorlessColorless' AND attackDamage = '60'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/fr/bw/bw10/64/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Anéantissement de Gaïa' AND attackCost = 'FeuEauIncoloreIncolore' AND attackDamage = '100'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/en/bw/bw9/58/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Lovestrike' AND attackCost = 'ColorlessColorless' AND attackDamage = '20'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/en/bw/bw9/58/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Horn Drill' AND attackCost = 'FightingColorlessColorlessColorless' AND attackDamage = '90'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/fr/bw/bw9/52/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Contrôleur d''Esprit' AND attackCost = 'PsyIncoloreIncoloreIncolore' AND attackDamage = '60'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/en/bw/bw1/48/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Hypnosis' AND attackCost = 'Colorless' AND attackDamage = null))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/en/bw/bw1/48/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Dream Eater' AND attackCost = 'PsychicPsychic' AND attackDamage = '60'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/fr/bw/bw8/11/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Danse Éblouissante' AND attackCost = 'Plante' AND attackDamage = '10'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/fr/bw/bw8/11/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Embuscade' AND attackCost = 'PlanteIncolore' AND attackDamage = '20'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/en/bw/bw1/11/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Mega Drain' AND attackCost = 'Grass' AND attackDamage = '20'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/en/bw/bw1/11/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Pin Missile' AND attackCost = 'GrassGrassColorless' AND attackDamage = '20'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/fr/bw/bw2/33/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Ronge' AND attackCost = 'Incolore' AND attackDamage = '10'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/en/bw/bw2/30/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Sheer Cold' AND attackCost = 'WaterColorlessColorless' AND attackDamage = '50'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/en/bw/bw2/30/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Icicle Crash' AND attackCost = 'WaterWaterColorlessColorless' AND attackDamage = '80'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/fr/bw/bw7/58/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Culbute Surprise' AND attackCost = 'PsyPsyIncolore' AND attackDamage = '60'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/en/bw/bw9/52/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Mind Bend' AND attackCost = 'PsychicColorlessColorlessColorless' AND attackDamage = '60'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/fr/bw/bw10/64/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Anéantissement de Gaïa' AND attackCost = 'FeuEauIncoloreIncolore' AND attackDamage = '100'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/en/bw/bw9/58/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Lovestrike' AND attackCost = 'ColorlessColorless' AND attackDamage = '20'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/en/bw/bw9/58/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Horn Drill' AND attackCost = 'FightingColorlessColorlessColorless' AND attackDamage = '90'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/fr/bw/bw2/83/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Grosse Baffe' AND attackCost = 'Incolore' AND attackDamage = '40'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/fr/bw/bw2/83/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Vibra Soin' AND attackCost = 'IncoloreIncoloreIncolore' AND attackDamage = null))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/en/bw/bw9/75/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Push Down' AND attackCost = 'DarknessColorless' AND attackDamage = '20'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/en/bw/bw9/75/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Bite' AND attackCost = 'DarknessColorlessColorless' AND attackDamage = '30'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/fr/bw/bw9/14/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Roussi' AND attackCost = 'Feu' AND attackDamage = null))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/fr/bw/bw9/14/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Charbon Mutant' AND attackCost = 'FeuIncolore' AND attackDamage = '20'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/en/bw/bw3/13/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Double Draw' AND attackCost = 'Colorless' AND attackDamage = null))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/en/bw/bw3/13/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Leaf Wallop' AND attackCost = 'GrassColorless' AND attackDamage = '40'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/fr/bw/bw8/113/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Double Morsure' AND attackCost = 'IncoloreIncolore' AND attackDamage = '20'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/fr/bw/bw8/113/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Balayage' AND attackCost = 'IncoloreIncoloreIncolore' AND attackDamage = '60'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/en/bw/bw11/99/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Dragonblast' AND attackCost = 'PsychicDarknessDarknessColorless' AND attackDamage = '140'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/en/bw/bw7/85/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Stone Edge' AND attackCost = 'FightingFightingColorless' AND attackDamage = '70'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/en/bw/bw9/43/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Hit Back' AND attackCost = 'Psychic' AND attackDamage = '30'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/en/bw/bw9/91/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Dual Draw' AND attackCost = 'Colorless' AND attackDamage = null))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/en/bw/bw3/65/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Chip Away' AND attackCost = 'Fighting' AND attackDamage = '40'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/en/bw/bw3/65/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Swing Around' AND attackCost = 'FightingFightingColorless' AND attackDamage = '60'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/fr/bw/bw2/88/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Cru-Aile' AND attackCost = 'IncoloreIncolore' AND attackDamage = '40'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/fr/bw/bw2/88/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Rapace' AND attackCost = 'IncoloreIncoloreIncolore' AND attackDamage = '90'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/en/bw/bw2/80/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Gust' AND attackCost = 'ColorlessColorless' AND attackDamage = '20'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/en/bw/bw9/93/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Max Milk' AND attackCost = 'ColorlessColorless' AND attackDamage = null))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/en/bw/bw9/93/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Tackle' AND attackCost = 'ColorlessColorless' AND attackDamage = '30'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/en/bw/bw8/106/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Supersonic' AND attackCost = 'Colorless' AND attackDamage = null))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/en/bw/bw8/106/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Hyper Voice' AND attackCost = 'ColorlessColorlessColorless' AND attackDamage = '50'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/fr/bw/bw4/42/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Saut' AND attackCost = 'Électrique' AND attackDamage = '10'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/fr/bw/bw4/42/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Choc Statique' AND attackCost = 'ÉlectriqueIncolore' AND attackDamage = '20'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/en/bw/bw3/38/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Thunder Wave' AND attackCost = 'Lightning' AND attackDamage = '10'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/fr/bw/bw9/49/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Griffe' AND attackCost = 'Incolore' AND attackDamage = '10'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/fr/bw/bw9/49/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Cage d’Ombre' AND attackCost = 'PsyIncolore' AND attackDamage = '20'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/en/bw/bw6/45/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Call for Family' AND attackCost = 'Colorless' AND attackDamage = null))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/en/bw/bw6/45/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Static Shock' AND attackCost = 'Lightning' AND attackDamage = '20'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/fr/bw/bw4/38/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Ailes Gelées' AND attackCost = 'EauIncoloreIncolore' AND attackDamage = '60'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/fr/bw/bw4/38/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Tempêtegrêle' AND attackCost = 'EauEauIncoloreIncolore' AND attackDamage = '120'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/en/bw/bw1/35/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Crunch' AND attackCost = 'WaterWater' AND attackDamage = '30'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/en/bw/bw11/37/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Razor Shell' AND attackCost = 'WaterColorless' AND attackDamage = '20'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/fr/bw/bw10/47/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Balayage' AND attackCost = 'CombatIncolore' AND attackDamage = '30'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/en/bw/bw2/43/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Hypnotic Gaze' AND attackCost = 'Colorless' AND attackDamage = null))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/en/bw/bw2/43/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Double Slap' AND attackCost = 'ColorlessColorless' AND attackDamage = '20'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/fr/bw/bw3/100/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Pression Énergétique' AND attackCost = 'MétalIncolore' AND attackDamage = '20'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/fr/bw/bw3/100/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Brise-Fer' AND attackCost = 'MétalMétalIncolore' AND attackDamage = '80'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/en/bw/bw6/91/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Jet Headbutt' AND attackCost = 'Colorless' AND attackDamage = '40'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/en/bw/bw6/91/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Sand Tomb' AND attackCost = 'WaterFightingColorless' AND attackDamage = '80'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/fr/bw/bw7/146/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Flux Draconique' AND attackCost = 'FeuIncoloreIncolore' AND attackDamage = '60'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/fr/bw/bw7/146/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Feu Glacé' AND attackCost = 'FeuFeuEauIncolore' AND attackDamage = '150'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/en/bw/bw5/109/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Mind Shock' AND attackCost = 'PsychicPsychicColorlessColorless' AND attackDamage = '60'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/fr/bw/bwp/BW55/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Coup d''Poing Éclair' AND attackCost = 'IncoloreIncolore' AND attackDamage = '10'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/en/bw/bw6/121/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Rock Tumble' AND attackCost = 'FightingColorless' AND attackDamage = '50'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/en/bw/bw6/121/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Pump-up Smash' AND attackCost = 'FightingFightingColorless' AND attackDamage = '90'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/fr/bw/bw6/73/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Cyclone' AND attackCost = 'IncoloreIncolore' AND attackDamage = '30'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/fr/bw/bw6/73/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Rafle Plongeante' AND attackCost = 'ObscuritéIncoloreIncolore' AND attackDamage = '70'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/en/bw/bw3/66/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Rock Throw' AND attackCost = 'Fighting' AND attackDamage = '20'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/en/bw/bw3/66/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Acrobatics' AND attackCost = 'ColorlessColorless' AND attackDamage = '20'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/fr/bw/bw6/81/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Triple Laser' AND attackCost = 'IncoloreIncoloreIncolore' AND attackDamage = null))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/fr/bw/bw6/81/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Recharge Protectrice' AND attackCost = 'MétalMétalIncoloreIncolore' AND attackDamage = '80'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/en/bw/bw8/73/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Rock Throw' AND attackCost = 'FightingColorless' AND attackDamage = '30'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/fr/bw/bw7/118/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Patrouille' AND attackCost = 'Incolore' AND attackDamage = null))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/en/bw/bw6/101/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Smack ''n'' Slack' AND attackCost = 'Colorless' AND attackDamage = '10'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/fr/bw/bw2/57/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Tunnel' AND attackCost = 'CombatIncolore' AND attackDamage = '30'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/fr/bw/bw2/57/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Séisme' AND attackCost = 'CombatIncoloreIncolore' AND attackDamage = '70'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/en/bw/bw5/52/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Chuck' AND attackCost = 'ColorlessColorless' AND attackDamage = '40'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/en/bw/bw5/52/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Lock Up' AND attackCost = 'PsychicPsychic' AND attackDamage = '40'))