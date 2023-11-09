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
	('Sol Verglacé','Une seule fois pendant votre tour (avant votre attaque), vous pouvez échanger votre Pokémon Actif avec 1 de vos Pokémon de Banc. Dans ce cas, votre adversaire échange son Pokémon Actif avec 1 de ses Pokémon de Banc.'),
	('Laid-Back','Any damage done to this Pokémon by attacks is reduced by 20 (after applying Weakness and Resistance).'),
	('Scorching Scales','Put 4 damage counters instead of 2 on your opponent’s Burned Pokémon between turns.'),
	('Stellar Guidance','When you play this Pokémon from your hand onto your Bench, you may search your deck for a Supporter card, reveal it, and put it into your hand. Shuffle your deck afterward.'),
	('Dual Armor','If this Pokémon has any Metal Energy attached to it, this Pokémon’s type is both Fighting and Metal.'),
	('Transfert Plasma','Autant de fois que vous le voulez pendant votre tour (avant votre attaque), vous pouvez déplacer une Énergie Plasma attachée à 1 de vos Pokémon vers un autre de vos Pokémon.'),
	('Poison Point','If this Pokémon is your Active Pokémon and is damaged by an opponent’s attack (even if this Pokémon is Knocked Out), the Attacking Pokémon is now Poisoned.'),
	('Freeze Zone','The Retreat Cost of each of your Team Plasma Pokémon in play is ColorlessColorless less.'),
	('Contre-Offensive','Si ce Pokémon est votre Pokémon Actif et qu’il subit les dégâts d’une attaque de votre adversaire (même si ce Pokémon est mis K.O.), placez 2 marqueurs de dégâts sur le Pokémon Attaquant.'),
	('Prehistoric Call','Once during your turn (before your attack), if this Pokémon is in your discard pile, you may put this Pokémon on the bottom of your deck.'),
	('Tool Reversal','As often as you like during your turn (before your attack), you may put a Pokémon Tool card attached to 1 of your Pokémon into your hand.'),
	('Dark Trance','As often as you like during your turn (before your attack), you may move a Darkness Energy attached to 1 of your Pokémon to another of your Pokémon.');

INSERT INTO P10_Attack(attackName,attackCost,attackDamage,attackEffect) VALUES 
	('Brise-Glace','EauIncoloreIncolore','60','Inflige 10 dégâts supplémentaires pour chaque Colorless dans le coût de Retraite du Pokémon Défenseur.'),
	('Flailing Flop','Colorless','10','Flip a coin. If tails, this Pokémon does 10 damage to itself.'),
	('Laser Glace','EauIncoloreIncolore','50','Lancez une pièce. Si c''est face, le Pokémon Défenseur est maintenant Paralysé.'),
	('Fire Fang','FireColorless','20','The Defending Pokémon is now Burned.'),
	('Cri du Ciel','Incolore',null,'Défaussez les 3 cartes du dessus de votre deck. Si vous y trouvez des cartes Énergie, attachez-les à ce Pokémon.'),
	('Glare and Peck','ColorlessColorless','10','Flip a coin. If heads, the Defending Pokémon is now Paralyzed.'),
	('Vol','IncoloreIncolore','50','Lancez une pièce. Si c’est pile, cette attaque ne fait rien. Si c’est face, évitez tous les effets d’attaques (y compris les dégâts) infligés à ce Pokémon pendant le prochain tour de votre adversaire.'),
	('Scratch','ColorlessColorless','20',null),
	('Doubleslap','ColorlessColorless','30','Flip 2 coins. This attack does 30 damage times the number of heads.'),
	('Roue d''Énergie','Incolore',null,'Déplacez une Énergie de l''un de vos Pokémon de Banc vers ce Pokémon.'),
	('Triple Laser','ColorlessColorlessColorless',null,'This attack does 30 damage to 3 of your opponent''s Pokémon. (Don''t apply Weakness and Resistance for Benched Pokémon.)'),
	('Pression de Garde','IncoloreIncolore','20','Pendant le prochain tour de votre adversaire, tous les dégâts infligés à ce Pokémon par des attaques sont réduits de 20 (après application de la Faiblesse et de la Résistance).'),
	('Tackle','Colorless','10',null),
	('Grosse Vague','Incolore','20',null),
	('Ice Ball','WaterColorless','30',null),
	('Roulade','Plante','20',null),
	('Bug Bite','Grass','20',null),
	('Mud Gun','WaterColorlessColorless','60','If this Pokémon has any Fighting Energy attached to it, this attack does 30 more damage.'),
	('Griffe','MétalIncolore','20',null),
	('Ram','Colorless','10',null),
	('Pluie Éclaboussante','IncoloreIncolore','20',null),
	('Jump On','ColorlessColorless','20','Flip a coin. If heads, this attack does 10 more damage.'),
	('Lait Max','IncoloreIncolore',null,'Soignez tous les dégâts de l''un de vos Pokémon. Ensuite, défaussez toutes les Énergies attachées à ce Pokémon.'),
	('Celestial Roar','Colorless',null,'Discard the top 3 cards of your deck. If any of those cards are Energy cards, attach them to this Pokémon.'),
	('Fléau','Incolore','10','Inflige 10 dégâts multipliés par le nombre de marqueurs de dégâts placés sur ce Pokémon.'),
	('Burning Wind','FireColorlessColorless','70','You may discard an Energy attached to this Pokémon. If you do, the Defending Pokémon is now Burned.'),
	('Coup d''Boule','Incolore','10',null),
	('Lure Poison','Psychic',null,'Flip a coin. If heads, switch 1 of your opponent''s Benched Pokémon with the Defending Pokémon. The new Defending Pokémon is now Poisoned.'),
	('Tir de Précision','Eau',null,'Cette attaque inflige 30 dégâts à 1 des Pokémon de votre adversaire. (N''appliquez ni la Faiblesse ni la Résistance aux Pokémon de Banc.)'),
	('Flame Cloak','Colorless','10','Flip a coin. If heads, attach a Fire Energy card from your discard pile to this Pokémon.'),
	('Glu Fétide','PsyIncolore','20','Lancez une pièce. Si c''est face, le Pokémon Défenseur est maintenant Paralysé.'),
	('Low Kick','FightingColorless','30',null),
	('Grêle','Incolore',null,'Cette attaque inflige 10 dégâts à chacun des Pokémon de votre adversaire. (N''appliquez ni la Faiblesse ni la Résistance aux Pokémon de Banc.)'),
	('Hypnostrike','MetalColorlessColorless','60','Both this Pokémon and the Defending Pokémon are now Asleep.'),
	('Hâte','Électrique','10','Lancez une pièce. Si c''est face, évitez tous les effets d''attaques (y compris les dégâts) infligés à ce Pokémon pendant le prochain tour de votre adversaire.'),
	('Thundershock','Lightning','10','Flip a coin. If heads, the Defending Pokémon is now Paralyzed.'),
	('Croc de Mort','Incolore','30','Lancez une pièce. Si c’est pile, cette attaque ne fait rien.'),
	('Lock Up','Psychic','20','The Defending Pokémon can''t retreat during your opponent''s next turn.'),
	('Vol Supersonique','PsyIncolore','40','Le Pokémon Défenseur ne peut pas battre en retraite pendant le prochain tour de votre adversaire.'),
	('Hurricane Kick','FightingColorlessColorless','60','Does 30 more damage for each Prize card your opponent has taken.'),
	('Barrière de Flammes','Feu','40','Pendant le prochain tour de votre adversaire, tous les dégâts infligés à ce Pokémon par des attaques sont réduits de 20 (après application de la Faiblesse et de la Résistance).'),
	('Ember','FireColorless','40','Flip a coin. If tails, discard an Energy attached to this Pokémon.'),
	('Triplattaque','IncoloreIncoloreIncolore','50','Lancez 3 pièces. Cette attaque inflige 50 dégâts multipliés par le nombre de côtés face.'),
	('Griffe Acier','MétalIncolore','30',null),
	('Icy Wind','WaterColorlessColorless','60','The Defending Pokémon is now Asleep.'),
	('Coud''Pied Éjecteur','ObscuritéIncolore','30','Votre adversaire échange le Pokémon Défenseur avec 1 de ses Pokémon de Banc.'),
	('Confuse Ray','ColorlessColorless',null,'The Defending Pokémon is now Confused.'),
	('Tombe de Sable','Combat','10','Le Pokémon Défenseur ne peut pas battre en retraite durant le prochain tour de votre adversaire.'),
	('Doom Decree','PsychicColorless',null,'Flip 2 coins. If both of them are heads, the Defending Pokémon is Knocked Out.'),
	('Aurasphère','CombatCombat','50','Inflige 20 dégâts à 1 des Pokémon de Banc de votre adversaire. (N''appliquez ni la Faiblesse ni la Résistance aux Pokémon de Banc.)'),
	('Teleportation Burst','Psychic','10','Switch this Pokémon with 1 of your Benched Pokémon.'),
	('Canon à Sable','CombatIncoloreIncolore','70','Vous pouvez déplacer une Énergie de base attachée à ce Pokémon vers 1 de vos Pokémon de Banc.'),
	('Mind Bend','PsychicColorless','20','Flip a coin. If heads, the Defending Pokémon is now Confused.'),
	('Morsure','Incolore','20',null),
	('Nasty Plot','Darkness',null,'Search your deck for a card and put it into your hand. Shuffle your deck afterward.'),
	('Vif Retournement','Psy','10','Lancez 2 pièces. Cette attaque inflige 10 dégâts multipliés par le nombre de côtés face.'),
	('Frozen Wings','WaterColorlessColorless','60','Discard a Special Energy attached to the Defending Pokémon.'),
	('Charge','Électrique','10',null),
	('Daunt','ColorlessColorless','40','During your opponent''s next turn, any damage done by attacks from the Defending Pokémon is reduced by 20 (before applying Weakness and Resistance).'),
	('Psypunch','ColorlessColorless','30',null),
	('Colère','IncoloreIncolore','20','Inflige 10 dégâts supplémentaires pour chaque marqueur de dégâts placé sur ce Pokémon.'),
	('Psychic','Psychic','10','Does 20 more damage for each Energy attached to the Defending Pokémon.'),
	('Essorage','PlanteIncolore','30','Lancez une pièce. Si c’est face, le Pokémon Défenseur est maintenant Paralysé, et vous défaussez une Énergie attachée au Pokémon Défenseur.'),
	('Spiral Drain','GrassColorless','20','Heal 10 damage from this Pokémon.'),
	('Giga Pouvoir','IncoloreIncoloreIncolore','60','Vous pouvez infliger 20 dégâts supplémentaires. Dans ce cas, ce Pokémon s''inflige 20 dégâts.'),
	('Bind','Metal','10','Flip a coin. If heads, the Defending Pokémon is now Paralyzed.'),
	('Vengeance','CombatIncolore','30','Si l''un de vos Pokémon a été mis K.O. par les dégâts d''une attaque de votre adversaire pendant son dernier tour, cette attaque inflige 60 dégâts supplémentaires.'),
	('Brutal Bash','ColorlessColorless','20','Does 20 damage times the number of Darkness Pokémon you have in play.'),
	('Bataille','IncoloreIncolore','20',null),
	('Grass'' Power','ColorlessColorless','30','If this Pokémon has any Grass Energy attached to it, heal 20 damage from this Pokémon.'),
	('Choc Frontal','IncoloreIncolore','20','Ce Pokémon et le Pokémon Défenseur sont maintenant Confus.'),
	('Glinting Claw','FireColorlessColorless','50','Flip a coin. If heads, this attack does 30 more damage.'),
	('Asticotage','PlanteIncoloreIncolore','40','Lancez une pièce. Si c''est face, cette attaque inflige 20 dégâts supplémentaires.'),
	('Anti-Flammes','Eau',null,'Défaussez une Énergie Fire attachée au Pokémon Défenseur.'),
	('Withdraw','Colorless',null,'Flip a coin. If heads, prevent all damage done to this Pokémon by attacks during your opponent''s next turn.'),
	('Brouillard Toxique','Incolore','20','Le Pokémon Défenseur est maintenant Empoisonné. Lancez une pièce. Si c''est face, défaussez une Énergie attachée au Pokémon Défenseur.'),
	('Fury Swipes','ColorlessColorless','30','Flip 3 coins. This attack does 30 damage times the number of heads.'),
	('Draco-Rage','IncoloreIncolore','50','Lancez 2 pièces. Si vous obtenez un côté pile, cette attaque ne fait rien.'),
	('Outrage','ColorlessColorless','20','Does 10 more damage for each damage counter on this Pokémon.'),
	('Flux Draconique','FeuIncoloreIncolore','60','Lancez une pièce. Si c''est face, attachez une carte Énergie de base de votre pile de défausse à ce Pokémon.'),
	('Coupe Vive','Combat','60','Défaussez une Énergie spéciale attachée au Pokémon Défenseur.'),
	('Slap Push','FightingFighting','30',null),
	('Coup de Chaud','FeuIncoloreIncolore','60','Si ce Pokémon est affecté par un État Spécial, cette attaque inflige 60 dégâts supplémentaires.'),
	('Dragonblast','PsychicDarknessDarknessColorless','140','Discard 2 Darkness Energy attached to this Pokémon.');

