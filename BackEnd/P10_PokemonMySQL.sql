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
	('Transe Obscure','Autant de fois que vous le voulez pendant votre tour (avant votre attaque), vous pouvez déplacer une Énergie Darkness attachée à 1 de vos Pokémon vers un autre de vos Pokémon.'),
	('Dark Cloak','Each of your Pokémon that has any Darkness Energy attached to it has no Retreat Cost.'),
	('Heal Block','Damage can’t be healed from any Pokémon (both yours and your opponent’s). (Damage counters can still be moved.)'),
	('Poison Point','If this Pokémon is your Active Pokémon and is damaged by an opponent’s attack (even if this Pokémon is Knocked Out), the Attacking Pokémon is now Poisoned.'),
	('Stickiness','The Retreat Cost of each of your opponent’s Pokémon in play is Colorless more.'),
	('Red Signal','When you attach a Plasma Energy from your hand to this Pokémon, you may switch 1 of your opponent’s Benched Pokémon with his or her Active Pokémon.'),
	('Tango Infernal','Autant de fois que vous le voulez pendant votre tour (avant votre attaque), vous pouvez attacher une carte Énergie Fire de votre main à 1 de vos Pokémon.'),
	('Plonge et Pioche','Une seule fois pendant votre tour (avant votre attaque), vous pouvez défausser une carte de votre main. Dans ce cas, piochez 2 cartes.'),
	('Recherche Plasma','Une seule fois pendant votre tour (avant votre attaque), vous pouvez chercher une carte de la Team Plasma dans votre deck, la montrer et l''ajouter à votre main. Mélangez ensuite votre deck. Vous ne pouvez pas utiliser une capacité spéciale du même nom pendant votre tour.'),
	('Rappel Temporel','Chacun de vos Pokémon évolués peut utiliser les attaques de ses pré-évolutions. (Vous avez toujours besoin de l’Énergie nécessaire pour utiliser chaque attaque.)'),
	('Dynamoteur','Une seule fois pendant votre tour (avant votre attaque), vous pouvez attacher une carte Énergie Lightning de votre pile de défausse à 1 de vos Pokémon de Banc.');

INSERT INTO P10_Attack(attackName,attackCost,attackDamage,attackEffect) VALUES 
	('Dracoxplosion','PsyObscuritéObscuritéIncolore','140','Défaussez 2 Énergies Darkness attachées à ce Pokémon.'),
	('Night Spear','DarknessDarknessColorless','90','Does 30 damage to 1 of your opponent''s Benched Pokémon. (Don''t apply Weakness and Resistance for Benched Pokémon.)'),
	('Dragon Pulse','Lightning','40','Discard the top 2 cards of your deck.'),
	('Vendetta','Incolore','20','Si l''un de vos Pokémon a été mis K.O. par les dégâts d''une attaque de votre adversaire pendant son dernier tour, cette attaque inflige 70 dégâts supplémentaires.'),
	('Psybeam','PsychicColorless','30','The Defending Pokémon is now Confused.'),
	('Oracle Inflict','MetalColorlessColorless','30','Does 10 more damage for each card in your opponent''s hand.'),
	('Anneau de Poison','Combat','20','Le Pokémon Défenseur est maintenant Empoisonné. Le Pokémon Défenseur ne peut pas battre en retraite pendant le prochain tour de votre adversaire.'),
	('Destructive Beam','ColorlessColorless','30','Flip a coin. If heads, discard an Energy attached to the Defending Pokémon.'),
	('Tornade','IncoloreIncolore','20',null),
	('Spinning Attack','PsychicColorlessColorless','50',null),
	('Enveloppe Douce','PsyIncolore','30','Le Pokémon Défenseur ne peut pas battre en retraite pendant le prochain tour de votre adversaire.'),
	('Eerie Light','WaterColorlessColorless','40','Flip a coin. If heads, the Defending Pokémon is now Confused.'),
	('Piège Osseux','Combat','30','Le Pokémon Défenseur ne peut pas battre en retraite pendant le prochain tour de votre adversaire.'),
	('Roar','Colorless',null,'Your opponent switches the Defending Pokémon with 1 of his or her Benched Pokémon.'),
	('Defensive Stance','Colorless',null,'Heal 30 damage from this Pokémon. Switch this Pokémon with 1 of your Benched Pokémon.'),
	('Croc de Mort','Incolore','30','Lancez une pièce. Si c''est pile, cette attaque ne fait rien.'),
	('Rock Tumble','FightingColorless','50','This attack''s damage isn''t affected by Resistance.'),
	('Coupe Vive','Combat','60','Défaussez une Énergie spéciale attachée au Pokémon Défenseur.'),
	('Ambush','ColorlessColorless','20','Flip a coin. If heads, this attack does 40 more damage.'),
	('Griffe','IncoloreIncolore','20',null),
	('Singe','Fire',null,'The Defending Pokémon is now Burned.'),
	('Flammèche','FeuIncolore','30','Défaussez une Énergie attachée à ce Pokémon.'),
	('Flamboiement','Feu','10',null),
	('Megalo Cannon','GrassGrassColorless','100','Does 20 damage to 1 of your opponent''s Benched Pokémon. (Don''t apply Weakness and Resistance for Benched Pokémon.)'),
	('Rallonge','Eau',null,'Lancez 2 pièces. Pour chaque côté face, piochez une carte.'),
	('Surprise Attack','Water','20','Flip a coin. If tails, this attack does nothing.'),
	('Danse Éblouissante','Plante','10','Le Pokémon Défenseur est maintenant Confus.'),
	('Mega Drain','Grass','20','Heal 20 damage from this Pokémon.'),
	('Fast Swipe','Colorless',null,'Discard a random card from your opponent''s hand.'),
	('Grosse Vague','EauIncoloreIncolore','40',null),
	('Rain Splash','Water','20',null),
	('Poudreuse','Eau','10','Lancez une pièce. Si c''est face, le Pokémon Défenseur est maintenant Endormi.'),
	('Vibration','ColorlessColorless','20',null),
	('Double Fouet','Incolore','10','Lancez 2 pièces. Cette attaque inflige 10 dégâts multipliés par le nombre de côtés face.'),
	('Helping Hand','Colorless',null,'Search your deck for a basic Energy card and attach it to 1 of your Benched Pokémon. Shuffle your deck afterward.'),
	('Tacle Feu','FeuFeuIncoloreIncolore','80',null),
	('Ordre d''Assaut','Eau','10','Inflige 10 dégâts multipliés par le nombre de Pokémon en jeu (les vôtres et ceux de votre adversaire).'),
	('Dragon Fang','LightningColorlessColorless','60','Flip a coin. If heads, the Defending Pokémon is now Paralyzed.'),
	('Choc Venin','Psy','10','Si le Pokémon Défenseur est Empoisonné, cette attaque inflige 60 dégâts supplémentaires.'),
	('Static Shock','LightningColorless','20',null),
	('Armure','Incolore',null,'Pendant le prochain tour de votre adversaire, si ce Pokémon doit subir les dégâts d''une attaque, évitez les dégâts infligés à ce Pokémon si ces dégâts sont de 40 ou moins.'),
	('Metal Sound','Colorless',null,'The Defending Pokémon is now Confused.'),
	('Attraction','Incolore',null,'Si le Pokémon Défenseur essaie d’attaquer pendant le prochain tour de votre adversaire, ce dernier lance une pièce. Si c’est pile, son attaque ne fait rien.'),
	('Deleting Glare','Psychic',null,'Flip a coin. If heads, discard an Energy attached to 1 of your opponent''s Pokémon.'),
	('Contrôleur d''Esprit','PsyIncoloreIncoloreIncolore','60','Le Pokémon Défenseur est maintenant Confus.'),
	('Dark Clamp','DarknessColorlessColorless','60','The Defending Pokémon can''t retreat during your opponent''s next turn.'),
	('Tit''Sieste','Incolore',null,'Soignez 20 dégâts à ce Pokémon.'),
	('Triple Stab','Grass','10','Flip 3 coins. This attack does 10 damage times the number of heads.'),
	('Rafale Tranchante','PlanteIncoloreIncolore','60','Échangez ce Pokémon avec 1 de vos Pokémon de Banc.'),
	('Slash','Colorless','30',null),
	('Retour','Incolore','20','Piochez des cartes jusqu''à ce que vous ayez 6 cartes en main.'),
	('Bubble','Water',null,'Flip a coin. If heads, the Defending Pokémon is now Paralyzed.'),
	('Lignes Magnétiques','IncoloreIncolore','30','Vous pouvez déplacer une Énergie attachée au Pokémon Défenseur vers 1 des Pokémon de Banc de votre adversaire.'),
	('Cut Down','ColorlessColorless','30','Flip a coin. If heads, discard an Energy attached to the Defending Pokémon.'),
	('Croc de Dragon','ÉlectriqueIncoloreIncolore','60','Lancez une pièce. Si c''est face, le Pokémon Défenseur est maintenant Paralysé.'),
	('Collecte','Plante',null,'Piochez 3 cartes.'),
	('Scratch','Colorless','10',null),
	('Double Baffe','Incolore','10','Lancez 2 pièces. Cette attaque inflige 10 dégâts multipliés par le nombre de côtés face.'),
	('Hone Claws','Colorless',null,'During your next turn, each of this Pokémon''s attacks does 30 more damage (before applying Weakness and Resistance).'),
	('Poison Sting','Psychic',null,'Flip a coin. If heads, the Defending Pokémon is now Poisoned.'),
	('Dard-Missile','Plante','30','Mélangez ce Pokémon et toutes les cartes qui lui sont attachées avec votre deck.'),
	('White Noise','Colorless','20','The Defending Pokémon is now Asleep.'),
	('Crunch','ColorlessColorless','30','Flip a coin. If heads, discard an Energy attached to the Defending Pokémon.'),
	('Morsure','Incolore','20',null),
	('Will-O-Wisp','Colorless','10',null),
	('Collect','ColorlessColorless',null,'Draw 3 cards.'),
	('Spinning Turn','Fighting','40','Switch this Pokémon with 1 of your Benched Pokémon.'),
	('Appel Foudroyant','Électrique','30','Attachez une carte Énergie de votre pile de défausse à 1 de vos Pokémon de la Team Plasma sur votre Banc.'),
	('Supersonic','Colorless',null,'The Defending Pokémon is now Confused.'),
	('Écume','Eau',null,'Lancez une pièce. Si c''est face, le Pokémon Défenseur est maintenant Paralysé.'),
	('Hard Press','ColorlessColorless','30','Flip a coin. If heads, the Defending Pokémon is now Paralyzed.'),
	('Ultrason','Incolore',null,'Le Pokémon Défenseur est maintenant Confus.'),
	('Choc Mental','PsyIncolore','20','Lancez une pièce. Si c''est face, le Pokémon Défenseur est maintenant Paralysé.'),
	('Firefighting','Water',null,'Discard a Fire Energy attached to the Defending Pokémon.'),
	('Vif Retournement','Électrique','20','Lancez 2 pièces. Cette attaque inflige 20 dégâts multipliés par le nombre de côtés face.'),
	('Reflect','Psychic',null,'During your opponent''s next turn, any damage done to this Pokémon by attacks is reduced by 40 (after applying Weakness and Resistance).'),
	('Boule de Foudre','ÉlectriqueÉlectriqueIncolore','50',null),
	('Icy Snow','WaterColorless','30',null),
	('Hydrocanon','IncoloreIncoloreIncolore','70','Inflige 10 dégâts supplémentaires pour chaque Énergie Water attachée à ce Pokémon.'),
	('Outrage','ColorlessColorless','20','Does 10 more damage for each damage counter on this Pokémon.'),
	('Barrière de Flammes','Feu','40','Pendant le prochain tour de votre adversaire, tous les dégâts infligés à ce Pokémon par des attaques sont réduits de 20 (après application de la Faiblesse et de la Résistance).'),
	('Ember','FireColorless','40','Flip a coin. If tails, discard an Energy attached to this Pokémon.');

