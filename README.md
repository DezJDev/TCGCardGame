# TCGCardGame
  Le TCGCardGame est un projet proposé par l'universite du Havre Normandie.  
Nous devons réaliser un site en utilisant trois façons sql pour la Base de Donnée du site.
MySQL, PostgreSQL et Oracle.  
Le but du dite sera de créer un site de collection où on répertorie les cartes Pokémons possédées 
par les utilisateurs du site.  
__Exemple d'une carte Pokémon:__
![Capture d'écran 2023-12-16 110013](https://github.com/DezJDev/TCGCardGame/assets/144434644/0e408b82-a4b4-46dc-99fe-233203a5d4a9)
Voici une carte Pokémon. Si vous l’avez dans votre main, 
félicitations vous avez l’un des millions d’exemplaires de 
cette carte. Il existe en tout plus 25 000 cartes Pokémon 
différentes, toutes extensions confondues. Cette 
information date de 2021.  

### Notre Base de Donnée aura comme modèle Entité / Association :
![ModeleEA](https://github.com/DezJDev/TCGCardGame/assets/144434644/2bc51e56-1968-44bb-93e2-34ba25a4c8bb)

### Modèle Relationnel de notre BDD :

__Relations & Forme Normale de la BDD:__
__Relation Card :__
Card (cardId, cardCategory, cardName, cardHp, cardRarity, cardImg, cardType, cardExtension, 
cardRetreat, cardLang)
cardId -> (cardCategory, cardName, cardHp, cardRarity, cardImg, cardType cardExtension, 
cardRetreat, cardLang)

__Relation Ability :__
Ability (abilityId, abilityName, abilityEffect)
abilityId ->(abilityName, abilityEffect)

__Relation Attack :__
Attack (attackId, attackName, attackCost, attackDamage, attackEffect)
attackId -> (attackName, attackCost, attackDamage, attackEffect)

__Relation Resistance :__
Resistance (resistanceId ,resistanceType, resistanceValue, resistanceLang)
resistanceId -> (resistanceType, resistanceValue, resistanceLang)

 __Relation Weakness :__
Weakness(weaknessId, weaknessType, weaknessValue)
weaknessId -> (weaknessType, weaknessValue)

__Relation User :__
User (userId, userName, userDob, userStatus, userNumCards, userLogin, userPass)
userId -> (userName, userDob, userStatus, userNumCards, userLogin, userPass)

__Relation Collection :__
Collection(userId, cardId)
Elle ne contient aucune dépendance fonctionelle.

__Relation Contient :__
Contient(cardId, attackId)
Elle ne contient aucune dépendance fonctionelle.

__Forme Normale de la BDD:__
 __Relation Card :__  
1. Respect de la 1NF : Tous les attributs de la relations sont atomiques.
2. Respect de la 2NF : La clé minimale cardId est atomique.
3. Respect de la 3NF : Chaque attribut dépend de la clé minimale.
4. Respect de la BCNF : Aucun Attribut non clé définit une partie de la clé.

 __Relation Ability :__
1. Respect de la 1NF : Tous les attributs de la relations sont atomiques.
2. Respect de la 2NF : La clé minimale abilityId est atomique.
3. Respect de la 3NF : Chaque attribut dépend de la clé minimale.
4. Respect de la BCNF : Aucun Attribut non clé définit une partie de la clé.
   
 __Relation Attack :__
1. Respect de la 1NF : Tous les attributs de la relations sont atomiques.
2. Respect de la 2NF : La clé minimale attackId est atomique.
3. Respect de la 3NF : Chaque attribut dépend de la clé minimale.
4. Respect de la BCNF : Aucun Attribut non clé définit une partie de la clé.
   
 __Relation Resistance :__
1. Respect de la 1NF : Tous les attributs de la relations sont atomiques.
2. Respect de la 2NF : La clé minimale resistanceId est atomique.
3. Respect de la 3NF : Chaque attribut dépend de la clé minimale.
4. Respect de la BCNF : Aucun Attribut non clé définit une partie de la clé.
   
__Relation Weakness :__
1. Respect de la 1NF : Tous les attributs de la relations sont atomiques.
2. Respect de la 2NF : La clé minimale weaknessId est atomique.
3. Respect de la 3NF : Chaque attribut dépend de la clé minimale.
4. Respect de la BCNF : Aucun Attribut non clé définit une partie de la clé.
   
__Relation User :__
1. Respect de la 1NF : Tous les attributs de la relations sont atomiques.
2. Respect de la 2NF : La clé minimale userId est atomique.
3. Respect de la 3NF : Chaque attribut dépend de la clé minimale.
4. Respect de la BCNF : Aucun Attribut non clé définit une partie de la clé.
   
__Relation Contient :__
 1. Respect de la 1NF : Tous les attributs de la relations sont atomiques.
 2. Respect de la 2NF : Aucun attribut non-clé ne dépend d’une partie de la clé.
 3. Respect de la 3NF : Chaque attribut dépend de la clé minimale.
 4. Respect de la BCNF : Aucun Attribut non clé définit une partie de la clé.

__Relation Collection :__
 1. Respect de la 1NF : Tous les attributs de la relations sont atomiques.
 2. Respect de la 2NF : Aucun attribut non-clé ne dépend d’une partie de la clé.
 3. Respect de la 3NF : Chaque attribut dépend de la clé minimale.
 4. Respect de la BCNF : Aucun Attribut non clé définit une partie de la clé.

Nos relations respectent toutes la Boyce-Codd Forme Normale.

