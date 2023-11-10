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
	userDob DATE NOT NULL,
	userStatus varchar(10) CHECK(userStatus IN ('root','user')),
	userLogin varchar(255) NOT NULL,
	userPass varchar(255) NOT NULL);

CREATE TABLE IF NOT EXISTS P10_Ability(
	abilityId INT AUTO_INCREMENT PRIMARY KEY,
	abilityName varchar(50) NOT NULL,
	abilityEffect varchar(255) NOT NULL);

CREATE TABLE IF NOT EXISTS P10_Resistance(
	resistanceId INT AUTO_INCREMENT PRIMARY KEY,
	resistanceType varchar(10) CHECK (resistanceType IN ('Incolore', 'Feu', 'Eau', 'Plante', 'Combat', 'Métal', 'Électrique', 'Psy', 'Obscurité', 'Dragon', 'Colorless', 'Fire', 'Water', 'Grass', 'Fighting', 'Metal', 'Lightning', 'Psychic', 'Darkness')),
	resistanceValue varchar(5) CHECK (resistanceValue IN ('/2','-20','-10','-30')));

CREATE TABLE IF NOT EXISTS P10_Weakness(
	weaknessId INT AUTO_INCREMENT PRIMARY KEY,
	weaknessType varchar(10) CHECK (weaknessValue IN ('Incolore', 'Feu', 'Eau', 'Plante', 'Combat', 'Métal', 'Électrique', 'Psy', 'Obscurité', 'Dragon', 'Colorless', 'Fire', 'Water', 'Grass', 'Fighting', 'Metal', 'Lightning', 'Psychic', 'Darkness')),
	weaknessValue varchar(5) CHECK (weaknessValue IN ('x2','+20','+10','+30')));

CREATE TABLE IF NOT EXISTS P10_Attack(
	attackId INT AUTO_INCREMENT PRIMARY KEY,
	attackName varchar(50) NOT NULL,
	attackCost varchar(50),
	attackDamage varchar(4),
	attackEffect varchar(255));