INSERT INTO P10_Attack(attackName,attackCost,attackDamage,attackEffect) VALUES 
	('Aile Glace','EauIncoloreIncoloreIncolore','80',null),
	('Thrash','FireColorlessColorless','70','Flip a coin. If heads, this attack does 20 more damage. If tails, this Pokémon does 20 damage to itself.'),
	('Fureur du Dragon','FeuÉlectrique','60','Défaussez toutes les Énergies Fire de base ou toutes les Énergies Lightning de base attachées à ce Pokémon. Cette attaque inflige 60 dégâts multipliés par le nombre de cartes Énergie que vous avez défaussées.'),
	('Vent Glacial','IncoloreIncoloreIncolore','70',null),
	('Metal Claw','MetalMetalColorless','40',null),
	('Vent Violent','IncoloreIncoloreIncolore','80','Déplacez une Énergie de base de ce Pokémon vers 1 de vos Pokémon de Banc.'),
	('Protect Charge','MetalMetalColorlessColorless','80','During your opponent''s next turn, any damage done to this Pokémon by attacks is reduced by 20 (after applying Weakness and Resistance).'),
	('Dracogriffe','FeuFeuEauIncolore','90',null),
	('Gnaw','WaterFighting','20',null),
	('Cascade','EauEau','60',null),
	('Aurora Beam','WaterColorlessColorless','40',null),
	('Souffle-Feu','FeuIncoloreIncolore','40','Lancez une pièce. Si c''est face, cette attaque inflige 20 dégâts supplémentaires.'),
	('Croc Aiguisé','CombatIncoloreIncolore','40',null),
	('Charge','IncoloreIncolore','30',null),
	('Dragon Burst','FireLightning','60','Discard all basic Fire Energy or all basic Lightning Energy attached to this Pokémon. This attack does 60 damage times the number of Energy cards you discarded.'),
	('Tout ou Rien','EauIncoloreIncolore','80','Lancez 2 pièces. Si vous obtenez 2 côtés pile, ce Pokémon s''inflige 80 dégâts.'),
	('Attaque Imprudente','CombatIncolore','30','Ce Pokémon s''inflige 10 dégâts.'),
	('Sludge Toss','PsychicColorlessColorless','30',null),
	('Bulles d''O','EauEau','40','Lancez une pièce. Si c''est face, le Pokémon Défenseur est maintenant Paralysé.'),
	('Heat Blast','FireColorlessColorless','60',null),
	('Calomnie','ObscuritéIncolore','30','Défaussez autant de Pokémon que vous voulez de votre main. Cette attaque inflige 30 dégâts multipliés par le nombre de Pokémon que vous avez défaussés.'),
	('Acrobatics','ColorlessColorless','10','Flip 2 coins. This attack does 20 more damage for each heads.'),
	('Damakinesis','PsychicColorlessColorless',null,'Move 6 damage counters from any of your Pokémon to the Defending Pokémon.'),
	('Lumi-Éclat','EauPsyIncolore','150','Défaussez toutes les Énergies attachées à ce Pokémon.'),
	('Lance-Flamme','FeuIncoloreIncolore','90','Défaussez une Énergie attachée à ce Pokémon.'),
	('Ravages','MétalMétalIncolore','60','Lancez une pièce jusqu''à ce que vous obteniez un côté pile. Pour chaque côté face, défaussez la carte du dessus du deck de votre adversaire.'),
	('Coup d’Boule Renforcé','ObscuritéObscuritéIncolore','50','Si une carte Outil Pokémon est attachée à ce Pokémon, cette attaque inflige 50 dégâts supplémentaires.'),
	('Hyper Fang','ColorlessColorless','60','Flip a coin. If tails, this attack does nothing.'),
	('Morsure','CombatIncoloreIncolore','30',null),
	('Black Magic','PsychicColorlessColorless','40','Does 20 more damage for each of your opponent''s Benched Pokémon.'),
	('Roule-Pierre','CombatCombatIncoloreIncolore','90','Les dégâts de cette attaque ne sont pas affectés par la Résistance.'),
	('Spinning Attack','PsychicColorlessColorless','40',null),
	('Bélier','IncoloreIncoloreIncolore','60','Ce Pokémon s''inflige 10 dégâts.'),
	('Foul Play','ColorlessColorless',null,'Choose 1 of the Defending Pokémon''s attacks and use it as this attack.'),
	('Assaut Psychique','IncoloreIncoloreIncolore','40','Inflige 10 dégâts supplémentaires pour chaque marqueur de dégâts placé sur le Pokémon Défenseur.'),
	('Hail Blizzard','WaterWaterColorlessColorless','120','This Pokémon can''t use Hail Blizzard during your next turn.'),
	('Vive-Attaque','ÉlectriqueIncolore','10','Lancez une pièce. Si c''est face, cette attaque inflige 20 dégâts supplémentaires.'),
	('Ambush','WaterColorlessColorless','60','Flip a coin. If heads, this attack does 30 more damage.'),
	('Destructive Beam','PsychicColorlessColorless','50','Flip a coin. If heads, discard an Energy attached to the Defending Pokémon.'),
	('ChargeFoudre','ÉlectriqueÉlectriqueIncolore','120','Ce Pokémon s’inflige 40 dégâts.'),
	('Ronge','EauCombat','20',null),
	('Echoed Voice','PsychicColorlessColorless','50','During your next turn, this Pokémon''s Echoed Voice attack does 50 more damage (before applying Weakness and Resistance).'),
	('Marteau Rageur','IncoloreIncoloreIncoloreIncolore','50','Inflige 10 dégâts supplémentaires pour chaque marqueur de dégâts placé sur ce Pokémon.'),
	('Gear Grind','MetalColorlessColorless','60','Flip 2 coins. This attack does 60 damage times the number of heads.'),
	('Écras''Terre','CombatCombatIncolore','90',null),
	('Dark Rush','DarknessDarkness','20','Does 20 damage times the number of damage counters on this Pokémon.'),
	('Tranch''Herbe','PlantePlanteIncolore','40',null),
	('Rushing Water','WaterColorlessColorless','60','Move an Energy attached to the Defending Pokémon to 1 of your opponent''s Benched Pokémon.'),
	('Brave Fire','FireFireColorlessColorless','150','Flip a coin. If tails, this Pokémon does 50 damage to itself.'),
	('Waterfall','WaterWaterColorless','60',null),
	('Bomb-Beurk','PsyPsyIncolore','70',null),
	('Karate Chop','FightingFighting','80','Does 80 damage minus 10 damage for each damage counter on this Pokémon.'),
	('Blue Flare','FireFireColorless','120','Discard 2 Fire Energy attached to this Pokémon.'),
	('Feu Glacé','FeuFeuEauIncolore','150','Défaussez 2 Énergies Fire attachées à ce Pokémon. Le Pokémon Défenseur est maintenant Brûlé.'),
	('Draco-Lame','EauCombat','100','Défaussez les 2 cartes du dessus de votre deck.'),
	('Pression Explosive','FeuFeuIncoloreIncolore','80','Si de l''Énergie Plasma est attachée à ce Pokémon, cette attaque inflige 10 dégâts supplémentaires pour chaque marqueur de dégâts placé sur le Pokémon Défenseur.');

