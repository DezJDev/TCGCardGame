DROP TABLE IF EXISTS P10_Card;
DROP TABLE IF EXISTS P10_Attack;
DROP TABLE IF EXISTS P10_Resistance;
DROP TABLE IF EXISTS P10_Weakness;
DROP TABLE IF EXISTS P10_User;
DROP TABLE IF EXISTS P10_Abitility;

CREATE TABLE IF NOT EXISTS P10_User(
	userId SERIAL PRIMARY KEY,
	userName varchar(20) NOT NULL,
	userDob date NOT NULL,
	userStatus varchar(10) NOT NULL DEFAULT 'user' CHECK IN ['root','user'],
	userLogin varchar(255) NOT NULL,
	userPass varchar(255) NOT NULL);

CREATE TABLE IF NOT EXISTS P10_Ability(
	abilityId SERIAL PRIMARY KEY,
	abilityName varchar(50) NOT NULL,
	abilityEffect varchar(255) NOT NULL);

CREATE TABLE IF NOT EXISTS P10_Resistance(
	resistanceId SERIAL PRIMARY KEY,
	resistanceType varchar(10) NOT NULL CHECK IN ['Incolore', 'Feu', 'Eau', 'Plante', 'Combat', 'Métal', 'Électrique', 'Psy', 'Obscurité', 'Dragon', 'Colorless', 'Fire', 'Water', 'Grass', 'Fighting', 'Metal', 'Lightning', 'Psychic', 'Darkness'],
	resistanceValue varchar(5) NOT NULL DEFAULT '-20' CHECK IN ['/2',-20,-10,-30]);

CREATE TABLE IF NOT EXISTS P10_Weakness(
	weaknessId SERIAL PRIMARY KEY,
	weaknessType varchar(10) NOT NULL CHECK IN ['Incolore', 'Feu', 'Eau', 'Plante', 'Combat', 'Métal', 'Électrique', 'Psy', 'Obscurité', 'Dragon', 'Colorless', 'Fire', 'Water', 'Grass', 'Fighting', 'Metal', 'Lightning', 'Psychic', 'Darkness'],
	weaknessValue varchar(5) NOT NULL DEFAULT 'x2' CHECK IN ['x2',+20,+10,+30]);

CREATE TABLE IF NOT EXISTS P10_Attack(
	attackId SERIAL PRIMARY KEY,
	attackName varchar(50) NOT NULL,
	attackCost varchar(50),
	attackDamage varchar(4),
	attackEffect varchar(255),
	attackLang varchar(20) NOT NULL DEFAULT 'fr' CHECK IN ['fr','en']);