CREATE TABLE IF NOT EXISTS P10_Card(
	cardId INT AUTO_INCREMENT PRIMARY KEY,
	cardCategory varchar(50) DEFAULT 'Pokémon' CHECK (cardCategory IN ('Pokémon','Pokemon','Dresseur','Trainer')),
	cardName varchar(50) NOT NULL,
	cardHP INT,
	cardRarity varchar(50) DEFAULT 'Commune' CHECK (cardRarity IN ('Commune','Common','Uncommon','Peu Commune','Rare','Ultra Rare','Secret Rare','Magnifique','Maginfic')),
	cardImg varchar(20) NOT NULL,
	cardType varchar(10) CHECK (cardType IN ('Incolore', 'Feu', 'Eau', 'Plante', 'Combat', 'Métal', 'Électrique', 'Psy', 'Obscurité', 'Dragon', 'Colorless', 'Fire', 'Water', 'Grass', 'Fighting', 'Metal', 'Lightning', 'Psychic', 'Darkness')),
	cardExtension TEXT NOT NULL,
	cardRetreat INT,
	cardLang varchar(20) CHECK(cardLang IN ('fr','en')),
	abilityId INT REFERENCES P10_Ability(abilityId),
	resistanceId INT REFERENCES P10_Resistance(resistanceId,
	weaknessId INT REFERENCES P10_Weakness(weaknessId));

CREATE TABLE IF NOT EXISTS P10_Contient(
	cardId INT REFERENCES P10_Card(cardId),
	attackId INT REFERENCES P10_Attack(attackId));

CREATE TABLE IF NOT EXISTS P10_Collection(
	cardId INT REFERENCES P10_Card(cardId),
	userId INT REFERENCES P10_User(userId));


INSERT INTO P10_Ability(abilityName,abilityEffect) VALUES 
	('Unobservant','If your opponent’s Active Pokémon is a Basic Pokémon, this Pokémon can’t attack.'),
	('Prédiction','Une seule fois pendant votre tour (avant votre attaque), vous pouvez regarder les 2 cartes du dessus de votre deck, en choisir 1 et l’ajouter à votre main. Replacez l’autre carte sur le dessus de votre deck.'),
	('Victorieux','Une seule fois pendant votre tour, après avoir lancé des pièces pour une attaque, vous pouvez ignorer les effets de ces lancers de pièce et lancer ces pièces à nouveau. Vous ne pouvez pas utiliser la capacité spéciale Victorieux plus d’une fois par tour.'),
	('Navigation Flamboyante','Une seule fois pendant votre tour (avant votre attaque), vous pouvez chercher une carte Énergie Fire dans votre deck et l''attacher à 1 de vos Pokémon. Dans ce cas, placez 1 marqueur de dégâts sur le Pokémon auquel l''Énergie a été attachée. Mélangez ensuite votre deck.'),
	('Hymne au Combat','Les attaques de vos Pokémon Dragon infligent 20 dégâts supplémentaires aux Pokémon Actifs (avant application de la Faiblesse et de la Résistance).'),
	('Garbotoxin','If this Pokémon has a Pokémon Tool card attached to it, each Pokémon in play, in each player’s hand, and in each player’s discard pile has no Abilities (except for Garbotoxin).'),
	('Cape Obscure','Chacun de vos Pokémon auquel de l’Énergie Darkness est attachée n’a pas de coût de Retraite.'),
	('Vision de Nuit','Une seule fois pendant votre tour (avant votre attaque), vous pouvez piocher une carte.'),
	('Versatile','This Pokémon can use the attacks of any Pokémon in play (both yours and your opponent’s). (You still need the necessary Energy to use each attack.)'),
	('Vent Méprisant','Une seule fois pendant votre tour (avant votre attaque), vous pouvez demander à votre adversaire de défausser des cartes de sa main jusqu''à ce qu''il ne reste que 4 cartes dans sa main.'),
	('Empty Shell','If this Pokémon is Knocked Out, your opponent can’t take any Prize cards for it.'),
	('Déluge','Autant de fois que vous le voulez pendant votre tour (avant votre attaque), vous pouvez attacher une carte Énergie Water de votre main à 1 de vos Pokémon.'),
	('Œil Noir','Une seule fois pendant votre tour (avant votre attaque), si ce Pokémon est votre Pokémon Actif, vous pouvez lancer une pièce. Si c’est face, défaussez une Énergie attachée au Pokémon Actif de votre adversaire.'),
	('Téléhypnose','Une seule fois pendant votre tour (avant votre attaque), vous pouvez lancer une pièce. Si c’est face, le Pokémon Actif de votre adversaire est maintenant Endormi. Si c’est pile, votre Pokémon Actif est maintenant Endormi.');

INSERT INTO P10_Attack(attackName,attackCost,attackDamage,attackEffect) VALUES 
	('Round','ColorlessColorless','20','Does 20 damage times the number of your Pokémon that have the Round attack.'),
	('Coupe-Vent','IncoloreIncolore','30','Lancez une pièce. Si c''est pile, cette attaque ne fait rien.'),
	('Crushing Blow','ColorlessColorlessColorlessColorless','100','Discard an Energy attached to the Defending Pokémon.'),
	('Nitrocharge','Incolore',null,'Cherchez une carte Énergie Fire dans votre deck et attachez-la à ce Pokémon. Mélangez ensuite votre deck.'),
	('V-create','FireColorless','100','If you have 4 or fewer Benched Pokémon, this attack does nothing.'),
	('Coup de Queue','Combat','10',null),
	('Cut','DarknessColorless','30',null),
	('Tit''Sieste','Plante',null,'Soignez 30 dégâts à ce Pokémon.'),
	('Lifesplosion','Grass',null,'For each Energy attached to this Pokémon, search your deck for a Stage 2 Pokémon and put it onto your Bench. Shuffle your deck afterward.'),
	('Roulade','IncoloreIncolore','20',null),
	('Rollout','LightningColorless','20',null),
	('Rêve Douillet','PsyPsy','40','Ce Pokémon est maintenant Endormi.'),
	('Electriwave','LightningColorlessColorless',null,'This attack does 30 damage to each of your opponent''s Benched Pokémon. (Don''t apply Weakness and Resistance for Benched Pokémon.)'),
	('Vendetta','IncoloreIncolore','20','Si l’un de vos Pokémon a été mis K.O. par les dégâts d''une attaque de votre adversaire lors de son dernier tour, cette attaque inflige 70 dégâts supplémentaires.'),
	('Rayon Électrique','Électrique','20','Lancez une pièce. Si c''est face, le Pokémon Défenseur est maintenant Paralysé.'),
	('Rage Massive','EauIncolore','20','Inflige 20 dégâts multipliés par le nombre de marqueurs de dégâts placés sur ce Pokémon.'),
	('Present','Colorless',null,'Flip a coin. If heads, search your deck for a card and put it into your hand. Shuffle your deck afterward.'),
	('Chargeur','Incolore',null,'Cherchez une carte Énergie Lightning dans votre deck et attachez-la à ce Pokémon. Mélangez ensuite votre deck.'),
	('Metal Claw','MetalColorless','30',null),
	('Attraction','Incolore',null,'Si le Pokémon Défenseur essaie d’attaquer pendant le prochain tour de votre adversaire, ce dernier lance une pièce. Si c’est pile, son attaque ne fait rien.'),
	('Deleting Glare','Psychic',null,'Flip a coin. If heads, discard an Energy attached to 1 of your opponent''s Pokémon.'),
	('Mainmise','Incolore',null,'Cherchez 2 cartes Outil Pokémon dans votre deck, montrez-les, puis ajoutez-les à votre main. Mélangez ensuite votre deck.'),
	('Rock Throw','ColorlessColorless','20',null),
	('Force Ajoutée','FeuIncolore','30','Déplacez toutes les Énergies attachées à ce Pokémon vers 1 de vos Pokémon de Banc.'),
	('Bug Bite','GrassColorless','20',null),
	('Absorption','FeuFeuIncolore','70','Soignez 30 dégâts à ce Pokémon.'),
	('Double Draw','Colorless',null,'Draw 2 cards.'),
	('Étonnement','Psy',null,'Choisissez une carte au hasard de la main de votre adversaire. Votre adversaire montre la carte choisie et la mélange avec son deck.'),
	('Fortunate Draw','Psychic',null,'You and your opponent play Rock-Paper-Scissors. The player who wins draws 3 cards. The player who loses discards the top 3 cards of his or her deck.'),
	('Méga-Sangsue','Plante','20','Soignez 20 dégâts infligés à ce Pokémon.'),
	('Body Slam','GrassGrass','20','Flip a coin. If heads, the Defending Pokémon is now Paralyzed.'),
	('Glissement','EauMétalIncolore','40',null),
	('Sludge Toss','PsychicPsychicColorless','60',null),
	('Impact-Flash','Électrique','60','Inflige 20 dégâts à 1 de vos Pokémon. (N''appliquez ni la Faiblesse ni la Résistance aux Pokémon de Banc.)'),
	('Quick Turn','LightningColorless','20','Flip 2 coins. This attack does 20 damage times the number of heads.'),
	('Choc Mental','PsyIncolore','20','Lancez une pièce. Si c''est face, le Pokémon Défenseur est maintenant Paralysé.'),
	('Firefighting','Water',null,'Discard a Fire Energy attached to the Defending Pokémon.'),
	('Finishing Blow','Darkness','20','If the Defending Pokémon already has any damage counters on it, this attack does 50 more damage.'),
	('Griffe Acier','Métal','20',null),
	('Shear','Fighting',null,'Discard the top 5 cards of your deck. If any of those cards are Fighting Energy cards, attach them to this Pokémon.'),
	('Cru-Aile','IncoloreIncolore','40',null),
	('Gust','ColorlessColorless','20',null),
	('Crachat d’Acide','Obscurité','20','Le Pokémon Défenseur est maintenant Brûlé. Lancez une pièce. Si c’est face, le Pokémon Défenseur est aussi Paralysé.'),
	('Headbutt','Colorless','10',null),
	('Kesa-Gatame','CombatIncolore','30','Lancez une pièce. Si c''est face, le Pokémon Défenseur ne peut pas attaquer pendant le prochain tour de votre adversaire.'),
	('Low Kick','LightningColorless','20',null),
	('Appel à la Famille','Incolore',null,'Cherchez 2 Pokémon de base dans votre deck et placez-les sur votre Banc. Mélangez ensuite votre deck.'),
	('Tangle Drag','Colorless',null,'Switch 1 of your opponent''s Benched Pokémon with the Defending Pokémon.'),
	('Croc Ultratoxik','PsyIncoloreIncolore','40','Le Pokémon Défenseur est maintenant Empoisonné. Placez 4 marqueurs de dégâts au lieu d''un sur le Pokémon ciblé entre chaque tour.'),
	('Replace','Psychic',null,'Move as many Energy attached to your Pokémon to your other Pokémon in any way you like.'),
	('Fouets Croisés','Plante','30','Lancez 4 pièces. Cette attaque inflige 30 dégâts multipliés par le nombre de côtés face.'),
	('Lunge','FightingMetal','30','Flip a coin. If tails, this attack does nothing.'),
	('Grosse Bourrasque','IncoloreIncolore','30','S''il y a une carte Stade en jeu, cette attaque inflige 30 dégâts supplémentaires.'),
	('Soin','Incolore',null,'Défaussez une Énergie attachée à ce Pokémon et soignez tous les dégâts de ce Pokémon.'),
	('Rock Smash','ColorlessColorless','20','Flip a coin. If heads, this attack does 20 more damage.'),
	('Bite','WaterColorless','20',null),
	('Pression Énergétique','MétalIncolore','20','Inflige 20 dégâts supplémentaires pour chaque Énergie attachée au Pokémon Défenseur.'),
	('Kick','ColorlessColorless','20',null),
	('Déchiquetage','FeuEauIncoloreIncolore','90','Les dégâts de cette attaque ne sont affectés par aucun effet en action sur le Pokémon Défenseur.'),
	('X-Scissor','GrassColorless','20','Flip a coin. If heads, this attack does 50 more damage.'),
	('Son Destructeur','IncoloreIncoloreIncolore',null,'Votre adversaire montre sa main. Défaussez toutes les cartes Objet que vous y trouvez.'),
	('Draw In','Colorless',null,'Attach 2 Darkness Energy cards from your discard pile to this Pokémon.'),
	('Machination','Obscurité',null,'Cherchez une carte dans votre deck et ajoutez-la à votre main. Mélangez ensuite votre deck.'),
	('Deafen','ColorlessColorlessColorless','60','Your opponent can''t play any Item cards from his or her hand during his or her next turn.'),
	('Smack','ColorlessColorless','20',null),
	('Vortex Draconique','Incolore','20','Inflige 20 dégâts multipliés par le nombre de cartes Énergie Water et de cartes Énergie Lightning dans votre pile de défausse. Ensuite, mélangez toutes ces cartes avec votre deck.'),
	('Psychic','Psychic','10','Does 20 more damage for each Energy attached to the Defending Pokémon.'),
	('Para-Spore','Plante',null,'Lancez une pièce. Si c''est face, le Pokémon Défenseur est maintenant Paralysé.'),
	('Encore','Colorless','20','Choose 1 of the Defending Pokémon''s attacks. During your opponent''s next turn, that Pokémon can use only that attack.'),
	('Ultrason','Incolore',null,'Le Pokémon Défenseur est maintenant Confus.'),
	('Vol Supersonique','PsyIncolore','40','Le Pokémon Défenseur ne peut pas battre en retraite pendant le prochain tour de votre adversaire.'),
	('Double Hit','Colorless','10','Flip 2 coins. This attack does 10 damage times the number of heads.'),
	('Balayage','ÉlectriqueIncolore','20',null),
	('Cursed Drop','Psychic',null,'Put 3 damage counters on your opponent''s Pokémon in any way you like.'),
	('Hydrocanon','IncoloreIncoloreIncoloreIncolore','60','Inflige 10 dégâts supplémentaires pour chaque Énergie Water attachée à ce Pokémon.'),
	('Destructive Sound','ColorlessColorlessColorless',null,'Your opponent reveals his or her hand. Discard all Item cards you find there.'),
	('Mania','CombatCombatIncolore','70','Lancez une pièce. Si c''est face, cette attaque inflige 20 dégâts supplémentaires. Si c''est pile, ce Pokémon s''inflige 20 dégâts.'),
	('Dark Clamp','DarknessColorless','30','The Defending Pokémon can''t retreat during your opponent''s next turn.'),
	('Piqûre Psy','PsyIncolore','20',null),
	('Powerful Storm','ColorlessColorless','20','Does 20 damage times the amount of Energy attached to all of your Pokémon.'),
	('Devour','Metal',null,'For each of your Durant in play, discard the top card of your opponent''s deck.');

INSERT INTO P10_Attack(attackName,attackCost,attackDamage,attackEffect) VALUES 
	('Hypnoblast','ColorlessColorlessColorless','60','Flip a coin. If heads, the Defending Pokémon is now Asleep.'),
	('Tacle Feu','FeuFeuIncolore','50',null),
	('Piqûre Infernale','CombatIncolore','20','Lancez une pièce. Si c''est face, le Pokémon Défenseur est maintenant Paralysé.'),
	('Fouet Lianes','PlanteIncoloreIncolore','50',null),
	('Spiral Drain','GrassColorlessColorless','60','Heal 20 damage from this Pokémon.'),
	('Pistolet à O','EauIncoloreIncolore','30',null),
	('Shock Wave','LightningColorlessColorlessColorless','80','This attack''s damage isn''t affected by Resistance.'),
	('Peignée','IncoloreIncoloreIncoloreIncolore','80','Lancez une pièce. Si c’est pile, ce Pokémon s’inflige 20 dégâts.'),
	('Destruction','ÉlectriqueIncoloreIncolore','100','Ce Pokémon s''inflige 100 dégâts.'),
	('Chute de Glacier','EauEauIncolore','90','Défaussez la carte du dessus du deck de votre adversaire.'),
	('Icy Wind','WaterColorless','30','The Defending Pokémon is now Asleep.'),
	('Éclair Désastre','ÉlectriqueÉlectriqueIncolore','80','Défaussez une Énergie attachée à ce Pokémon.'),
	('Wreak Havoc','MetalMetalColorless','60','Flip a coin until you get tails. For each heads, discard the top card of your opponent''s deck.'),
	('Crèvecœur','PsyIncolore','40',null),
	('Super Psy Bolt','PsychicColorlessColorless','50',null),
	('Yoga','CombatIncolore','30','Inflige 10 dégâts supplémentaires pour chaque marqueur de dégâts placé sur le Pokémon Défenseur.'),
	('Leaf Wallop','GrassColorless','40','During your next turn, this Pokémon''s Leaf Wallop attack does 40 more damage (before applying Weakness and Resistance).'),
	('Piqûre Psy','PsyIncoloreIncolore','40',null),
	('Miracle Wing','PsychicColorlessColorless','60','Flip a coin. If heads, the Defending Pokémon is now Confused.'),
	('Dard-Nuée','PlantePlanteIncolore','20','Lancez 4 pièces. Cette attaque inflige 20 dégâts multipliés par le nombre de côtés face.'),
	('Mâchouille','ÉlectriqueÉlectriqueIncolore','80','Lancez une pièce. Si c''est face, défaussez une Énergie attachée au Pokémon Défenseur.'),
	('Night Slash','DarknessColorless','30','Switch this Pokémon with 1 of your Benched Pokémon.'),
	('Tête de Fer','MétalIncoloreIncolore','50','Lancez une pièce jusqu''à ce que vous obteniez un côté pile. Cette attaque inflige 50 dégâts multipliés par le nombre de côtés face.'),
	('Rock Bullet','ColorlessColorlessColorlessColorless','40','Does 20 more damage for each Fighting Energy attached to this Pokémon.'),
	('Rapace','IncoloreIncoloreIncolore','90','Ce Pokémon s''inflige 30 dégâts.'),
	('Pied Voltige','ObscuritéObscuritéIncolore','70',null),
	('Dragon Claw','FireWater','20',null),
	('Magnetic Blast','LightningColorlessColorless','50',null),
	('Feuille Sangsue','PlantePlante','30','Lancez une pièce. Si c''est face, soignez 30 dégâts à ce Pokémon.'),
	('Point Poison','PlanteIncoloreIncolore','60','Le Pokémon Défenseur est maintenant Empoisonné.'),
	('Violente Déflagration','IncoloreIncoloreIncolore','100','Lancez une pièce. Si c''est pile, défaussez une Énergie attachée à ce Pokémon.'),
	('Fire Punch','FireFireColorlessColorless','70','The Defending Pokémon is now Burned.'),
	('Brise-Fer','MétalMétalIncolore','80','Le Pokémon Défenseur ne peut pas attaquer pendant le prochain tour de votre adversaire.'),
	('Feint','FightingColorlessColorless','40','This attack''s damage isn''t affected by Resistance.'),
	('Reckless Charge','GrassColorlessColorless','80','This Pokémon does 10 damage to itself.'),
	('Chant Canon','IncoloreIncoloreIncoloreIncolore','50','Inflige 50 dégâts multipliés par le nombre de vos Pokémon possédant l''attaque Chant Canon.'),
	('Dragon Headbutt','PsychicDarknessColorless','40',null),
	('Tricherie','IncoloreIncolore',null,'Choisissez 1 des attaques du Pokémon Défenseur et utilisez-la à la place de cette attaque.'),
	('Healwing','GrassLightningColorlessColorless','90','Heal 30 damage from this Pokémon.'),
	('Psychic','PsychicColorlessColorless','40','Does 10 more damage for each Energy attached to the Defending Pokémon.'),
	('Triple Décharge','Eau',null,'Cette attaque inflige 30 dégâts à 3 des Pokémon de votre adversaire. (N''appliquez ni la Faiblesse ni la Résistance aux Pokémon de Banc.)'),
	('Echoed Voice','PsychicColorlessColorless','50','During your next turn, this Pokémon''s Echoed Voice attack does 50 more damage (before applying Weakness and Resistance).'),
	('Coupe','PlanteIncolore','20',null),
	('U-turn','GrassGrass','40','Switch this Pokémon with 1 of your Benched Pokémon.'),
	('Mégaphone','IncoloreIncoloreIncolore','50',null),
	('Lumi-Éclat','EauPsyIncolore','150','Défaussez toutes les Énergies attachées à ce Pokémon.'),
	('Explosion Magnétique','ÉlectriqueIncoloreIncolore','50',null),
	('Round','ColorlessColorlessColorlessColorless','50','Does 50 damage times the number of your Pokémon that have the Round attack.'),
	('Blazing Claws','DarknessColorlessColorless','60','If the Defending Pokémon is a Team Plasma Pokémon, this attack does 60 more damage, and the Defending Pokémon is now Burned.'),
	('Swift Lunge','PsychicColorlessColorless','80','Your opponent switches the Defending Pokémon with 1 of his or her Benched Pokémon.'),
	('Vice Grip','ColorlessColorless','30',null);

INSERT INTO P10_Resistance(resistanceType,resistanceValue) VALUES 
	('Combat','-20'),
	('Électrique','-20'),
	('Psychic','-20'),
	('Eau','-20'),
	('Water','-20'),
	('Psy','-20'),
	('Fighting','-20');

INSERT INTO P10_Weakness(weaknessType,weaknessValue) VALUES 
	('Fighting','×2'),
	('Électrique','×2'),
	('Eau','×2'),
	('Water','×2'),
	('Feu','×2'),
	('Fire','×2'),
	('Psy','×2'),
	('Combat','×2'),
	('Métal','×2'),
	('Metal','×2'),
	('Psychic','×2'),
	('Grass','×2'),
	('Obscurité','×2'),
	('Dragon','×2'),
	('Lightning','×2'),
	('Plante','×2');

INSERT INTO P10_Card(cardCategory,cardName,cardHP,cardRarity,cardImg,cardType,cardExtension,cardRetreat,cardLang,abilityId,resistanceId,weaknessId) VALUES
	('Dresseur','Multi Exp',null,'Peu Commune','https://assets.tcgdex.net/fr/bw/bw4/87/high.webp',null,'Destinées Futures',null,'fr',(SELECT abilityId FROM P10_Ability WHERE abilityEffect = 'Lorsque votre Pokémon Actif est mis K.O. par les dégâts d’une attaque de votre adversaire, vous pouvez déplacer 1 carte Énergie de base qui était attachée au Pokémon mis K.O. vers le Pokémon auquel cette carte est attachée.'),null,null),
	('Pokemon','Wigglytuff','90','Rare','https://assets.tcgdex.net/en/bw/bw4/79/high.webp','Colorless','Next Destinies',2,'en',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Fighting' AND weaknessValue = '×2'),null),
	('Énergie','Énergie Amalgamée GrassFirePsychicDarkness',null,'Peu Commune','https://assets.tcgdex.net/fr/bw/bw6/117/high.webp',null,'Dragons Éxaltés',null,'fr',(SELECT abilityId FROM P10_Ability WHERE abilityEffect = 'Cette carte fournit de l’Énergie Colorless. Lorsque cette carte est attachée à un Pokémon, cette carte fournit de l’Énergie Grass, Fire, Psychic ou Darkness mais ne fournit qu’une Énergie à la fois.'),null,null),
	('Trainer','Professor Juniper',null,'Uncommon','https://assets.tcgdex.net/en/bw/bw1/101/high.webp',null,'Black & White',null,'en',null,null,null),
	('Pokémon','Poichigeon','60','Commune','https://assets.tcgdex.net/fr/bw/bw7/123/high.webp','Incolore','Frontières Franchies',1,'fr',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Électrique' AND weaknessValue = '×2'),(SELECT resistanceId FROM P10_Resistance WHERE resistanceType = 'Combat' AND resistanceValue = '-20')),
	('Pokemon','Slaking','150','Rare','https://assets.tcgdex.net/en/bw/bw6/103/high.webp','Colorless','Dragons Exalted',4,'en',(SELECT abilityId FROM P10_Ability WHERE abilityName = 'Unobservant' AND abilityEffect = 'If your opponent’s Active Pokémon is a Basic Pokémon, this Pokémon can’t attack.'),(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Fighting' AND weaknessValue = '×2'),null),
	('Pokémon','Grotichon','100','Peu Commune','https://assets.tcgdex.net/fr/bw/bw1/17/high.webp','Feu','Noir & Blanc',3,'fr',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Eau' AND weaknessValue = '×2'),null),
	('Pokemon','Victini','70','Rare','https://assets.tcgdex.net/en/bw/bw3/15/high.webp','Fire','Noble Victories',1,'en',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Water' AND weaknessValue = '×2'),null),
	('Pokémon','Scorplane','70','Commune','https://assets.tcgdex.net/fr/bw/bw7/80/high.webp','Combat','Frontières Franchies',1,'fr',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Eau' AND weaknessValue = '×2'),(SELECT resistanceId FROM P10_Resistance WHERE resistanceType = 'Électrique' AND resistanceValue = '-20')),
	('Pokemon','Pawniard','50','Common','https://assets.tcgdex.net/en/bw/bw9/72/high.webp','Darkness','Plasma Freeze',1,'en',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Fighting' AND weaknessValue = '×2'),(SELECT resistanceId FROM P10_Resistance WHERE resistanceType = 'Psychic' AND resistanceValue = '-20')),
	('Pokémon','Saquedeneu','80','Commune','https://assets.tcgdex.net/fr/bw/bw7/5/high.webp','Plante','Frontières Franchies',2,'fr',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Feu' AND weaknessValue = '×2'),(SELECT resistanceId FROM P10_Resistance WHERE resistanceType = 'Eau' AND resistanceValue = '-20')),
	('Pokemon','Cradily','120','Rare','https://assets.tcgdex.net/en/bw/bw10/4/high.webp','Grass','Plasma Blast',2,'en',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Fire' AND weaknessValue = '×2'),(SELECT resistanceId FROM P10_Resistance WHERE resistanceType = 'Water' AND resistanceValue = '-20')),
	('Pokémon','Marill','70','Commune','https://assets.tcgdex.net/fr/bw/bw7/36/high.webp','Eau','Frontières Franchies',2,'fr',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Électrique' AND weaknessValue = '×2'),null),
	('Pokemon','Voltorb','60','Common','https://assets.tcgdex.net/en/bw/bw9/32/high.webp','Lightning','Plasma Freeze',1,'en',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Fighting' AND weaknessValue = '×2'),null),
	('Pokémon','Mushana','100','Rare','https://assets.tcgdex.net/fr/bw/bw4/59/high.webp','Psy','Destinées Futures',3,'fr',(SELECT abilityId FROM P10_Ability WHERE abilityName = 'Prédiction' AND abilityEffect = 'Une seule fois pendant votre tour (avant votre attaque), vous pouvez regarder les 2 cartes du dessus de votre deck, en choisir 1 et l’ajouter à votre main. Replacez l’autre carte sur le dessus de votre deck.'),(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Psy' AND weaknessValue = '×2'),null),
	('Pokemon','Electivire','120','Rare','https://assets.tcgdex.net/en/bw/bw7/54/high.webp','Lightning','Boundaries Crossed',3,'en',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Fighting' AND weaknessValue = '×2'),null),
	('Pokémon','Frison','100','Rare','https://assets.tcgdex.net/fr/bw/bw1/91/high.webp','Incolore','Noir & Blanc',2,'fr',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Combat' AND weaknessValue = '×2'),null),
	('Trainer','Plume Fossil',null,'Uncommon','https://assets.tcgdex.net/en/bw/bw10/82/high.webp',null,'Plasma Blast',null,'en',null,null,null),
	('Pokémon','Électrode','100','Commune','https://assets.tcgdex.net/fr/bw/bwp/BW76/high.webp','Électrique','Promo BW',null,'fr',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Combat' AND weaknessValue = '×2'),null),
	('Energy','Plasma Energy',null,'Uncommon','https://assets.tcgdex.net/en/bw/bw8/127/high.webp',null,'Plasma Storm',null,'en',null,null,null),
	('Pokémon','Polagriffe','130','Rare','https://assets.tcgdex.net/fr/bw/bw8/41/high.webp','Eau','Tempète Plasma',4,'fr',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Métal' AND weaknessValue = '×2'),null),
	('Pokemon','Delibird','80','Uncommon','https://assets.tcgdex.net/en/bw/bw7/38/high.webp','Water','Boundaries Crossed',1,'en',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Metal' AND weaknessValue = '×2'),null),
	('Pokémon','Fulguris','110','Ultra Rare','https://assets.tcgdex.net/fr/bw/bw2/97/high.webp','Électrique','Pouvoirs Émergents',1,'fr',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Combat' AND weaknessValue = '×2'),null),
	('Trainer','Heavy Ball',null,'Uncommon','https://assets.tcgdex.net/en/bw/bw4/88/high.webp',null,'Next Destinies',null,'en',null,null,null),
	('Pokémon','Ponchien','80','Peu Commune','https://assets.tcgdex.net/fr/bw/bw5/87/high.webp','Incolore','Explorateurs Obscurs',2,'fr',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Combat' AND weaknessValue = '×2'),null),
	('Pokemon','Lairon','90','Uncommon','https://assets.tcgdex.net/en/bw/bw6/79/high.webp','Metal','Dragons Exalted',3,'en',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Fire' AND weaknessValue = '×2'),(SELECT resistanceId FROM P10_Resistance WHERE resistanceType = 'Psychic' AND resistanceValue = '-20')),
	('Pokémon','Rhinolove','80','Peu Commune','https://assets.tcgdex.net/fr/bw/bw1/51/high.webp','Psy','Noir & Blanc',1,'fr',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Électrique' AND weaknessValue = '×2'),(SELECT resistanceId FROM P10_Resistance WHERE resistanceType = 'Combat' AND resistanceValue = '-20')),
	('Pokemon','Gothorita','80','Uncommon','https://assets.tcgdex.net/en/bw/bw2/46/high.webp','Psychic','Emerging Powers',1,'en',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Psychic' AND weaknessValue = '×2'),null),
	('Pokémon','Shaofouine','90','Peu Commune','https://assets.tcgdex.net/fr/bw/bw4/68/high.webp','Combat','Destinées Futures',1,'fr',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Psy' AND weaknessValue = '×2'),null),
	('Pokemon','Nosepass','80','Common','https://assets.tcgdex.net/en/bw/bw6/62/high.webp','Fighting','Dragons Exalted',2,'en',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Grass' AND weaknessValue = '×2'),null),
	('Pokémon','Victini','60','Rare','https://assets.tcgdex.net/fr/bw/bw3/14/high.webp','Feu','Nobles Victoires',1,'fr',(SELECT abilityId FROM P10_Ability WHERE abilityName = 'Victorieux' AND abilityEffect = 'Une seule fois pendant votre tour, après avoir lancé des pièces pour une attaque, vous pouvez ignorer les effets de ces lancers de pièce et lancer ces pièces à nouveau. Vous ne pouvez pas utiliser la capacité spéciale Victorieux plus d’une fois par tour.'),(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Eau' AND weaknessValue = '×2'),null),
	('Pokemon','Dwebble','60','Common','https://assets.tcgdex.net/en/bw/bw11/13/high.webp','Grass','Legendary Treasures',2,'en',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Fire' AND weaknessValue = '×2'),null),
	('Pokémon','Lugulabre','130','Rare','https://assets.tcgdex.net/fr/bw/bw9/16/high.webp','Feu','Glaciation Plasma',2,'fr',(SELECT abilityId FROM P10_Ability WHERE abilityName = 'Navigation Flamboyante' AND abilityEffect = 'Une seule fois pendant votre tour (avant votre attaque), vous pouvez chercher une carte Énergie Fire dans votre deck et l''attacher à 1 de vos Pokémon. Dans ce cas, placez 1 marqueur de dégâts sur le Pokémon auquel l''Énergie a été attachée. Mélangez ensuite votre deck.'),(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Eau' AND weaknessValue = '×2'),null),
	('Pokemon','Virizion','110','Rare','https://assets.tcgdex.net/en/bw/bw11/15/high.webp','Grass','Legendary Treasures',1,'en',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Fire' AND weaknessValue = '×2'),(SELECT resistanceId FROM P10_Resistance WHERE resistanceType = 'Water' AND resistanceValue = '-20')),
	('Pokémon','Téraclope','80','Peu Commune','https://assets.tcgdex.net/fr/bw/bw7/62/high.webp','Psy','Frontières Franchies',2,'fr',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Obscurité' AND weaknessValue = '×2'),null),
	('Pokemon','Xatu','90','Rare','https://assets.tcgdex.net/en/bw/bw11/56/high.webp','Psychic','Legendary Treasures',1,'en',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Psychic' AND weaknessValue = '×2'),null),
	('Pokémon','Maracachi','80','Peu Commune','https://assets.tcgdex.net/fr/bw/bw1/11/high.webp','Plante','Noir & Blanc',2,'fr',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Feu' AND weaknessValue = '×2'),(SELECT resistanceId FROM P10_Resistance WHERE resistanceType = 'Eau' AND resistanceValue = '-20')),
	('Pokemon','Shelmet','60','Common','https://assets.tcgdex.net/en/bw/bw5/10/high.webp','Grass','Dark Explorers',3,'en',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Fire' AND weaknessValue = '×2'),null),
	('Pokémon','Altaria','70','Commune','https://assets.tcgdex.net/fr/bw/bwp/BW48/high.webp','Dragon','Promo BW',1,'fr',(SELECT abilityId FROM P10_Ability WHERE abilityName = 'Hymne au Combat' AND abilityEffect = 'Les attaques de vos Pokémon Dragon infligent 20 dégâts supplémentaires aux Pokémon Actifs (avant application de la Faiblesse et de la Résistance).'),(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Dragon' AND weaknessValue = '×2'),null),
	('Pokemon','Garbodor','100','Secret Rare','https://assets.tcgdex.net/en/bw/bw9/119/high.webp','Psychic','Plasma Freeze',3,'en',(SELECT abilityId FROM P10_Ability WHERE abilityName = 'Garbotoxin' AND abilityEffect = 'If this Pokémon has a Pokémon Tool card attached to it, each Pokémon in play, in each player’s hand, and in each player’s discard pile has no Abilities (except for Garbotoxin).'),(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Psychic' AND weaknessValue = '×2'),null),
	('Pokémon','Darkrai-EX','180','Ultra Rare','https://assets.tcgdex.net/fr/bw/bw5/107/high.webp','Obscurité','Explorateurs Obscurs',2,'fr',(SELECT abilityId FROM P10_Ability WHERE abilityName = 'Cape Obscure' AND abilityEffect = 'Chacun de vos Pokémon auquel de l’Énergie Darkness est attachée n’a pas de coût de Retraite.'),(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Combat' AND weaknessValue = '×2'),(SELECT resistanceId FROM P10_Resistance WHERE resistanceType = 'Psy' AND resistanceValue = '-20')),
	('Trainer','PlusPower',null,'Uncommon','https://assets.tcgdex.net/en/bw/bw1/96/high.webp',null,'Black & White',null,'en',null,null,null),
	('Pokémon','Luxray','140','Rare','https://assets.tcgdex.net/fr/bw/bw4/46/high.webp','Électrique','Destinées Futures',1,'fr',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Combat' AND weaknessValue = '×2'),null),
	('Pokemon','Electrike','60','Common','https://assets.tcgdex.net/en/bw/bw6/42/high.webp','Lightning','Dragons Exalted',1,'en',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Fighting' AND weaknessValue = '×2'),null),
	('Pokémon','Chovsourir','60','Commune','https://assets.tcgdex.net/fr/bw/bw2/36/high.webp','Psy','Pouvoirs Émergents',1,'fr',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Psy' AND weaknessValue = '×2'),null),
	('Pokemon','Psyduck','70','Common','https://assets.tcgdex.net/en/bw/bw7/33/high.webp','Water','Boundaries Crossed',3,'en',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Lightning' AND weaknessValue = '×2'),null),
	('Pokémon','Altaria','70','Rare','https://assets.tcgdex.net/fr/bw/bw6/84/high.webp','Dragon','Dragons Éxaltés',1,'fr',(SELECT abilityId FROM P10_Ability WHERE abilityName = 'Hymne au Combat' AND abilityEffect = 'Les attaques de vos Pokémon Dragon infligent 20 dégâts supplémentaires aux Pokémon Actifs (avant application de la Faiblesse et de la Résistance).'),(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Dragon' AND weaknessValue = '×2'),null),
	('Pokemon','Bisharp','90','Uncommon','https://assets.tcgdex.net/en/bw/bw3/76/high.webp','Darkness','Noble Victories',1,'en',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Fighting' AND weaknessValue = '×2'),(SELECT resistanceId FROM P10_Resistance WHERE resistanceType = 'Psychic' AND resistanceValue = '-20')),
	('Pokémon','Galegon','90','Peu Commune','https://assets.tcgdex.net/fr/bw/bw10/58/high.webp','Métal','Explosion Plasma',4,'fr',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Feu' AND weaknessValue = '×2'),(SELECT resistanceId FROM P10_Resistance WHERE resistanceType = 'Psy' AND resistanceValue = '-20')),
	('Pokemon','Gigalith','140','Rare','https://assets.tcgdex.net/en/bw/bw2/53/high.webp','Fighting','Emerging Powers',4,'en',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Grass' AND weaknessValue = '×2'),null),
	('Pokémon','Gueriaigle','100','Rare','https://assets.tcgdex.net/fr/bw/bw2/88/high.webp','Incolore','Pouvoirs Émergents',1,'fr',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Électrique' AND weaknessValue = '×2'),(SELECT resistanceId FROM P10_Resistance WHERE resistanceType = 'Combat' AND resistanceValue = '-20')),
	('Pokemon','Pidove','50','Common','https://assets.tcgdex.net/en/bw/bw2/80/high.webp','Colorless','Emerging Powers',1,'en',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Lightning' AND weaknessValue = '×2'),(SELECT resistanceId FROM P10_Resistance WHERE resistanceType = 'Fighting' AND resistanceValue = '-20')),
	('Pokémon','Baggaïd','90','Rare','https://assets.tcgdex.net/fr/bw/bw1/69/high.webp','Obscurité','Noir & Blanc',1,'fr',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Combat' AND weaknessValue = '×2'),(SELECT resistanceId FROM P10_Resistance WHERE resistanceType = 'Psy' AND resistanceValue = '-20')),
	('Pokemon','Bagon','50','Common','https://assets.tcgdex.net/en/bw/bw10/62/high.webp','Dragon','Plasma Blast',1,'en',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Dragon' AND weaknessValue = '×2'),null),
	('Pokémon','Judokrak','90','Peu Commune','https://assets.tcgdex.net/fr/bw/bw2/58/high.webp','Combat','Pouvoirs Émergents',2,'fr',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Psy' AND weaknessValue = '×2'),null),
	('Pokemon','Electabuzz','80','Common','https://assets.tcgdex.net/en/bw/bw7/53/high.webp','Lightning','Boundaries Crossed',2,'en',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Fighting' AND weaknessValue = '×2'),null),
	('Pokémon','Shaymin','70','Rare','https://assets.tcgdex.net/fr/bw/bw7/10/high.webp','Plante','Frontières Franchies',1,'fr',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Feu' AND weaknessValue = '×2'),null),
	('Pokemon','Cascoon','80','Uncommon','https://assets.tcgdex.net/en/bw/bw6/9/high.webp','Grass','Dragons Exalted',3,'en',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Fire' AND weaknessValue = '×2'),null),
	('Dresseur','Multi Exp',null,'Peu Commune','https://assets.tcgdex.net/fr/bw/bw4/87/high.webp',null,'Destinées Futures',null,'fr',(SELECT abilityId FROM P10_Ability WHERE abilityEffect = 'Lorsque votre Pokémon Actif est mis K.O. par les dégâts d’une attaque de votre adversaire, vous pouvez déplacer 1 carte Énergie de base qui était attachée au Pokémon mis K.O. vers le Pokémon auquel cette carte est attachée.'),null,null),
	('Pokemon','Wigglytuff','90','Rare','https://assets.tcgdex.net/en/bw/bw4/79/high.webp','Colorless','Next Destinies',2,'en',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Fighting' AND weaknessValue = '×2'),null),
	('Pokémon','Nostenfer','130','Rare','https://assets.tcgdex.net/fr/bw/bwp/BW51/high.webp','Psy','Promo BW',null,'fr',(SELECT abilityId FROM P10_Ability WHERE abilityName = 'Vision de Nuit' AND abilityEffect = 'Une seule fois pendant votre tour (avant votre attaque), vous pouvez piocher une carte.'),(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Électrique' AND weaknessValue = '×2'),(SELECT resistanceId FROM P10_Resistance WHERE resistanceType = 'Combat' AND resistanceValue = '-20')),
	('Pokemon','Mew-EX','120','Ultra Rare','https://assets.tcgdex.net/en/bw/bw6/120/high.webp','Psychic','Dragons Exalted',1,'en',(SELECT abilityId FROM P10_Ability WHERE abilityName = 'Versatile' AND abilityEffect = 'This Pokémon can use the attacks of any Pokémon in play (both yours and your opponent’s). (You still need the necessary Energy to use each attack.)'),(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Psychic' AND weaknessValue = '×2'),null),
	('Pokémon','Roserade','90','Peu Commune','https://assets.tcgdex.net/fr/bw/bw6/14/high.webp','Plante','Dragons Éxaltés',1,'fr',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Feu' AND weaknessValue = '×2'),(SELECT resistanceId FROM P10_Resistance WHERE resistanceType = 'Eau' AND resistanceValue = '-20')),
	('Pokemon','Axew','50','Rare','/high.webp','Dragon','Dragon Vault',1,'en',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Dragon' AND weaknessValue = '×2'),null),
	('Pokémon','Boréas ex','170','Commune','https://assets.tcgdex.net/fr/bw/bwp/BW96/high.webp','Incolore','Promo BW',1,'fr',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Électrique' AND weaknessValue = '×2'),(SELECT resistanceId FROM P10_Resistance WHERE resistanceType = 'Combat' AND resistanceValue = '-20')),
	('Trainer','Town Map',null,'Uncommon','https://assets.tcgdex.net/en/bw/bw7/136/high.webp',null,'Boundaries Crossed',null,'en',null,null,null),
	('Pokémon','Stari','60','Commune','https://assets.tcgdex.net/fr/bw/bw4/23/high.webp','Eau','Destinées Futures',1,'fr',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Électrique' AND weaknessValue = '×2'),null),
	('Pokemon','Darmanitan','100','Rare','https://assets.tcgdex.net/en/bw/bw2/21/high.webp','Fire','Emerging Powers',3,'en',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Water' AND weaknessValue = '×2'),null),
	('Pokémon','Lakmécygne','90','Rare','https://assets.tcgdex.net/fr/bw/bw5/36/high.webp','Eau','Explorateurs Obscurs',1,'fr',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Électrique' AND weaknessValue = '×2'),(SELECT resistanceId FROM P10_Resistance WHERE resistanceType = 'Combat' AND resistanceValue = '-20')),
	('Pokemon','Carvanha','60','Common','https://assets.tcgdex.net/en/bw/bw8/32/high.webp','Water','Plasma Storm',1,'en',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Lightning' AND weaknessValue = '×2'),null),
	('Pokémon','Cobaltium','120','Rare','https://assets.tcgdex.net/fr/bw/bw3/84/high.webp','Métal','Nobles Victoires',2,'fr',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Feu' AND weaknessValue = '×2'),(SELECT resistanceId FROM P10_Resistance WHERE resistanceType = 'Psy' AND resistanceValue = '-20')),
	('Pokemon','Riolu','70','Common','https://assets.tcgdex.net/en/bw/bw8/76/high.webp','Fighting','Plasma Storm',1,'en',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Psychic' AND weaknessValue = '×2'),null),
	('Pokémon','Drattak','140','Rare','https://assets.tcgdex.net/fr/bw/dv1/8/high.webp','Dragon','Coffre des Dragons',2,'fr',(SELECT abilityId FROM P10_Ability WHERE abilityName = 'Vent Méprisant' AND abilityEffect = 'Une seule fois pendant votre tour (avant votre attaque), vous pouvez demander à votre adversaire de défausser des cartes de sa main jusqu''à ce qu''il ne reste que 4 cartes dans sa main.'),(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Dragon' AND weaknessValue = '×2'),null),
	('Pokemon','Crustle','100','Uncommon','https://assets.tcgdex.net/en/bw/bw3/7/high.webp','Grass','Noble Victories',3,'en',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Fire' AND weaknessValue = '×2'),null),
	('Pokémon','Brouhabam','140','Rare','https://assets.tcgdex.net/fr/bw/bw8/107/high.webp','Incolore','Tempète Plasma',4,'fr',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Combat' AND weaknessValue = '×2'),null),
	('Pokemon','Zweilous','90','Uncommon','https://assets.tcgdex.net/en/bw/bw6/96/high.webp','Dragon','Dragons Exalted',3,'en',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Dragon' AND weaknessValue = '×2'),null),
	('Pokémon','Zoroark','100','Rare','https://assets.tcgdex.net/fr/bw/bwp/BW09/high.webp','Obscurité','Promo BW',1,'fr',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Combat' AND weaknessValue = '×2'),(SELECT resistanceId FROM P10_Resistance WHERE resistanceType = 'Psy' AND resistanceValue = '-20')),
	('Trainer','Crushing Hammer',null,'Uncommon','https://assets.tcgdex.net/en/bw/bw11/111/high.webp',null,'Legendary Treasures',null,'en',null,null,null),
	('Dresseur','Griffe Obscure',null,'Peu Commune','https://assets.tcgdex.net/fr/bw/bw5/92/high.webp',null,'Explorateurs Obscurs',null,'fr',(SELECT abilityId FROM P10_Ability WHERE abilityEffect = 'Si cette carte est attachée à un Pokémon Darkness, chacune de ses attaques inflige 20 dégâts supplémentaires aux Pokémon Actifs (avant application de la Faiblesse et de la Résistance).'),null,null),
	('Pokemon','Dragonite','150','Rare','https://assets.tcgdex.net/en/bw/bw9/83/high.webp','Dragon','Plasma Freeze',3,'en',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Dragon' AND weaknessValue = '×2'),null),
	('Pokémon','Ténéfix','70','Peu Commune','https://assets.tcgdex.net/fr/bw/bw5/62/high.webp','Obscurité','Explorateurs Obscurs',1,'fr',null,null,null),
	('Pokemon','Kirlia','80','Uncommon','https://assets.tcgdex.net/en/bw/bw4/56/high.webp','Psychic','Next Destinies',1,'en',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Psychic' AND weaknessValue = '×2'),null),
	('Pokémon','Hyporoi','140','Rare','https://assets.tcgdex.net/fr/bw/bw9/84/high.webp','Dragon','Glaciation Plasma',1,'fr',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Dragon' AND weaknessValue = '×2'),null),
	('Pokemon','Meloetta','80','Rare','https://assets.tcgdex.net/en/bw/bw7/77/high.webp','Psychic','Boundaries Crossed',1,'en',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Psychic' AND weaknessValue = '×2'),null),
	('Pokémon','Chlorobule','50','Commune','https://assets.tcgdex.net/fr/bw/bw2/13/high.webp','Plante','Pouvoirs Émergents',1,'fr',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Feu' AND weaknessValue = '×2'),(SELECT resistanceId FROM P10_Resistance WHERE resistanceType = 'Eau' AND resistanceValue = '-20')),
	('Pokemon','Whimsicott','80','Rare','https://assets.tcgdex.net/en/bw/bw2/12/high.webp','Grass','Emerging Powers',1,'en',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Fire' AND weaknessValue = '×2'),(SELECT resistanceId FROM P10_Resistance WHERE resistanceType = 'Water' AND resistanceValue = '-20')),
	('Pokémon','Ramboum','90','Peu Commune','https://assets.tcgdex.net/fr/bw/bw8/106/high.webp','Incolore','Tempète Plasma',3,'fr',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Combat' AND weaknessValue = '×2'),null),
	('Trainer','Scoop Up Cyclone',null,'Rare','https://assets.tcgdex.net/en/bw/bw10/95/high.webp',null,'Plasma Blast',null,'en',null,null,null),
	('Pokémon','Latios-EX','170','Ultra Rare','https://assets.tcgdex.net/fr/bw/bw9/113/high.webp','Dragon','Glaciation Plasma',2,'fr',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Dragon' AND weaknessValue = '×2'),null),
	('Pokemon','Aipom','60','Common','https://assets.tcgdex.net/en/bw/bw6/99/high.webp','Colorless','Dragons Exalted',1,'en',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Fighting' AND weaknessValue = '×2'),null),
	('Pokémon','Élektek','80','Commune','https://assets.tcgdex.net/fr/bw/bw7/53/high.webp','Électrique','Frontières Franchies',2,'fr',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Combat' AND weaknessValue = '×2'),null),
	('Pokemon','Shedinja','60','Rare','https://assets.tcgdex.net/en/bw/bw6/48/high.webp','Psychic','Dragons Exalted',0,'en',(SELECT abilityId FROM P10_Ability WHERE abilityName = 'Empty Shell' AND abilityEffect = 'If this Pokémon is Knocked Out, your opponent can’t take any Prize cards for it.'),null,null),
	('Pokémon','Tortank','140','Magnifique rare','https://assets.tcgdex.net/fr/bw/bw8/137/high.webp','Eau','Tempète Plasma',4,'fr',(SELECT abilityId FROM P10_Ability WHERE abilityName = 'Déluge' AND abilityEffect = 'Autant de fois que vous le voulez pendant votre tour (avant votre attaque), vous pouvez attacher une carte Énergie Water de votre main à 1 de vos Pokémon.'),(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Plante' AND weaknessValue = '×2'),null),
	('Pokemon','Exploud','140','Rare','https://assets.tcgdex.net/en/bw/bw8/107/high.webp','Colorless','Plasma Storm',4,'en',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Fighting' AND weaknessValue = '×2'),null),
	('Pokémon','Crocorible','140','Rare','https://assets.tcgdex.net/fr/bw/bw2/62/high.webp','Combat','Pouvoirs Émergents',3,'fr',(SELECT abilityId FROM P10_Ability WHERE abilityName = 'Œil Noir' AND abilityEffect = 'Une seule fois pendant votre tour (avant votre attaque), si ce Pokémon est votre Pokémon Actif, vous pouvez lancer une pièce. Si c’est face, défaussez une Énergie attachée au Pokémon Actif de votre adversaire.'),(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Eau' AND weaknessValue = '×2'),(SELECT resistanceId FROM P10_Resistance WHERE resistanceType = 'Électrique' AND resistanceValue = '-20')),
	('Pokemon','Houndoom','100','Rare','https://assets.tcgdex.net/en/bw/bw10/56/high.webp','Darkness','Plasma Blast',1,'en',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Fighting' AND weaknessValue = '×2'),(SELECT resistanceId FROM P10_Resistance WHERE resistanceType = 'Psychic' AND resistanceValue = '-20')),
	('Pokémon','Munna','60','Peu Commune','https://assets.tcgdex.net/fr/bw/bw7/68/high.webp','Psy','Frontières Franchies',2,'fr',(SELECT abilityId FROM P10_Ability WHERE abilityName = 'Téléhypnose' AND abilityEffect = 'Une seule fois pendant votre tour (avant votre attaque), vous pouvez lancer une pièce. Si c’est face, le Pokémon Actif de votre adversaire est maintenant Endormi. Si c’est pile, votre Pokémon Actif est maintenant Endormi.'),(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Psy' AND weaknessValue = '×2'),null),
	('Pokemon','Gallade','140','Rare','https://assets.tcgdex.net/en/bw/bw8/61/high.webp','Psychic','Plasma Storm',2,'en',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Psychic' AND weaknessValue = '×2'),null),
	('Dresseur','Récupération d’Énergie',null,'Peu Commune','https://assets.tcgdex.net/fr/bw/bw1/92/high.webp',null,'Noir & Blanc',null,'fr',(SELECT abilityId FROM P10_Ability WHERE abilityEffect = 'Prenez 2 cartes Énergie de base dans votre pile de défausse et ajoutez-les à votre main.'),null,null),
	('Pokemon','Durant','70','Uncommon','https://assets.tcgdex.net/en/bw/bw3/83/high.webp','Metal','Noble Victories',1,'en',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Fire' AND weaknessValue = '×2'),(SELECT resistanceId FROM P10_Resistance WHERE resistanceType = 'Psychic' AND resistanceValue = '-20'));

INSERT INTO P10_Contient(cardId, attackId) VALUES
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/en/bw/bw4/79/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Round' AND attackCost = 'ColorlessColorless' AND attackDamage = '20'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/en/bw/bw4/79/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Hypnoblast' AND attackCost = 'ColorlessColorlessColorless' AND attackDamage = '60'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/fr/bw/bw7/123/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Coupe-Vent' AND attackCost = 'IncoloreIncolore' AND attackDamage = '30'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/en/bw/bw6/103/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Crushing Blow' AND attackCost = 'ColorlessColorlessColorlessColorless' AND attackDamage = '100'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/fr/bw/bw1/17/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Nitrocharge' AND attackCost = 'Incolore' AND attackDamage = null))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/fr/bw/bw1/17/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Tacle Feu' AND attackCost = 'FeuFeuIncolore' AND attackDamage = '50'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/en/bw/bw3/15/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'V-create' AND attackCost = 'FireColorless' AND attackDamage = '100'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/fr/bw/bw7/80/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Coup de Queue' AND attackCost = 'Combat' AND attackDamage = '10'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/fr/bw/bw7/80/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Piqûre Infernale' AND attackCost = 'CombatIncolore' AND attackDamage = '20'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/en/bw/bw9/72/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Cut' AND attackCost = 'DarknessColorless' AND attackDamage = '30'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/fr/bw/bw7/5/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Tit''Sieste' AND attackCost = 'Plante' AND attackDamage = null))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/fr/bw/bw7/5/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Fouet Lianes' AND attackCost = 'PlanteIncoloreIncolore' AND attackDamage = '50'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/en/bw/bw10/4/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Lifesplosion' AND attackCost = 'Grass' AND attackDamage = null))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/en/bw/bw10/4/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Spiral Drain' AND attackCost = 'GrassColorlessColorless' AND attackDamage = '60'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/fr/bw/bw7/36/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Roulade' AND attackCost = 'IncoloreIncolore' AND attackDamage = '20'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/fr/bw/bw7/36/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Pistolet à O' AND attackCost = 'EauIncoloreIncolore' AND attackDamage = '30'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/en/bw/bw9/32/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Rollout' AND attackCost = 'LightningColorless' AND attackDamage = '20'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/fr/bw/bw4/59/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Rêve Douillet' AND attackCost = 'PsyPsy' AND attackDamage = '40'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/en/bw/bw7/54/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Electriwave' AND attackCost = 'LightningColorlessColorless' AND attackDamage = null))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/en/bw/bw7/54/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Shock Wave' AND attackCost = 'LightningColorlessColorlessColorless' AND attackDamage = '80'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/fr/bw/bw1/91/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Vendetta' AND attackCost = 'IncoloreIncolore' AND attackDamage = '20'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/fr/bw/bw1/91/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Peignée' AND attackCost = 'IncoloreIncoloreIncoloreIncolore' AND attackDamage = '80'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/fr/bw/bwp/BW76/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Rayon Électrique' AND attackCost = 'Électrique' AND attackDamage = '20'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/fr/bw/bwp/BW76/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Destruction' AND attackCost = 'ÉlectriqueIncoloreIncolore' AND attackDamage = '100'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/fr/bw/bw8/41/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Rage Massive' AND attackCost = 'EauIncolore' AND attackDamage = '20'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/fr/bw/bw8/41/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Chute de Glacier' AND attackCost = 'EauEauIncolore' AND attackDamage = '90'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/en/bw/bw7/38/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Present' AND attackCost = 'Colorless' AND attackDamage = null))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/en/bw/bw7/38/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Icy Wind' AND attackCost = 'WaterColorless' AND attackDamage = '30'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/fr/bw/bw2/97/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Chargeur' AND attackCost = 'Incolore' AND attackDamage = null))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/fr/bw/bw2/97/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Éclair Désastre' AND attackCost = 'ÉlectriqueÉlectriqueIncolore' AND attackDamage = '80'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/en/bw/bw6/79/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Metal Claw' AND attackCost = 'MetalColorless' AND attackDamage = '30'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/en/bw/bw6/79/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Wreak Havoc' AND attackCost = 'MetalMetalColorless' AND attackDamage = '60'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/fr/bw/bw1/51/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Attraction' AND attackCost = 'Incolore' AND attackDamage = null))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/fr/bw/bw1/51/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Crèvecœur' AND attackCost = 'PsyIncolore' AND attackDamage = '40'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/en/bw/bw2/46/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Deleting Glare' AND attackCost = 'Psychic' AND attackDamage = null))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/en/bw/bw2/46/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Super Psy Bolt' AND attackCost = 'PsychicColorlessColorless' AND attackDamage = '50'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/fr/bw/bw4/68/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Mainmise' AND attackCost = 'Incolore' AND attackDamage = null))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/fr/bw/bw4/68/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Yoga' AND attackCost = 'CombatIncolore' AND attackDamage = '30'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/en/bw/bw6/62/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Rock Throw' AND attackCost = 'ColorlessColorless' AND attackDamage = '20'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/fr/bw/bw3/14/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Force Ajoutée' AND attackCost = 'FeuIncolore' AND attackDamage = '30'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/en/bw/bw11/13/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Bug Bite' AND attackCost = 'GrassColorless' AND attackDamage = '20'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/fr/bw/bw9/16/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Absorption' AND attackCost = 'FeuFeuIncolore' AND attackDamage = '70'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/en/bw/bw11/15/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Double Draw' AND attackCost = 'Colorless' AND attackDamage = null))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/en/bw/bw11/15/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Leaf Wallop' AND attackCost = 'GrassColorless' AND attackDamage = '40'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/fr/bw/bw7/62/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Étonnement' AND attackCost = 'Psy' AND attackDamage = null))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/fr/bw/bw7/62/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Piqûre Psy' AND attackCost = 'PsyIncoloreIncolore' AND attackDamage = '40'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/en/bw/bw11/56/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Fortunate Draw' AND attackCost = 'Psychic' AND attackDamage = null))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/en/bw/bw11/56/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Miracle Wing' AND attackCost = 'PsychicColorlessColorless' AND attackDamage = '60'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/fr/bw/bw1/11/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Méga-Sangsue' AND attackCost = 'Plante' AND attackDamage = '20'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/fr/bw/bw1/11/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Dard-Nuée' AND attackCost = 'PlantePlanteIncolore' AND attackDamage = '20'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/en/bw/bw5/10/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Body Slam' AND attackCost = 'GrassGrass' AND attackDamage = '20'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/fr/bw/bwp/BW48/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Glissement' AND attackCost = 'EauMétalIncolore' AND attackDamage = '40'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/en/bw/bw9/119/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Sludge Toss' AND attackCost = 'PsychicPsychicColorless' AND attackDamage = '60'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/fr/bw/bw4/46/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Impact-Flash' AND attackCost = 'Électrique' AND attackDamage = '60'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/fr/bw/bw4/46/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Mâchouille' AND attackCost = 'ÉlectriqueÉlectriqueIncolore' AND attackDamage = '80'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/en/bw/bw6/42/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Quick Turn' AND attackCost = 'LightningColorless' AND attackDamage = '20'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/fr/bw/bw2/36/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Choc Mental' AND attackCost = 'PsyIncolore' AND attackDamage = '20'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/en/bw/bw7/33/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Firefighting' AND attackCost = 'Water' AND attackDamage = null))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/fr/bw/bw6/84/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Glissement' AND attackCost = 'EauMétalIncolore' AND attackDamage = '40'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/en/bw/bw3/76/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Finishing Blow' AND attackCost = 'Darkness' AND attackDamage = '20'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/en/bw/bw3/76/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Night Slash' AND attackCost = 'DarknessColorless' AND attackDamage = '30'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/fr/bw/bw10/58/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Griffe Acier' AND attackCost = 'Métal' AND attackDamage = '20'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/fr/bw/bw10/58/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Tête de Fer' AND attackCost = 'MétalIncoloreIncolore' AND attackDamage = '50'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/en/bw/bw2/53/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Shear' AND attackCost = 'Fighting' AND attackDamage = null))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/en/bw/bw2/53/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Rock Bullet' AND attackCost = 'ColorlessColorlessColorlessColorless' AND attackDamage = '40'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/fr/bw/bw2/88/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Cru-Aile' AND attackCost = 'IncoloreIncolore' AND attackDamage = '40'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/fr/bw/bw2/88/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Rapace' AND attackCost = 'IncoloreIncoloreIncolore' AND attackDamage = '90'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/en/bw/bw2/80/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Gust' AND attackCost = 'ColorlessColorless' AND attackDamage = '20'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/fr/bw/bw1/69/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Crachat d’Acide' AND attackCost = 'Obscurité' AND attackDamage = '20'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/fr/bw/bw1/69/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Pied Voltige' AND attackCost = 'ObscuritéObscuritéIncolore' AND attackDamage = '70'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/en/bw/bw10/62/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Headbutt' AND attackCost = 'Colorless' AND attackDamage = '10'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/en/bw/bw10/62/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Dragon Claw' AND attackCost = 'FireWater' AND attackDamage = '20'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/fr/bw/bw2/58/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Kesa-Gatame' AND attackCost = 'CombatIncolore' AND attackDamage = '30'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/en/bw/bw7/53/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Low Kick' AND attackCost = 'LightningColorless' AND attackDamage = '20'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/en/bw/bw7/53/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Magnetic Blast' AND attackCost = 'LightningColorlessColorless' AND attackDamage = '50'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/fr/bw/bw7/10/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Appel à la Famille' AND attackCost = 'Incolore' AND attackDamage = null))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/fr/bw/bw7/10/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Feuille Sangsue' AND attackCost = 'PlantePlante' AND attackDamage = '30'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/en/bw/bw6/9/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Tangle Drag' AND attackCost = 'Colorless' AND attackDamage = null))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/en/bw/bw6/9/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Spiral Drain' AND attackCost = 'ColorlessColorless' AND attackDamage = '20'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/en/bw/bw4/79/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Round' AND attackCost = 'ColorlessColorless' AND attackDamage = '20'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/en/bw/bw4/79/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Hypnoblast' AND attackCost = 'ColorlessColorlessColorless' AND attackDamage = '60'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/fr/bw/bwp/BW51/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Croc Ultratoxik' AND attackCost = 'PsyIncoloreIncolore' AND attackDamage = '40'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/en/bw/bw6/120/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Replace' AND attackCost = 'Psychic' AND attackDamage = null))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/fr/bw/bw6/14/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Fouets Croisés' AND attackCost = 'Plante' AND attackDamage = '30'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/fr/bw/bw6/14/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Point Poison' AND attackCost = 'PlanteIncoloreIncolore' AND attackDamage = '60'))
	((SELECT cardId FROM P10_Card WHERE cardImg = '/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Lunge' AND attackCost = 'FightingMetal' AND attackDamage = '30'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/fr/bw/bwp/BW96/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Grosse Bourrasque' AND attackCost = 'IncoloreIncolore' AND attackDamage = '30'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/fr/bw/bwp/BW96/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Violente Déflagration' AND attackCost = 'IncoloreIncoloreIncolore' AND attackDamage = '100'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/fr/bw/bw4/23/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Soin' AND attackCost = 'Incolore' AND attackDamage = null))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/fr/bw/bw4/23/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Pistolet à O' AND attackCost = 'Eau' AND attackDamage = '10'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/en/bw/bw2/21/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Rock Smash' AND attackCost = 'ColorlessColorless' AND attackDamage = '20'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/en/bw/bw2/21/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Fire Punch' AND attackCost = 'FireFireColorlessColorless' AND attackDamage = '70'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/en/bw/bw8/32/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Bite' AND attackCost = 'WaterColorless' AND attackDamage = '20'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/fr/bw/bw3/84/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Pression Énergétique' AND attackCost = 'MétalIncolore' AND attackDamage = '20'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/fr/bw/bw3/84/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Brise-Fer' AND attackCost = 'MétalMétalIncolore' AND attackDamage = '80'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/en/bw/bw8/76/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Kick' AND attackCost = 'ColorlessColorless' AND attackDamage = '20'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/en/bw/bw8/76/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Feint' AND attackCost = 'FightingColorlessColorless' AND attackDamage = '40'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/fr/bw/dv1/8/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Déchiquetage' AND attackCost = 'FeuEauIncoloreIncolore' AND attackDamage = '90'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/en/bw/bw3/7/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'X-Scissor' AND attackCost = 'GrassColorless' AND attackDamage = '20'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/en/bw/bw3/7/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Reckless Charge' AND attackCost = 'GrassColorlessColorless' AND attackDamage = '80'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/fr/bw/bw8/107/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Son Destructeur' AND attackCost = 'IncoloreIncoloreIncolore' AND attackDamage = null))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/fr/bw/bw8/107/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Chant Canon' AND attackCost = 'IncoloreIncoloreIncoloreIncolore' AND attackDamage = '50'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/en/bw/bw6/96/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Draw In' AND attackCost = 'Colorless' AND attackDamage = null))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/en/bw/bw6/96/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Dragon Headbutt' AND attackCost = 'PsychicDarknessColorless' AND attackDamage = '40'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/fr/bw/bwp/BW09/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Machination' AND attackCost = 'Obscurité' AND attackDamage = null))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/fr/bw/bwp/BW09/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Tricherie' AND attackCost = 'IncoloreIncolore' AND attackDamage = null))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/en/bw/bw9/83/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Deafen' AND attackCost = 'ColorlessColorlessColorless' AND attackDamage = '60'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/en/bw/bw9/83/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Healwing' AND attackCost = 'GrassLightningColorlessColorless' AND attackDamage = '90'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/en/bw/bw4/56/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Smack' AND attackCost = 'ColorlessColorless' AND attackDamage = '20'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/en/bw/bw4/56/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Psychic' AND attackCost = 'PsychicColorlessColorless' AND attackDamage = '40'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/fr/bw/bw9/84/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Vortex Draconique' AND attackCost = 'Incolore' AND attackDamage = '20'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/fr/bw/bw9/84/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Triple Décharge' AND attackCost = 'Eau' AND attackDamage = null))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/en/bw/bw7/77/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Psychic' AND attackCost = 'Psychic' AND attackDamage = '10'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/en/bw/bw7/77/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Echoed Voice' AND attackCost = 'PsychicColorlessColorless' AND attackDamage = '50'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/fr/bw/bw2/13/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Para-Spore' AND attackCost = 'Plante' AND attackDamage = null))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/fr/bw/bw2/13/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Coupe' AND attackCost = 'PlanteIncolore' AND attackDamage = '20'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/en/bw/bw2/12/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Encore' AND attackCost = 'Colorless' AND attackDamage = '20'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/en/bw/bw2/12/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'U-turn' AND attackCost = 'GrassGrass' AND attackDamage = '40'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/fr/bw/bw8/106/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Ultrason' AND attackCost = 'Incolore' AND attackDamage = null))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/fr/bw/bw8/106/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Mégaphone' AND attackCost = 'IncoloreIncoloreIncolore' AND attackDamage = '50'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/fr/bw/bw9/113/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Vol Supersonique' AND attackCost = 'PsyIncolore' AND attackDamage = '40'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/fr/bw/bw9/113/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Lumi-Éclat' AND attackCost = 'EauPsyIncolore' AND attackDamage = '150'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/en/bw/bw6/99/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Double Hit' AND attackCost = 'Colorless' AND attackDamage = '10'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/fr/bw/bw7/53/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Balayage' AND attackCost = 'ÉlectriqueIncolore' AND attackDamage = '20'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/fr/bw/bw7/53/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Explosion Magnétique' AND attackCost = 'ÉlectriqueIncoloreIncolore' AND attackDamage = '50'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/en/bw/bw6/48/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Cursed Drop' AND attackCost = 'Psychic' AND attackDamage = null))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/fr/bw/bw8/137/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Hydrocanon' AND attackCost = 'IncoloreIncoloreIncoloreIncolore' AND attackDamage = '60'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/en/bw/bw8/107/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Destructive Sound' AND attackCost = 'ColorlessColorlessColorless' AND attackDamage = null))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/en/bw/bw8/107/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Round' AND attackCost = 'ColorlessColorlessColorlessColorless' AND attackDamage = '50'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/fr/bw/bw2/62/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Mania' AND attackCost = 'CombatCombatIncolore' AND attackDamage = '70'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/en/bw/bw10/56/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Dark Clamp' AND attackCost = 'DarknessColorless' AND attackDamage = '30'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/en/bw/bw10/56/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Blazing Claws' AND attackCost = 'DarknessColorlessColorless' AND attackDamage = '60'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/fr/bw/bw7/68/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Piqûre Psy' AND attackCost = 'PsyIncolore' AND attackDamage = '20'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/en/bw/bw8/61/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Powerful Storm' AND attackCost = 'ColorlessColorless' AND attackDamage = '20'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/en/bw/bw8/61/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Swift Lunge' AND attackCost = 'PsychicColorlessColorless' AND attackDamage = '80'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/en/bw/bw3/83/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Devour' AND attackCost = 'Metal' AND attackDamage = null))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/en/bw/bw3/83/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Vice Grip' AND attackCost = 'ColorlessColorless' AND attackDamage = '30'))