INSERT INTO P10_Resistance(resistanceType,resistanceValue) VALUES 
	('Combat','-20'),
	('Fighting','-20'),
	('Psychic','-20'),
	('Eau','-20'),
	('Water','-20'),
	('Psy','-20'),
	('Électrique','-20');

INSERT INTO P10_Weakness(weaknessType,weaknessValue) VALUES 
	('Métal','×2'),
	('Lightning','×2'),
	('Water','×2'),
	('Dragon','×2'),
	('Électrique','×2'),
	('Fire','×2'),
	('Fighting','×2'),
	('Metal','×2'),
	('Feu','×2'),
	('Eau','×2'),
	('Grass','×2'),
	('Combat','×2'),
	('Plante','×2'),
	('Psychic','×2'),
	('Psy','×2'),
	('Darkness','×2');

INSERT INTO P10_Card(cardCategory,cardName,cardHP,cardRarity,cardImg,cardType,cardExtensioncardRetreat,cardLang,abilityId,resistanceId,weaknessId) VALUES
	('Pokémon','Sorbouboul','130','Rare','https://assets.tcgdex.net/fr/bw/bw4/33/high.webp','Eau','Destinées Futures',2,'fr',(SELECT abilityId FROM P10_Ability WHERE abilityName = 'Sol Verglacé' AND abilityEffect = 'Une seule fois pendant votre tour (avant votre attaque), vous pouvez échanger votre Pokémon Actif avec 1 de vos Pokémon de Banc. Dans ce cas, votre adversaire échange son Pokémon Actif avec 1 de ses Pokémon de Banc.'),(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Métal' AND weaknessValue = '×2'),null),
	('Pokemon','Magikarp','30','Common','https://assets.tcgdex.net/en/bw/bw11/30/high.webp','Water','Legendary Treasures',1,'en',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Lightning' AND weaknessValue = '×2'),null),
	('Pokémon','Artikodin','120','Rare','https://assets.tcgdex.net/fr/bw/bw4/27/high.webp','Eau','Destinées Futures',2,'fr',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Métal' AND weaknessValue = '×2'),(SELECT resistanceId FROM P10_Resistance WHERE resistanceType = 'Combat' AND resistanceValue = '-20')),
	('Pokemon','Darmanitan','120','Rare','https://assets.tcgdex.net/en/bw/bw1/25/high.webp','Fire','Black & White',2,'en',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Water' AND weaknessValue = '×2'),null),
	('Pokémon','Rayquaza-EX','170','Ultra Rare','https://assets.tcgdex.net/fr/bw/bw6/123/high.webp','Dragon','Dragons Éxaltés',1,'fr',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Dragon' AND weaknessValue = '×2'),null),
	('Pokemon','Swablu','40','Common','https://assets.tcgdex.net/en/bw/bw11/103/high.webp','Colorless','Legendary Treasures',1,'en',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Lightning' AND weaknessValue = '×2'),(SELECT resistanceId FROM P10_Resistance WHERE resistanceType = 'Fighting' AND resistanceValue = '-20')),
	('Pokémon','Déflaisan','120','Rare','https://assets.tcgdex.net/fr/bw/bw1/86/high.webp','Incolore','Noir & Blanc',1,'fr',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Électrique' AND weaknessValue = '×2'),(SELECT resistanceId FROM P10_Resistance WHERE resistanceType = 'Combat' AND resistanceValue = '-20')),
	('Pokemon','Pawniard','60','Common','https://assets.tcgdex.net/en/bw/bw5/78/high.webp','Metal','Dark Explorers',1,'en',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Fire' AND weaknessValue = '×2'),(SELECT resistanceId FROM P10_Resistance WHERE resistanceType = 'Psychic' AND resistanceValue = '-20')),
	('Dresseur','Rappel Cyclone',null,'Rare','https://assets.tcgdex.net/fr/bw/bw10/95/high.webp',null,'Explosion Plasma',null,'fr',(SELECT abilityId FROM P10_Ability WHERE abilityEffect = 'Placez 1 de vos Pokémon et toutes les cartes qui lui sont attachées dans votre main.'),null,null),
	('Pokemon','Audino','80','Uncommon','https://assets.tcgdex.net/en/bw/bw1/87/high.webp','Colorless','Black & White',2,'en',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Fighting' AND weaknessValue = '×2'),null),
	('Pokémon','Boréas','110','Rare','https://assets.tcgdex.net/fr/bw/bw2/89/high.webp','Incolore','Pouvoirs Émergents',1,'fr',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Électrique' AND weaknessValue = '×2'),(SELECT resistanceId FROM P10_Resistance WHERE resistanceType = 'Combat' AND resistanceValue = '-20')),
	('Pokemon','Registeel-EX','180','Rare','https://assets.tcgdex.net/en/bw/bw6/81/high.webp','Metal','Dragons Exalted',4,'en',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Fire' AND weaknessValue = '×2'),(SELECT resistanceId FROM P10_Resistance WHERE resistanceType = 'Psychic' AND resistanceValue = '-20')),
	('Pokémon','Drakkarmin','110','Rare','https://assets.tcgdex.net/fr/bw/bw8/94/high.webp','Dragon','Tempète Plasma',1,'fr',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Dragon' AND weaknessValue = '×2'),null),
	('Pokemon','Gible','50','Common','https://assets.tcgdex.net/en/bw/bw6/86/high.webp','Dragon','Dragons Exalted',1,'en',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Dragon' AND weaknessValue = '×2'),null),
	('Pokémon','Mustéflott','90','Peu Commune','https://assets.tcgdex.net/fr/bw/bw6/33/high.webp','Eau','Dragons Éxaltés',1,'fr',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Électrique' AND weaknessValue = '×2'),null),
	('Pokemon','Sealeo','80','Uncommon','https://assets.tcgdex.net/en/bw/bw6/30/high.webp','Water','Dragons Exalted',3,'en',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Metal' AND weaknessValue = '×2'),null),
	('Pokémon','Trompignon','40','Commune','https://assets.tcgdex.net/fr/bw/bw3/9/high.webp','Plante','Nobles Victoires',1,'fr',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Feu' AND weaknessValue = '×2'),(SELECT resistanceId FROM P10_Resistance WHERE resistanceType = 'Eau' AND resistanceValue = '-20')),
	('Pokemon','Sewaddle','40','Common','https://assets.tcgdex.net/en/bw/bw8/8/high.webp','Grass','Plasma Storm',1,'en',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Fire' AND weaknessValue = '×2'),null),
	('Dresseur','Badge de la Team Plasma',null,'Peu Commune','https://assets.tcgdex.net/fr/bw/bw9/104/high.webp',null,'Glaciation Plasma',null,'fr',(SELECT abilityId FROM P10_Ability WHERE abilityEffect = 'Le Pokémon auquel cette carte est attachée est un Pokémon de la Team Plasma.'),null,null),
	('Pokemon','Gible','50','Common','https://assets.tcgdex.net/en/bw/bw11/94/high.webp','Dragon','Legendary Treasures',1,'en',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Dragon' AND weaknessValue = '×2'),null),
	('Pokémon','Grotichon','90','Peu Commune','https://assets.tcgdex.net/fr/bw/bw7/25/high.webp','Feu','Frontières Franchies',2,'fr',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Eau' AND weaknessValue = '×2'),null),
	('Pokemon','Quagsire','100','Rare','https://assets.tcgdex.net/en/bw/bw9/22/high.webp','Water','Plasma Freeze',3,'en',(SELECT abilityId FROM P10_Ability WHERE abilityName = 'Laid-Back' AND abilityEffect = 'Any damage done to this Pokémon by attacks is reduced by 20 (after applying Weakness and Resistance).'),(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Grass' AND weaknessValue = '×2'),null),
	('Pokémon','Incisache','80','Rare','https://assets.tcgdex.net/fr/bw/dv1/15/high.webp','Dragon','Coffre des Dragons',2,'fr',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Dragon' AND weaknessValue = '×2'),null),
	('Pokemon','Cottonee','50','Common','https://assets.tcgdex.net/en/bw/bw7/14/high.webp','Grass','Boundaries Crossed',1,'en',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Fire' AND weaknessValue = '×2'),(SELECT resistanceId FROM P10_Resistance WHERE resistanceType = 'Water' AND resistanceValue = '-20')),
	('Pokémon','Viskuse','80','Commune','https://assets.tcgdex.net/fr/bw/bw3/30/high.webp','Eau','Nobles Victoires',2,'fr',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Électrique' AND weaknessValue = '×2'),null),
	('Pokemon','Vanillite','60','Common','https://assets.tcgdex.net/en/bw/bw9/27/high.webp','Water','Plasma Freeze',1,'en',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Metal' AND weaknessValue = '×2'),null),
	('Pokémon','Écrémeuh','100','Peu Commune','https://assets.tcgdex.net/fr/bw/bw9/93/high.webp','Incolore','Glaciation Plasma',3,'fr',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Combat' AND weaknessValue = '×2'),null),
	('Pokemon','Rayquaza-EX','170','Rare','https://assets.tcgdex.net/en/bw/bw6/85/high.webp','Dragon','Dragons Exalted',1,'en',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Dragon' AND weaknessValue = '×2'),null),
	('Pokémon','Bargantua','80','Commune','https://assets.tcgdex.net/fr/bw/bw2/24/high.webp','Eau','Pouvoirs Émergents',1,'fr',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Électrique' AND weaknessValue = '×2'),null),
	('Pokemon','Volcarona','110','Rare','https://assets.tcgdex.net/en/bw/bw5/22/high.webp','Fire','Dark Explorers',3,'en',(SELECT abilityId FROM P10_Ability WHERE abilityName = 'Scorching Scales' AND abilityEffect = 'Put 4 damage counters instead of 2 on your opponent’s Burned Pokémon between turns.'),(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Water' AND weaknessValue = '×2'),null),
	('Pokémon','Nodulithe','60','Commune','https://assets.tcgdex.net/fr/bw/bw2/50/high.webp','Combat','Pouvoirs Émergents',2,'fr',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Plante' AND weaknessValue = '×2'),null),
	('Pokemon','Grimer','70','Common','https://assets.tcgdex.net/en/bw/bw9/45/high.webp','Psychic','Plasma Freeze',2,'en',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Psychic' AND weaknessValue = '×2'),null),
	('Pokémon','Octillery','90','Peu Commune','https://assets.tcgdex.net/fr/bw/bw10/19/high.webp','Eau','Explosion Plasma',1,'fr',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Électrique' AND weaknessValue = '×2'),null),
	('Pokemon','Torkoal','90','Uncommon','https://assets.tcgdex.net/en/bw/bw5/18/high.webp','Fire','Dark Explorers',2,'en',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Water' AND weaknessValue = '×2'),null),
	('Pokémon','Tadmorv','70','Commune','https://assets.tcgdex.net/fr/bw/bw4/52/high.webp','Psy','Destinées Futures',2,'fr',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Psy' AND weaknessValue = '×2'),null),
	('Pokemon','Machop','60','Common','https://assets.tcgdex.net/en/bw/bw10/47/high.webp','Fighting','Plasma Blast',3,'en',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Psychic' AND weaknessValue = '×2'),null),
	('Pokémon','Dimoret','90','Rare','https://assets.tcgdex.net/fr/bw/bw9/66/high.webp','Obscurité','Glaciation Plasma',1,'fr',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Combat' AND weaknessValue = '×2'),(SELECT resistanceId FROM P10_Resistance WHERE resistanceType = 'Psy' AND resistanceValue = '-20')),
	('Pokemon','Jirachi-EX','90','Rare','https://assets.tcgdex.net/en/bw/bw10/60/high.webp','Metal','Plasma Blast',1,'en',(SELECT abilityId FROM P10_Ability WHERE abilityName = 'Stellar Guidance' AND abilityEffect = 'When you play this Pokémon from your hand onto your Bench, you may search your deck for a Supporter card, reveal it, and put it into your hand. Shuffle your deck afterward.'),(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Fire' AND weaknessValue = '×2'),(SELECT resistanceId FROM P10_Resistance WHERE resistanceType = 'Psychic' AND resistanceValue = '-20')),
	('Pokémon','Zébibron','60','Commune','https://assets.tcgdex.net/fr/bw/bw3/35/high.webp','Électrique','Nobles Victoires',1,'fr',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Combat' AND weaknessValue = '×2'),null),
	('Pokemon','Emolga','70','Common','https://assets.tcgdex.net/en/bw/bw2/32/high.webp','Lightning','Emerging Powers',0,'en',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Fighting' AND weaknessValue = '×2'),null),
	('Pokémon','Ratentif','60','Commune','https://assets.tcgdex.net/fr/bw/bw1/78/high.webp','Incolore','Noir & Blanc',1,'fr',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Combat' AND weaknessValue = '×2'),null),
	('Pokemon','Beheeyem','90','Rare','https://assets.tcgdex.net/en/bw/bw8/70/high.webp','Psychic','Plasma Storm',1,'en',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Psychic' AND weaknessValue = '×2'),null),
	('Pokémon','Latios-EX','170','Rare','https://assets.tcgdex.net/fr/bw/bw9/86/high.webp','Dragon','Glaciation Plasma',2,'fr',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Dragon' AND weaknessValue = '×2'),null),
	('Pokemon','Lucario','100','Rare','https://assets.tcgdex.net/en/bw/bw8/78/high.webp','Fighting','Plasma Storm',2,'en',(SELECT abilityId FROM P10_Ability WHERE abilityName = 'Dual Armor' AND abilityEffect = 'If this Pokémon has any Metal Energy attached to it, this Pokémon’s type is both Fighting and Metal.'),(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Psychic' AND weaknessValue = '×2'),null),
	('Pokémon','Incisache','80','Rare','https://assets.tcgdex.net/fr/bw/dv1/15/high.webp','Dragon','Coffre des Dragons',2,'fr',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Dragon' AND weaknessValue = '×2'),null),
	('Pokemon','Cottonee','50','Common','https://assets.tcgdex.net/en/bw/bw7/14/high.webp','Grass','Boundaries Crossed',1,'en',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Fire' AND weaknessValue = '×2'),(SELECT resistanceId FROM P10_Resistance WHERE resistanceType = 'Water' AND resistanceValue = '-20')),
	('Pokémon','Maganon','120','Rare','https://assets.tcgdex.net/fr/bw/bw6/21/high.webp','Feu','Dragons Éxaltés',3,'fr',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Eau' AND weaknessValue = '×2'),null),
	('Pokemon','Lampent','80','Uncommon','https://assets.tcgdex.net/en/bw/bw4/19/high.webp','Fire','Next Destinies',1,'en',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Water' AND weaknessValue = '×2'),null),
	('Pokémon','Porygon-Z','130','Commune','https://assets.tcgdex.net/fr/bw/bwp/BW84/high.webp','Incolore','Promo BW',1,'fr',(SELECT abilityId FROM P10_Ability WHERE abilityName = 'Transfert Plasma' AND abilityEffect = 'Autant de fois que vous le voulez pendant votre tour (avant votre attaque), vous pouvez déplacer une Énergie Plasma attachée à 1 de vos Pokémon vers un autre de vos Pokémon.'),(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Combat' AND weaknessValue = '×2'),null),
	('Trainer','Hugh',null,'Uncommon','https://assets.tcgdex.net/en/bw/bw7/130/high.webp',null,'Boundaries Crossed',null,'en',null,null,null),
	('Pokémon','Galegon','90','Peu Commune','https://assets.tcgdex.net/fr/bw/bw6/79/high.webp','Métal','Dragons Éxaltés',3,'fr',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Feu' AND weaknessValue = '×2'),(SELECT resistanceId FROM P10_Resistance WHERE resistanceType = 'Psy' AND resistanceValue = '-20')),
	('Pokemon','Venipede','70','Common','https://assets.tcgdex.net/en/bw/bw7/72/high.webp','Psychic','Boundaries Crossed',2,'en',(SELECT abilityId FROM P10_Ability WHERE abilityName = 'Poison Point' AND abilityEffect = 'If this Pokémon is your Active Pokémon and is damaged by an opponent’s attack (even if this Pokémon is Knocked Out), the Attacking Pokémon is now Poisoned.'),(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Psychic' AND weaknessValue = '×2'),null),
	('Pokémon','Kyogre-EX','170','Rare','https://assets.tcgdex.net/fr/bw/bw5/26/high.webp','Eau','Explorateurs Obscurs',4,'fr',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Électrique' AND weaknessValue = '×2'),null),
	('Pokemon','Glaceon','90','Rare','https://assets.tcgdex.net/en/bw/bw9/23/high.webp','Water','Plasma Freeze',2,'en',(SELECT abilityId FROM P10_Ability WHERE abilityName = 'Freeze Zone' AND abilityEffect = 'The Retreat Cost of each of your Team Plasma Pokémon in play is ColorlessColorless less.'),(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Metal' AND weaknessValue = '×2'),null),
	('Pokémon','Baggaïd','90','Rare','https://assets.tcgdex.net/fr/bw/bw8/86/high.webp','Obscurité','Tempète Plasma',1,'fr',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Combat' AND weaknessValue = '×2'),(SELECT resistanceId FROM P10_Resistance WHERE resistanceType = 'Psy' AND resistanceValue = '-20')),
	('Pokemon','Watchog','90','Uncommon','https://assets.tcgdex.net/en/bw/bw1/79/high.webp','Colorless','Black & White',1,'en',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Fighting' AND weaknessValue = '×2'),null),
	('Énergie','Énergie Eau',null,'Commune','https://assets.tcgdex.net/fr/bw/bw1/107/high.webp',null,'Noir & Blanc',null,'fr',null,null,null),
	('Pokemon','Starly','60','Common','https://assets.tcgdex.net/en/bw/bw9/95/high.webp','Colorless','Plasma Freeze',1,'en',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Lightning' AND weaknessValue = '×2'),(SELECT resistanceId FROM P10_Resistance WHERE resistanceType = 'Fighting' AND resistanceValue = '-20')),
	('Pokémon','Mascaïman','70','Commune','https://assets.tcgdex.net/fr/bw/bw1/63/high.webp','Combat','Noir & Blanc',2,'fr',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Eau' AND weaknessValue = '×2'),(SELECT resistanceId FROM P10_Resistance WHERE resistanceType = 'Électrique' AND resistanceValue = '-20')),
	('Pokemon','Gothitelle','130','Rare','https://assets.tcgdex.net/en/bw/bw6/57/high.webp','Psychic','Dragons Exalted',2,'en',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Psychic' AND weaknessValue = '×2'),null),
	('Pokémon','Lucario','100','Rare','https://assets.tcgdex.net/fr/bw/bw4/64/high.webp','Combat','Destinées Futures',1,'fr',(SELECT abilityId FROM P10_Ability WHERE abilityName = 'Contre-Offensive' AND abilityEffect = 'Si ce Pokémon est votre Pokémon Actif et qu’il subit les dégâts d’une attaque de votre adversaire (même si ce Pokémon est mis K.O.), placez 2 marqueurs de dégâts sur le Pokémon Attaquant.'),(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Psy' AND weaknessValue = '×2'),null),
	('Pokemon','Litwick','50','Common','https://assets.tcgdex.net/en/bw/bw3/58/high.webp','Psychic','Noble Victories',1,'en',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Darkness' AND weaknessValue = '×2'),null),
	('Pokémon','Hippodocus','130','Peu Commune','https://assets.tcgdex.net/fr/bw/bw4/66/high.webp','Combat','Destinées Futures',4,'fr',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Eau' AND weaknessValue = '×2'),(SELECT resistanceId FROM P10_Resistance WHERE resistanceType = 'Électrique' AND resistanceValue = '-20')),
	('Pokemon','Kirlia','80','Uncommon','https://assets.tcgdex.net/en/bw/bw11/60/high.webp','Psychic','Legendary Treasures',1,'en',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Psychic' AND weaknessValue = '×2'),null),
	('Pokémon','Ponchien','80','Peu Commune','https://assets.tcgdex.net/fr/bw/bw7/121/high.webp','Incolore','Frontières Franchies',1,'fr',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Combat' AND weaknessValue = '×2'),null),
	('Pokemon','Zoroark','100','Secret Rare','https://assets.tcgdex.net/en/bw/bw4/102/high.webp','Darkness','Next Destinies',1,'en',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Fighting' AND weaknessValue = '×2'),(SELECT resistanceId FROM P10_Resistance WHERE resistanceType = 'Psychic' AND resistanceValue = '-20')),
	('Pokémon','Cryptéro','90','Peu Commune','https://assets.tcgdex.net/fr/bw/bw2/42/high.webp','Psy','Pouvoirs Émergents',1,'fr',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Électrique' AND weaknessValue = '×2'),(SELECT resistanceId FROM P10_Resistance WHERE resistanceType = 'Combat' AND resistanceValue = '-20')),
	('Pokemon','Kyurem-EX','180','Rare','https://assets.tcgdex.net/en/bw/bw4/38/high.webp','Water','Next Destinies',3,'en',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Metal' AND weaknessValue = '×2'),null),
	('Pokémon','Dynavolt','60','Commune','https://assets.tcgdex.net/fr/bw/bw6/41/high.webp','Électrique','Dragons Éxaltés',1,'fr',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Combat' AND weaknessValue = '×2'),null),
	('Pokemon','Beartic','120','Rare','https://assets.tcgdex.net/en/bw/bw4/37/high.webp','Water','Next Destinies',3,'en',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Metal' AND weaknessValue = '×2'),null),
	('Dresseur','Attrape-Pokémon',null,'Peu Commune','https://assets.tcgdex.net/fr/bw/bw10/83/high.webp',null,'Explosion Plasma',null,'fr',(SELECT abilityId FROM P10_Ability WHERE abilityEffect = 'Échangez le Pokémon Actif de votre adversaire avec 1 de ses Pokémon de Banc.'),null,null),
	('Pokemon','Gothorita','80','Uncommon','https://assets.tcgdex.net/en/bw/bw7/76/high.webp','Psychic','Boundaries Crossed',1,'en',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Psychic' AND weaknessValue = '×2'),null),
	('Pokémon','Zekrom','130','Rare','https://assets.tcgdex.net/fr/bw/bwp/BW05/high.webp','Électrique','Promo BW',2,'fr',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Combat' AND weaknessValue = '×2'),null),
	('Energy','Darkness Energy',null,'Common','https://assets.tcgdex.net/en/bw/bw1/111/high.webp',null,'Black & White',null,'en',null,null,null),
	('Pokémon','Griknot','50','Commune','https://assets.tcgdex.net/fr/bw/bw6/86/high.webp','Dragon','Dragons Éxaltés',1,'fr',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Dragon' AND weaknessValue = '×2'),null),
	('Pokemon','Meloetta','80','Rare','https://assets.tcgdex.net/en/bw/bw11/78/high.webp','Psychic','Legendary Treasures',1,'en',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Psychic' AND weaknessValue = '×2'),null),
	('Pokémon','Lianaja','80','Peu Commune','https://assets.tcgdex.net/fr/bw/bw1/4/high.webp','Plante','Noir & Blanc',1,'fr',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Feu' AND weaknessValue = '×2'),(SELECT resistanceId FROM P10_Resistance WHERE resistanceType = 'Eau' AND resistanceValue = '-20')),
	('Pokemon','Lileep','80','Uncommon','https://assets.tcgdex.net/en/bw/bw10/3/high.webp','Grass','Plasma Blast',2,'en',(SELECT abilityId FROM P10_Ability WHERE abilityName = 'Prehistoric Call' AND abilityEffect = 'Once during your turn (before your attack), if this Pokémon is in your discard pile, you may put this Pokémon on the bottom of your deck.'),(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Fire' AND weaknessValue = '×2'),(SELECT resistanceId FROM P10_Resistance WHERE resistanceType = 'Water' AND resistanceValue = '-20')),
	('Pokémon','Regigigas-EX','180','Rare','https://assets.tcgdex.net/fr/bw/bw4/82/high.webp','Incolore','Destinées Futures',4,'fr',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Combat' AND weaknessValue = '×2'),null),
	('Pokemon','Klang','80','Uncommon','https://assets.tcgdex.net/en/bw/bw1/75/high.webp','Metal','Black & White',2,'en',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Fire' AND weaknessValue = '×2'),(SELECT resistanceId FROM P10_Resistance WHERE resistanceType = 'Psychic' AND resistanceValue = '-20')),
	('Pokémon','Terrakium','130','Ultra Rare','https://assets.tcgdex.net/fr/bw/bw3/99/high.webp','Combat','Nobles Victoires',4,'fr',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Plante' AND weaknessValue = '×2'),null),
	('Pokemon','Zoroark','100','Rare','https://assets.tcgdex.net/en/bw/bw11/90/high.webp','Darkness','Legendary Treasures',2,'en',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Fighting' AND weaknessValue = '×2'),(SELECT resistanceId FROM P10_Resistance WHERE resistanceType = 'Psychic' AND resistanceValue = '-20')),
	('Pokémon','Blizzi','70','Commune','https://assets.tcgdex.net/fr/bw/bw10/25/high.webp','Eau','Explosion Plasma',2,'fr',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Métal' AND weaknessValue = '×2'),null),
	('Pokemon','Simipour','90','Rare','https://assets.tcgdex.net/en/bw/bw2/23/high.webp','Water','Emerging Powers',1,'en',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Lightning' AND weaknessValue = '×2'),null),
	('Pokémon','Keunotor','70','Commune','https://assets.tcgdex.net/fr/bw/bw6/106/high.webp','Incolore','Dragons Éxaltés',2,'fr',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Combat' AND weaknessValue = '×2'),null),
	('Pokemon','Reshiram-EX','180','Ultra Rare','https://assets.tcgdex.net/en/bw/bw4/95/high.webp','Fire','Next Destinies',3,'en',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Water' AND weaknessValue = '×2'),null),
	('Pokémon','Boskara','100','Peu Commune','https://assets.tcgdex.net/fr/bw/bw8/2/high.webp','Plante','Tempète Plasma',3,'fr',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Feu' AND weaknessValue = '×2'),(SELECT resistanceId FROM P10_Resistance WHERE resistanceType = 'Eau' AND resistanceValue = '-20')),
	('Pokemon','Masquerain','80','Rare','https://assets.tcgdex.net/en/bw/bw10/2/high.webp','Grass','Plasma Blast',1,'en',(SELECT abilityId FROM P10_Ability WHERE abilityName = 'Tool Reversal' AND abilityEffect = 'As often as you like during your turn (before your attack), you may put a Pokémon Tool card attached to 1 of your Pokémon into your hand.'),(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Fire' AND weaknessValue = '×2'),null),
	('Pokémon','Psykokwak','70','Commune','https://assets.tcgdex.net/fr/bw/bw7/33/high.webp','Eau','Frontières Franchies',3,'fr',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Électrique' AND weaknessValue = '×2'),null),
	('Pokemon','Wartortle','80','Uncommon','https://assets.tcgdex.net/en/bw/bw7/30/high.webp','Water','Boundaries Crossed',2,'en',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Grass' AND weaknessValue = '×2'),null),
	('Pokémon','Miasmax','110','Rare','https://assets.tcgdex.net/fr/bw/bw8/66/high.webp','Psy','Tempète Plasma',3,'fr',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Psy' AND weaknessValue = '×2'),null),
	('Pokemon','Primeape','90','Common','https://assets.tcgdex.net/en/bw/bw9/60/high.webp','Fighting','Plasma Freeze',1,'en',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Psychic' AND weaknessValue = '×2'),null),
	('Pokémon','Coupenotte','50','Commune','https://assets.tcgdex.net/fr/bw/bwp/BW16/high.webp','Incolore','Promo BW',1,'fr',null,null,null),
	('Pokemon','Reshiram','130','Ultra Rare','https://assets.tcgdex.net/en/bw/bw1/113/high.webp','Fire','Black & White',2,'en',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Water' AND weaknessValue = '×2'),null),
	('Pokémon','Kyurem Blanc EX','180','Rare','https://assets.tcgdex.net/fr/bw/bw7/103/high.webp','Dragon','Frontières Franchies',3,'fr',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Dragon' AND weaknessValue = '×2'),null),
	('Trainer','Great Ball',null,'Uncommon','https://assets.tcgdex.net/en/bw/bw2/93/high.webp',null,'Emerging Powers',null,'en',null,null,null),
	('Pokémon','Carchacrok','140','Rare','https://assets.tcgdex.net/fr/bw/bw6/90/high.webp','Dragon','Dragons Éxaltés',1,'fr',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Dragon' AND weaknessValue = '×2'),null),
	('Pokemon','Makuhita','70','Common','https://assets.tcgdex.net/en/bw/bw7/82/high.webp','Fighting','Boundaries Crossed',2,'en',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Psychic' AND weaknessValue = '×2'),null),
	('Pokémon','Heatran-EX','180','Ultra Rare','https://assets.tcgdex.net/fr/bw/bw9/109/high.webp','Feu','Glaciation Plasma',3,'fr',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Eau' AND weaknessValue = '×2'),null),
	('Pokemon','Hydreigon','150','Rare','https://assets.tcgdex.net/en/bw/bw6/97/high.webp','Dragon','Dragons Exalted',3,'en',(SELECT abilityId FROM P10_Ability WHERE abilityName = 'Dark Trance' AND abilityEffect = 'As often as you like during your turn (before your attack), you may move a Darkness Energy attached to 1 of your Pokémon to another of your Pokémon.'),(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Dragon' AND weaknessValue = '×2'),null);

INSERT INTO P10_Contient(cardId, attackId) VALUES
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/fr/bw/bw4/33/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Brise-Glace' AND attackCost = 'EauIncoloreIncolore' AND attackDamage = '60'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/en/bw/bw11/30/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Flailing Flop' AND attackCost = 'Colorless' AND attackDamage = '10'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/fr/bw/bw4/27/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Laser Glace' AND attackCost = 'EauIncoloreIncolore' AND attackDamage = '50'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/fr/bw/bw4/27/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Aile Glace' AND attackCost = 'EauIncoloreIncoloreIncolore' AND attackDamage = '80'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/en/bw/bw1/25/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Fire Fang' AND attackCost = 'FireColorless' AND attackDamage = '20'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/en/bw/bw1/25/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Thrash' AND attackCost = 'FireColorlessColorless' AND attackDamage = '70'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/fr/bw/bw6/123/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Cri du Ciel' AND attackCost = 'Incolore' AND attackDamage = null))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/fr/bw/bw6/123/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Fureur du Dragon' AND attackCost = 'FeuÉlectrique' AND attackDamage = '60'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/en/bw/bw11/103/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Glare and Peck' AND attackCost = 'ColorlessColorless' AND attackDamage = '10'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/fr/bw/bw1/86/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Vol' AND attackCost = 'IncoloreIncolore' AND attackDamage = '50'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/fr/bw/bw1/86/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Vent Glacial' AND attackCost = 'IncoloreIncoloreIncolore' AND attackDamage = '70'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/en/bw/bw5/78/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Scratch' AND attackCost = 'ColorlessColorless' AND attackDamage = '20'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/en/bw/bw5/78/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Metal Claw' AND attackCost = 'MetalMetalColorless' AND attackDamage = '40'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/en/bw/bw1/87/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Doubleslap' AND attackCost = 'ColorlessColorless' AND attackDamage = '30'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/fr/bw/bw2/89/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Roue d''Énergie' AND attackCost = 'Incolore' AND attackDamage = null))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/fr/bw/bw2/89/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Vent Violent' AND attackCost = 'IncoloreIncoloreIncolore' AND attackDamage = '80'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/en/bw/bw6/81/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Triple Laser' AND attackCost = 'ColorlessColorlessColorless' AND attackDamage = null))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/en/bw/bw6/81/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Protect Charge' AND attackCost = 'MetalMetalColorlessColorless' AND attackDamage = '80'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/fr/bw/bw8/94/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Pression de Garde' AND attackCost = 'IncoloreIncolore' AND attackDamage = '20'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/fr/bw/bw8/94/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Dracogriffe' AND attackCost = 'FeuFeuEauIncolore' AND attackDamage = '90'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/en/bw/bw6/86/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Tackle' AND attackCost = 'Colorless' AND attackDamage = '10'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/en/bw/bw6/86/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Gnaw' AND attackCost = 'WaterFighting' AND attackDamage = '20'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/fr/bw/bw6/33/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Grosse Vague' AND attackCost = 'Incolore' AND attackDamage = '20'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/fr/bw/bw6/33/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Cascade' AND attackCost = 'EauEau' AND attackDamage = '60'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/en/bw/bw6/30/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Ice Ball' AND attackCost = 'WaterColorless' AND attackDamage = '30'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/en/bw/bw6/30/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Aurora Beam' AND attackCost = 'WaterColorlessColorless' AND attackDamage = '40'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/fr/bw/bw3/9/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Roulade' AND attackCost = 'Plante' AND attackDamage = '20'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/en/bw/bw8/8/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Bug Bite' AND attackCost = 'Grass' AND attackDamage = '20'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/en/bw/bw11/94/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Tackle' AND attackCost = 'Colorless' AND attackDamage = '10'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/en/bw/bw11/94/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Gnaw' AND attackCost = 'WaterFighting' AND attackDamage = '20'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/fr/bw/bw7/25/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Roulade' AND attackCost = 'FeuIncolore' AND attackDamage = '20'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/fr/bw/bw7/25/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Souffle-Feu' AND attackCost = 'FeuIncoloreIncolore' AND attackDamage = '40'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/en/bw/bw9/22/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Mud Gun' AND attackCost = 'WaterColorlessColorless' AND attackDamage = '60'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/fr/bw/dv1/15/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Griffe' AND attackCost = 'MétalIncolore' AND attackDamage = '20'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/fr/bw/dv1/15/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Croc Aiguisé' AND attackCost = 'CombatIncoloreIncolore' AND attackDamage = '40'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/en/bw/bw7/14/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Ram' AND attackCost = 'Colorless' AND attackDamage = '10'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/fr/bw/bw3/30/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Pluie Éclaboussante' AND attackCost = 'IncoloreIncolore' AND attackDamage = '20'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/en/bw/bw9/27/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Jump On' AND attackCost = 'ColorlessColorless' AND attackDamage = '20'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/fr/bw/bw9/93/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Lait Max' AND attackCost = 'IncoloreIncolore' AND attackDamage = null))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/fr/bw/bw9/93/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Charge' AND attackCost = 'IncoloreIncolore' AND attackDamage = '30'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/en/bw/bw6/85/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Celestial Roar' AND attackCost = 'Colorless' AND attackDamage = null))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/en/bw/bw6/85/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Dragon Burst' AND attackCost = 'FireLightning' AND attackDamage = '60'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/fr/bw/bw2/24/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Fléau' AND attackCost = 'Incolore' AND attackDamage = '10'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/fr/bw/bw2/24/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Tout ou Rien' AND attackCost = 'EauIncoloreIncolore' AND attackDamage = '80'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/en/bw/bw5/22/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Burning Wind' AND attackCost = 'FireColorlessColorless' AND attackDamage = '70'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/fr/bw/bw2/50/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Coup d''Boule' AND attackCost = 'Incolore' AND attackDamage = '10'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/fr/bw/bw2/50/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Attaque Imprudente' AND attackCost = 'CombatIncolore' AND attackDamage = '30'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/en/bw/bw9/45/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Lure Poison' AND attackCost = 'Psychic' AND attackDamage = null))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/en/bw/bw9/45/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Sludge Toss' AND attackCost = 'PsychicColorlessColorless' AND attackDamage = '30'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/fr/bw/bw10/19/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Tir de Précision' AND attackCost = 'Eau' AND attackDamage = null))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/fr/bw/bw10/19/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Bulles d''O' AND attackCost = 'EauEau' AND attackDamage = '40'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/en/bw/bw5/18/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Flame Cloak' AND attackCost = 'Colorless' AND attackDamage = '10'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/en/bw/bw5/18/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Heat Blast' AND attackCost = 'FireColorlessColorless' AND attackDamage = '60'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/fr/bw/bw4/52/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Glu Fétide' AND attackCost = 'PsyIncolore' AND attackDamage = '20'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/en/bw/bw10/47/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Low Kick' AND attackCost = 'FightingColorless' AND attackDamage = '30'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/fr/bw/bw9/66/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Grêle' AND attackCost = 'Incolore' AND attackDamage = null))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/fr/bw/bw9/66/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Calomnie' AND attackCost = 'ObscuritéIncolore' AND attackDamage = '30'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/en/bw/bw10/60/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Hypnostrike' AND attackCost = 'MetalColorlessColorless' AND attackDamage = '60'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/fr/bw/bw3/35/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Hâte' AND attackCost = 'Électrique' AND attackDamage = '10'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/en/bw/bw2/32/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Thundershock' AND attackCost = 'Lightning' AND attackDamage = '10'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/en/bw/bw2/32/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Acrobatics' AND attackCost = 'ColorlessColorless' AND attackDamage = '10'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/fr/bw/bw1/78/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Croc de Mort' AND attackCost = 'Incolore' AND attackDamage = '30'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/en/bw/bw8/70/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Lock Up' AND attackCost = 'Psychic' AND attackDamage = '20'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/en/bw/bw8/70/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Damakinesis' AND attackCost = 'PsychicColorlessColorless' AND attackDamage = null))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/fr/bw/bw9/86/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Vol Supersonique' AND attackCost = 'PsyIncolore' AND attackDamage = '40'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/fr/bw/bw9/86/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Lumi-Éclat' AND attackCost = 'EauPsyIncolore' AND attackDamage = '150'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/en/bw/bw8/78/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Hurricane Kick' AND attackCost = 'FightingColorlessColorless' AND attackDamage = '60'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/fr/bw/dv1/15/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Griffe' AND attackCost = 'MétalIncolore' AND attackDamage = '20'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/fr/bw/dv1/15/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Croc Aiguisé' AND attackCost = 'CombatIncoloreIncolore' AND attackDamage = '40'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/en/bw/bw7/14/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Ram' AND attackCost = 'Colorless' AND attackDamage = '10'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/fr/bw/bw6/21/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Barrière de Flammes' AND attackCost = 'Feu' AND attackDamage = '40'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/fr/bw/bw6/21/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Lance-Flamme' AND attackCost = 'FeuIncoloreIncolore' AND attackDamage = '90'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/en/bw/bw4/19/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Ember' AND attackCost = 'FireColorless' AND attackDamage = '40'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/fr/bw/bwp/BW84/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Triplattaque' AND attackCost = 'IncoloreIncoloreIncolore' AND attackDamage = '50'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/fr/bw/bw6/79/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Griffe Acier' AND attackCost = 'MétalIncolore' AND attackDamage = '30'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/fr/bw/bw6/79/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Ravages' AND attackCost = 'MétalMétalIncolore' AND attackDamage = '60'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/en/bw/bw7/72/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Bug Bite' AND attackCost = 'PsychicColorless' AND attackDamage = '20'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/en/bw/bw9/23/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Icy Wind' AND attackCost = 'WaterColorlessColorless' AND attackDamage = '60'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/fr/bw/bw8/86/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Coud''Pied Éjecteur' AND attackCost = 'ObscuritéIncolore' AND attackDamage = '30'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/fr/bw/bw8/86/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Coup d’Boule Renforcé' AND attackCost = 'ObscuritéObscuritéIncolore' AND attackDamage = '50'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/en/bw/bw1/79/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Confuse Ray' AND attackCost = 'ColorlessColorless' AND attackDamage = null))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/en/bw/bw1/79/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Hyper Fang' AND attackCost = 'ColorlessColorless' AND attackDamage = '60'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/en/bw/bw9/95/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Tackle' AND attackCost = 'Colorless' AND attackDamage = '10'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/fr/bw/bw1/63/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Tombe de Sable' AND attackCost = 'Combat' AND attackDamage = '10'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/fr/bw/bw1/63/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Morsure' AND attackCost = 'CombatIncoloreIncolore' AND attackDamage = '30'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/en/bw/bw6/57/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Doom Decree' AND attackCost = 'PsychicColorless' AND attackDamage = null))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/en/bw/bw6/57/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Black Magic' AND attackCost = 'PsychicColorlessColorless' AND attackDamage = '40'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/fr/bw/bw4/64/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Aurasphère' AND attackCost = 'CombatCombat' AND attackDamage = '50'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/en/bw/bw3/58/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Teleportation Burst' AND attackCost = 'Psychic' AND attackDamage = '10'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/fr/bw/bw4/66/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Canon à Sable' AND attackCost = 'CombatIncoloreIncolore' AND attackDamage = '70'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/fr/bw/bw4/66/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Roule-Pierre' AND attackCost = 'CombatCombatIncoloreIncolore' AND attackDamage = '90'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/en/bw/bw11/60/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Mind Bend' AND attackCost = 'PsychicColorless' AND attackDamage = '20'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/en/bw/bw11/60/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Spinning Attack' AND attackCost = 'PsychicColorlessColorless' AND attackDamage = '40'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/fr/bw/bw7/121/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Morsure' AND attackCost = 'Incolore' AND attackDamage = '20'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/fr/bw/bw7/121/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Bélier' AND attackCost = 'IncoloreIncoloreIncolore' AND attackDamage = '60'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/en/bw/bw4/102/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Nasty Plot' AND attackCost = 'Darkness' AND attackDamage = null))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/en/bw/bw4/102/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Foul Play' AND attackCost = 'ColorlessColorless' AND attackDamage = null))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/fr/bw/bw2/42/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Vif Retournement' AND attackCost = 'Psy' AND attackDamage = '10'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/fr/bw/bw2/42/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Assaut Psychique' AND attackCost = 'IncoloreIncoloreIncolore' AND attackDamage = '40'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/en/bw/bw4/38/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Frozen Wings' AND attackCost = 'WaterColorlessColorless' AND attackDamage = '60'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/en/bw/bw4/38/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Hail Blizzard' AND attackCost = 'WaterWaterColorlessColorless' AND attackDamage = '120'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/fr/bw/bw6/41/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Charge' AND attackCost = 'Électrique' AND attackDamage = '10'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/fr/bw/bw6/41/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Vive-Attaque' AND attackCost = 'ÉlectriqueIncolore' AND attackDamage = '10'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/en/bw/bw4/37/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Daunt' AND attackCost = 'ColorlessColorless' AND attackDamage = '40'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/en/bw/bw4/37/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Ambush' AND attackCost = 'WaterColorlessColorless' AND attackDamage = '60'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/en/bw/bw7/76/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Psypunch' AND attackCost = 'ColorlessColorless' AND attackDamage = '30'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/en/bw/bw7/76/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Destructive Beam' AND attackCost = 'PsychicColorlessColorless' AND attackDamage = '50'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/fr/bw/bwp/BW05/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Colère' AND attackCost = 'IncoloreIncolore' AND attackDamage = '20'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/fr/bw/bwp/BW05/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'ChargeFoudre' AND attackCost = 'ÉlectriqueÉlectriqueIncolore' AND attackDamage = '120'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/fr/bw/bw6/86/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Charge' AND attackCost = 'Incolore' AND attackDamage = '10'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/fr/bw/bw6/86/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Ronge' AND attackCost = 'EauCombat' AND attackDamage = '20'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/en/bw/bw11/78/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Psychic' AND attackCost = 'Psychic' AND attackDamage = '10'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/en/bw/bw11/78/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Echoed Voice' AND attackCost = 'PsychicColorlessColorless' AND attackDamage = '50'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/fr/bw/bw1/4/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Essorage' AND attackCost = 'PlanteIncolore' AND attackDamage = '30'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/en/bw/bw10/3/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Spiral Drain' AND attackCost = 'GrassColorless' AND attackDamage = '20'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/fr/bw/bw4/82/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Giga Pouvoir' AND attackCost = 'IncoloreIncoloreIncolore' AND attackDamage = '60'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/fr/bw/bw4/82/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Marteau Rageur' AND attackCost = 'IncoloreIncoloreIncoloreIncolore' AND attackDamage = '50'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/en/bw/bw1/75/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Bind' AND attackCost = 'Metal' AND attackDamage = '10'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/en/bw/bw1/75/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Gear Grind' AND attackCost = 'MetalColorlessColorless' AND attackDamage = '60'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/fr/bw/bw3/99/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Vengeance' AND attackCost = 'CombatIncolore' AND attackDamage = '30'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/fr/bw/bw3/99/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Écras''Terre' AND attackCost = 'CombatCombatIncolore' AND attackDamage = '90'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/en/bw/bw11/90/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Brutal Bash' AND attackCost = 'ColorlessColorless' AND attackDamage = '20'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/en/bw/bw11/90/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Dark Rush' AND attackCost = 'DarknessDarkness' AND attackDamage = '20'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/fr/bw/bw10/25/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Bataille' AND attackCost = 'IncoloreIncolore' AND attackDamage = '20'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/fr/bw/bw10/25/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Tranch''Herbe' AND attackCost = 'PlantePlanteIncolore' AND attackDamage = '40'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/en/bw/bw2/23/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Grass'' Power' AND attackCost = 'ColorlessColorless' AND attackDamage = '30'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/en/bw/bw2/23/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Rushing Water' AND attackCost = 'WaterColorlessColorless' AND attackDamage = '60'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/fr/bw/bw6/106/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Choc Frontal' AND attackCost = 'IncoloreIncolore' AND attackDamage = '20'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/en/bw/bw4/95/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Glinting Claw' AND attackCost = 'FireColorlessColorless' AND attackDamage = '50'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/en/bw/bw4/95/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Brave Fire' AND attackCost = 'FireFireColorlessColorless' AND attackDamage = '150'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/fr/bw/bw8/2/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Asticotage' AND attackCost = 'PlanteIncoloreIncolore' AND attackDamage = '40'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/en/bw/bw10/2/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Bug Bite' AND attackCost = 'ColorlessColorlessColorless' AND attackDamage = '60'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/fr/bw/bw7/33/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Anti-Flammes' AND attackCost = 'Eau' AND attackDamage = null))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/en/bw/bw7/30/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Withdraw' AND attackCost = 'Colorless' AND attackDamage = null))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/en/bw/bw7/30/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Waterfall' AND attackCost = 'WaterWaterColorless' AND attackDamage = '60'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/fr/bw/bw8/66/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Brouillard Toxique' AND attackCost = 'Incolore' AND attackDamage = '20'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/fr/bw/bw8/66/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Bomb-Beurk' AND attackCost = 'PsyPsyIncolore' AND attackDamage = '70'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/en/bw/bw9/60/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Fury Swipes' AND attackCost = 'ColorlessColorless' AND attackDamage = '30'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/en/bw/bw9/60/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Karate Chop' AND attackCost = 'FightingFighting' AND attackDamage = '80'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/fr/bw/bwp/BW16/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Draco-Rage' AND attackCost = 'IncoloreIncolore' AND attackDamage = '50'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/en/bw/bw1/113/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Outrage' AND attackCost = 'ColorlessColorless' AND attackDamage = '20'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/en/bw/bw1/113/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Blue Flare' AND attackCost = 'FireFireColorless' AND attackDamage = '120'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/fr/bw/bw7/103/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Flux Draconique' AND attackCost = 'FeuIncoloreIncolore' AND attackDamage = '60'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/fr/bw/bw7/103/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Feu Glacé' AND attackCost = 'FeuFeuEauIncolore' AND attackDamage = '150'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/fr/bw/bw6/90/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Coupe Vive' AND attackCost = 'Combat' AND attackDamage = '60'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/fr/bw/bw6/90/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Draco-Lame' AND attackCost = 'EauCombat' AND attackDamage = '100'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/en/bw/bw7/82/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Slap Push' AND attackCost = 'FightingFighting' AND attackDamage = '30'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/fr/bw/bw9/109/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Coup de Chaud' AND attackCost = 'FeuIncoloreIncolore' AND attackDamage = '60'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/fr/bw/bw9/109/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Pression Explosive' AND attackCost = 'FeuFeuIncoloreIncolore' AND attackDamage = '80'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/en/bw/bw6/97/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Dragonblast' AND attackCost = 'PsychicDarknessDarknessColorless' AND attackDamage = '140'))