INSERT INTO P10_Attack(attackName,attackCost,attackDamage,attackEffect) VALUES 
	('Shred','FireLightningColorless','90','This attack''s damage isn''t affected by any effects on the Defending Pokémon.'),
	('Direct Toxik','PsyIncoloreIncolore','60','Le Pokémon Défenseur est maintenant Empoisonné.'),
	('Extrasensory','PsychicColorlessColorless','60','If you have the same number of cards in your hand as your opponent, this attack does 60 more damage.'),
	('Tranche-Nuit','CombatIncolore','40','Échangez ce Pokémon avec 1 de vos Pokémon de Banc.'),
	('Détricanon','PsyPsyIncolore','60','Le Pokémon Défenseur est maintenant Empoisonné.'),
	('Coupe-Tourbillon','CombatIncoloreIncolore','60','Si le Pokémon Défenseur a une Résistance, cette attaque inflige 30 dégâts supplémentaires.'),
	('Ambush','DarknessColorless','20','Flip a coin. If heads, this attack does 10 more damage.'),
	('Karate Chop','FightingColorlessColorless','70','Does 70 damage minus 10 damage for each damage counter on this Pokémon.'),
	('Pump-up Smash','FightingFightingColorless','90','Attach 2 basic Energy cards from your hand to your Benched Pokémon in any way you like.'),
	('Draco-Lame','EauCombat','100','Défaussez les 2 cartes du dessus de votre deck.'),
	('Double Feu','FeuFeuIncolore','40','Lancez 2 pièces. Cette attaque inflige 40 dégâts multipliés par le nombre de côtés face.'),
	('Flammèche','FeuIncolore','30','Défaussez une Énergie attachée à ce Pokémon.'),
	('Embuscade','PlanteIncolore','20','Lancez une pièce. Si c''est face, cette attaque inflige 30 dégâts supplémentaires.'),
	('Pin Missile','GrassGrassColorless','20','Flip 4 coins. This attack does 20 damage times the number of heads.'),
	('Biting Fang','ColorlessColorless','30','Flip a coin. If heads, this attack does 20 more damage.'),
	('Waterfall','WaterWaterColorless','50',null),
	('Repos','IncoloreIncolore',null,'Soignez 60 dégâts à ce Pokémon. Ce Pokémon est maintenant Endormi.'),
	('Suspicious Soundwave','WaterColorlessColorless','30','Flip a coin. If heads, the Defending Pokémon is now Confused.'),
	('Parfum Relaxant','Plante',null,'Soignez 30 dégâts et retirez tous les États Spéciaux de ce Pokémon.'),
	('Cotton Guard','Grass','30','During your opponent''s next turn, any damage done to this Pokémon by attacks is reduced by 30 (after applying Weakness and Resistance).'),
	('Freeze Shock','WaterLightningLightningColorless','150','This Pokémon can''t attack during your next turn.'),
	('Bulldoboule','IncoloreIncoloreIncolore','40','Les dégâts de cette attaque ne sont pas affectés par la Résistance.'),
	('Coup d''Boule','CombatIncoloreIncolore','40',null),
	('Electro Ball','LightningColorless','30',null),
	('Crèvecœur','PsyIncolore','40',null),
	('Super Psy Bolt','PsychicColorlessColorless','50',null),
	('Bombast','DarknessDarknessColorlessColorless','40','Does 40 damage times the number of Prize cards you have taken.'),
	('Tranch''Herbe','PlanteIncoloreIncolore','30',null),
	('Triple Cutter','GrassGrassColorless','60','Flip 3 coins. This attack does 60 damage times the number of heads.'),
	('Feuillemagik','PlanteIncoloreIncolore','50','Lancez une pièce. Si c''est face, cette attaque inflige 30 dégâts supplémentaires et vous soignez 30 dégâts à ce Pokémon.'),
	('Double Spin','WaterColorlessColorless','30','Flip 2 coins. This attack does 30 damage times the number of heads.'),
	('Pif Paf','MétalIncoloreIncolore','60','Si le Pokémon Défenseur a déjà des marqueurs de dégâts, cette attaque inflige 30 dégâts supplémentaires.'),
	('Slicing Blade','DarknessColorlessColorless','70',null),
	('Éclair Gelé','EauÉlectriqueÉlectriqueIncolore','150','Ce Pokémon ne peut pas attaquer pendant votre prochain tour.'),
	('Vampire de Stade','PlanteIncolore','30','S''il y a une carte Stade en jeu, cette attaque inflige 30 dégâts supplémentaires et vous soignez 30 dégâts à ce Pokémon.'),
	('Vine Whip','GrassColorlessColorless','30',null),
	('Scratch','Fighting','10',null),
	('Tackle','ColorlessColorless','20',null),
	('Draining Cut','GrassColorless','40','Flip 2 coins. This attack does 40 damage times the number of heads. Heal from this Pokémon the same amount of damage you did to the Defending Pokémon.'),
	('Souplesse','IncoloreIncolore','20','Lancez 2 pièces. Cette attaque inflige 20 dégâts multipliés par le nombre de côtés face.'),
	('Dragon Claw','PsychicDarknessDarkness','80',null),
	('Mâchouille','CombatIncoloreIncolore','40','Lancez une pièce. Si c''est face, défaussez une Énergie attachée au Pokémon Défenseur.'),
	('Ram','PsychicColorlessColorless','30',null),
	('Bite','ColorlessColorlessColorless','50',null),
	('Wreck','FightingFightingColorlessColorless','80','If there is any Stadium card in play, this attack does 60 more damage. Discard that Stadium card.'),
	('Grondement Tonitruant','ÉlectriqueÉlectriqueIncoloreIncolore','90','Si de l''Énergie Plasma est attachée à ce Pokémon, défaussez une Énergie attachée au Pokémon Défenseur.'),
	('Hyper Voice','WaterColorlessColorless','50',null),
	('Double Tour','EauIncoloreIncolore','30','Lancez 2 pièces. Cette attaque inflige 30 dégâts multipliés par le nombre de côtés face.'),
	('Hammer In','GrassColorlessColorless','70',null),
	('Mégaphone','IncoloreIncoloreIncolore','50',null),
	('Morsure','IncoloreIncolore','30',null),
	('Telekinesis','PsychicColorlessColorless',null,'Does 50 damage to 1 of your opponent''s Pokémon. This attack''s damage isn''t affected by Weakness or Resistance.'),
	('Bolt Strike','LightningLightningColorless','120','This Pokémon does 40 damage to itself.'),
	('Lance-Flamme','FeuIncoloreIncolore','90','Défaussez une Énergie attachée à ce Pokémon.');