CREATE TABLE IF NOT EXISTS P10_Card(
	cardId SERIAL PRIMARY KEY,
	cardCategory varchar(50) NOT NULL DEFAULT 'Pokémon' CHECK IN ['Pokémon','Pokemon','Dresseur','Trainer'],
	cardName varchar(50) NOT NULL,
	cardHP INT,
	cardRarity varchar(50) NOT NULL DEFAULT 'Commune' CHECK IN ['Commune','Peu Commune','Rare','Ultra Rare','Magnifique'],
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
	('Corniaud','S’il vous reste 2, 4 ou 6 cartes Récompense, ce Pokémon ne peut pas attaquer.'),
	('Distrait','Si le Pokémon Actif de votre adversaire est un Pokémon de base, ce Pokémon ne peut pas attaquer.'),
	('Corps Solide','Si ce Pokémon doit être mis K.O. par les dégâts d’une attaque, lancez une pièce. Si c’est face, ce Pokémon n’est pas mis K.O. mais il ne lui reste que 10 PV.'),
	('Peau Dure','Si ce Pokémon est votre Pokémon Actif et qu’il subit les dégâts d’une attaque de votre adversaire (même si ce Pokémon est mis K.O.), placez 2 marqueurs de dégâts sur le Pokémon Attaquant.'),
	('Dragon Call','Once during your turn (before your attack), you may search your deck for a Dragon Pokémon, reveal it, and put it into your hand. Shuffle your deck afterward.');

INSERT INTO P10_Attack(attackName,attackCost,attackDamage,attackEffect) VALUES 
	('Charge','Incolore','10',null),
	('Vibration','Colorless','10',null),
	('Spiral Drain','Colorless','10','Heal 10 damage from this Pokémon.'),
	('Verdict Fatal','PsyIncolore',null,'Lancez 2 pièces. Si vous obtenez 2 côtés face, le Pokémon Défenseur est mis K.O.'),
	('Static Shock','Colorless','20',null),
	('Psychic','Psychic','10','Does 20 more damage for each Energy attached to the Defending Pokémon.'),
	('Bras à Rallonges','Incolore',null,'Cette attaque inflige 30 dégâts à 1 des Pokémon de votre adversaire. (N''appliquez ni la Faiblesse ni la Résistance aux Pokémon de Banc.)'),
	('Nasty Goo','PsychicColorless','20','Flip a coin. If heads, the Defending Pokémon is now Paralyzed.'),
	('Draco-Rage','IncoloreIncolore','50','Lancez 2 pièces. Si vous obtenez un côté pile, cette attaque ne fait rien.'),
	('Outrage','ColorlessColorless','20','Does 10 more damage for each damage counter on this Pokémon.'),
	('Coup Double','Incolore','10','Lancez 2 pièces. Cette attaque inflige 10 dégâts multipliés par le nombre de côtés face.'),
	('Mach Cut','Fighting','60','Discard a Special Energy attached to the Defending Pokémon.'),
	('Corne Empoisonnée','PsyIncolore','50','Le Pokémon Défenseur est maintenant Empoisonné.'),
	('Absorb','WaterColorless','10','Heal 10 damage from this Pokémon.'),
	('Giga-Sangsue','PlanteIncolore','30','Soignez à ce Pokémon la même quantité de dégâts que vous avez infligée au Pokémon Défenseur.'),
	('Sleep Powder','Grass','10','Flip a coin. If heads, the Defending Pokémon is now Asleep.'),
	('Paralyzing Gaze','Colorless',null,'Flip a coin. If heads, the Defending Pokémon is now Paralyzed.'),
	('Flame Burst','Fire','20','Does 20 damage to 2 of your opponent''s Benched Pokémon. (Don''t apply Weakness and Resistance for Benched Pokémon.)'),
	('Cru-Aile','IncoloreIncolore','40',null),
	('Gust','ColorlessColorless','20',null),
	('Bâillement','Incolore',null,'Le Pokémon Défenseur est maintenant Endormi.'),
	('Bélier','IncoloreIncolore','30','Lancez une pièce. Si c''est pile, ce Pokémon s''inflige 10 dégâts.'),
	('Tail Slap','Colorless','10','Flip 2 coins. This attack does 10 damage times the number of heads.'),
	('Vision Puissante','IncoloreIncolore','10','Inflige 10 dégâts multipliés par le nombre de cartes dans la main de votre adversaire.'),
	('Last Resort','Colorless','30','Flip a coin. If tails, this attack does nothing.'),
	('Coup d''Boule','Incolore','10',null),
	('Blockade','Colorless','10','Your opponent can''t play any Supporter cards from his or her hand during his or her next turn.'),
	('Assistance Énergétique','Incolore',null,'Attachez une carte Énergie de base de votre pile de défausse à 1 de vos Pokémon de Banc.'),
	('Find a Friend','Colorless',null,'Flip a coin. If heads, search your deck for a Pokémon, reveal it, and put it into your hand. Shuffle your deck afterward.'),
	('Fournaise','FeuIncolore','20',null),
	('Toxic','Grass',null,'The Defending Pokémon is now Poisoned. Put 2 damage counters instead of 1 on that Pokémon between turns.'),
	('Crunch','ColorlessColorless','30','Flip a coin. If heads, discard an Energy attached to the Defending Pokémon.'),
	('Coud''Pattes','Incolore','10',null),
	('Attract','Colorless',null,'If the Defending Pokémon tries to attack during your opponent''s next turn, your opponent flips a coin. If tails, that attack does nothing.'),
	('Poison Ring','Fighting','20','The Defending Pokémon is now Poisoned. The Defending Pokémon can''t retreat during your opponent''s next turn.'),
	('Coup Écrasant','IncoloreIncoloreIncoloreIncolore','100','Défaussez une Énergie attachée au Pokémon Défenseur.'),
	('Collect','Grass',null,'Draw 3 cards.'),
	('Tranche','IncoloreIncoloreIncolore','60',null),
	('Roar','Colorless',null,'Your opponent switches the Defending Pokémon with 1 of his or her Benched Pokémon.'),
	('Rendre Sourd','IncoloreIncoloreIncolore','60','Votre adversaire ne peut pas jouer de cartes Objet de sa main pendant son prochain tour.'),
	('Charge Beam','ColorlessColorless','20','Flip a coin. If heads, attach an Energy card from your discard pile to this Pokémon.'),
	('Affolement','Psy','10','Lancez une pièce. Si c''est face, le Pokémon Défenseur est maintenant Confus.'),
	('Thundershock','Lightning','20','Flip a coin. If heads, the Defending Pokémon is now Paralyzed.'),
	('Sand-Attack','Colorless','20','If the Defending Pokémon tries to attack during your opponent''s next turn, your opponent flips a coin. If tails, that attack does nothing.'),
	('Coud''Boue','CombatCombatIncolore','40',null),
	('Headbutt','Colorless','10',null),
	('Claque','Psy','30',null),
	('Stun Needle','Lightning','10','Flip a coin. If heads, the Defending Pokémon is now Paralyzed.'),
	('Lure Poison','Psychic',null,'Flip a coin. If heads, switch 1 of your opponent''s Benched Pokémon with the Defending Pokémon. The new Defending Pokémon is now Poisoned.'),
	('Embuscade','PsyIncolore','40','Lancez une pièce. Si c''est face, cette attaque inflige 20 dégâts supplémentaires.'),
	('Energy Crush','Lightning','20','Does 20 damage times the amount of Energy attached to all of your opponent''s Pokémon.'),
	('Serre','IncoloreIncoloreIncolore','60','Le Pokémon Défenseur ne peut pas battre en retraite pendant le prochain tour de votre adversaire.'),
	('Nerve Shot','Fighting','30','Flip a coin. If heads, the Defending Pokémon is now Paralyzed.'),
	('Espionnage','Psy',null,'Votre adversaire montre sa main.'),
	('Knock Away','Colorless','10','Flip a coin. If heads, this attack does 20 more damage.'),
	('Regard Paralysant','Incolore',null,'Lancez une pièce. Si c''est face, le Pokémon Défenseur est maintenant Paralysé.'),
	('Poison Jab','PsychicColorless','20','The Defending Pokémon is now Poisoned.'),
	('Toile Élek','Électrique','20','Le Pokémon Défenseur ne peut pas battre en retraite lors du prochain tour de votre adversaire.'),
	('Poison Sting','PsychicColorless','20','The Defending Pokémon is now Poisoned.'),
	('Piqûre Piquante','PlanteIncolore','10','Lancez une pièce. Si c''est face, cette attaque inflige 20 dégâts supplémentaires.'),
	('Double Whip','Colorless','10','Flip 2 coins. This attack does 10 damage times the number of heads.'),
	('Rayon Désintégrateur','IncoloreIncolore','30','Lancez une pièce. Si c''est face, défaussez une Énergie attachée au Pokémon Défenseur.'),
	('Taunt','Colorless',null,'Switch the Defending Pokémon with 1 of your opponent''s Benched Pokémon.'),
	('Direct Toxik','PsyIncolore','20','Le Pokémon Défenseur est maintenant Empoisonné.'),
	('Low Kick','Colorless','20',null),
	('Tit''Sieste','IncoloreIncolore',null,'Soignez 40 dégâts à ce Pokémon.'),
	('Koud''Poing','Incolore','10',null),
	('Spit Acid','Darkness','20','The Defending Pokémon is now Burned. Flip a coin. If heads, the Defending Pokémon is also Paralyzed.'),
	('Plongée Profonde','IncoloreIncolore',null,'Lancez 2 pièces. Pour chaque côté face, soignez 40 dégâts à ce Pokémon.'),
	('Crush and Burn','LightningColorless','30','Discard as many Energy attached to your Pokémon as you like. This attack does 30 damage times the number of Energy cards you discarded.'),
	('Dig','Colorless','10','Flip a coin. If heads, prevent all effects of attacks, including damage, done to this Pokémon during your opponent''s next turn.'),
	('Pound','Colorless','10',null),
	('Amoncellement','Psy',null,'Lancez une pièce. Si c''est face, cherchez une carte Outil Pokémon dans votre deck, montrez-la, puis ajoutez-la à votre main. Mélangez ensuite votre deck.'),
	('Headbutt Bounce','PsychicPsychicColorless','60',null),
	('Pluie Éclaboussante','Eau','10',null),
	('Vengeful Wish','Colorless',null,'If this Pokémon was damaged by an attack during your opponent''s last turn, this attack does the same amount of damage to the Defending Pokémon.'),
	('Silent Claw','Colorless',null,'Your opponent reveals his or her hand. Discard a Supporter card you find there. Use the effect of that card as the effect of this attack.'),
	('Ronge','Incolore','10',null),
	('Dragonslice','WaterFighting','20',null),
	('Dragon Stream','FireColorlessColorless','60','Flip a coin. If heads, attach a basic Energy card from your discard pile to this Pokémon.'),
	('Piège Osseux','Combat','30','Le Pokémon Défenseur ne peut pas battre en retraite pendant le prochain tour de votre adversaire.');

INSERT INTO P10_Attack(attackName,attackCost,attackDamage,attackEffect) VALUES 
	('Mud Shot','WaterColorless','20',null),
	('Magie Noire','PsyIncoloreIncolore','40','Inflige 20 dégâts supplémentaires pour chaque Pokémon de Banc de votre adversaire.'),
	('Electro Ball','LightningColorlessColorless','60',null),
	('Ronge','EauCombat','20',null),
	('Echoed Voice','PsychicColorlessColorless','50','During your next turn, this Pokémon''s Echoed Voice attack does 50 more damage (before applying Weakness and Resistance).'),
	('Gifle Folle','PsyIncoloreIncolore','40','Lancez 4 pièces. Cette attaque inflige 40 dégâts multipliés par le nombre de côtés face.'),
	('Blue Flare','FireFireColorless','120','Discard 2 Fire Energy attached to this Pokémon.'),
	('Dragonblade','WaterFighting','100','Discard the top 2 cards of your deck.'),
	('Double Écrasement','PsyIncoloreIncolore','60','Lancez 2 pièces. Cette attaque inflige 30 dégâts supplémentaires pour chaque côté face.'),
	('Lame Sainte','PlantePlanteIncolore','100','Ce Pokémon ne peut pas utiliser Lame Sainte pendant votre prochain tour.'),
	('Shadow Bind','DarknessColorless','20','The Defending Pokémon can''t retreat during your opponent''s next turn.'),
	('Fury Swipes','ColorlessColorlessColorless','40','Flip 3 coins. This attack does 40 damage times the number of heads.'),
	('Rapace','IncoloreIncoloreIncolore','90','Ce Pokémon s''inflige 30 dégâts.'),
	('Vol','IncoloreIncoloreIncolore','50','Lancez une pièce. Si c''est pile, cette attaque ne fait rien. Si c''est face, évitez tous les effets d''attaques (y compris les dégâts) infligés à ce Pokémon pendant le prochain tour de votre adversaire.'),
	('Dracogriffe','FeuEau','20',null),
	('Stomp','GrassColorlessColorless','60','Flip a coin. If heads, this attack does 30 more damage.'),
	('Guérison Céleste','FeuPsy','40','Si Latios est sur votre Banc, soignez 20 dégâts à ce Pokémon.'),
	('Rising Lunge','GrassColorless','10','Flip a coin. If heads, this attack does 20 more damage.'),
	('Body Slam','ColorlessColorless','30','Flip a coin. If heads, the Defending Pokémon is now Paralyzed.'),
	('Dragon Claw','PsychicDarknessDarkness','80',null),
	('Heart Stamp','PsychicColorless','40',null),
	('Night Slash','FightingColorless','40','Switch this Pokémon with 1 of your Benched Pokémon.'),
	('Stadium Drain','GrassColorless','30','If there is any Stadium card in play, this attack does 30 more damage and heal 30 damage from this Pokémon.'),
	('Baliste Noire','EauEauÉlectriqueIncolore','200','Défaussez 3 Énergies attachées à ce Pokémon.'),
	('Tackle','ColorlessColorless','30',null),
	('Aile Soin','PlanteÉlectriqueIncoloreIncolore','90','Soignez 30 dégâts à ce Pokémon.'),
	('Vice Grip','MetalColorlessColorless','50',null),
	('Slam','LightningColorlessColorless','80','Flip 2 coins. This attack does 80 damage times the number of heads.'),
	('Fire Slash','FireColorlessColorless','60','You may discard a Fire Energy attached to this Pokémon. If you do, this attack does 30 more damage.'),
	('Reckless Charge','FightingColorless','30','This Pokémon does 10 damage to itself.'),
	('Choc Émotionnel','PsyIncoloreIncolore','60','Lancez une pièce. Si c''est face, le Pokémon Défenseur est maintenant Confus. Si c''est pile, défaussez une Énergie attachée au Pokémon Défenseur.'),
	('Attaque Imprudente','CombatIncolore','30','Ce Pokémon s''inflige 10 dégâts.'),
	('Sludge Toss','PsychicColorlessColorless','30',null),
	('Flash Impact','LightningColorlessColorless','80','Does 20 damage to 1 of your Pokémon. (Don''t apply Weakness and Resistance for Benched Pokémon.)'),
	('Pandemonium Blade','FightingColorlessColorless','60','Does 20 more damage for each of your Benched Pokémon that has any damage counters on it.'),
	('Crèvecœur','IncoloreIncolore','20',null),
	('Rollout','FireWaterColorless','50',null),
	('Vampirisme','IncoloreIncolore','40','Soignez à ce Pokémon la même quantité de dégâts que vous avez infligée au Pokémon Défenseur.'),
	('Double Kick','PsychicColorlessColorless','40','Flip 2 coins. This attack does 40 damage times the number of heads.'),
	('Relaxing Fragrance','Grass',null,'Heal 30 damage and remove all Special Conditions from this Pokémon.'),
	('Sucker Punch','ColorlessColorless','30','If this Pokémon has any Darkness Energy attached to it, this attack does 30 more damage.'),
	('Steel Swing','FightingColorlessColorless','60','Flip 2 coins. This attack does 60 damage times the number of heads.'),
	('Écras''Face','PsyIncoloreIncolore','40',null),
	('Koud''Pied','CombatIncolore','20',null),
	('High Jump Kick','DarknessDarknessColorless','70',null),
	('Aquasonique','EauEauIncolore','70','Les dégâts de cette attaque ne sont pas affectés par la Résistance.'),
	('Thunder Tempest','LightningColorlessColorlessColorless','50','Flip 4 coins. This attack does 50 damage times the number of heads.'),
	('Giclée Vaseuse','IncoloreIncolore','20',null),
	('Carap''Attaque','EauIncolore','20',null),
	('Absorb Life','WaterWaterColorless','30','Heal 30 damage from this Pokémon.'),
	('Fake Out','DarknessColorless','30','Flip a coin. If heads, the Defending Pokémon is now Paralyzed.'),
	('Coup de Queue','IncoloreIncolore','20',null),
	('Ice Burn','FireFireWaterColorless','150','Discard 2 Fire Energy attached to this Pokémon. The Defending Pokémon is now Burned.'),
	('Coupe-Tourbillon','CombatIncoloreIncolore','60','Si le Pokémon Défenseur a une Résistance, cette attaque inflige 30 dégâts supplémentaires.'),
	('Ambush','DarknessColorless','20','Flip a coin. If heads, this attack does 10 more damage.');

INSERT INTO P10_Resistance(resistanceType,resistanceValue) VALUES 
	('Fighting','-20'),
	('Eau','-20'),
	('Water','-20'),
	('Psy','-20'),
	('Psychic','-20'),
	('Combat','-20'),
	('Lightning','-20'),
	('Électrique','-20');

INSERT INTO P10_Weakness(weaknessType,weaknessValue) VALUES 
	('Plante','×2'),
	('Grass','×2'),
	('Psy','×2'),
	('Lightning','×2'),
	('Fighting','×2'),
	('Dragon','×2'),
	('Psychic','×2'),
	('Obscurité','×2'),
	('Water','×2'),
	('Combat','×2'),
	('Feu','×2'),
	('Fire','×2'),
	('Électrique','×2'),
	('Eau','×2');

INSERT INTO Card(cardCatergory,cardName,cardHP,cardRarity,cardImg,cardType,cardExtensioncardRetreat,cardLang,abilityId,resistanceId,weaknessId) VALUES
	('Pokémon','Carapuce','60','Commune','https://assets.tcgdex.net/fr/bw/bw8/24/high.webp','Eau','Tempète Plasma',1,'fr',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Plante' AND weaknessValue = '×2'),null),
	('Pokemon','Tympole','60','Common','https://assets.tcgdex.net/en/bw/bw3/22/high.webp','Water','Noble Victories',1,'en',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Grass' AND weaknessValue = '×2'),null),
	('Pokémon','Charpenti','60','Commune','https://assets.tcgdex.net/fr/bw/bw5/58/high.webp','Combat','Explorateurs Obscurs',1,'fr',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Psy' AND weaknessValue = '×2'),null),
	('Pokemon','Zubat','50','Common','https://assets.tcgdex.net/en/bw/bw8/52/high.webp','Psychic','Plasma Storm',1,'en',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Lightning' AND weaknessValue = '×2'),(SELECT resistanceId FROM P10_Resistance WHERE resistanceType = 'Fighting' AND resistanceValue = '-20')),
	('Pokémon','Sidérella','130','Rare','https://assets.tcgdex.net/fr/bw/bw6/57/high.webp','Psy','Dragons Éxaltés',2,'fr',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Psy' AND weaknessValue = '×2'),null),
	('Pokemon','Electrode','80','Uncommon','https://assets.tcgdex.net/en/bw/bw7/52/high.webp','Lightning','Boundaries Crossed',0,'en',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Fighting' AND weaknessValue = '×2'),null),
	('Pokémon','Griknot','50','Commune','https://assets.tcgdex.net/fr/bw/bw6/86/high.webp','Dragon','Dragons Éxaltés',1,'fr',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Dragon' AND weaknessValue = '×2'),null),
	('Pokemon','Meloetta','80','Rare','https://assets.tcgdex.net/en/bw/bw11/78/high.webp','Psychic','Legendary Treasures',1,'en',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Psychic' AND weaknessValue = '×2'),null),
	('Pokémon','Tutankafer','100','Rare','https://assets.tcgdex.net/fr/bw/bw9/57/high.webp','Psy','Glaciation Plasma',2,'fr',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Obscurité' AND weaknessValue = '×2'),null),
	('Pokemon','Grimer','70','Common','https://assets.tcgdex.net/en/bw/bw4/52/high.webp','Psychic','Next Destinies',2,'en',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Psychic' AND weaknessValue = '×2'),null),
	('Pokémon','Coupenotte','50','Commune','https://assets.tcgdex.net/fr/bw/bwp/BW16/high.webp','Incolore','Promo BW',1,'fr',null,null,null),
	('Pokemon','Reshiram','130','Ultra Rare','https://assets.tcgdex.net/en/bw/bw1/113/high.webp','Fire','Black & White',2,'en',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Water' AND weaknessValue = '×2'),null),
	('Pokémon','Capumain','60','Commune','https://assets.tcgdex.net/fr/bw/bw6/99/high.webp','Incolore','Dragons Éxaltés',1,'fr',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Combat' AND weaknessValue = '×2'),null),
	('Pokemon','Garchomp','140','Rare','https://assets.tcgdex.net/en/bw/bw6/90/high.webp','Dragon','Dragons Exalted',1,'en',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Dragon' AND weaknessValue = '×2'),null),
	('Pokémon','Nidoqueen','130','Rare','https://assets.tcgdex.net/fr/bw/bw9/42/high.webp','Psy','Glaciation Plasma',3,'fr',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Psy' AND weaknessValue = '×2'),null),
	('Pokemon','Frillish','70','Common','https://assets.tcgdex.net/en/bw/bw8/38/high.webp','Water','Plasma Storm',2,'en',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Lightning' AND weaknessValue = '×2'),null),
	('Pokémon','Viridium','100','Rare','https://assets.tcgdex.net/fr/bw/bw2/17/high.webp','Plante','Pouvoirs Émergents',1,'fr',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Feu' AND weaknessValue = '×2'),(SELECT resistanceId FROM P10_Resistance WHERE resistanceType = 'Eau' AND resistanceValue = '-20')),
	('Pokemon','Petilil','50','Uncommon','https://assets.tcgdex.net/en/bw/bw7/16/high.webp','Grass','Boundaries Crossed',1,'en',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Fire' AND weaknessValue = '×2'),(SELECT resistanceId FROM P10_Resistance WHERE resistanceType = 'Water' AND resistanceValue = '-20')),
	('Pokémon','Cliticlic','140','Rare','https://assets.tcgdex.net/fr/bw/bw5/77/high.webp','Métal','Explorateurs Obscurs',4,'fr',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Feu' AND weaknessValue = '×2'),(SELECT resistanceId FROM P10_Resistance WHERE resistanceType = 'Psy' AND resistanceValue = '-20')),
	('Pokemon','Zorua','60','Common','https://assets.tcgdex.net/en/bw/bw5/70/high.webp','Darkness','Dark Explorers',1,'en',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Fighting' AND weaknessValue = '×2'),(SELECT resistanceId FROM P10_Resistance WHERE resistanceType = 'Psychic' AND resistanceValue = '-20')),
	('Pokémon','Flagadoss','100','Peu Commune','https://assets.tcgdex.net/fr/bw/bw5/24/high.webp','Eau','Explorateurs Obscurs',3,'fr',(SELECT abilityId FROM P10_Ability WHERE abilityName = 'Corniaud' AND abilityEffect = 'S’il vous reste 2, 4 ou 6 cartes Récompense, ce Pokémon ne peut pas attaquer.'),(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Électrique' AND weaknessValue = '×2'),null),
	('Pokemon','Simisear','90','Uncommon','https://assets.tcgdex.net/en/bw/bw1/22/high.webp','Fire','Black & White',1,'en',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Water' AND weaknessValue = '×2'),null),
	('Pokémon','Gueriaigle','100','Rare','https://assets.tcgdex.net/fr/bw/bw2/88/high.webp','Incolore','Pouvoirs Émergents',1,'fr',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Électrique' AND weaknessValue = '×2'),(SELECT resistanceId FROM P10_Resistance WHERE resistanceType = 'Combat' AND resistanceValue = '-20')),
	('Pokemon','Pidove','50','Common','https://assets.tcgdex.net/en/bw/bw2/80/high.webp','Colorless','Emerging Powers',1,'en',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Lightning' AND weaknessValue = '×2'),(SELECT resistanceId FROM P10_Resistance WHERE resistanceType = 'Fighting' AND resistanceValue = '-20')),
	('Pokémon','Togepi','40','Commune','https://assets.tcgdex.net/fr/bw/bw8/102/high.webp','Incolore','Tempète Plasma',1,'fr',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Combat' AND weaknessValue = '×2'),null),
	('Trainer','Dark Patch',null,'Uncommon','https://assets.tcgdex.net/en/bw/bw5/93/high.webp',null,'Dark Explorers',null,'en',null,null,null),
	('Pokémon','Étourvol','80','Peu Commune','https://assets.tcgdex.net/fr/bw/bw9/96/high.webp','Incolore','Glaciation Plasma',1,'fr',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Électrique' AND weaknessValue = '×2'),(SELECT resistanceId FROM P10_Resistance WHERE resistanceType = 'Combat' AND resistanceValue = '-20')),
	('Pokemon','Minccino','60','Common','https://assets.tcgdex.net/en/bw/bw1/88/high.webp','Colorless','Black & White',1,'en',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Fighting' AND weaknessValue = '×2'),null),
	('Pokémon','Noarfang','90','Peu Commune','https://assets.tcgdex.net/fr/bw/bw9/92/high.webp','Incolore','Glaciation Plasma',1,'fr',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Électrique' AND weaknessValue = '×2'),(SELECT resistanceId FROM P10_Resistance WHERE resistanceType = 'Combat' AND resistanceValue = '-20')),
	('Pokemon','Minccino','60','Common','https://assets.tcgdex.net/en/bw/bw2/84/high.webp','Colorless','Emerging Powers',1,'en',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Fighting' AND weaknessValue = '×2'),null),
	('Pokémon','Draby','50','Rare','https://assets.tcgdex.net/fr/bw/dv1/6/high.webp','Dragon','Coffre des Dragons',1,'fr',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Dragon' AND weaknessValue = '×2'),null),
	('Pokemon','Exeggutor','100','Rare','https://assets.tcgdex.net/en/bw/bw9/5/high.webp','Grass','Plasma Freeze',2,'en',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Fire' AND weaknessValue = '×2'),(SELECT resistanceId FROM P10_Resistance WHERE resistanceType = 'Water' AND resistanceValue = '-20')),
	('Pokémon','Latias','100','Rare','https://assets.tcgdex.net/fr/bw/dv1/9/high.webp','Dragon','Coffre des Dragons',1,'fr',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Dragon' AND weaknessValue = '×2'),null),
	('Pokemon','Foongus','40','Common','https://assets.tcgdex.net/en/bw/bw4/8/high.webp','Grass','Next Destinies',1,'en',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Fire' AND weaknessValue = '×2'),(SELECT resistanceId FROM P10_Resistance WHERE resistanceType = 'Water' AND resistanceValue = '-20')),
	('Pokémon','Caninos','80','Commune','https://assets.tcgdex.net/fr/bw/bw4/11/high.webp','Feu','Destinées Futures',2,'fr',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Eau' AND weaknessValue = '×2'),null),
	('Pokemon','Amoonguss','90','Uncommon','https://assets.tcgdex.net/en/bw/bw3/10/high.webp','Grass','Noble Victories',2,'en',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Fire' AND weaknessValue = '×2'),(SELECT resistanceId FROM P10_Resistance WHERE resistanceType = 'Water' AND resistanceValue = '-20')),
	('Énergie','Énergie Feu',null,'Commune','https://assets.tcgdex.net/fr/bw/bw1/106/high.webp',null,'Noir & Blanc',null,'fr',null,null,null),
	('Pokemon','Zweilous','80','Uncommon','https://assets.tcgdex.net/en/bw/bw6/95/high.webp','Dragon','Dragons Exalted',2,'en',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Dragon' AND weaknessValue = '×2'),null),
	('Pokémon','Zébibron','70','Commune','https://assets.tcgdex.net/fr/bw/bw7/56/high.webp','Électrique','Frontières Franchies',1,'fr',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Combat' AND weaknessValue = '×2'),null),
	('Pokemon','Swoobat','80','Uncommon','https://assets.tcgdex.net/en/bw/bw1/51/high.webp','Psychic','Black & White',1,'en',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Lightning' AND weaknessValue = '×2'),(SELECT resistanceId FROM P10_Resistance WHERE resistanceType = 'Fighting' AND resistanceValue = '-20')),
	('Pokémon','Tranchodon','140','Rare','https://assets.tcgdex.net/fr/bw/bw5/89/high.webp','Incolore','Explorateurs Obscurs',3,'fr',null,null,null),
	('Pokemon','Gliscor','100','Rare','https://assets.tcgdex.net/en/bw/bw7/81/high.webp','Fighting','Boundaries Crossed',1,'en',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Water' AND weaknessValue = '×2'),(SELECT resistanceId FROM P10_Resistance WHERE resistanceType = 'Lightning' AND resistanceValue = '-20')),
	('Pokémon','Monaflèmit','150','Rare','https://assets.tcgdex.net/fr/bw/bw6/103/high.webp','Incolore','Dragons Éxaltés',4,'fr',(SELECT abilityId FROM P10_Ability WHERE abilityName = 'Distrait' AND abilityEffect = 'Si le Pokémon Actif de votre adversaire est un Pokémon de base, ce Pokémon ne peut pas attaquer.'),(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Combat' AND weaknessValue = '×2'),null),
	('Energy','Prism Energy',null,'Uncommon','https://assets.tcgdex.net/en/bw/bw4/93/high.webp',null,'Next Destinies',null,'en',null,null,null),
	('Pokémon','Crabaraque','110','Peu Commune','https://assets.tcgdex.net/fr/bw/bw5/8/high.webp','Plante','Explorateurs Obscurs',3,'fr',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Feu' AND weaknessValue = '×2'),null),
	('Pokemon','Simisage','90','Rare','https://assets.tcgdex.net/en/bw/bw4/7/high.webp','Grass','Next Destinies',2,'en',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Fire' AND weaknessValue = '×2'),(SELECT resistanceId FROM P10_Resistance WHERE resistanceType = 'Water' AND resistanceValue = '-20')),
	('Pokémon','Kyurem Noir-EX','180','Rare','https://assets.tcgdex.net/fr/bw/bw8/95/high.webp','Dragon','Tempète Plasma',3,'fr',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Dragon' AND weaknessValue = '×2'),null),
	('Pokemon','Herdier','80','Uncommon','https://assets.tcgdex.net/en/bw/bw5/87/high.webp','Colorless','Dark Explorers',2,'en',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Fighting' AND weaknessValue = '×2'),null),
	('Pokémon','Dracolosse','150','Rare','https://assets.tcgdex.net/fr/bw/bw9/83/high.webp','Dragon','Glaciation Plasma',3,'fr',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Dragon' AND weaknessValue = '×2'),null),
	('Pokemon','Klang','80','Uncommon','https://assets.tcgdex.net/en/bw/bw5/76/high.webp','Metal','Dark Explorers',3,'en',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Fire' AND weaknessValue = '×2'),(SELECT resistanceId FROM P10_Resistance WHERE resistanceType = 'Psychic' AND resistanceValue = '-20')),
	('Pokémon','Tutafeh','60','Commune','https://assets.tcgdex.net/fr/bw/bw3/44/high.webp','Psy','Nobles Victoires',1,'fr',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Obscurité' AND weaknessValue = '×2'),null),
	('Pokemon','Raichu','90','Uncommon','https://assets.tcgdex.net/en/bw/bw4/40/high.webp','Lightning','Next Destinies',1,'en',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Fighting' AND weaknessValue = '×2'),null),
	('Pokémon','Entei-EX','180','Rare','https://assets.tcgdex.net/fr/bw/bw5/13/high.webp','Feu','Explorateurs Obscurs',3,'fr',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Eau' AND weaknessValue = '×2'),null),
	('Pokemon','Flareon','90','Uncommon','https://assets.tcgdex.net/en/bw/bw5/12/high.webp','Fire','Dark Explorers',1,'en',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Water' AND weaknessValue = '×2'),null),
	('Pokémon','Rototaupe','60','Commune','https://assets.tcgdex.net/fr/bw/bw2/55/high.webp','Combat','Pouvoirs Émergents',1,'fr',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Eau' AND weaknessValue = '×2'),(SELECT resistanceId FROM P10_Resistance WHERE resistanceType = 'Électrique' AND resistanceValue = '-20')),
	('Pokemon','Roggenrola','60','Common','https://assets.tcgdex.net/en/bw/bw2/50/high.webp','Fighting','Emerging Powers',2,'en',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Grass' AND weaknessValue = '×2'),null),
	('Pokémon','Sidérella','120','Rare','https://assets.tcgdex.net/fr/bw/bw2/48/high.webp','Psy','Pouvoirs Émergents',1,'fr',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Psy' AND weaknessValue = '×2'),null),
	('Pokemon','Joltik','40','Common','https://assets.tcgdex.net/en/bw/bw1/44/high.webp','Lightning','Black & White',1,'en',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Fighting' AND weaknessValue = '×2'),null),
	('Pokémon','Nodulithe','60','Commune','https://assets.tcgdex.net/fr/bw/bw2/50/high.webp','Combat','Pouvoirs Émergents',2,'fr',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Plante' AND weaknessValue = '×2'),null),
	('Pokemon','Grimer','70','Common','https://assets.tcgdex.net/en/bw/bw9/45/high.webp','Psychic','Plasma Freeze',2,'en',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Psychic' AND weaknessValue = '×2'),null),
	('Pokémon','Tutankafer','90','Rare','https://assets.tcgdex.net/fr/bw/bw3/47/high.webp','Psy','Nobles Victoires',2,'fr',(SELECT abilityId FROM P10_Ability WHERE abilityName = 'Corps Solide' AND abilityEffect = 'Si ce Pokémon doit être mis K.O. par les dégâts d’une attaque, lancez une pièce. Si c’est face, ce Pokémon n’est pas mis K.O. mais il ne lui reste que 10 PV.'),(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Obscurité' AND weaknessValue = '×2'),null),
	('Pokemon','Manectric','90','Rare','https://assets.tcgdex.net/en/bw/bw6/43/high.webp','Lightning','Dragons Exalted',0,'en',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Fighting' AND weaknessValue = '×2'),null),
	('Pokémon','Drakkarmin','100','Rare','https://assets.tcgdex.net/fr/bw/bw3/89/high.webp','Incolore','Nobles Victoires',2,'fr',(SELECT abilityId FROM P10_Ability WHERE abilityName = 'Peau Dure' AND abilityEffect = 'Si ce Pokémon est votre Pokémon Actif et qu’il subit les dégâts d’une attaque de votre adversaire (même si ce Pokémon est mis K.O.), placez 2 marqueurs de dégâts sur le Pokémon Attaquant.'),null,null),
	('Pokemon','Gallade','140','Rare','https://assets.tcgdex.net/en/bw/bw11/81/high.webp','Fighting','Legendary Treasures',2,'en',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Psychic' AND weaknessValue = '×2'),null),
	('Pokémon','Chovsourir','60','Commune','https://assets.tcgdex.net/fr/bw/bw7/70/high.webp','Psy','Frontières Franchies',1,'fr',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Électrique' AND weaknessValue = '×2'),(SELECT resistanceId FROM P10_Resistance WHERE resistanceType = 'Combat' AND resistanceValue = '-20')),
	('Pokemon','Shelgon','80','Uncommon','https://assets.tcgdex.net/en/bw/bw10/63/high.webp','Dragon','Plasma Blast',3,'en',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Dragon' AND weaknessValue = '×2'),null),
	('Pokémon','Incisache','80','Peu Commune','https://assets.tcgdex.net/fr/bw/bw10/68/high.webp','Dragon','Explosion Plasma',2,'fr',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Dragon' AND weaknessValue = '×2'),null),
	('Pokemon','Croagunk','70','Common','https://assets.tcgdex.net/en/bw/bw11/62/high.webp','Psychic','Legendary Treasures',1,'en',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Psychic' AND weaknessValue = '×2'),null),
	('Pokémon','Mygavolt','80','Rare','https://assets.tcgdex.net/fr/bw/bw1/46/high.webp','Électrique','Noir & Blanc',1,'fr',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Combat' AND weaknessValue = '×2'),null),
	('Pokemon','Nidorina','90','Uncommon','https://assets.tcgdex.net/en/bw/bw9/41/high.webp','Psychic','Plasma Freeze',3,'en',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Psychic' AND weaknessValue = '×2'),null),
	('Pokémon','Rosélia','70','Commune','https://assets.tcgdex.net/fr/bw/bw6/13/high.webp','Plante','Dragons Éxaltés',1,'fr',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Feu' AND weaknessValue = '×2'),(SELECT resistanceId FROM P10_Resistance WHERE resistanceType = 'Eau' AND resistanceValue = '-20')),
	('Pokemon','Roselia','70','Uncommon','https://assets.tcgdex.net/en/bw/bw6/12/high.webp','Grass','Dragons Exalted',1,'en',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Fire' AND weaknessValue = '×2'),(SELECT resistanceId FROM P10_Resistance WHERE resistanceType = 'Water' AND resistanceValue = '-20')),
	('Pokémon','Porygon2','80','Peu Commune','https://assets.tcgdex.net/fr/bw/bw10/73/high.webp','Incolore','Explosion Plasma',1,'fr',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Combat' AND weaknessValue = '×2'),null),
	('Pokemon','Liepard','80','Rare','https://assets.tcgdex.net/en/bw/bw1/67/high.webp','Darkness','Black & White',1,'en',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Fighting' AND weaknessValue = '×2'),(SELECT resistanceId FROM P10_Resistance WHERE resistanceType = 'Psychic' AND resistanceValue = '-20')),
	('Pokémon','Cradopaud','70','Peu Commune','https://assets.tcgdex.net/fr/bw/bw7/65/high.webp','Psy','Frontières Franchies',1,'fr',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Psy' AND weaknessValue = '×2'),null),
	('Pokemon','Gurdurr','80','Uncommon','https://assets.tcgdex.net/en/bw/bw5/59/high.webp','Fighting','Dark Explorers',2,'en',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Psychic' AND weaknessValue = '×2'),null),
	('Pokémon','Gringolem','90','Commune','https://assets.tcgdex.net/fr/bw/bw6/58/high.webp','Psy','Dragons Éxaltés',3,'fr',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Obscurité' AND weaknessValue = '×2'),null),
	('Pokemon','Whirlipede','90','Uncommon','https://assets.tcgdex.net/en/bw/bw1/53/high.webp','Psychic','Black & White',2,'en',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Psychic' AND weaknessValue = '×2'),null),
	('Pokémon','Riolu','60','Commune','https://assets.tcgdex.net/fr/bw/bw8/75/high.webp','Combat','Tempète Plasma',1,'fr',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Psy' AND weaknessValue = '×2'),null),
	('Pokemon','Scrafty','90','Rare','https://assets.tcgdex.net/en/bw/bw1/69/high.webp','Darkness','Black & White',1,'en',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Fighting' AND weaknessValue = '×2'),(SELECT resistanceId FROM P10_Resistance WHERE resistanceType = 'Psychic' AND resistanceValue = '-20')),
	('Pokémon','Azumarill','90','Peu Commune','https://assets.tcgdex.net/fr/bw/bw7/37/high.webp','Eau','Frontières Franchies',1,'fr',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Électrique' AND weaknessValue = '×2'),null),
	('Pokemon','Eelektross','140','Rare','https://assets.tcgdex.net/en/bw/bw10/33/high.webp','Lightning','Plasma Blast',3,'en',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Fighting' AND weaknessValue = '×2'),null),
	('Pokémon','Limaspeed','90','Rare','https://assets.tcgdex.net/fr/bw/bw5/11/high.webp','Plante','Explorateurs Obscurs',0,'fr',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Feu' AND weaknessValue = '×2'),null),
	('Pokemon','Nincada','40','Common','https://assets.tcgdex.net/en/bw/bw6/10/high.webp','Grass','Dragons Exalted',1,'en',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Fire' AND weaknessValue = '×2'),null),
	('Dresseur','Bianca',null,'Ultra Rare','https://assets.tcgdex.net/fr/bw/bw7/147/high.webp',null,'Frontières Franchies',null,'fr',(SELECT abilityId FROM P10_Ability WHERE abilityEffect = 'Piochez des cartes jusqu’à ce que vous ayez 6 cartes en main.'),null,null),
	('Pokemon','Minccino','60','Common','https://assets.tcgdex.net/en/bw/bw6/109/high.webp','Colorless','Dragons Exalted',1,'en',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Fighting' AND weaknessValue = '×2'),null),
	('Pokémon','Miamiasme','60','Peu Commune','https://assets.tcgdex.net/fr/bw/bw8/63/high.webp','Psy','Tempète Plasma',1,'fr',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Psy' AND weaknessValue = '×2'),null),
	('Pokemon','Wobbuffet','90','Uncommon','https://assets.tcgdex.net/en/bw/bw7/58/high.webp','Psychic','Boundaries Crossed',2,'en',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Psychic' AND weaknessValue = '×2'),null),
	('Pokémon','Moustillon','60','Commune','https://assets.tcgdex.net/fr/bw/bw7/39/high.webp','Eau','Frontières Franchies',1,'fr',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Plante' AND weaknessValue = '×2'),null),
	('Pokemon','Jellicent','120','Rare','https://assets.tcgdex.net/en/bw/bw4/35/high.webp','Water','Next Destinies',2,'en',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Lightning' AND weaknessValue = '×2'),null),
	('Dresseur','Super Ball',null,'Peu Commune','https://assets.tcgdex.net/fr/bw/bw2/93/high.webp',null,'Pouvoirs Émergents',null,'fr',(SELECT abilityId FROM P10_Ability WHERE abilityEffect = 'Regardez les 7 cartes du dessus de votre deck. Vous pouvez montrer un Pokémon que vous y trouvez et l''ajouter à votre main. Mélangez les autres cartes avec votre deck.'),null,null),
	('Pokemon','Liepard','80','Rare','https://assets.tcgdex.net/en/bw/bw8/84/high.webp','Darkness','Plasma Storm',1,'en',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Fighting' AND weaknessValue = '×2'),(SELECT resistanceId FROM P10_Resistance WHERE resistanceType = 'Psychic' AND resistanceValue = '-20')),
	('Pokémon','Chinchidou','50','Commune','https://assets.tcgdex.net/fr/bw/bwp/BW13/high.webp','Incolore','Promo BW',1,'fr',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Combat' AND weaknessValue = '×2'),null),
	('Trainer','Energy Switch',null,'Uncommon','https://assets.tcgdex.net/en/bw/bw11/112/high.webp',null,'Legendary Treasures',null,'en',null,null,null),
	('Dresseur','Professeur Keteleeria',null,'Peu Commune','https://assets.tcgdex.net/fr/bw/bw5/98/high.webp',null,'Explorateurs Obscurs',null,'fr',(SELECT abilityId FROM P10_Ability WHERE abilityEffect = 'Défaussez votre main et piochez 7 cartes.'),null,null),
	('Pokemon','Gabite','80','Uncommon','https://assets.tcgdex.net/en/bw/bw6/89/high.webp','Dragon','Dragons Exalted',1,'en',(SELECT abilityId FROM P10_Ability WHERE abilityName = 'Dragon Call' AND abilityEffect = 'Once during your turn (before your attack), you may search your deck for a Dragon Pokémon, reveal it, and put it into your hand. Shuffle your deck afterward.'),(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Dragon' AND weaknessValue = '×2'),null),
	('Énergie','Énergie Amalgamée WaterLightningFightingMetal',null,'Peu Commune','https://assets.tcgdex.net/fr/bw/bw6/118/high.webp',null,'Dragons Éxaltés',null,'fr',(SELECT abilityId FROM P10_Ability WHERE abilityEffect = 'Cette carte fournit de l’Énergie Colorless. Lorsque cette carte est attachée à un Pokémon, cette carte fournit de l’Énergie Water, Lightning, Fighting ou Metal mais ne fournit qu’une Énergie à la fois.'),null,null),
	('Pokemon','White Kyurem-EX','180','Rare','https://assets.tcgdex.net/en/bw/bw11/101/high.webp','Dragon','Legendary Treasures',3,'en',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Dragon' AND weaknessValue = '×2'),null),
	('Pokémon','Ossatueur','100','Rare','https://assets.tcgdex.net/fr/bw/bw6/61/high.webp','Combat','Dragons Éxaltés',1,'fr',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Eau' AND weaknessValue = '×2'),(SELECT resistanceId FROM P10_Resistance WHERE resistanceType = 'Électrique' AND resistanceValue = '-20')),
	('Pokemon','Houndour','60','Common','https://assets.tcgdex.net/en/bw/bw10/55/high.webp','Darkness','Plasma Blast',1,'en',null,(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = 'Fighting' AND weaknessValue = '×2'),(SELECT resistanceId FROM P10_Resistance WHERE resistanceType = 'Psychic' AND resistanceValue = '-20'));

INSERT INTO P10_Contient(cardId, attackId) VALUES
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/fr/bw/bw8/24/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Charge' AND attackCost = 'Incolore' AND attackDamage = '10'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/en/bw/bw3/22/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Vibration' AND attackCost = 'Colorless' AND attackDamage = '10'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/en/bw/bw3/22/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Mud Shot' AND attackCost = 'WaterColorless' AND attackDamage = '20'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/en/bw/bw8/52/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Spiral Drain' AND attackCost = 'Colorless' AND attackDamage = '10'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/fr/bw/bw6/57/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Verdict Fatal' AND attackCost = 'PsyIncolore' AND attackDamage = null))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/fr/bw/bw6/57/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Magie Noire' AND attackCost = 'PsyIncoloreIncolore' AND attackDamage = '40'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/en/bw/bw7/52/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Static Shock' AND attackCost = 'Colorless' AND attackDamage = '20'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/en/bw/bw7/52/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Electro Ball' AND attackCost = 'LightningColorlessColorless' AND attackDamage = '60'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/fr/bw/bw6/86/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Charge' AND attackCost = 'Incolore' AND attackDamage = '10'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/fr/bw/bw6/86/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Ronge' AND attackCost = 'EauCombat' AND attackDamage = '20'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/en/bw/bw11/78/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Psychic' AND attackCost = 'Psychic' AND attackDamage = '10'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/en/bw/bw11/78/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Echoed Voice' AND attackCost = 'PsychicColorlessColorless' AND attackDamage = '50'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/fr/bw/bw9/57/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Bras à Rallonges' AND attackCost = 'Incolore' AND attackDamage = null))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/fr/bw/bw9/57/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Gifle Folle' AND attackCost = 'PsyIncoloreIncolore' AND attackDamage = '40'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/en/bw/bw4/52/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Nasty Goo' AND attackCost = 'PsychicColorless' AND attackDamage = '20'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/fr/bw/bwp/BW16/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Draco-Rage' AND attackCost = 'IncoloreIncolore' AND attackDamage = '50'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/en/bw/bw1/113/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Outrage' AND attackCost = 'ColorlessColorless' AND attackDamage = '20'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/en/bw/bw1/113/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Blue Flare' AND attackCost = 'FireFireColorless' AND attackDamage = '120'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/fr/bw/bw6/99/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Coup Double' AND attackCost = 'Incolore' AND attackDamage = '10'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/en/bw/bw6/90/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Mach Cut' AND attackCost = 'Fighting' AND attackDamage = '60'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/en/bw/bw6/90/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Dragonblade' AND attackCost = 'WaterFighting' AND attackDamage = '100'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/fr/bw/bw9/42/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Corne Empoisonnée' AND attackCost = 'PsyIncolore' AND attackDamage = '50'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/fr/bw/bw9/42/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Double Écrasement' AND attackCost = 'PsyIncoloreIncolore' AND attackDamage = '60'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/en/bw/bw8/38/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Absorb' AND attackCost = 'WaterColorless' AND attackDamage = '10'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/fr/bw/bw2/17/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Giga-Sangsue' AND attackCost = 'PlanteIncolore' AND attackDamage = '30'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/fr/bw/bw2/17/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Lame Sainte' AND attackCost = 'PlantePlanteIncolore' AND attackDamage = '100'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/en/bw/bw7/16/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Sleep Powder' AND attackCost = 'Grass' AND attackDamage = '10'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/en/bw/bw5/70/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Paralyzing Gaze' AND attackCost = 'Colorless' AND attackDamage = null))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/en/bw/bw5/70/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Shadow Bind' AND attackCost = 'DarknessColorless' AND attackDamage = '20'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/en/bw/bw1/22/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Flame Burst' AND attackCost = 'Fire' AND attackDamage = '20'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/en/bw/bw1/22/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Fury Swipes' AND attackCost = 'ColorlessColorlessColorless' AND attackDamage = '40'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/fr/bw/bw2/88/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Cru-Aile' AND attackCost = 'IncoloreIncolore' AND attackDamage = '40'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/fr/bw/bw2/88/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Rapace' AND attackCost = 'IncoloreIncoloreIncolore' AND attackDamage = '90'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/en/bw/bw2/80/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Gust' AND attackCost = 'ColorlessColorless' AND attackDamage = '20'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/fr/bw/bw8/102/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Bâillement' AND attackCost = 'Incolore' AND attackDamage = null))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/fr/bw/bw9/96/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Bélier' AND attackCost = 'IncoloreIncolore' AND attackDamage = '30'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/en/bw/bw1/88/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Tail Slap' AND attackCost = 'Colorless' AND attackDamage = '10'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/fr/bw/bw9/92/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Vision Puissante' AND attackCost = 'IncoloreIncolore' AND attackDamage = '10'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/fr/bw/bw9/92/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Vol' AND attackCost = 'IncoloreIncoloreIncolore' AND attackDamage = '50'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/en/bw/bw2/84/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Last Resort' AND attackCost = 'Colorless' AND attackDamage = '30'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/fr/bw/dv1/6/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Coup d''Boule' AND attackCost = 'Incolore' AND attackDamage = '10'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/fr/bw/dv1/6/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Dracogriffe' AND attackCost = 'FeuEau' AND attackDamage = '20'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/en/bw/bw9/5/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Blockade' AND attackCost = 'Colorless' AND attackDamage = '10'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/en/bw/bw9/5/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Stomp' AND attackCost = 'GrassColorlessColorless' AND attackDamage = '60'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/fr/bw/dv1/9/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Assistance Énergétique' AND attackCost = 'Incolore' AND attackDamage = null))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/fr/bw/dv1/9/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Guérison Céleste' AND attackCost = 'FeuPsy' AND attackDamage = '40'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/en/bw/bw4/8/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Find a Friend' AND attackCost = 'Colorless' AND attackDamage = null))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/en/bw/bw4/8/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Rising Lunge' AND attackCost = 'GrassColorless' AND attackDamage = '10'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/fr/bw/bw4/11/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Fournaise' AND attackCost = 'FeuIncolore' AND attackDamage = '20'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/en/bw/bw3/10/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Toxic' AND attackCost = 'Grass' AND attackDamage = null))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/en/bw/bw3/10/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Body Slam' AND attackCost = 'ColorlessColorless' AND attackDamage = '30'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/en/bw/bw6/95/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Crunch' AND attackCost = 'ColorlessColorless' AND attackDamage = '30'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/en/bw/bw6/95/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Dragon Claw' AND attackCost = 'PsychicDarknessDarkness' AND attackDamage = '80'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/fr/bw/bw7/56/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Coud''Pattes' AND attackCost = 'Incolore' AND attackDamage = '10'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/en/bw/bw1/51/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Attract' AND attackCost = 'Colorless' AND attackDamage = null))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/en/bw/bw1/51/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Heart Stamp' AND attackCost = 'PsychicColorless' AND attackDamage = '40'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/en/bw/bw7/81/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Poison Ring' AND attackCost = 'Fighting' AND attackDamage = '20'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/en/bw/bw7/81/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Night Slash' AND attackCost = 'FightingColorless' AND attackDamage = '40'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/fr/bw/bw6/103/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Coup Écrasant' AND attackCost = 'IncoloreIncoloreIncoloreIncolore' AND attackDamage = '100'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/en/bw/bw4/7/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Collect' AND attackCost = 'Grass' AND attackDamage = null))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/en/bw/bw4/7/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Stadium Drain' AND attackCost = 'GrassColorless' AND attackDamage = '30'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/fr/bw/bw8/95/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Tranche' AND attackCost = 'IncoloreIncoloreIncolore' AND attackDamage = '60'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/fr/bw/bw8/95/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Baliste Noire' AND attackCost = 'EauEauÉlectriqueIncolore' AND attackDamage = '200'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/en/bw/bw5/87/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Roar' AND attackCost = 'Colorless' AND attackDamage = null))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/en/bw/bw5/87/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Tackle' AND attackCost = 'ColorlessColorless' AND attackDamage = '30'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/fr/bw/bw9/83/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Rendre Sourd' AND attackCost = 'IncoloreIncoloreIncolore' AND attackDamage = '60'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/fr/bw/bw9/83/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Aile Soin' AND attackCost = 'PlanteÉlectriqueIncoloreIncolore' AND attackDamage = '90'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/en/bw/bw5/76/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Charge Beam' AND attackCost = 'ColorlessColorless' AND attackDamage = '20'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/en/bw/bw5/76/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Vice Grip' AND attackCost = 'MetalColorlessColorless' AND attackDamage = '50'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/fr/bw/bw3/44/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Affolement' AND attackCost = 'Psy' AND attackDamage = '10'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/en/bw/bw4/40/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Thundershock' AND attackCost = 'Lightning' AND attackDamage = '20'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/en/bw/bw4/40/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Slam' AND attackCost = 'LightningColorlessColorless' AND attackDamage = '80'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/en/bw/bw5/12/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Sand-Attack' AND attackCost = 'Colorless' AND attackDamage = '20'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/en/bw/bw5/12/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Fire Slash' AND attackCost = 'FireColorlessColorless' AND attackDamage = '60'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/fr/bw/bw2/55/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Coud''Boue' AND attackCost = 'CombatCombatIncolore' AND attackDamage = '40'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/en/bw/bw2/50/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Headbutt' AND attackCost = 'Colorless' AND attackDamage = '10'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/en/bw/bw2/50/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Reckless Charge' AND attackCost = 'FightingColorless' AND attackDamage = '30'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/fr/bw/bw2/48/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Claque' AND attackCost = 'Psy' AND attackDamage = '30'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/fr/bw/bw2/48/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Choc Émotionnel' AND attackCost = 'PsyIncoloreIncolore' AND attackDamage = '60'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/en/bw/bw1/44/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Stun Needle' AND attackCost = 'Lightning' AND attackDamage = '10'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/fr/bw/bw2/50/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Coup d''Boule' AND attackCost = 'Incolore' AND attackDamage = '10'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/fr/bw/bw2/50/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Attaque Imprudente' AND attackCost = 'CombatIncolore' AND attackDamage = '30'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/en/bw/bw9/45/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Lure Poison' AND attackCost = 'Psychic' AND attackDamage = null))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/en/bw/bw9/45/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Sludge Toss' AND attackCost = 'PsychicColorlessColorless' AND attackDamage = '30'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/fr/bw/bw3/47/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Embuscade' AND attackCost = 'PsyIncolore' AND attackDamage = '40'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/en/bw/bw6/43/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Energy Crush' AND attackCost = 'Lightning' AND attackDamage = '20'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/en/bw/bw6/43/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Flash Impact' AND attackCost = 'LightningColorlessColorless' AND attackDamage = '80'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/fr/bw/bw3/89/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Serre' AND attackCost = 'IncoloreIncoloreIncolore' AND attackDamage = '60'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/en/bw/bw11/81/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Nerve Shot' AND attackCost = 'Fighting' AND attackDamage = '30'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/en/bw/bw11/81/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Pandemonium Blade' AND attackCost = 'FightingColorlessColorless' AND attackDamage = '60'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/fr/bw/bw7/70/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Espionnage' AND attackCost = 'Psy' AND attackDamage = null))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/fr/bw/bw7/70/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Crèvecœur' AND attackCost = 'IncoloreIncolore' AND attackDamage = '20'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/en/bw/bw10/63/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Knock Away' AND attackCost = 'Colorless' AND attackDamage = '10'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/en/bw/bw10/63/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Rollout' AND attackCost = 'FireWaterColorless' AND attackDamage = '50'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/fr/bw/bw10/68/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Regard Paralysant' AND attackCost = 'Incolore' AND attackDamage = null))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/fr/bw/bw10/68/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Dracogriffe' AND attackCost = 'CombatMétal' AND attackDamage = '40'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/en/bw/bw11/62/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Poison Jab' AND attackCost = 'PsychicColorless' AND attackDamage = '20'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/fr/bw/bw1/46/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Toile Élek' AND attackCost = 'Électrique' AND attackDamage = '20'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/fr/bw/bw1/46/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Vampirisme' AND attackCost = 'IncoloreIncolore' AND attackDamage = '40'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/en/bw/bw9/41/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Poison Sting' AND attackCost = 'PsychicColorless' AND attackDamage = '20'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/en/bw/bw9/41/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Double Kick' AND attackCost = 'PsychicColorlessColorless' AND attackDamage = '40'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/fr/bw/bw6/13/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Piqûre Piquante' AND attackCost = 'PlanteIncolore' AND attackDamage = '10'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/en/bw/bw6/12/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Double Whip' AND attackCost = 'Colorless' AND attackDamage = '10'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/en/bw/bw6/12/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Relaxing Fragrance' AND attackCost = 'Grass' AND attackDamage = null))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/fr/bw/bw10/73/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Rayon Désintégrateur' AND attackCost = 'IncoloreIncolore' AND attackDamage = '30'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/en/bw/bw1/67/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Taunt' AND attackCost = 'Colorless' AND attackDamage = null))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/en/bw/bw1/67/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Sucker Punch' AND attackCost = 'ColorlessColorless' AND attackDamage = '30'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/fr/bw/bw7/65/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Direct Toxik' AND attackCost = 'PsyIncolore' AND attackDamage = '20'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/en/bw/bw5/59/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Low Kick' AND attackCost = 'Colorless' AND attackDamage = '20'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/en/bw/bw5/59/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Steel Swing' AND attackCost = 'FightingColorlessColorless' AND attackDamage = '60'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/fr/bw/bw6/58/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Tit''Sieste' AND attackCost = 'IncoloreIncolore' AND attackDamage = null))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/fr/bw/bw6/58/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Écras''Face' AND attackCost = 'PsyIncoloreIncolore' AND attackDamage = '40'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/en/bw/bw1/53/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Poison Sting' AND attackCost = 'PsychicColorless' AND attackDamage = '20'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/en/bw/bw1/53/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Rollout' AND attackCost = 'PsychicColorlessColorless' AND attackDamage = '50'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/fr/bw/bw8/75/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Koud''Poing' AND attackCost = 'Incolore' AND attackDamage = '10'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/fr/bw/bw8/75/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Koud''Pied' AND attackCost = 'CombatIncolore' AND attackDamage = '20'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/en/bw/bw1/69/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Spit Acid' AND attackCost = 'Darkness' AND attackDamage = '20'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/en/bw/bw1/69/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'High Jump Kick' AND attackCost = 'DarknessDarknessColorless' AND attackDamage = '70'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/fr/bw/bw7/37/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Plongée Profonde' AND attackCost = 'IncoloreIncolore' AND attackDamage = null))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/fr/bw/bw7/37/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Aquasonique' AND attackCost = 'EauEauIncolore' AND attackDamage = '70'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/en/bw/bw10/33/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Crush and Burn' AND attackCost = 'LightningColorless' AND attackDamage = '30'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/en/bw/bw10/33/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Thunder Tempest' AND attackCost = 'LightningColorlessColorlessColorless' AND attackDamage = '50'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/en/bw/bw6/10/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Dig' AND attackCost = 'Colorless' AND attackDamage = '10'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/en/bw/bw6/109/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Pound' AND attackCost = 'Colorless' AND attackDamage = '10'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/en/bw/bw6/109/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Reckless Charge' AND attackCost = 'ColorlessColorless' AND attackDamage = '30'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/fr/bw/bw8/63/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Amoncellement' AND attackCost = 'Psy' AND attackDamage = null))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/fr/bw/bw8/63/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Giclée Vaseuse' AND attackCost = 'IncoloreIncolore' AND attackDamage = '20'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/en/bw/bw7/58/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Headbutt Bounce' AND attackCost = 'PsychicPsychicColorless' AND attackDamage = '60'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/fr/bw/bw7/39/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Pluie Éclaboussante' AND attackCost = 'Eau' AND attackDamage = '10'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/fr/bw/bw7/39/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Carap''Attaque' AND attackCost = 'EauIncolore' AND attackDamage = '20'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/en/bw/bw4/35/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Vengeful Wish' AND attackCost = 'Colorless' AND attackDamage = null))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/en/bw/bw4/35/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Absorb Life' AND attackCost = 'WaterWaterColorless' AND attackDamage = '30'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/en/bw/bw8/84/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Silent Claw' AND attackCost = 'Colorless' AND attackDamage = null))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/en/bw/bw8/84/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Fake Out' AND attackCost = 'DarknessColorless' AND attackDamage = '30'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/fr/bw/bwp/BW13/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Ronge' AND attackCost = 'Incolore' AND attackDamage = '10'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/fr/bw/bwp/BW13/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Coup de Queue' AND attackCost = 'IncoloreIncolore' AND attackDamage = '20'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/en/bw/bw6/89/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Dragonslice' AND attackCost = 'WaterFighting' AND attackDamage = '20'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/en/bw/bw11/101/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Dragon Stream' AND attackCost = 'FireColorlessColorless' AND attackDamage = '60'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/en/bw/bw11/101/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Ice Burn' AND attackCost = 'FireFireWaterColorless' AND attackDamage = '150'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/fr/bw/bw6/61/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Piège Osseux' AND attackCost = 'Combat' AND attackDamage = '30'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/fr/bw/bw6/61/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Coupe-Tourbillon' AND attackCost = 'CombatIncoloreIncolore' AND attackDamage = '60'))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/en/bw/bw10/55/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Roar' AND attackCost = 'Colorless' AND attackDamage = null))
	((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/en/bw/bw10/55/high.webp'), (SELECT attackId FROM P10_Attack WHERE attackName = 'Ambush' AND attackCost = 'DarknessColorless' AND attackDamage = '20'))