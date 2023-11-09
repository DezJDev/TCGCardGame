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
	resistanceType varchar(10) NOT NULL CHECK IN ['Incolore', 'Feu', 'Eau', 'Plante', 'Combat', 'M�tal', '�lectrique', 'Psy', 'Obscurit�', 'Dragon', 'Colorless', 'Fire', 'Water', 'Grass', 'Fighting', 'Metal', 'Lightning', 'Psychic', 'Darkness'],
	resistanceValue varchar(5) NOT NULL CHECK IN ['/2',-20,-10,-30]);

CREATE TABLE IF NOT EXISTS P10_Weakness(
	weaknessId INT AUTO_INCREMENT PRIMARY KEY,
	weaknessType varchar(10) NOT NULL CHECK IN ['Incolore', 'Feu', 'Eau', 'Plante', 'Combat', 'M�tal', '�lectrique', 'Psy', 'Obscurit�', 'Dragon', 'Colorless', 'Fire', 'Water', 'Grass', 'Fighting', 'Metal', 'Lightning', 'Psychic', 'Darkness'],
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
	('Sol Verglac�','Une seule fois pendant votre tour (avant votre attaque), vous pouvez �changer votre Pok�mon Actif avec 1 de vos Pok�mon de Banc. Dans ce cas, votre adversaire �change son Pok�mon Actif avec 1 de ses Pok�mon de Banc.'),
	('Laid-Back','Any damage done to this Pok�mon by attacks is reduced by 20 (after applying Weakness and Resistance).'),
	('Scorching Scales','Put 4 damage counters instead of 2 on your opponent�s Burned Pok�mon between turns.'),
	('Stellar Guidance','When you play this Pok�mon from your hand onto your Bench, you may search your deck for a Supporter card, reveal it, and put it into your hand. Shuffle your deck afterward.'),
	('Dual Armor','If this Pok�mon has any Metal Energy attached to it, this Pok�mon�s type is both Fighting and Metal.'),
	('Transfert Plasma','Autant de fois que vous le voulez pendant votre tour (avant votre attaque), vous pouvez d�placer une �nergie Plasma attach�e � 1 de vos Pok�mon vers un autre de vos Pok�mon.'),
	('Poison Point','If this Pok�mon is your Active Pok�mon and is damaged by an opponent�s attack (even if this Pok�mon is Knocked Out), the Attacking Pok�mon is now Poisoned.'),
	('Freeze Zone','The Retreat Cost of each of your Team Plasma Pok�mon in play is ColorlessColorless less.'),
	('Contre-Offensive','Si ce Pok�mon est votre Pok�mon Actif et qu�il subit les d�g�ts d�une attaque de votre adversaire (m�me si ce Pok�mon est mis K.O.), placez 2 marqueurs de d�g�ts sur le Pok�mon Attaquant.'),
	('Prehistoric Call','Once during your turn (before your attack), if this Pok�mon is in your discard pile, you may put this Pok�mon on the bottom of your deck.'),
	('Tool Reversal','As often as you like during your turn (before your attack), you may put a Pok�mon Tool card attached to 1 of your Pok�mon into your hand.'),
	('Dark Trance','As often as you like during your turn (before your attack), you may move a Darkness Energy attached to 1 of your Pok�mon to another of your Pok�mon.');

INSERT INTO P10_Attack(attackName,attackCost,attackDamage,attackEffect) VALUES 
	('Brise-Glace','EauIncoloreIncolore','60','Inflige 10 d�g�ts suppl�mentaires pour chaque Colorless dans le co�t de Retraite du Pok�mon D�fenseur.'),
	('Flailing Flop','Colorless','10','Flip a coin. If tails, this Pok�mon does 10 damage to itself.'),
	('Laser Glace','EauIncoloreIncolore','50','Lancez une pi�ce. Si c''est face, le Pok�mon D�fenseur est maintenant Paralys�.'),
	('Fire Fang','FireColorless','20','The Defending Pok�mon is now Burned.'),
	('Cri du Ciel','Incolore',null,'D�faussez les 3 cartes du dessus de votre deck. Si vous y trouvez des cartes �nergie, attachez-les � ce Pok�mon.'),
	('Glare and Peck','ColorlessColorless','10','Flip a coin. If heads, the Defending Pok�mon is now Paralyzed.'),
	('Vol','IncoloreIncolore','50','Lancez une pi�ce. Si c�est pile, cette attaque ne fait rien. Si c�est face, �vitez tous les effets d�attaques (y compris les d�g�ts) inflig�s � ce Pok�mon pendant le prochain tour de votre adversaire.'),
	('Scratch','ColorlessColorless','20',null),
	('Doubleslap','ColorlessColorless','30','Flip 2 coins. This attack does 30 damage times the number of heads.'),
	('Roue d''�nergie','Incolore',null,'D�placez une �nergie de l''un de vos Pok�mon de Banc vers ce Pok�mon.'),
	('Triple Laser','ColorlessColorlessColorless',null,'This attack does 30 damage to 3 of your opponent''s Pok�mon. (Don''t apply Weakness and Resistance for Benched Pok�mon.)'),
	('Pression de Garde','IncoloreIncolore','20','Pendant le prochain tour de votre adversaire, tous les d�g�ts inflig�s � ce Pok�mon par des attaques sont r�duits de 20 (apr�s application de la Faiblesse et de la R�sistance).'),
	('Tackle','Colorless','10',null),
	('Grosse Vague','Incolore','20',null),
	('Ice Ball','WaterColorless','30',null),
	('Roulade','Plante','20',null),
	('Bug Bite','Grass','20',null),
	('Mud Gun','WaterColorlessColorless','60','If this Pok�mon has any Fighting Energy attached to it, this attack does 30 more damage.'),
	('Griffe','M�talIncolore','20',null),
	('Ram','Colorless','10',null),
	('Pluie �claboussante','IncoloreIncolore','20',null),
	('Jump On','ColorlessColorless','20','Flip a coin. If heads, this attack does 10 more damage.'),
	('Lait Max','IncoloreIncolore',null,'Soignez tous les d�g�ts de l''un de vos Pok�mon. Ensuite, d�faussez toutes les �nergies attach�es � ce Pok�mon.'),
	('Celestial Roar','Colorless',null,'Discard the top 3 cards of your deck. If any of those cards are Energy cards, attach them to this Pok�mon.'),
	('Fl�au','Incolore','10','Inflige 10 d�g�ts multipli�s par le nombre de marqueurs de d�g�ts plac�s sur ce Pok�mon.'),
	('Burning Wind','FireColorlessColorless','70','You may discard an Energy attached to this Pok�mon. If you do, the Defending Pok�mon is now Burned.'),
	('Coup d''Boule','Incolore','10',null),
	('Lure Poison','Psychic',null,'Flip a coin. If heads, switch 1 of your opponent''s Benched Pok�mon with the Defending Pok�mon. The new Defending Pok�mon is now Poisoned.'),
	('Tir de Pr�cision','Eau',null,'Cette attaque inflige 30 d�g�ts � 1 des Pok�mon de votre adversaire. (N''appliquez ni la Faiblesse ni la R�sistance aux Pok�mon de Banc.)'),
	('Flame Cloak','Colorless','10','Flip a coin. If heads, attach a Fire Energy card from your discard pile to this Pok�mon.'),
	('Glu F�tide','PsyIncolore','20','Lancez une pi�ce. Si c''est face, le Pok�mon D�fenseur est maintenant Paralys�.'),
	('Low Kick','FightingColorless','30',null),
	('Gr�le','Incolore',null,'Cette attaque inflige 10 d�g�ts � chacun des Pok�mon de votre adversaire. (N''appliquez ni la Faiblesse ni la R�sistance aux Pok�mon de Banc.)'),
	('Hypnostrike','MetalColorlessColorless','60','Both this Pok�mon and the Defending Pok�mon are now Asleep.'),
	('H�te','�lectrique','10','Lancez une pi�ce. Si c''est face, �vitez tous les effets d''attaques (y compris les d�g�ts) inflig�s � ce Pok�mon pendant le prochain tour de votre adversaire.'),
	('Thundershock','Lightning','10','Flip a coin. If heads, the Defending Pok�mon is now Paralyzed.'),
	('Croc de Mort','Incolore','30','Lancez une pi�ce. Si c�est pile, cette attaque ne fait rien.'),
	('Lock Up','Psychic','20','The Defending Pok�mon can''t retreat during your opponent''s next turn.'),
	('Vol Supersonique','PsyIncolore','40','Le Pok�mon D�fenseur ne peut pas battre en retraite pendant le prochain tour de votre adversaire.'),
	('Hurricane Kick','FightingColorlessColorless','60','Does 30 more damage for each Prize card your opponent has taken.'),
	('Barri�re de Flammes','Feu','40','Pendant le prochain tour de votre adversaire, tous les d�g�ts inflig�s � ce Pok�mon par des attaques sont r�duits de 20 (apr�s application de la Faiblesse et de la R�sistance).'),
	('Ember','FireColorless','40','Flip a coin. If tails, discard an Energy attached to this Pok�mon.'),
	('Triplattaque','IncoloreIncoloreIncolore','50','Lancez 3 pi�ces. Cette attaque inflige 50 d�g�ts multipli�s par le nombre de c�t�s face.'),
	('Griffe Acier','M�talIncolore','30',null),
	('Icy Wind','WaterColorlessColorless','60','The Defending Pok�mon is now Asleep.'),
	('Coud''Pied �jecteur','Obscurit�Incolore','30','Votre adversaire �change le Pok�mon D�fenseur avec 1 de ses Pok�mon de Banc.'),
	('Confuse Ray','ColorlessColorless',null,'The Defending Pok�mon is now Confused.'),
	('Tombe de Sable','Combat','10','Le Pok�mon D�fenseur ne peut pas battre en retraite durant le prochain tour de votre adversaire.'),
	('Doom Decree','PsychicColorless',null,'Flip 2 coins. If both of them are heads, the Defending Pok�mon is Knocked Out.'),
	('Aurasph�re','CombatCombat','50','Inflige 20 d�g�ts � 1 des Pok�mon de Banc de votre adversaire. (N''appliquez ni la Faiblesse ni la R�sistance aux Pok�mon de Banc.)'),
	('Teleportation Burst','Psychic','10','Switch this Pok�mon with 1 of your Benched Pok�mon.'),
	('Canon � Sable','CombatIncoloreIncolore','70','Vous pouvez d�placer une �nergie de base attach�e � ce Pok�mon vers 1 de vos Pok�mon de Banc.'),
	('Mind Bend','PsychicColorless','20','Flip a coin. If heads, the Defending Pok�mon is now Confused.'),
	('Morsure','Incolore','20',null),
	('Nasty Plot','Darkness',null,'Search your deck for a card and put it into your hand. Shuffle your deck afterward.'),
	('Vif Retournement','Psy','10','Lancez 2 pi�ces. Cette attaque inflige 10 d�g�ts multipli�s par le nombre de c�t�s face.'),
	('Frozen Wings','WaterColorlessColorless','60','Discard a Special Energy attached to the Defending Pok�mon.'),
	('Charge','�lectrique','10',null),
	('Daunt','ColorlessColorless','40','During your opponent''s next turn, any damage done by attacks from the Defending Pok�mon is reduced by 20 (before applying Weakness and Resistance).'),
	('Psypunch','ColorlessColorless','30',null),
	('Col�re','IncoloreIncolore','20','Inflige 10 d�g�ts suppl�mentaires pour chaque marqueur de d�g�ts plac� sur ce Pok�mon.'),
	('Psychic','Psychic','10','Does 20 more damage for each Energy attached to the Defending Pok�mon.'),
	('Essorage','PlanteIncolore','30','Lancez une pi�ce. Si c�est face, le Pok�mon D�fenseur est maintenant Paralys�, et vous d�faussez une �nergie attach�e au Pok�mon D�fenseur.'),
	('Spiral Drain','GrassColorless','20','Heal 10 damage from this Pok�mon.'),
	('Giga Pouvoir','IncoloreIncoloreIncolore','60','Vous pouvez infliger 20 d�g�ts suppl�mentaires. Dans ce cas, ce Pok�mon s''inflige 20 d�g�ts.'),
	('Bind','Metal','10','Flip a coin. If heads, the Defending Pok�mon is now Paralyzed.'),
	('Vengeance','CombatIncolore','30','Si l''un de vos Pok�mon a �t� mis K.O. par les d�g�ts d''une attaque de votre adversaire pendant son dernier tour, cette attaque inflige 60 d�g�ts suppl�mentaires.'),
	('Brutal Bash','ColorlessColorless','20','Does 20 damage times the number of Darkness Pok�mon you have in play.'),
	('Bataille','IncoloreIncolore','20',null),
	('Grass'' Power','ColorlessColorless','30','If this Pok�mon has any Grass Energy attached to it, heal 20 damage from this Pok�mon.'),
	('Choc Frontal','IncoloreIncolore','20','Ce Pok�mon et le Pok�mon D�fenseur sont maintenant Confus.'),
	('Glinting Claw','FireColorlessColorless','50','Flip a coin. If heads, this attack does 30 more damage.'),
	('Asticotage','PlanteIncoloreIncolore','40','Lancez une pi�ce. Si c''est face, cette attaque inflige 20 d�g�ts suppl�mentaires.'),
	('Anti-Flammes','Eau',null,'D�faussez une �nergie Fire attach�e au Pok�mon D�fenseur.'),
	('Withdraw','Colorless',null,'Flip a coin. If heads, prevent all damage done to this Pok�mon by attacks during your opponent''s next turn.'),
	('Brouillard Toxique','Incolore','20','Le Pok�mon D�fenseur est maintenant Empoisonn�. Lancez une pi�ce. Si c''est face, d�faussez une �nergie attach�e au Pok�mon D�fenseur.'),
	('Fury Swipes','ColorlessColorless','30','Flip 3 coins. This attack does 30 damage times the number of heads.'),
	('Draco-Rage','IncoloreIncolore','50','Lancez 2 pi�ces. Si vous obtenez un c�t� pile, cette attaque ne fait rien.'),
	('Outrage','ColorlessColorless','20','Does 10 more damage for each damage counter on this Pok�mon.'),
	('Flux Draconique','FeuIncoloreIncolore','60','Lancez une pi�ce. Si c''est face, attachez une carte �nergie de base de votre pile de d�fausse � ce Pok�mon.'),
	('Coupe Vive','Combat','60','D�faussez une �nergie sp�ciale attach�e au Pok�mon D�fenseur.'),
	('Slap Push','FightingFighting','30',null),
	('Coup de Chaud','FeuIncoloreIncolore','60','Si ce Pok�mon est affect� par un �tat Sp�cial, cette attaque inflige 60 d�g�ts suppl�mentaires.'),
	('Dragonblast','PsychicDarknessDarknessColorless','140','Discard 2 Darkness Energy attached to this Pok�mon.');

INSERT INTO P10_Attack(attackName,attackCost,attackDamage,attackEffect) VALUES 
	('Aile Glace','EauIncoloreIncoloreIncolore','80',null),
	('Thrash','FireColorlessColorless','70','Flip a coin. If heads, this attack does 20 more damage. If tails, this Pok�mon does 20 damage to itself.'),
	('Fureur du Dragon','Feu�lectrique','60','D�faussez toutes les �nergies Fire de base ou toutes les �nergies Lightning de base attach�es � ce Pok�mon. Cette attaque inflige 60 d�g�ts multipli�s par le nombre de cartes �nergie que vous avez d�fauss�es.'),
	('Vent Glacial','IncoloreIncoloreIncolore','70',null),
	('Metal Claw','MetalMetalColorless','40',null),
	('Vent Violent','IncoloreIncoloreIncolore','80','D�placez une �nergie de base de ce Pok�mon vers 1 de vos Pok�mon de Banc.'),
	('Protect Charge','MetalMetalColorlessColorless','80','During your opponent''s next turn, any damage done to this Pok�mon by attacks is reduced by 20 (after applying Weakness and Resistance).'),
	('Dracogriffe','FeuFeuEauIncolore','90',null),
	('Gnaw','WaterFighting','20',null),
	('Cascade','EauEau','60',null),
	('Aurora Beam','WaterColorlessColorless','40',null),
	('Souffle-Feu','FeuIncoloreIncolore','40','Lancez une pi�ce. Si c''est face, cette attaque inflige 20 d�g�ts suppl�mentaires.'),
	('Croc Aiguis�','CombatIncoloreIncolore','40',null),
	('Charge','IncoloreIncolore','30',null),
	('Dragon Burst','FireLightning','60','Discard all basic Fire Energy or all basic Lightning Energy attached to this Pok�mon. This attack does 60 damage times the number of Energy cards you discarded.'),
	('Tout ou Rien','EauIncoloreIncolore','80','Lancez 2 pi�ces. Si vous obtenez 2 c�t�s pile, ce Pok�mon s''inflige 80 d�g�ts.'),
	('Attaque Imprudente','CombatIncolore','30','Ce Pok�mon s''inflige 10 d�g�ts.'),
	('Sludge Toss','PsychicColorlessColorless','30',null),
	('Bulles d''O','EauEau','40','Lancez une pi�ce. Si c''est face, le Pok�mon D�fenseur est maintenant Paralys�.'),
	('Heat Blast','FireColorlessColorless','60',null),
	('Calomnie','Obscurit�Incolore','30','D�faussez autant de Pok�mon que vous voulez de votre main. Cette attaque inflige 30 d�g�ts multipli�s par le nombre de Pok�mon que vous avez d�fauss�s.'),
	('Acrobatics','ColorlessColorless','10','Flip 2 coins. This attack does 20 more damage for each heads.'),
	('Damakinesis','PsychicColorlessColorless',null,'Move 6 damage counters from any of your Pok�mon to the Defending Pok�mon.'),
	('Lumi-�clat','EauPsyIncolore','150','D�faussez toutes les �nergies attach�es � ce Pok�mon.'),
	('Lance-Flamme','FeuIncoloreIncolore','90','D�faussez une �nergie attach�e � ce Pok�mon.'),
	('Ravages','M�talM�talIncolore','60','Lancez une pi�ce jusqu''� ce que vous obteniez un c�t� pile. Pour chaque c�t� face, d�faussez la carte du dessus du deck de votre adversaire.'),
	('Coup d�Boule Renforc�','Obscurit�Obscurit�Incolore','50','Si une carte Outil Pok�mon est attach�e � ce Pok�mon, cette attaque inflige 50 d�g�ts suppl�mentaires.'),
	('Hyper Fang','ColorlessColorless','60','Flip a coin. If tails, this attack does nothing.'),
	('Morsure','CombatIncoloreIncolore','30',null),
	('Black Magic','PsychicColorlessColorless','40','Does 20 more damage for each of your opponent''s Benched Pok�mon.'),
	('Roule-Pierre','CombatCombatIncoloreIncolore','90','Les d�g�ts de cette attaque ne sont pas affect�s par la R�sistance.'),
	('Spinning Attack','PsychicColorlessColorless','40',null),
	('B�lier','IncoloreIncoloreIncolore','60','Ce Pok�mon s''inflige 10 d�g�ts.'),
	('Foul Play','ColorlessColorless',null,'Choose 1 of the Defending Pok�mon''s attacks and use it as this attack.'),
	('Assaut Psychique','IncoloreIncoloreIncolore','40','Inflige 10 d�g�ts suppl�mentaires pour chaque marqueur de d�g�ts plac� sur le Pok�mon D�fenseur.'),
	('Hail Blizzard','WaterWaterColorlessColorless','120','This Pok�mon can''t use Hail Blizzard during your next turn.'),
	('Vive-Attaque','�lectriqueIncolore','10','Lancez une pi�ce. Si c''est face, cette attaque inflige 20 d�g�ts suppl�mentaires.'),
	('Ambush','WaterColorlessColorless','60','Flip a coin. If heads, this attack does 30 more damage.'),
	('Destructive Beam','PsychicColorlessColorless','50','Flip a coin. If heads, discard an Energy attached to the Defending Pok�mon.'),
	('ChargeFoudre','�lectrique�lectriqueIncolore','120','Ce Pok�mon s�inflige 40 d�g�ts.'),
	('Ronge','EauCombat','20',null),
	('Echoed Voice','PsychicColorlessColorless','50','During your next turn, this Pok�mon''s Echoed Voice attack does 50 more damage (before applying Weakness and Resistance).'),
	('Marteau Rageur','IncoloreIncoloreIncoloreIncolore','50','Inflige 10 d�g�ts suppl�mentaires pour chaque marqueur de d�g�ts plac� sur ce Pok�mon.'),
	('Gear Grind','MetalColorlessColorless','60','Flip 2 coins. This attack does 60 damage times the number of heads.'),
	('�cras''Terre','CombatCombatIncolore','90',null),
	('Dark Rush','DarknessDarkness','20','Does 20 damage times the number of damage counters on this Pok�mon.'),
	('Tranch''Herbe','PlantePlanteIncolore','40',null),
	('Rushing Water','WaterColorlessColorless','60','Move an Energy attached to the Defending Pok�mon to 1 of your opponent''s Benched Pok�mon.'),
	('Brave Fire','FireFireColorlessColorless','150','Flip a coin. If tails, this Pok�mon does 50 damage to itself.'),
	('Waterfall','WaterWaterColorless','60',null),
	('Bomb-Beurk','PsyPsyIncolore','70',null),
	('Karate Chop','FightingFighting','80','Does 80 damage minus 10 damage for each damage counter on this Pok�mon.'),
	('Blue Flare','FireFireColorless','120','Discard 2 Fire Energy attached to this Pok�mon.'),
	('Feu Glac�','FeuFeuEauIncolore','150','D�faussez 2 �nergies Fire attach�es � ce Pok�mon. Le Pok�mon D�fenseur est maintenant Br�l�.'),
	('Draco-Lame','EauCombat','100','D�faussez les 2 cartes du dessus de votre deck.'),
	('Pression Explosive','FeuFeuIncoloreIncolore','80','Si de l''�nergie Plasma est attach�e � ce Pok�mon, cette attaque inflige 10 d�g�ts suppl�mentaires pour chaque marqueur de d�g�ts plac� sur le Pok�mon D�fenseur.');

INSERT INTO P10_Resistance(resistanceType,resistanceValue) VALUES 
	('Combat','-20'),
	('Fighting','-20'),
	('Psychic','-20'),
	('Eau','-20'),
	('Water','-20'),
	('Psy','-20'),
	('�lectrique','-20');

INSERT INTO P10_Weakness(weaknessType,weaknessValue) VALUES 
	('M�tal','�2'),
	('Lightning','�2'),
	('Water','�2'),
	('Dragon','�2'),
	('�lectrique','�2'),
	('Fire','�2'),
	('Fighting','�2'),
	('Metal','�2'),
	('Feu','�2'),
	('Eau','�2'),
	('Grass','�2'),
	('Combat','�2'),
	('Plante','�2'),
	('Psychic','�2'),
	('Psy','�2'),
	('Darkness','�2');

INSERT INTO P10_Card(cardCategory,cardName,cardHP,cardRarity,cardImg,cardType,cardExtensioncardRetreat,cardLang,abilityId,resistanceId,weaknessId) VALUES
	('Pok�mon','Sorbouboul','130','Rare','https://assets.tcgdex.net/fr/bw/bw4/33/high.webp','Eau','Destin�es Futures',2,'fr',(SELECT abilityId FROM P10_Ability WHERE abilityName = 'Sol Verglac�' AND abilityEffect = 'Une seule fois pendant votre tour (avant votre attaque), vous pouvez �changer votre Pok�mon Actif avec 1 de vos Pok�mon de Banc. Dans ce cas, votre adversaire �change son Pok�mon Actif avec 1 de ses Pok�mon de Banc.'),(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'M�tal' AND weaknessValue = '�2'),null),
	('Pokemon','Magikarp','30','Common','https://assets.tcgdex.net/en/bw/bw11/30/high.webp','Water','Legendary Treasures',1,'en',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Lightning' AND weaknessValue = '�2'),null),
	('Pok�mon','Artikodin','120','Rare','https://assets.tcgdex.net/fr/bw/bw4/27/high.webp','Eau','Destin�es Futures',2,'fr',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'M�tal' AND weaknessValue = '�2'),(SELECT resistanceId FROM P10_Resistance WHERE resistanceType = 'Combat' AND resistanceValue = '-20')),
	('Pokemon','Darmanitan','120','Rare','https://assets.tcgdex.net/en/bw/bw1/25/high.webp','Fire','Black & White',2,'en',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Water' AND weaknessValue = '�2'),null),
	('Pok�mon','Rayquaza-EX','170','Ultra Rare','https://assets.tcgdex.net/fr/bw/bw6/123/high.webp','Dragon','Dragons �xalt�s',1,'fr',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Dragon' AND weaknessValue = '�2'),null),
	('Pokemon','Swablu','40','Common','https://assets.tcgdex.net/en/bw/bw11/103/high.webp','Colorless','Legendary Treasures',1,'en',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Lightning' AND weaknessValue = '�2'),(SELECT resistanceId FROM P10_Resistance WHERE resistanceType = 'Fighting' AND resistanceValue = '-20')),
	('Pok�mon','D�flaisan','120','Rare','https://assets.tcgdex.net/fr/bw/bw1/86/high.webp','Incolore','Noir & Blanc',1,'fr',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = '�lectrique' AND weaknessValue = '�2'),(SELECT resistanceId FROM P10_Resistance WHERE resistanceType = 'Combat' AND resistanceValue = '-20')),
	('Pokemon','Pawniard','60','Common','https://assets.tcgdex.net/en/bw/bw5/78/high.webp','Metal','Dark Explorers',1,'en',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Fire' AND weaknessValue = '�2'),(SELECT resistanceId FROM P10_Resistance WHERE resistanceType = 'Psychic' AND resistanceValue = '-20')),
	('Dresseur','Rappel Cyclone',null,'Rare','https://assets.tcgdex.net/fr/bw/bw10/95/high.webp',null,'Explosion Plasma',null,'fr',(SELECT abilityId FROM P10_Ability WHERE abilityEffect = 'Placez 1 de vos Pok�mon et toutes les cartes qui lui sont attach�es dans votre main.'),null,null),
	('Pokemon','Audino','80','Uncommon','https://assets.tcgdex.net/en/bw/bw1/87/high.webp','Colorless','Black & White',2,'en',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Fighting' AND weaknessValue = '�2'),null),
	('Pok�mon','Bor�as','110','Rare','https://assets.tcgdex.net/fr/bw/bw2/89/high.webp','Incolore','Pouvoirs �mergents',1,'fr',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = '�lectrique' AND weaknessValue = '�2'),(SELECT resistanceId FROM P10_Resistance WHERE resistanceType = 'Combat' AND resistanceValue = '-20')),
	('Pokemon','Registeel-EX','180','Rare','https://assets.tcgdex.net/en/bw/bw6/81/high.webp','Metal','Dragons Exalted',4,'en',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Fire' AND weaknessValue = '�2'),(SELECT resistanceId FROM P10_Resistance WHERE resistanceType = 'Psychic' AND resistanceValue = '-20')),
	('Pok�mon','Drakkarmin','110','Rare','https://assets.tcgdex.net/fr/bw/bw8/94/high.webp','Dragon','Temp�te Plasma',1,'fr',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Dragon' AND weaknessValue = '�2'),null),
	('Pokemon','Gible','50','Common','https://assets.tcgdex.net/en/bw/bw6/86/high.webp','Dragon','Dragons Exalted',1,'en',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Dragon' AND weaknessValue = '�2'),null),
	('Pok�mon','Must�flott','90','Peu Commune','https://assets.tcgdex.net/fr/bw/bw6/33/high.webp','Eau','Dragons �xalt�s',1,'fr',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = '�lectrique' AND weaknessValue = '�2'),null),
	('Pokemon','Sealeo','80','Uncommon','https://assets.tcgdex.net/en/bw/bw6/30/high.webp','Water','Dragons Exalted',3,'en',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Metal' AND weaknessValue = '�2'),null),
	('Pok�mon','Trompignon','40','Commune','https://assets.tcgdex.net/fr/bw/bw3/9/high.webp','Plante','Nobles Victoires',1,'fr',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Feu' AND weaknessValue = '�2'),(SELECT resistanceId FROM P10_Resistance WHERE resistanceType = 'Eau' AND resistanceValue = '-20')),
	('Pokemon','Sewaddle','40','Common','https://assets.tcgdex.net/en/bw/bw8/8/high.webp','Grass','Plasma Storm',1,'en',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Fire' AND weaknessValue = '�2'),null),
	('Dresseur','Badge de la Team Plasma',null,'Peu Commune','https://assets.tcgdex.net/fr/bw/bw9/104/high.webp',null,'Glaciation Plasma',null,'fr',(SELECT abilityId FROM P10_Ability WHERE abilityEffect = 'Le Pok�mon auquel cette carte est attach�e est un Pok�mon de la Team Plasma.'),null,null),
	('Pokemon','Gible','50','Common','https://assets.tcgdex.net/en/bw/bw11/94/high.webp','Dragon','Legendary Treasures',1,'en',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Dragon' AND weaknessValue = '�2'),null),
	('Pok�mon','Grotichon','90','Peu Commune','https://assets.tcgdex.net/fr/bw/bw7/25/high.webp','Feu','Fronti�res Franchies',2,'fr',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Eau' AND weaknessValue = '�2'),null),
	('Pokemon','Quagsire','100','Rare','https://assets.tcgdex.net/en/bw/bw9/22/high.webp','Water','Plasma Freeze',3,'en',(SELECT abilityId FROM P10_Ability WHERE abilityName = 'Laid-Back' AND abilityEffect = 'Any damage done to this Pok�mon by attacks is reduced by 20 (after applying Weakness and Resistance).'),(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Grass' AND weaknessValue = '�2'),null),
	('Pok�mon','Incisache','80','Rare','https://assets.tcgdex.net/fr/bw/dv1/15/high.webp','Dragon','Coffre des Dragons',2,'fr',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Dragon' AND weaknessValue = '�2'),null),
	('Pokemon','Cottonee','50','Common','https://assets.tcgdex.net/en/bw/bw7/14/high.webp','Grass','Boundaries Crossed',1,'en',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Fire' AND weaknessValue = '�2'),(SELECT resistanceId FROM P10_Resistance WHERE resistanceType = 'Water' AND resistanceValue = '-20')),
	('Pok�mon','Viskuse','80','Commune','https://assets.tcgdex.net/fr/bw/bw3/30/high.webp','Eau','Nobles Victoires',2,'fr',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = '�lectrique' AND weaknessValue = '�2'),null),
	('Pokemon','Vanillite','60','Common','https://assets.tcgdex.net/en/bw/bw9/27/high.webp','Water','Plasma Freeze',1,'en',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Metal' AND weaknessValue = '�2'),null),
	('Pok�mon','�cr�meuh','100','Peu Commune','https://assets.tcgdex.net/fr/bw/bw9/93/high.webp','Incolore','Glaciation Plasma',3,'fr',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Combat' AND weaknessValue = '�2'),null),
	('Pokemon','Rayquaza-EX','170','Rare','https://assets.tcgdex.net/en/bw/bw6/85/high.webp','Dragon','Dragons Exalted',1,'en',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Dragon' AND weaknessValue = '�2'),null),
	('Pok�mon','Bargantua','80','Commune','https://assets.tcgdex.net/fr/bw/bw2/24/high.webp','Eau','Pouvoirs �mergents',1,'fr',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = '�lectrique' AND weaknessValue = '�2'),null),
	('Pokemon','Volcarona','110','Rare','https://assets.tcgdex.net/en/bw/bw5/22/high.webp','Fire','Dark Explorers',3,'en',(SELECT abilityId FROM P10_Ability WHERE abilityName = 'Scorching Scales' AND abilityEffect = 'Put 4 damage counters instead of 2 on your opponent�s Burned Pok�mon between turns.'),(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Water' AND weaknessValue = '�2'),null),
	('Pok�mon','Nodulithe','60','Commune','https://assets.tcgdex.net/fr/bw/bw2/50/high.webp','Combat','Pouvoirs �mergents',2,'fr',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Plante' AND weaknessValue = '�2'),null),
	('Pokemon','Grimer','70','Common','https://assets.tcgdex.net/en/bw/bw9/45/high.webp','Psychic','Plasma Freeze',2,'en',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Psychic' AND weaknessValue = '�2'),null),
	('Pok�mon','Octillery','90','Peu Commune','https://assets.tcgdex.net/fr/bw/bw10/19/high.webp','Eau','Explosion Plasma',1,'fr',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = '�lectrique' AND weaknessValue = '�2'),null),
	('Pokemon','Torkoal','90','Uncommon','https://assets.tcgdex.net/en/bw/bw5/18/high.webp','Fire','Dark Explorers',2,'en',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Water' AND weaknessValue = '�2'),null),
	('Pok�mon','Tadmorv','70','Commune','https://assets.tcgdex.net/fr/bw/bw4/52/high.webp','Psy','Destin�es Futures',2,'fr',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Psy' AND weaknessValue = '�2'),null),
	('Pokemon','Machop','60','Common','https://assets.tcgdex.net/en/bw/bw10/47/high.webp','Fighting','Plasma Blast',3,'en',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Psychic' AND weaknessValue = '�2'),null),
	('Pok�mon','Dimoret','90','Rare','https://assets.tcgdex.net/fr/bw/bw9/66/high.webp','Obscurit�','Glaciation Plasma',1,'fr',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Combat' AND weaknessValue = '�2'),(SELECT resistanceId FROM P10_Resistance WHERE resistanceType = 'Psy' AND resistanceValue = '-20')),
	('Pokemon','Jirachi-EX','90','Rare','https://assets.tcgdex.net/en/bw/bw10/60/high.webp','Metal','Plasma Blast',1,'en',(SELECT abilityId FROM P10_Ability WHERE abilityName = 'Stellar Guidance' AND abilityEffect = 'When you play this Pok�mon from your hand onto your Bench, you may search your deck for a Supporter card, reveal it, and put it into your hand. Shuffle your deck afterward.'),(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Fire' AND weaknessValue = '�2'),(SELECT resistanceId FROM P10_Resistance WHERE resistanceType = 'Psychic' AND resistanceValue = '-20')),
	('Pok�mon','Z�bibron','60','Commune','https://assets.tcgdex.net/fr/bw/bw3/35/high.webp','�lectrique','Nobles Victoires',1,'fr',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Combat' AND weaknessValue = '�2'),null),
	('Pokemon','Emolga','70','Common','https://assets.tcgdex.net/en/bw/bw2/32/high.webp','Lightning','Emerging Powers',0,'en',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Fighting' AND weaknessValue = '�2'),null),
	('Pok�mon','Ratentif','60','Commune','https://assets.tcgdex.net/fr/bw/bw1/78/high.webp','Incolore','Noir & Blanc',1,'fr',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Combat' AND weaknessValue = '�2'),null),
	('Pokemon','Beheeyem','90','Rare','https://assets.tcgdex.net/en/bw/bw8/70/high.webp','Psychic','Plasma Storm',1,'en',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Psychic' AND weaknessValue = '�2'),null),
	('Pok�mon','Latios-EX','170','Rare','https://assets.tcgdex.net/fr/bw/bw9/86/high.webp','Dragon','Glaciation Plasma',2,'fr',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Dragon' AND weaknessValue = '�2'),null),
	('Pokemon','Lucario','100','Rare','https://assets.tcgdex.net/en/bw/bw8/78/high.webp','Fighting','Plasma Storm',2,'en',(SELECT abilityId FROM P10_Ability WHERE abilityName = 'Dual Armor' AND abilityEffect = 'If this Pok�mon has any Metal Energy attached to it, this Pok�mon�s type is both Fighting and Metal.'),(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Psychic' AND weaknessValue = '�2'),null),
	('Pok�mon','Incisache','80','Rare','https://assets.tcgdex.net/fr/bw/dv1/15/high.webp','Dragon','Coffre des Dragons',2,'fr',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Dragon' AND weaknessValue = '�2'),null),
	('Pokemon','Cottonee','50','Common','https://assets.tcgdex.net/en/bw/bw7/14/high.webp','Grass','Boundaries Crossed',1,'en',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Fire' AND weaknessValue = '�2'),(SELECT resistanceId FROM P10_Resistance WHERE resistanceType = 'Water' AND resistanceValue = '-20')),
	('Pok�mon','Maganon','120','Rare','https://assets.tcgdex.net/fr/bw/bw6/21/high.webp','Feu','Dragons �xalt�s',3,'fr',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Eau' AND weaknessValue = '�2'),null),
	('Pokemon','Lampent','80','Uncommon','https://assets.tcgdex.net/en/bw/bw4/19/high.webp','Fire','Next Destinies',1,'en',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Water' AND weaknessValue = '�2'),null),
	('Pok�mon','Porygon-Z','130','Commune','https://assets.tcgdex.net/fr/bw/bwp/BW84/high.webp','Incolore','Promo BW',1,'fr',(SELECT abilityId FROM P10_Ability WHERE abilityName = 'Transfert Plasma' AND abilityEffect = 'Autant de fois que vous le voulez pendant votre tour (avant votre attaque), vous pouvez d�placer une �nergie Plasma attach�e � 1 de vos Pok�mon vers un autre de vos Pok�mon.'),(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Combat' AND weaknessValue = '�2'),null),
	('Trainer','Hugh',null,'Uncommon','https://assets.tcgdex.net/en/bw/bw7/130/high.webp',null,'Boundaries Crossed',null,'en',null,null,null),
	('Pok�mon','Galegon','90','Peu Commune','https://assets.tcgdex.net/fr/bw/bw6/79/high.webp','M�tal','Dragons �xalt�s',3,'fr',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Feu' AND weaknessValue = '�2'),(SELECT resistanceId FROM P10_Resistance WHERE resistanceType = 'Psy' AND resistanceValue = '-20')),
	('Pokemon','Venipede','70','Common','https://assets.tcgdex.net/en/bw/bw7/72/high.webp','Psychic','Boundaries Crossed',2,'en',(SELECT abilityId FROM P10_Ability WHERE abilityName = 'Poison Point' AND abilityEffect = 'If this Pok�mon is your Active Pok�mon and is damaged by an opponent�s attack (even if this Pok�mon is Knocked Out), the Attacking Pok�mon is now Poisoned.'),(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Psychic' AND weaknessValue = '�2'),null),
	('Pok�mon','Kyogre-EX','170','Rare','https://assets.tcgdex.net/fr/bw/bw5/26/high.webp','Eau','Explorateurs Obscurs',4,'fr',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = '�lectrique' AND weaknessValue = '�2'),null),
	('Pokemon','Glaceon','90','Rare','https://assets.tcgdex.net/en/bw/bw9/23/high.webp','Water','Plasma Freeze',2,'en',(SELECT abilityId FROM P10_Ability WHERE abilityName = 'Freeze Zone' AND abilityEffect = 'The Retreat Cost of each of your Team Plasma Pok�mon in play is ColorlessColorless less.'),(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Metal' AND weaknessValue = '�2'),null),
	('Pok�mon','Bagga�d','90','Rare','https://assets.tcgdex.net/fr/bw/bw8/86/high.webp','Obscurit�','Temp�te Plasma',1,'fr',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Combat' AND weaknessValue = '�2'),(SELECT resistanceId FROM P10_Resistance WHERE resistanceType = 'Psy' AND resistanceValue = '-20')),
	('Pokemon','Watchog','90','Uncommon','https://assets.tcgdex.net/en/bw/bw1/79/high.webp','Colorless','Black & White',1,'en',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Fighting' AND weaknessValue = '�2'),null),
	('�nergie','�nergie Eau',null,'Commune','https://assets.tcgdex.net/fr/bw/bw1/107/high.webp',null,'Noir & Blanc',null,'fr',null,null,null),
	('Pokemon','Starly','60','Common','https://assets.tcgdex.net/en/bw/bw9/95/high.webp','Colorless','Plasma Freeze',1,'en',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Lightning' AND weaknessValue = '�2'),(SELECT resistanceId FROM P10_Resistance WHERE resistanceType = 'Fighting' AND resistanceValue = '-20')),
	('Pok�mon','Masca�man','70','Commune','https://assets.tcgdex.net/fr/bw/bw1/63/high.webp','Combat','Noir & Blanc',2,'fr',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Eau' AND weaknessValue = '�2'),(SELECT resistanceId FROM P10_Resistance WHERE resistanceType = '�lectrique' AND resistanceValue = '-20')),
	('Pokemon','Gothitelle','130','Rare','https://assets.tcgdex.net/en/bw/bw6/57/high.webp','Psychic','Dragons Exalted',2,'en',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Psychic' AND weaknessValue = '�2'),null),
	('Pok�mon','Lucario','100','Rare','https://assets.tcgdex.net/fr/bw/bw4/64/high.webp','Combat','Destin�es Futures',1,'fr',(SELECT abilityId FROM P10_Ability WHERE abilityName = 'Contre-Offensive' AND abilityEffect = 'Si ce Pok�mon est votre Pok�mon Actif et qu�il subit les d�g�ts d�une attaque de votre adversaire (m�me si ce Pok�mon est mis K.O.), placez 2 marqueurs de d�g�ts sur le Pok�mon Attaquant.'),(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Psy' AND weaknessValue = '�2'),null),
	('Pokemon','Litwick','50','Common','https://assets.tcgdex.net/en/bw/bw3/58/high.webp','Psychic','Noble Victories',1,'en',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Darkness' AND weaknessValue = '�2'),null),
	('Pok�mon','Hippodocus','130','Peu Commune','https://assets.tcgdex.net/fr/bw/bw4/66/high.webp','Combat','Destin�es Futures',4,'fr',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Eau' AND weaknessValue = '�2'),(SELECT resistanceId FROM P10_Resistance WHERE resistanceType = '�lectrique' AND resistanceValue = '-20')),
	('Pokemon','Kirlia','80','Uncommon','https://assets.tcgdex.net/en/bw/bw11/60/high.webp','Psychic','Legendary Treasures',1,'en',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Psychic' AND weaknessValue = '�2'),null),
	('Pok�mon','Ponchien','80','Peu Commune','https://assets.tcgdex.net/fr/bw/bw7/121/high.webp','Incolore','Fronti�res Franchies',1,'fr',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Combat' AND weaknessValue = '�2'),null),
	('Pokemon','Zoroark','100','Secret Rare','https://assets.tcgdex.net/en/bw/bw4/102/high.webp','Darkness','Next Destinies',1,'en',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Fighting' AND weaknessValue = '�2'),(SELECT resistanceId FROM P10_Resistance WHERE resistanceType = 'Psychic' AND resistanceValue = '-20')),
	('Pok�mon','Crypt�ro','90','Peu Commune','https://assets.tcgdex.net/fr/bw/bw2/42/high.webp','Psy','Pouvoirs �mergents',1,'fr',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = '�lectrique' AND weaknessValue = '�2'),(SELECT resistanceId FROM P10_Resistance WHERE resistanceType = 'Combat' AND resistanceValue = '-20')),
	('Pokemon','Kyurem-EX','180','Rare','https://assets.tcgdex.net/en/bw/bw4/38/high.webp','Water','Next Destinies',3,'en',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Metal' AND weaknessValue = '�2'),null),
	('Pok�mon','Dynavolt','60','Commune','https://assets.tcgdex.net/fr/bw/bw6/41/high.webp','�lectrique','Dragons �xalt�s',1,'fr',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Combat' AND weaknessValue = '�2'),null),
	('Pokemon','Beartic','120','Rare','https://assets.tcgdex.net/en/bw/bw4/37/high.webp','Water','Next Destinies',3,'en',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Metal' AND weaknessValue = '�2'),null),
	('Dresseur','Attrape-Pok�mon',null,'Peu Commune','https://assets.tcgdex.net/fr/bw/bw10/83/high.webp',null,'Explosion Plasma',null,'fr',(SELECT abilityId FROM P10_Ability WHERE abilityEffect = '�changez le Pok�mon Actif de votre adversaire avec 1 de ses Pok�mon de Banc.'),null,null),
	('Pokemon','Gothorita','80','Uncommon','https://assets.tcgdex.net/en/bw/bw7/76/high.webp','Psychic','Boundaries Crossed',1,'en',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Psychic' AND weaknessValue = '�2'),null),
	('Pok�mon','Zekrom','130','Rare','https://assets.tcgdex.net/fr/bw/bwp/BW05/high.webp','�lectrique','Promo BW',2,'fr',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Combat' AND weaknessValue = '�2'),null),
	('Energy','Darkness Energy',null,'Common','https://assets.tcgdex.net/en/bw/bw1/111/high.webp',null,'Black & White',null,'en',null,null,null),
	('Pok�mon','Griknot','50','Commune','https://assets.tcgdex.net/fr/bw/bw6/86/high.webp','Dragon','Dragons �xalt�s',1,'fr',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Dragon' AND weaknessValue = '�2'),null),
	('Pokemon','Meloetta','80','Rare','https://assets.tcgdex.net/en/bw/bw11/78/high.webp','Psychic','Legendary Treasures',1,'en',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Psychic' AND weaknessValue = '�2'),null),
	('Pok�mon','Lianaja','80','Peu Commune','https://assets.tcgdex.net/fr/bw/bw1/4/high.webp','Plante','Noir & Blanc',1,'fr',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Feu' AND weaknessValue = '�2'),(SELECT resistanceId FROM P10_Resistance WHERE resistanceType = 'Eau' AND resistanceValue = '-20')),
	('Pokemon','Lileep','80','Uncommon','https://assets.tcgdex.net/en/bw/bw10/3/high.webp','Grass','Plasma Blast',2,'en',(SELECT abilityId FROM P10_Ability WHERE abilityName = 'Prehistoric Call' AND abilityEffect = 'Once during your turn (before your attack), if this Pok�mon is in your discard pile, you may put this Pok�mon on the bottom of your deck.'),(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Fire' AND weaknessValue = '�2'),(SELECT resistanceId FROM P10_Resistance WHERE resistanceType = 'Water' AND resistanceValue = '-20')),
	('Pok�mon','Regigigas-EX','180','Rare','https://assets.tcgdex.net/fr/bw/bw4/82/high.webp','Incolore','Destin�es Futures',4,'fr',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Combat' AND weaknessValue = '�2'),null),
	('Pokemon','Klang','80','Uncommon','https://assets.tcgdex.net/en/bw/bw1/75/high.webp','Metal','Black & White',2,'en',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Fire' AND weaknessValue = '�2'),(SELECT resistanceId FROM P10_Resistance WHERE resistanceType = 'Psychic' AND resistanceValue = '-20')),
	('Pok�mon','Terrakium','130','Ultra Rare','https://assets.tcgdex.net/fr/bw/bw3/99/high.webp','Combat','Nobles Victoires',4,'fr',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Plante' AND weaknessValue = '�2'),null),
	('Pokemon','Zoroark','100','Rare','https://assets.tcgdex.net/en/bw/bw11/90/high.webp','Darkness','Legendary Treasures',2,'en',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Fighting' AND weaknessValue = '�2'),(SELECT resistanceId FROM P10_Resistance WHERE resistanceType = 'Psychic' AND resistanceValue = '-20')),
	('Pok�mon','Blizzi','70','Commune','https://assets.tcgdex.net/fr/bw/bw10/25/high.webp','Eau','Explosion Plasma',2,'fr',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'M�tal' AND weaknessValue = '�2'),null),
	('Pokemon','Simipour','90','Rare','https://assets.tcgdex.net/en/bw/bw2/23/high.webp','Water','Emerging Powers',1,'en',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Lightning' AND weaknessValue = '�2'),null),
	('Pok�mon','Keunotor','70','Commune','https://assets.tcgdex.net/fr/bw/bw6/106/high.webp','Incolore','Dragons �xalt�s',2,'fr',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Combat' AND weaknessValue = '�2'),null),
	('Pokemon','Reshiram-EX','180','Ultra Rare','https://assets.tcgdex.net/en/bw/bw4/95/high.webp','Fire','Next Destinies',3,'en',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Water' AND weaknessValue = '�2'),null),
	('Pok�mon','Boskara','100','Peu Commune','https://assets.tcgdex.net/fr/bw/bw8/2/high.webp','Plante','Temp�te Plasma',3,'fr',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Feu' AND weaknessValue = '�2'),(SELECT resistanceId FROM P10_Resistance WHERE resistanceType = 'Eau' AND resistanceValue = '-20')),
	('Pokemon','Masquerain','80','Rare','https://assets.tcgdex.net/en/bw/bw10/2/high.webp','Grass','Plasma Blast',1,'en',(SELECT abilityId FROM P10_Ability WHERE abilityName = 'Tool Reversal' AND abilityEffect = 'As often as you like during your turn (before your attack), you may put a Pok�mon Tool card attached to 1 of your Pok�mon into your hand.'),(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Fire' AND weaknessValue = '�2'),null),
	('Pok�mon','Psykokwak','70','Commune','https://assets.tcgdex.net/fr/bw/bw7/33/high.webp','Eau','Fronti�res Franchies',3,'fr',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = '�lectrique' AND weaknessValue = '�2'),null),
	('Pokemon','Wartortle','80','Uncommon','https://assets.tcgdex.net/en/bw/bw7/30/high.webp','Water','Boundaries Crossed',2,'en',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Grass' AND weaknessValue = '�2'),null),
	('Pok�mon','Miasmax','110','Rare','https://assets.tcgdex.net/fr/bw/bw8/66/high.webp','Psy','Temp�te Plasma',3,'fr',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Psy' AND weaknessValue = '�2'),null),
	('Pokemon','Primeape','90','Common','https://assets.tcgdex.net/en/bw/bw9/60/high.webp','Fighting','Plasma Freeze',1,'en',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Psychic' AND weaknessValue = '�2'),null),
	('Pok�mon','Coupenotte','50','Commune','https://assets.tcgdex.net/fr/bw/bwp/BW16/high.webp','Incolore','Promo BW',1,'fr',null,null,null),
	('Pokemon','Reshiram','130','Ultra Rare','https://assets.tcgdex.net/en/bw/bw1/113/high.webp','Fire','Black & White',2,'en',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Water' AND weaknessValue = '�2'),null),
	('Pok�mon','Kyurem Blanc EX','180','Rare','https://assets.tcgdex.net/fr/bw/bw7/103/high.webp','Dragon','Fronti�res Franchies',3,'fr',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Dragon' AND weaknessValue = '�2'),null),
	('Trainer','Great Ball',null,'Uncommon','https://assets.tcgdex.net/en/bw/bw2/93/high.webp',null,'Emerging Powers',null,'en',null,null,null),
	('Pok�mon','Carchacrok','140','Rare','https://assets.tcgdex.net/fr/bw/bw6/90/high.webp','Dragon','Dragons �xalt�s',1,'fr',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Dragon' AND weaknessValue = '�2'),null),
	('Pokemon','Makuhita','70','Common','https://assets.tcgdex.net/en/bw/bw7/82/high.webp','Fighting','Boundaries Crossed',2,'en',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Psychic' AND weaknessValue = '�2'),null),
	('Pok�mon','Heatran-EX','180','Ultra Rare','https://assets.tcgdex.net/fr/bw/bw9/109/high.webp','Feu','Glaciation Plasma',3,'fr',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Eau' AND weaknessValue = '�2'),null),
	('Pokemon','Hydreigon','150','Rare','https://assets.tcgdex.net/en/bw/bw6/97/high.webp','Dragon','Dragons Exalted',3,'en',(SELECT abilityId FROM P10_Ability WHERE abilityName = 'Dark Trance' AND abilityEffect = 'As often as you like during your turn (before your attack), you may move a Darkness Energy attached to 1 of your Pok�mon to another of your Pok�mon.'),(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Dragon' AND weaknessValue = '�2'),null);

INSERT INTO P10_Contient(cardId, attackId) VALUES
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/fr/bw/bw4/33/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Brise-Glace' AND attackCost = 'EauIncoloreIncolore' AND attackDamage = '60'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/en/bw/bw11/30/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Flailing Flop' AND attackCost = 'Colorless' AND attackDamage = '10'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/fr/bw/bw4/27/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Laser Glace' AND attackCost = 'EauIncoloreIncolore' AND attackDamage = '50'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/fr/bw/bw4/27/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Aile Glace' AND attackCost = 'EauIncoloreIncoloreIncolore' AND attackDamage = '80'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/en/bw/bw1/25/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Fire Fang' AND attackCost = 'FireColorless' AND attackDamage = '20'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/en/bw/bw1/25/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Thrash' AND attackCost = 'FireColorlessColorless' AND attackDamage = '70'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/fr/bw/bw6/123/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Cri du Ciel' AND attackCost = 'Incolore' AND attackDamage = null))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/fr/bw/bw6/123/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Fureur du Dragon' AND attackCost = 'Feu�lectrique' AND attackDamage = '60'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/en/bw/bw11/103/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Glare and Peck' AND attackCost = 'ColorlessColorless' AND attackDamage = '10'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/fr/bw/bw1/86/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Vol' AND attackCost = 'IncoloreIncolore' AND attackDamage = '50'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/fr/bw/bw1/86/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Vent Glacial' AND attackCost = 'IncoloreIncoloreIncolore' AND attackDamage = '70'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/en/bw/bw5/78/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Scratch' AND attackCost = 'ColorlessColorless' AND attackDamage = '20'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/en/bw/bw5/78/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Metal Claw' AND attackCost = 'MetalMetalColorless' AND attackDamage = '40'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/en/bw/bw1/87/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Doubleslap' AND attackCost = 'ColorlessColorless' AND attackDamage = '30'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/fr/bw/bw2/89/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Roue d''�nergie' AND attackCost = 'Incolore' AND attackDamage = null))
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
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/fr/bw/dv1/15/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Griffe' AND attackCost = 'M�talIncolore' AND attackDamage = '20'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/fr/bw/dv1/15/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Croc Aiguis�' AND attackCost = 'CombatIncoloreIncolore' AND attackDamage = '40'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/en/bw/bw7/14/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Ram' AND attackCost = 'Colorless' AND attackDamage = '10'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/fr/bw/bw3/30/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Pluie �claboussante' AND attackCost = 'IncoloreIncolore' AND attackDamage = '20'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/en/bw/bw9/27/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Jump On' AND attackCost = 'ColorlessColorless' AND attackDamage = '20'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/fr/bw/bw9/93/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Lait Max' AND attackCost = 'IncoloreIncolore' AND attackDamage = null))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/fr/bw/bw9/93/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Charge' AND attackCost = 'IncoloreIncolore' AND attackDamage = '30'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/en/bw/bw6/85/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Celestial Roar' AND attackCost = 'Colorless' AND attackDamage = null))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/en/bw/bw6/85/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Dragon Burst' AND attackCost = 'FireLightning' AND attackDamage = '60'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/fr/bw/bw2/24/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Fl�au' AND attackCost = 'Incolore' AND attackDamage = '10'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/fr/bw/bw2/24/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Tout ou Rien' AND attackCost = 'EauIncoloreIncolore' AND attackDamage = '80'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/en/bw/bw5/22/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Burning Wind' AND attackCost = 'FireColorlessColorless' AND attackDamage = '70'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/fr/bw/bw2/50/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Coup d''Boule' AND attackCost = 'Incolore' AND attackDamage = '10'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/fr/bw/bw2/50/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Attaque Imprudente' AND attackCost = 'CombatIncolore' AND attackDamage = '30'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/en/bw/bw9/45/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Lure Poison' AND attackCost = 'Psychic' AND attackDamage = null))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/en/bw/bw9/45/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Sludge Toss' AND attackCost = 'PsychicColorlessColorless' AND attackDamage = '30'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/fr/bw/bw10/19/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Tir de Pr�cision' AND attackCost = 'Eau' AND attackDamage = null))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/fr/bw/bw10/19/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Bulles d''O' AND attackCost = 'EauEau' AND attackDamage = '40'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/en/bw/bw5/18/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Flame Cloak' AND attackCost = 'Colorless' AND attackDamage = '10'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/en/bw/bw5/18/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Heat Blast' AND attackCost = 'FireColorlessColorless' AND attackDamage = '60'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/fr/bw/bw4/52/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Glu F�tide' AND attackCost = 'PsyIncolore' AND attackDamage = '20'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/en/bw/bw10/47/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Low Kick' AND attackCost = 'FightingColorless' AND attackDamage = '30'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/fr/bw/bw9/66/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Gr�le' AND attackCost = 'Incolore' AND attackDamage = null))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/fr/bw/bw9/66/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Calomnie' AND attackCost = 'Obscurit�Incolore' AND attackDamage = '30'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/en/bw/bw10/60/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Hypnostrike' AND attackCost = 'MetalColorlessColorless' AND attackDamage = '60'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/fr/bw/bw3/35/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'H�te' AND attackCost = '�lectrique' AND attackDamage = '10'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/en/bw/bw2/32/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Thundershock' AND attackCost = 'Lightning' AND attackDamage = '10'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/en/bw/bw2/32/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Acrobatics' AND attackCost = 'ColorlessColorless' AND attackDamage = '10'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/fr/bw/bw1/78/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Croc de Mort' AND attackCost = 'Incolore' AND attackDamage = '30'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/en/bw/bw8/70/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Lock Up' AND attackCost = 'Psychic' AND attackDamage = '20'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/en/bw/bw8/70/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Damakinesis' AND attackCost = 'PsychicColorlessColorless' AND attackDamage = null))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/fr/bw/bw9/86/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Vol Supersonique' AND attackCost = 'PsyIncolore' AND attackDamage = '40'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/fr/bw/bw9/86/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Lumi-�clat' AND attackCost = 'EauPsyIncolore' AND attackDamage = '150'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/en/bw/bw8/78/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Hurricane Kick' AND attackCost = 'FightingColorlessColorless' AND attackDamage = '60'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/fr/bw/dv1/15/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Griffe' AND attackCost = 'M�talIncolore' AND attackDamage = '20'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/fr/bw/dv1/15/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Croc Aiguis�' AND attackCost = 'CombatIncoloreIncolore' AND attackDamage = '40'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/en/bw/bw7/14/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Ram' AND attackCost = 'Colorless' AND attackDamage = '10'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/fr/bw/bw6/21/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Barri�re de Flammes' AND attackCost = 'Feu' AND attackDamage = '40'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/fr/bw/bw6/21/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Lance-Flamme' AND attackCost = 'FeuIncoloreIncolore' AND attackDamage = '90'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/en/bw/bw4/19/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Ember' AND attackCost = 'FireColorless' AND attackDamage = '40'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/fr/bw/bwp/BW84/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Triplattaque' AND attackCost = 'IncoloreIncoloreIncolore' AND attackDamage = '50'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/fr/bw/bw6/79/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Griffe Acier' AND attackCost = 'M�talIncolore' AND attackDamage = '30'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/fr/bw/bw6/79/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Ravages' AND attackCost = 'M�talM�talIncolore' AND attackDamage = '60'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/en/bw/bw7/72/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Bug Bite' AND attackCost = 'PsychicColorless' AND attackDamage = '20'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/en/bw/bw9/23/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Icy Wind' AND attackCost = 'WaterColorlessColorless' AND attackDamage = '60'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/fr/bw/bw8/86/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Coud''Pied �jecteur' AND attackCost = 'Obscurit�Incolore' AND attackDamage = '30'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/fr/bw/bw8/86/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Coup d�Boule Renforc�' AND attackCost = 'Obscurit�Obscurit�Incolore' AND attackDamage = '50'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/en/bw/bw1/79/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Confuse Ray' AND attackCost = 'ColorlessColorless' AND attackDamage = null))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/en/bw/bw1/79/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Hyper Fang' AND attackCost = 'ColorlessColorless' AND attackDamage = '60'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/en/bw/bw9/95/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Tackle' AND attackCost = 'Colorless' AND attackDamage = '10'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/fr/bw/bw1/63/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Tombe de Sable' AND attackCost = 'Combat' AND attackDamage = '10'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/fr/bw/bw1/63/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Morsure' AND attackCost = 'CombatIncoloreIncolore' AND attackDamage = '30'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/en/bw/bw6/57/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Doom Decree' AND attackCost = 'PsychicColorless' AND attackDamage = null))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/en/bw/bw6/57/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Black Magic' AND attackCost = 'PsychicColorlessColorless' AND attackDamage = '40'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/fr/bw/bw4/64/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Aurasph�re' AND attackCost = 'CombatCombat' AND attackDamage = '50'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/en/bw/bw3/58/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Teleportation Burst' AND attackCost = 'Psychic' AND attackDamage = '10'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/fr/bw/bw4/66/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Canon � Sable' AND attackCost = 'CombatIncoloreIncolore' AND attackDamage = '70'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/fr/bw/bw4/66/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Roule-Pierre' AND attackCost = 'CombatCombatIncoloreIncolore' AND attackDamage = '90'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/en/bw/bw11/60/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Mind Bend' AND attackCost = 'PsychicColorless' AND attackDamage = '20'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/en/bw/bw11/60/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Spinning Attack' AND attackCost = 'PsychicColorlessColorless' AND attackDamage = '40'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/fr/bw/bw7/121/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Morsure' AND attackCost = 'Incolore' AND attackDamage = '20'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/fr/bw/bw7/121/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'B�lier' AND attackCost = 'IncoloreIncoloreIncolore' AND attackDamage = '60'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/en/bw/bw4/102/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Nasty Plot' AND attackCost = 'Darkness' AND attackDamage = null))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/en/bw/bw4/102/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Foul Play' AND attackCost = 'ColorlessColorless' AND attackDamage = null))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/fr/bw/bw2/42/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Vif Retournement' AND attackCost = 'Psy' AND attackDamage = '10'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/fr/bw/bw2/42/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Assaut Psychique' AND attackCost = 'IncoloreIncoloreIncolore' AND attackDamage = '40'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/en/bw/bw4/38/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Frozen Wings' AND attackCost = 'WaterColorlessColorless' AND attackDamage = '60'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/en/bw/bw4/38/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Hail Blizzard' AND attackCost = 'WaterWaterColorlessColorless' AND attackDamage = '120'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/fr/bw/bw6/41/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Charge' AND attackCost = '�lectrique' AND attackDamage = '10'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/fr/bw/bw6/41/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Vive-Attaque' AND attackCost = '�lectriqueIncolore' AND attackDamage = '10'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/en/bw/bw4/37/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Daunt' AND attackCost = 'ColorlessColorless' AND attackDamage = '40'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/en/bw/bw4/37/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Ambush' AND attackCost = 'WaterColorlessColorless' AND attackDamage = '60'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/en/bw/bw7/76/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Psypunch' AND attackCost = 'ColorlessColorless' AND attackDamage = '30'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/en/bw/bw7/76/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Destructive Beam' AND attackCost = 'PsychicColorlessColorless' AND attackDamage = '50'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/fr/bw/bwp/BW05/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Col�re' AND attackCost = 'IncoloreIncolore' AND attackDamage = '20'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/fr/bw/bwp/BW05/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'ChargeFoudre' AND attackCost = '�lectrique�lectriqueIncolore' AND attackDamage = '120'))
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
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/fr/bw/bw3/99/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = '�cras''Terre' AND attackCost = 'CombatCombatIncolore' AND attackDamage = '90'))
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
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/fr/bw/bw7/103/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Feu Glac�' AND attackCost = 'FeuFeuEauIncolore' AND attackDamage = '150'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/fr/bw/bw6/90/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Coupe Vive' AND attackCost = 'Combat' AND attackDamage = '60'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/fr/bw/bw6/90/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Draco-Lame' AND attackCost = 'EauCombat' AND attackDamage = '100'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/en/bw/bw7/82/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Slap Push' AND attackCost = 'FightingFighting' AND attackDamage = '30'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/fr/bw/bw9/109/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Coup de Chaud' AND attackCost = 'FeuIncoloreIncolore' AND attackDamage = '60'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/fr/bw/bw9/109/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Pression Explosive' AND attackCost = 'FeuFeuIncoloreIncolore' AND attackDamage = '80'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/en/bw/bw6/97/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Dragonblast' AND attackCost = 'PsychicDarknessDarknessColorless' AND attackDamage = '140'))