INSERT INTO P10_Resistance(resistanceType,resistanceValue) VALUES 
	('Psychic','-20'),
	('Électrique','-20'),
	('Combat','-20'),
	('Psy','-20'),
	('Eau','-20'),
	('Water','-20'),
	('Lightning','-20'),
	('Fighting','-20');

INSERT INTO P10_Weakness(weaknessType,weaknessValue) VALUES 
	('Dragon','×2'),
	('Fighting','×2'),
	('Eau','×2'),
	('Psy','×2'),
	('Psychic','×2'),
	('Combat','×2'),
	('Fire','×2'),
	('Électrique','×2'),
	('Lightning','×2'),
	('Feu','×2'),
	('Grass','×2'),
	('Water','×2'),
	('Métal','×2'),
	('Plante','×2'),
	('Darkness','×2'),
	('Metal','×2');

INSERT INTO P10_Card(cardCategory,cardName,cardHP,cardRarity,cardImg,cardType,cardExtensioncardRetreat,cardLang,abilityId,resistanceId,weaknessId) VALUES
	('Pokémon','Trioxhydre','150','Rare','https://assets.tcgdex.net/fr/bw/bw6/97/high.webp','Dragon','Dragons Éxaltés',3,'fr',(SELECT abilityId FROM P10_Ability WHERE abilityName = 'Transe Obscure' AND abilityEffect = 'Autant de fois que vous le voulez pendant votre tour (avant votre attaque), vous pouvez déplacer une Énergie Darkness attachée à 1 de vos Pokémon vers un autre de vos Pokémon.'),(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Dragon' AND weaknessValue = '×2'),null),
	('Pokemon','Darkrai-EX','180','Rare','https://assets.tcgdex.net/en/bw/bw11/88/high.webp','Darkness','Legendary Treasures',2,'en',(SELECT abilityId FROM P10_Ability WHERE abilityName = 'Dark Cloak' AND abilityEffect = 'Each of your Pokémon that has any Darkness Energy attached to it has no Retreat Cost.'),(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Fighting' AND weaknessValue = '×2'),(SELECT resistanceId FROM P10_Resistance WHERE resistanceType = 'Psychic' AND resistanceValue = '-20')),
	('Pokémon','Pyroli','90','Peu Commune','https://assets.tcgdex.net/fr/bw/bw5/12/high.webp','Feu','Explorateurs Obscurs',1,'fr',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Eau' AND weaknessValue = '×2'),null),
	('Pokemon','Rayquaza','120','Rare','/high.webp','Dragon','Dragon Vault',3,'en',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Dragon' AND weaknessValue = '×2'),null),
	('Pokémon','Coatox','90','Rare','https://assets.tcgdex.net/fr/bw/bw7/66/high.webp','Psy','Frontières Franchies',1,'fr',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Psy' AND weaknessValue = '×2'),null),
	('Pokemon','Grumpig','110','Rare','https://assets.tcgdex.net/en/bw/bw7/60/high.webp','Psychic','Boundaries Crossed',2,'en',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Psychic' AND weaknessValue = '×2'),null),
	('Pokémon','Évoli','50','Commune','https://assets.tcgdex.net/fr/bw/bw5/84/high.webp','Incolore','Explorateurs Obscurs',1,'fr',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Combat' AND weaknessValue = '×2'),null),
	('Pokemon','Bronzong','110','Rare','https://assets.tcgdex.net/en/bw/bw4/76/high.webp','Metal','Next Destinies',4,'en',(SELECT abilityId FROM P10_Ability WHERE abilityName = 'Heal Block' AND abilityEffect = 'Damage can’t be healed from any Pokémon (both yours and your opponent’s). (Damage counters can still be moved.)'),(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Fire' AND weaknessValue = '×2'),(SELECT resistanceId FROM P10_Resistance WHERE resistanceType = 'Psychic' AND resistanceValue = '-20')),
	('Pokémon','Scorvol','100','Rare','https://assets.tcgdex.net/fr/bw/bw7/81/high.webp','Combat','Frontières Franchies',1,'fr',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Eau' AND weaknessValue = '×2'),(SELECT resistanceId FROM P10_Resistance WHERE resistanceType = 'Électrique' AND resistanceValue = '-20')),
	('Pokemon','Porygon2','80','Uncommon','https://assets.tcgdex.net/en/bw/bw10/73/high.webp','Colorless','Plasma Blast',1,'en',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Fighting' AND weaknessValue = '×2'),null),
	('Pokémon','Poichigeon','50','Commune','https://assets.tcgdex.net/fr/bw/bw2/80/high.webp','Incolore','Pouvoirs Émergents',1,'fr',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Électrique' AND weaknessValue = '×2'),(SELECT resistanceId FROM P10_Resistance WHERE resistanceType = 'Combat' AND resistanceValue = '-20')),
	('Pokemon','Whirlipede','100','Uncommon','https://assets.tcgdex.net/en/bw/bw7/73/high.webp','Psychic','Boundaries Crossed',3,'en',(SELECT abilityId FROM P10_Ability WHERE abilityName = 'Poison Point' AND abilityEffect = 'If this Pokémon is your Active Pokémon and is damaged by an opponent’s attack (even if this Pokémon is Knocked Out), the Attacking Pokémon is now Poisoned.'),(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Psychic' AND weaknessValue = '×2'),null),
	('Pokémon','Miasmax','100','Peu Commune','https://assets.tcgdex.net/fr/bw/bw3/49/high.webp','Psy','Nobles Victoires',3,'fr',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Psy' AND weaknessValue = '×2'),null),
	('Pokemon','Jellicent','100','Rare','https://assets.tcgdex.net/en/bw/bw7/45/high.webp','Water','Boundaries Crossed',3,'en',(SELECT abilityId FROM P10_Ability WHERE abilityName = 'Stickiness' AND abilityEffect = 'The Retreat Cost of each of your opponent’s Pokémon in play is Colorless more.'),(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Lightning' AND weaknessValue = '×2'),null),
	('Pokémon','Ossatueur','100','Rare','https://assets.tcgdex.net/fr/bw/bw6/61/high.webp','Combat','Dragons Éxaltés',1,'fr',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Eau' AND weaknessValue = '×2'),(SELECT resistanceId FROM P10_Resistance WHERE resistanceType = 'Électrique' AND resistanceValue = '-20')),
	('Pokemon','Houndour','60','Common','https://assets.tcgdex.net/en/bw/bw10/55/high.webp','Darkness','Plasma Blast',1,'en',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Fighting' AND weaknessValue = '×2'),(SELECT resistanceId FROM P10_Resistance WHERE resistanceType = 'Psychic' AND resistanceValue = '-20')),
	('Pokémon','Clic','80','Peu Commune','https://assets.tcgdex.net/fr/bw/bw5/76/high.webp','Métal','Explorateurs Obscurs',3,'fr',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Feu' AND weaknessValue = '×2'),(SELECT resistanceId FROM P10_Resistance WHERE resistanceType = 'Psy' AND resistanceValue = '-20')),
	('Pokemon','Sawk','90','Uncommon','https://assets.tcgdex.net/en/bw/bw6/69/high.webp','Fighting','Dragons Exalted',1,'en',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Psychic' AND weaknessValue = '×2'),null),
	('Pokémon','Ratentif','60','Commune','https://assets.tcgdex.net/fr/bw/bw2/78/high.webp','Incolore','Pouvoirs Émergents',1,'fr',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Combat' AND weaknessValue = '×2'),null),
	('Pokemon','Terrakion-EX','180','Rare','https://assets.tcgdex.net/en/bw/bw6/71/high.webp','Fighting','Dragons Exalted',3,'en',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Grass' AND weaknessValue = '×2'),null),
	('Pokémon','Carchacrok','140','Magnifique rare','https://assets.tcgdex.net/fr/bw/bw9/120/high.webp','Dragon','Glaciation Plasma',1,'fr',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Dragon' AND weaknessValue = '×2'),null),
	('Pokemon','Vigoroth','80','Uncommon','https://assets.tcgdex.net/en/bw/bw6/102/high.webp','Colorless','Dragons Exalted',1,'en',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Fighting' AND weaknessValue = '×2'),null),
	('Pokémon','Flamajou','70','Commune','https://assets.tcgdex.net/fr/bw/bw8/19/high.webp','Feu','Tempète Plasma',1,'fr',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Eau' AND weaknessValue = '×2'),null),
	('Pokemon','Vulpix','60','Common','https://assets.tcgdex.net/en/bw/bw6/18/high.webp','Fire','Dragons Exalted',1,'en',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Water' AND weaknessValue = '×2'),null),
	('Pokémon','Gruikui','70','Commune','https://assets.tcgdex.net/fr/bw/bwp/BW02/high.webp','Feu','Promo BW',2,'fr',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Eau' AND weaknessValue = '×2'),null),
	('Trainer','Cedric Juniper',null,'Uncommon','https://assets.tcgdex.net/en/bw/bw11/110/high.webp',null,'Legendary Treasures',null,'en',null,null,null),
	('Pokémon','Pyronille','70','Commune','https://assets.tcgdex.net/fr/bw/bw10/12/high.webp','Feu','Explosion Plasma',3,'fr',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Eau' AND weaknessValue = '×2'),null),
	('Pokemon','Genesect-EX','170','Rare','https://assets.tcgdex.net/en/bw/bw10/11/high.webp','Grass','Plasma Blast',1,'en',(SELECT abilityId FROM P10_Ability WHERE abilityName = 'Red Signal' AND abilityEffect = 'When you attach a Plasma Energy from your hand to this Pokémon, you may switch 1 of your opponent’s Benched Pokémon with his or her Active Pokémon.'),(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Fire' AND weaknessValue = '×2'),null),
	('Pokémon','Barpau','30','Commune','https://assets.tcgdex.net/fr/bw/bw6/27/high.webp','Eau','Dragons Éxaltés',1,'fr',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Électrique' AND weaknessValue = '×2'),null),
	('Pokemon','Tympole','60','Common','https://assets.tcgdex.net/en/bw/bw9/24/high.webp','Water','Plasma Freeze',1,'en',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Grass' AND weaknessValue = '×2'),null),
	('Pokémon','Maracachi','90','Peu Commune','https://assets.tcgdex.net/fr/bw/bw8/11/high.webp','Plante','Tempète Plasma',1,'fr',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Feu' AND weaknessValue = '×2'),(SELECT resistanceId FROM P10_Resistance WHERE resistanceType = 'Eau' AND resistanceValue = '-20')),
	('Pokemon','Maractus','80','Uncommon','https://assets.tcgdex.net/en/bw/bw1/11/high.webp','Grass','Black & White',2,'en',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Fire' AND weaknessValue = '×2'),(SELECT resistanceId FROM P10_Resistance WHERE resistanceType = 'Water' AND resistanceValue = '-20')),
	('Pokémon','Poichigeon','50','Commune','https://assets.tcgdex.net/fr/bw/bwp/BW15/high.webp','Incolore','Promo BW',1,'fr',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Électrique' AND weaknessValue = '×2'),(SELECT resistanceId FROM P10_Resistance WHERE resistanceType = 'Combat' AND resistanceValue = '-20')),
	('Pokemon','Watchog','90','Uncommon','https://assets.tcgdex.net/en/bw/bw8/112/high.webp','Colorless','Plasma Storm',1,'en',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Fighting' AND weaknessValue = '×2'),null),
	('Pokémon','Viskuse','80','Commune','https://assets.tcgdex.net/fr/bw/bw7/44/high.webp','Eau','Frontières Franchies',2,'fr',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Électrique' AND weaknessValue = '×2'),null),
	('Pokemon','Dewott','90','Uncommon','https://assets.tcgdex.net/en/bw/bw7/40/high.webp','Water','Boundaries Crossed',1,'en',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Grass' AND weaknessValue = '×2'),null),
	('Pokémon','Polarhume','70','Commune','https://assets.tcgdex.net/fr/bw/bw2/28/high.webp','Eau','Pouvoirs Émergents',2,'fr',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Métal' AND weaknessValue = '×2'),null),
	('Pokemon','Palpitoad','90','Uncommon','https://assets.tcgdex.net/en/bw/bw9/25/high.webp','Water','Plasma Freeze',2,'en',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Grass' AND weaknessValue = '×2'),null),
	('Pokémon','Rosélia','70','Peu Commune','https://assets.tcgdex.net/fr/bw/bw6/12/high.webp','Plante','Dragons Éxaltés',1,'fr',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Feu' AND weaknessValue = '×2'),(SELECT resistanceId FROM P10_Resistance WHERE resistanceType = 'Eau' AND resistanceValue = '-20')),
	('Pokemon','Whimsicott','80','Uncommon','https://assets.tcgdex.net/en/bw/bw2/11/high.webp','Grass','Emerging Powers',0,'en',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Fire' AND weaknessValue = '×2'),(SELECT resistanceId FROM P10_Resistance WHERE resistanceType = 'Water' AND resistanceValue = '-20')),
	('Pokémon','Roitiflam','150','Magnifique rare','https://assets.tcgdex.net/fr/bw/bw4/100/high.webp','Feu','Destinées Futures',4,'fr',(SELECT abilityId FROM P10_Ability WHERE abilityName = 'Tango Infernal' AND abilityEffect = 'Autant de fois que vous le voulez pendant votre tour (avant votre attaque), vous pouvez attacher une carte Énergie Fire de votre main à 1 de vos Pokémon.'),(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Eau' AND weaknessValue = '×2'),null),
	('Trainer','Cheren',null,'Uncommon','https://assets.tcgdex.net/en/bw/bw5/91/high.webp',null,'Dark Explorers',null,'en',null,null,null),
	('Pokémon','Pingoléon','140','Magnifique rare','https://assets.tcgdex.net/fr/bw/bw9/117/high.webp','Eau','Glaciation Plasma',2,'fr',(SELECT abilityId FROM P10_Ability WHERE abilityName = 'Plonge et Pioche' AND abilityEffect = 'Une seule fois pendant votre tour (avant votre attaque), vous pouvez défausser une carte de votre main. Dans ce cas, piochez 2 cartes.'),(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Électrique' AND weaknessValue = '×2'),null),
	('Pokemon','Black Kyurem-EX','180','Rare','https://assets.tcgdex.net/en/bw/bw7/101/high.webp','Dragon','Boundaries Crossed',3,'en',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Dragon' AND weaknessValue = '×2'),null),
	('Pokémon','Scobolide','90','Peu Commune','https://assets.tcgdex.net/fr/bw/bw2/39/high.webp','Psy','Pouvoirs Émergents',3,'fr',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Psy' AND weaknessValue = '×2'),null),
	('Pokemon','Chinchou','70','Common','https://assets.tcgdex.net/en/bw/bw9/35/high.webp','Lightning','Plasma Freeze',2,'en',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Fighting' AND weaknessValue = '×2'),null),
	('Pokémon','Nodulithe','60','Commune','https://assets.tcgdex.net/fr/bw/bw2/49/high.webp','Combat','Pouvoirs Émergents',2,'fr',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Plante' AND weaknessValue = '×2'),null),
	('Pokemon','Magneton','80','Uncommon','https://assets.tcgdex.net/en/bw/bw8/44/high.webp','Lightning','Plasma Storm',2,'en',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Fighting' AND weaknessValue = '×2'),null),
	('Pokémon','Rhinolove','80','Peu Commune','https://assets.tcgdex.net/fr/bw/bw1/51/high.webp','Psy','Noir & Blanc',1,'fr',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Électrique' AND weaknessValue = '×2'),(SELECT resistanceId FROM P10_Resistance WHERE resistanceType = 'Combat' AND resistanceValue = '-20')),
	('Pokemon','Gothorita','80','Uncommon','https://assets.tcgdex.net/en/bw/bw2/46/high.webp','Psychic','Emerging Powers',1,'en',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Psychic' AND weaknessValue = '×2'),null),
	('Pokémon','Métalosse','140','Rare','https://assets.tcgdex.net/fr/bw/bwp/BW75/high.webp','Psy','Promo BW',2,'fr',(SELECT abilityId FROM P10_Ability WHERE abilityName = 'Recherche Plasma' AND abilityEffect = 'Une seule fois pendant votre tour (avant votre attaque), vous pouvez chercher une carte de la Team Plasma dans votre deck, la montrer et l''ajouter à votre main. Mélangez ensuite votre deck. Vous ne pouvez pas utiliser une capacité spéciale du même nom pendant votre tour.'),(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Psy' AND weaknessValue = '×2'),null),
	('Pokemon','Krookodile','150','Secret Rare','https://assets.tcgdex.net/en/bw/bw6/127/high.webp','Darkness','Dragons Exalted',3,'en',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Fighting' AND weaknessValue = '×2'),(SELECT resistanceId FROM P10_Resistance WHERE resistanceType = 'Psychic' AND resistanceValue = '-20')),
	('Pokémon','Tortipouss','70','Commune','https://assets.tcgdex.net/fr/bw/bw8/1/high.webp','Plante','Tempète Plasma',2,'fr',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Feu' AND weaknessValue = '×2'),(SELECT resistanceId FROM P10_Resistance WHERE resistanceType = 'Eau' AND resistanceValue = '-20')),
	('Pokemon','Weedle','50','Common','https://assets.tcgdex.net/en/bw/bw9/1/high.webp','Grass','Plasma Freeze',1,'en',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Fire' AND weaknessValue = '×2'),null),
	('Pokémon','Celebi-EX','110','Rare','https://assets.tcgdex.net/fr/bw/bw7/9/high.webp','Plante','Frontières Franchies',1,'fr',(SELECT abilityId FROM P10_Ability WHERE abilityName = 'Rappel Temporel' AND abilityEffect = 'Chacun de vos Pokémon évolués peut utiliser les attaques de ses pré-évolutions. (Vous avez toujours besoin de l’Énergie nécessaire pour utiliser chaque attaque.)'),(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Feu' AND weaknessValue = '×2'),(SELECT resistanceId FROM P10_Resistance WHERE resistanceType = 'Eau' AND resistanceValue = '-20')),
	('Pokemon','Leavanny','130','Rare','https://assets.tcgdex.net/en/bw/bw2/8/high.webp','Grass','Emerging Powers',1,'en',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Fire' AND weaknessValue = '×2'),null),
	('Pokémon','Fragilady','80','Rare','https://assets.tcgdex.net/fr/bw/bw7/17/high.webp','Plante','Frontières Franchies',1,'fr',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Feu' AND weaknessValue = '×2'),(SELECT resistanceId FROM P10_Resistance WHERE resistanceType = 'Eau' AND resistanceValue = '-20')),
	('Pokemon','Wartortle','80','Uncommon','https://assets.tcgdex.net/en/bw/bw10/15/high.webp','Water','Plasma Blast',2,'en',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Grass' AND weaknessValue = '×2'),null),
	('Pokémon','Tarinorme','110','Rare','https://assets.tcgdex.net/fr/bw/bw6/82/high.webp','Métal','Dragons Éxaltés',4,'fr',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Feu' AND weaknessValue = '×2'),(SELECT resistanceId FROM P10_Resistance WHERE resistanceType = 'Psy' AND resistanceValue = '-20')),
	('Pokemon','Bisharp','90','Uncommon','https://assets.tcgdex.net/en/bw/bw9/74/high.webp','Darkness','Plasma Freeze',1,'en',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Fighting' AND weaknessValue = '×2'),(SELECT resistanceId FROM P10_Resistance WHERE resistanceType = 'Psychic' AND resistanceValue = '-20')),
	('Pokémon','Kyurem Noir-EX','180','Rare','https://assets.tcgdex.net/fr/bw/bw7/101/high.webp','Dragon','Frontières Franchies',3,'fr',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Dragon' AND weaknessValue = '×2'),null),
	('Energy','Plasma Energy',null,'Uncommon','https://assets.tcgdex.net/en/bw/bw10/91/high.webp',null,'Plasma Blast',null,'en',null,null,null),
	('Pokémon','Feuiloutan','90','Rare','https://assets.tcgdex.net/fr/bw/bw4/7/high.webp','Plante','Destinées Futures',2,'fr',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Feu' AND weaknessValue = '×2'),(SELECT resistanceId FROM P10_Resistance WHERE resistanceType = 'Eau' AND resistanceValue = '-20')),
	('Pokemon','Pansage','60','Common','https://assets.tcgdex.net/en/bw/bw1/7/high.webp','Grass','Black & White',1,'en',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Fire' AND weaknessValue = '×2'),(SELECT resistanceId FROM P10_Resistance WHERE resistanceType = 'Water' AND resistanceValue = '-20')),
	('Pokémon','Coupenotte','60','Commune','https://assets.tcgdex.net/fr/bw/bw3/86/high.webp','Incolore','Nobles Victoires',1,'fr',null,null,null),
	('Trainer','Caitlin',null,'Uncommon','https://assets.tcgdex.net/en/bw/bw10/78/high.webp',null,'Plasma Blast',null,'en',null,null,null),
	('Dresseur','Nikolaï',null,'Ultra Rare','https://assets.tcgdex.net/fr/bw/bw8/135/high.webp',null,'Tempète Plasma',null,'fr',(SELECT abilityId FROM P10_Ability WHERE abilityEffect = 'Mélangez votre main avec votre deck. Ensuite, piochez un nombre de cartes égal au nombre de Pokémon de Banc (les vôtres et ceux de votre adversaire).'),null,null),
	('Pokemon','Darkrai-EX','180','Ultra Rare','https://assets.tcgdex.net/en/bw/bw5/107/high.webp','Darkness','Dark Explorers',2,'en',(SELECT abilityId FROM P10_Ability WHERE abilityName = 'Dark Cloak' AND abilityEffect = 'Each of your Pokémon that has any Darkness Energy attached to it has no Retreat Cost.'),(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Fighting' AND weaknessValue = '×2'),(SELECT resistanceId FROM P10_Resistance WHERE resistanceType = 'Psychic' AND resistanceValue = '-20')),
	('Pokémon','Férosinge','50','Commune','https://assets.tcgdex.net/fr/bw/bw9/59/high.webp','Combat','Glaciation Plasma',1,'fr',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Psy' AND weaknessValue = '×2'),null),
	('Pokemon','Drilbur','70','Uncommon','https://assets.tcgdex.net/en/bw/bw2/54/high.webp','Fighting','Emerging Powers',2,'en',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Water' AND weaknessValue = '×2'),(SELECT resistanceId FROM P10_Resistance WHERE resistanceType = 'Lightning' AND resistanceValue = '-20')),
	('Pokémon','Statitik','30','Commune','https://assets.tcgdex.net/fr/bw/bw5/42/high.webp','Électrique','Explorateurs Obscurs',1,'fr',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Combat' AND weaknessValue = '×2'),null),
	('Pokemon','Venipede','70','Common','https://assets.tcgdex.net/en/bw/bw2/38/high.webp','Psychic','Emerging Powers',2,'en',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Psychic' AND weaknessValue = '×2'),null),
	('Pokémon','Apitrini','30','Commune','https://assets.tcgdex.net/fr/bw/bw8/4/high.webp','Plante','Tempète Plasma',1,'fr',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Feu' AND weaknessValue = '×2'),null),
	('Pokemon','Kricketune','90','Uncommon','https://assets.tcgdex.net/en/bw/bw4/4/high.webp','Grass','Next Destinies',1,'en',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Fire' AND weaknessValue = '×2'),null),
	('Pokémon','Ratentif','50','Commune','https://assets.tcgdex.net/fr/bw/bw8/111/high.webp','Incolore','Tempète Plasma',1,'fr',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Combat' AND weaknessValue = '×2'),null),
	('Pokemon','Zweilous','80','Uncommon','https://assets.tcgdex.net/en/bw/bw11/98/high.webp','Dragon','Legendary Treasures',2,'en',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Dragon' AND weaknessValue = '×2'),null),
	('Pokémon','Escroco','90','Peu Commune','https://assets.tcgdex.net/fr/bw/bw2/61/high.webp','Combat','Pouvoirs Émergents',2,'fr',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Eau' AND weaknessValue = '×2'),null),
	('Pokemon','Yamask','60','Common','https://assets.tcgdex.net/en/bw/bw9/55/high.webp','Psychic','Plasma Freeze',1,'en',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Darkness' AND weaknessValue = '×2'),null),
	('Pokémon','Boréas-EX','170','Rare','https://assets.tcgdex.net/fr/bw/bw5/90/high.webp','Incolore','Explorateurs Obscurs',1,'fr',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Électrique' AND weaknessValue = '×2'),(SELECT resistanceId FROM P10_Resistance WHERE resistanceType = 'Combat' AND resistanceValue = '-20')),
	('Pokemon','Herdier','80','Uncommon','https://assets.tcgdex.net/en/bw/bw1/82/high.webp','Colorless','Black & White',1,'en',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Fighting' AND weaknessValue = '×2'),null),
	('Pokémon','Leveinard','100','Commune','https://assets.tcgdex.net/fr/bw/bw5/80/high.webp','Incolore','Explorateurs Obscurs',3,'fr',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Combat' AND weaknessValue = '×2'),null),
	('Pokemon','Donphan','130','Uncommon','https://assets.tcgdex.net/en/bw/bw8/72/high.webp','Fighting','Plasma Storm',4,'en',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Water' AND weaknessValue = '×2'),(SELECT resistanceId FROM P10_Resistance WHERE resistanceType = 'Lightning' AND resistanceValue = '-20')),
	('Pokémon','Fulguris-EX','170','Rare','https://assets.tcgdex.net/fr/bw/bw9/38/high.webp','Électrique','Glaciation Plasma',1,'fr',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Combat' AND weaknessValue = '×2'),null),
	('Pokemon','Palpitoad','80','Uncommon','https://assets.tcgdex.net/en/bw/bw6/35/high.webp','Water','Dragons Exalted',1,'en',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Grass' AND weaknessValue = '×2'),null),
	('Pokémon','Carabaffe','80','Peu Commune','https://assets.tcgdex.net/fr/bw/bw10/15/high.webp','Eau','Explosion Plasma',2,'fr',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Plante' AND weaknessValue = '×2'),null),
	('Pokemon','Crustle','100','Uncommon','https://assets.tcgdex.net/en/bw/bw11/14/high.webp','Grass','Legendary Treasures',2,'en',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Fire' AND weaknessValue = '×2'),null),
	('Pokémon','Ramboum','90','Peu Commune','https://assets.tcgdex.net/fr/bw/bw8/106/high.webp','Incolore','Tempète Plasma',3,'fr',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Combat' AND weaknessValue = '×2'),null),
	('Trainer','Scoop Up Cyclone',null,'Rare','https://assets.tcgdex.net/en/bw/bw10/95/high.webp',null,'Plasma Blast',null,'en',null,null,null),
	('Pokémon','Ratentif','60','Commune','https://assets.tcgdex.net/fr/bw/bw2/78/high.webp','Incolore','Pouvoirs Émergents',1,'fr',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Combat' AND weaknessValue = '×2'),null),
	('Pokemon','Terrakion-EX','180','Rare','https://assets.tcgdex.net/en/bw/bw6/71/high.webp','Fighting','Dragons Exalted',3,'en',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Grass' AND weaknessValue = '×2'),null),
	('Pokémon','Chovsourir','60','Commune','https://assets.tcgdex.net/fr/bw/bw2/36/high.webp','Psy','Pouvoirs Émergents',1,'fr',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Psy' AND weaknessValue = '×2'),null),
	('Pokemon','Psyduck','70','Common','https://assets.tcgdex.net/en/bw/bw7/33/high.webp','Water','Boundaries Crossed',3,'en',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Lightning' AND weaknessValue = '×2'),null),
	('Pokémon','Luxio','80','Peu Commune','https://assets.tcgdex.net/fr/bw/bw4/45/high.webp','Électrique','Destinées Futures',0,'fr',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Combat' AND weaknessValue = '×2'),null),
	('Pokemon','Sigilyph','90','Uncommon','https://assets.tcgdex.net/en/bw/bw2/41/high.webp','Psychic','Emerging Powers',1,'en',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Lightning' AND weaknessValue = '×2'),(SELECT resistanceId FROM P10_Resistance WHERE resistanceType = 'Fighting' AND resistanceValue = '-20')),
	('Pokémon','Lampéroie','90','Peu Commune','https://assets.tcgdex.net/fr/bw/bw3/40/high.webp','Électrique','Nobles Victoires',2,'fr',(SELECT abilityId FROM P10_Ability WHERE abilityName = 'Dynamoteur' AND abilityEffect = 'Une seule fois pendant votre tour (avant votre attaque), vous pouvez attacher une carte Énergie Lightning de votre pile de défausse à 1 de vos Pokémon de Banc.'),(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Combat' AND weaknessValue = '×2'),null),
	('Pokemon','Vanillish','80','Uncommon','https://assets.tcgdex.net/en/bw/bw8/36/high.webp','Water','Plasma Storm',1,'en',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Metal' AND weaknessValue = '×2'),null),
	('Pokémon','Clamiral','140','Rare','https://assets.tcgdex.net/fr/bw/bwp/BW22/high.webp','Eau','Promo BW',2,'fr',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Électrique' AND weaknessValue = '×2'),null),
	('Pokemon','Zekrom','130','Ultra Rare','https://assets.tcgdex.net/en/bw/bw1/114/high.webp','Lightning','Black & White',2,'en',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Fighting' AND weaknessValue = '×2'),null),
	('Pokémon','Maganon','120','Rare','https://assets.tcgdex.net/fr/bw/bw6/21/high.webp','Feu','Dragons Éxaltés',3,'fr',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Eau' AND weaknessValue = '×2'),null),
	('Pokemon','Lampent','80','Uncommon','https://assets.tcgdex.net/en/bw/bw4/19/high.webp','Fire','Next Destinies',1,'en',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Water' AND weaknessValue = '×2'),null);

INSERT INTO P10_Contient(cardId, attackId) VALUES
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/fr/bw/bw6/97/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Dracoxplosion' AND attackCost = 'PsyObscuritéObscuritéIncolore' AND attackDamage = '140'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/en/bw/bw11/88/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Night Spear' AND attackCost = 'DarknessDarknessColorless' AND attackDamage = '90'))
	((SELECT cardId FROM P10_Card WHERE cardImg = '/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Dragon Pulse' AND attackCost = 'Lightning' AND attackDamage = '40'))
	((SELECT cardId FROM P10_Card WHERE cardImg = '/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Shred' AND attackCost = 'FireLightningColorless' AND attackDamage = '90'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/fr/bw/bw7/66/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Vendetta' AND attackCost = 'Incolore' AND attackDamage = '20'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/fr/bw/bw7/66/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Direct Toxik' AND attackCost = 'PsyIncoloreIncolore' AND attackDamage = '60'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/en/bw/bw7/60/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Psybeam' AND attackCost = 'PsychicColorless' AND attackDamage = '30'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/en/bw/bw7/60/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Extrasensory' AND attackCost = 'PsychicColorlessColorless' AND attackDamage = '60'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/en/bw/bw4/76/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Oracle Inflict' AND attackCost = 'MetalColorlessColorless' AND attackDamage = '30'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/fr/bw/bw7/81/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Anneau de Poison' AND attackCost = 'Combat' AND attackDamage = '20'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/fr/bw/bw7/81/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Tranche-Nuit' AND attackCost = 'CombatIncolore' AND attackDamage = '40'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/en/bw/bw10/73/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Destructive Beam' AND attackCost = 'ColorlessColorless' AND attackDamage = '30'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/fr/bw/bw2/80/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Tornade' AND attackCost = 'IncoloreIncolore' AND attackDamage = '20'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/en/bw/bw7/73/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Spinning Attack' AND attackCost = 'PsychicColorlessColorless' AND attackDamage = '50'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/fr/bw/bw3/49/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Enveloppe Douce' AND attackCost = 'PsyIncolore' AND attackDamage = '30'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/fr/bw/bw3/49/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Détricanon' AND attackCost = 'PsyPsyIncolore' AND attackDamage = '60'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/en/bw/bw7/45/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Eerie Light' AND attackCost = 'WaterColorlessColorless' AND attackDamage = '40'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/fr/bw/bw6/61/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Piège Osseux' AND attackCost = 'Combat' AND attackDamage = '30'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/fr/bw/bw6/61/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Coupe-Tourbillon' AND attackCost = 'CombatIncoloreIncolore' AND attackDamage = '60'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/en/bw/bw10/55/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Roar' AND attackCost = 'Colorless' AND attackDamage = null))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/en/bw/bw10/55/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Ambush' AND attackCost = 'DarknessColorless' AND attackDamage = '20'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/en/bw/bw6/69/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Defensive Stance' AND attackCost = 'Colorless' AND attackDamage = null))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/en/bw/bw6/69/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Karate Chop' AND attackCost = 'FightingColorlessColorless' AND attackDamage = '70'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/fr/bw/bw2/78/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Croc de Mort' AND attackCost = 'Incolore' AND attackDamage = '30'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/en/bw/bw6/71/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Rock Tumble' AND attackCost = 'FightingColorless' AND attackDamage = '50'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/en/bw/bw6/71/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Pump-up Smash' AND attackCost = 'FightingFightingColorless' AND attackDamage = '90'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/fr/bw/bw9/120/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Coupe Vive' AND attackCost = 'Combat' AND attackDamage = '60'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/fr/bw/bw9/120/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Draco-Lame' AND attackCost = 'EauCombat' AND attackDamage = '100'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/en/bw/bw6/102/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Ambush' AND attackCost = 'ColorlessColorless' AND attackDamage = '20'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/fr/bw/bw8/19/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Griffe' AND attackCost = 'IncoloreIncolore' AND attackDamage = '20'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/fr/bw/bw8/19/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Double Feu' AND attackCost = 'FeuFeuIncolore' AND attackDamage = '40'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/en/bw/bw6/18/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Singe' AND attackCost = 'Fire' AND attackDamage = null))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/fr/bw/bwp/BW02/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Flammèche' AND attackCost = 'FeuIncolore' AND attackDamage = '30'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/fr/bw/bw10/12/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Flamboiement' AND attackCost = 'Feu' AND attackDamage = '10'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/fr/bw/bw10/12/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Flammèche' AND attackCost = 'FeuIncolore' AND attackDamage = '30'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/en/bw/bw10/11/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Megalo Cannon' AND attackCost = 'GrassGrassColorless' AND attackDamage = '100'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/fr/bw/bw6/27/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Rallonge' AND attackCost = 'Eau' AND attackDamage = null))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/en/bw/bw9/24/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Surprise Attack' AND attackCost = 'Water' AND attackDamage = '20'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/fr/bw/bw8/11/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Danse Éblouissante' AND attackCost = 'Plante' AND attackDamage = '10'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/fr/bw/bw8/11/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Embuscade' AND attackCost = 'PlanteIncolore' AND attackDamage = '20'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/en/bw/bw1/11/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Mega Drain' AND attackCost = 'Grass' AND attackDamage = '20'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/en/bw/bw1/11/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Pin Missile' AND attackCost = 'GrassGrassColorless' AND attackDamage = '20'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/fr/bw/bwp/BW15/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Tornade' AND attackCost = 'IncoloreIncolore' AND attackDamage = '20'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/en/bw/bw8/112/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Fast Swipe' AND attackCost = 'Colorless' AND attackDamage = null))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/en/bw/bw8/112/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Biting Fang' AND attackCost = 'ColorlessColorless' AND attackDamage = '30'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/fr/bw/bw7/44/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Grosse Vague' AND attackCost = 'EauIncoloreIncolore' AND attackDamage = '40'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/en/bw/bw7/40/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Rain Splash' AND attackCost = 'Water' AND attackDamage = '20'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/en/bw/bw7/40/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Waterfall' AND attackCost = 'WaterWaterColorless' AND attackDamage = '50'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/fr/bw/bw2/28/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Poudreuse' AND attackCost = 'Eau' AND attackDamage = '10'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/fr/bw/bw2/28/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Repos' AND attackCost = 'IncoloreIncolore' AND attackDamage = null))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/en/bw/bw9/25/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Vibration' AND attackCost = 'ColorlessColorless' AND attackDamage = '20'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/en/bw/bw9/25/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Suspicious Soundwave' AND attackCost = 'WaterColorlessColorless' AND attackDamage = '30'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/fr/bw/bw6/12/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Double Fouet' AND attackCost = 'Incolore' AND attackDamage = '10'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/fr/bw/bw6/12/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Parfum Relaxant' AND attackCost = 'Plante' AND attackDamage = null))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/en/bw/bw2/11/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Helping Hand' AND attackCost = 'Colorless' AND attackDamage = null))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/en/bw/bw2/11/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Cotton Guard' AND attackCost = 'Grass' AND attackDamage = '30'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/fr/bw/bw4/100/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Tacle Feu' AND attackCost = 'FeuFeuIncoloreIncolore' AND attackDamage = '80'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/fr/bw/bw9/117/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Ordre d''Assaut' AND attackCost = 'Eau' AND attackDamage = '10'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/en/bw/bw7/101/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Dragon Fang' AND attackCost = 'LightningColorlessColorless' AND attackDamage = '60'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/en/bw/bw7/101/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Freeze Shock' AND attackCost = 'WaterLightningLightningColorless' AND attackDamage = '150'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/fr/bw/bw2/39/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Choc Venin' AND attackCost = 'Psy' AND attackDamage = '10'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/fr/bw/bw2/39/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Bulldoboule' AND attackCost = 'IncoloreIncoloreIncolore' AND attackDamage = '40'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/en/bw/bw9/35/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Static Shock' AND attackCost = 'LightningColorless' AND attackDamage = '20'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/fr/bw/bw2/49/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Armure' AND attackCost = 'Incolore' AND attackDamage = null))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/fr/bw/bw2/49/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Coup d''Boule' AND attackCost = 'CombatIncoloreIncolore' AND attackDamage = '40'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/en/bw/bw8/44/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Metal Sound' AND attackCost = 'Colorless' AND attackDamage = null))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/en/bw/bw8/44/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Electro Ball' AND attackCost = 'LightningColorless' AND attackDamage = '30'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/fr/bw/bw1/51/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Attraction' AND attackCost = 'Incolore' AND attackDamage = null))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/fr/bw/bw1/51/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Crèvecœur' AND attackCost = 'PsyIncolore' AND attackDamage = '40'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/en/bw/bw2/46/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Deleting Glare' AND attackCost = 'Psychic' AND attackDamage = null))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/en/bw/bw2/46/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Super Psy Bolt' AND attackCost = 'PsychicColorlessColorless' AND attackDamage = '50'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/fr/bw/bwp/BW75/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Contrôleur d''Esprit' AND attackCost = 'PsyIncoloreIncoloreIncolore' AND attackDamage = '60'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/en/bw/bw6/127/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Dark Clamp' AND attackCost = 'DarknessColorlessColorless' AND attackDamage = '60'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/en/bw/bw6/127/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Bombast' AND attackCost = 'DarknessDarknessColorlessColorless' AND attackDamage = '40'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/fr/bw/bw8/1/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Tit''Sieste' AND attackCost = 'Incolore' AND attackDamage = null))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/fr/bw/bw8/1/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Tranch''Herbe' AND attackCost = 'PlanteIncoloreIncolore' AND attackDamage = '30'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/en/bw/bw9/1/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Triple Stab' AND attackCost = 'Grass' AND attackDamage = '10'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/fr/bw/bw7/9/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Rafale Tranchante' AND attackCost = 'PlanteIncoloreIncolore' AND attackDamage = '60'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/en/bw/bw2/8/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Slash' AND attackCost = 'Colorless' AND attackDamage = '30'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/en/bw/bw2/8/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Triple Cutter' AND attackCost = 'GrassGrassColorless' AND attackDamage = '60'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/fr/bw/bw7/17/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Retour' AND attackCost = 'Incolore' AND attackDamage = '20'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/fr/bw/bw7/17/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Feuillemagik' AND attackCost = 'PlanteIncoloreIncolore' AND attackDamage = '50'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/en/bw/bw10/15/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Bubble' AND attackCost = 'Water' AND attackDamage = null))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/en/bw/bw10/15/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Double Spin' AND attackCost = 'WaterColorlessColorless' AND attackDamage = '30'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/fr/bw/bw6/82/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Lignes Magnétiques' AND attackCost = 'IncoloreIncolore' AND attackDamage = '30'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/fr/bw/bw6/82/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Pif Paf' AND attackCost = 'MétalIncoloreIncolore' AND attackDamage = '60'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/en/bw/bw9/74/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Cut Down' AND attackCost = 'ColorlessColorless' AND attackDamage = '30'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/en/bw/bw9/74/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Slicing Blade' AND attackCost = 'DarknessColorlessColorless' AND attackDamage = '70'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/fr/bw/bw7/101/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Croc de Dragon' AND attackCost = 'ÉlectriqueIncoloreIncolore' AND attackDamage = '60'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/fr/bw/bw7/101/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Éclair Gelé' AND attackCost = 'EauÉlectriqueÉlectriqueIncolore' AND attackDamage = '150'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/fr/bw/bw4/7/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Collecte' AND attackCost = 'Plante' AND attackDamage = null))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/fr/bw/bw4/7/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Vampire de Stade' AND attackCost = 'PlanteIncolore' AND attackDamage = '30'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/en/bw/bw1/7/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Scratch' AND attackCost = 'Colorless' AND attackDamage = '10'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/en/bw/bw1/7/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Vine Whip' AND attackCost = 'GrassColorlessColorless' AND attackDamage = '30'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/fr/bw/bw3/86/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Double Baffe' AND attackCost = 'Incolore' AND attackDamage = '10'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/en/bw/bw5/107/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Night Spear' AND attackCost = 'DarknessDarknessColorless' AND attackDamage = '90'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/fr/bw/bw9/59/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Griffe' AND attackCost = 'Combat' AND attackDamage = '20'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/en/bw/bw2/54/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Hone Claws' AND attackCost = 'Colorless' AND attackDamage = null))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/en/bw/bw2/54/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Scratch' AND attackCost = 'Fighting' AND attackDamage = '10'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/en/bw/bw2/38/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Poison Sting' AND attackCost = 'Psychic' AND attackDamage = null))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/en/bw/bw2/38/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Tackle' AND attackCost = 'ColorlessColorless' AND attackDamage = '20'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/fr/bw/bw8/4/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Dard-Missile' AND attackCost = 'Plante' AND attackDamage = '30'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/en/bw/bw4/4/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'White Noise' AND attackCost = 'Colorless' AND attackDamage = '20'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/en/bw/bw4/4/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Draining Cut' AND attackCost = 'GrassColorless' AND attackDamage = '40'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/fr/bw/bw8/111/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Collecte' AND attackCost = 'Incolore' AND attackDamage = null))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/fr/bw/bw8/111/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Souplesse' AND attackCost = 'IncoloreIncolore' AND attackDamage = '20'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/en/bw/bw11/98/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Crunch' AND attackCost = 'ColorlessColorless' AND attackDamage = '30'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/en/bw/bw11/98/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Dragon Claw' AND attackCost = 'PsychicDarknessDarkness' AND attackDamage = '80'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/fr/bw/bw2/61/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Morsure' AND attackCost = 'Incolore' AND attackDamage = '20'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/fr/bw/bw2/61/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Mâchouille' AND attackCost = 'CombatIncoloreIncolore' AND attackDamage = '40'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/en/bw/bw9/55/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Will-O-Wisp' AND attackCost = 'Colorless' AND attackDamage = '10'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/en/bw/bw9/55/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Ram' AND attackCost = 'PsychicColorlessColorless' AND attackDamage = '30'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/en/bw/bw1/82/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Collect' AND attackCost = 'ColorlessColorless' AND attackDamage = null))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/en/bw/bw1/82/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Bite' AND attackCost = 'ColorlessColorlessColorless' AND attackDamage = '50'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/en/bw/bw8/72/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Spinning Turn' AND attackCost = 'Fighting' AND attackDamage = '40'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/en/bw/bw8/72/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Wreck' AND attackCost = 'FightingFightingColorlessColorless' AND attackDamage = '80'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/fr/bw/bw9/38/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Appel Foudroyant' AND attackCost = 'Électrique' AND attackDamage = '30'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/fr/bw/bw9/38/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Grondement Tonitruant' AND attackCost = 'ÉlectriqueÉlectriqueIncoloreIncolore' AND attackDamage = '90'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/en/bw/bw6/35/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Supersonic' AND attackCost = 'Colorless' AND attackDamage = null))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/en/bw/bw6/35/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Hyper Voice' AND attackCost = 'WaterColorlessColorless' AND attackDamage = '50'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/fr/bw/bw10/15/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Écume' AND attackCost = 'Eau' AND attackDamage = null))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/fr/bw/bw10/15/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Double Tour' AND attackCost = 'EauIncoloreIncolore' AND attackDamage = '30'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/en/bw/bw11/14/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Hard Press' AND attackCost = 'ColorlessColorless' AND attackDamage = '30'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/en/bw/bw11/14/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Hammer In' AND attackCost = 'GrassColorlessColorless' AND attackDamage = '70'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/fr/bw/bw8/106/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Ultrason' AND attackCost = 'Incolore' AND attackDamage = null))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/fr/bw/bw8/106/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Mégaphone' AND attackCost = 'IncoloreIncoloreIncolore' AND attackDamage = '50'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/fr/bw/bw2/78/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Croc de Mort' AND attackCost = 'Incolore' AND attackDamage = '30'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/en/bw/bw6/71/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Rock Tumble' AND attackCost = 'FightingColorless' AND attackDamage = '50'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/en/bw/bw6/71/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Pump-up Smash' AND attackCost = 'FightingFightingColorless' AND attackDamage = '90'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/fr/bw/bw2/36/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Choc Mental' AND attackCost = 'PsyIncolore' AND attackDamage = '20'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/en/bw/bw7/33/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Firefighting' AND attackCost = 'Water' AND attackDamage = null))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/fr/bw/bw4/45/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Vif Retournement' AND attackCost = 'Électrique' AND attackDamage = '20'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/fr/bw/bw4/45/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Morsure' AND attackCost = 'IncoloreIncolore' AND attackDamage = '30'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/en/bw/bw2/41/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Reflect' AND attackCost = 'Psychic' AND attackDamage = null))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/en/bw/bw2/41/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Telekinesis' AND attackCost = 'PsychicColorlessColorless' AND attackDamage = null))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/fr/bw/bw3/40/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Boule de Foudre' AND attackCost = 'ÉlectriqueÉlectriqueIncolore' AND attackDamage = '50'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/en/bw/bw8/36/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Icy Snow' AND attackCost = 'WaterColorless' AND attackDamage = '30'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/fr/bw/bwp/BW22/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Hydrocanon' AND attackCost = 'IncoloreIncoloreIncolore' AND attackDamage = '70'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/en/bw/bw1/114/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Outrage' AND attackCost = 'ColorlessColorless' AND attackDamage = '20'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/en/bw/bw1/114/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Bolt Strike' AND attackCost = 'LightningLightningColorless' AND attackDamage = '120'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/fr/bw/bw6/21/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Barrière de Flammes' AND attackCost = 'Feu' AND attackDamage = '40'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/fr/bw/bw6/21/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Lance-Flamme' AND attackCost = 'FeuIncoloreIncolore' AND attackDamage = '90'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/en/bw/bw4/19/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Ember' AND attackCost = 'FireColorless' AND attackDamage = '40'))