from random import randint


def getNameTable(chaine: str) -> str:
    for i, c in enumerate(chaine):
        if c.isupper():
            return chaine[:i].capitalize()
    return chaine.capitalize()


def traitementLigne(ligne: str) -> list[str]:
    attributs = ligne.split("|")
    attributsTraites = []
    for element in attributs:
        element = element.replace("\n", "").replace("'", "''")
        tableauProvisoire = element.split(":")
        if len(tableauProvisoire) > 2:
            tableauProvisoire[1] += ":" + tableauProvisoire[2]
        if not tableauProvisoire == ['']:
            attributsTraites.append(tableauProvisoire[1])

    return attributsTraites


def getAttributsFromTable(ligne: str, attributs: list[int]) -> list[str]:
    nbAttribut = len(attributs)
    donnees = ligne.split("|")
    donneesTraites = []
    for lignes in donnees:
        donneesTraites.append(lignes.split(":")[0])

    resultat = []
    for i in range(nbAttribut):
        attributNonTraite = donneesTraites[attributs[i]]
        if attributNonTraite[-1].isdigit():
            resultat.append(attributNonTraite[:-1])
        else:
            resultat.append(attributNonTraite)

    return resultat


class Gestionnaire:
    newSource = open("school_data.txt", "w+", encoding="utf-8")
    francais = open("FR-DataBlackWhiteWithoutDoublon.txt", "r", encoding="utf-8")
    anglais = open("EN-DataBlackWhiteWithoutDoublon.txt", "r", encoding="utf-8")
    perso = open("perso.txt", "r", encoding="utf-8")

    FRnumberLines = sum(1 for _ in francais)
    ENnumberLines = sum(1 for _ in anglais)
    FRExistingLines = []
    ENExistingLines = []

    for i in range(100):
        francais.seek(0)
        anglais.seek(0)
        FRLineAlea = randint(0, FRnumberLines)
        ENLineAlea = randint(0, ENnumberLines)

        francais.seek(0)
        while FRLineAlea in FRExistingLines:
            FRLineAlea = randint(0, FRnumberLines)
        FRExistingLines.append(FRLineAlea)
        for k in range(FRLineAlea):
            francais.readline()
        FRLinetoAppend = francais.readline()
        dataLinetoAppend = traitementLigne(FRLinetoAppend)

        while not dataLinetoAppend:
            francais.seek(0)
            while FRLineAlea in FRExistingLines:
                FRLineAlea = randint(0, FRnumberLines)
            FRExistingLines.append(FRLineAlea)
            for k in range(FRLineAlea):
                francais.readline()
            FRLinetoAppend = francais.readline()
            dataLinetoAppend = traitementLigne(FRLinetoAppend)

        if dataLinetoAppend[1] == "Pokémon" or not dataLinetoAppend[1] == "Pokemon":
            FRLinetoAppend = FRLinetoAppend.replace("attackName1:null", "attackName1:Bug de l'API").replace("attackName2:null", "attackName2:Bug de l'API")
        newSource.write(FRLinetoAppend)

        ENLinetoAppend = "cardCategory:Trainer"
        while "cardCategory:Trainer" in ENLinetoAppend or "cardImg:/high.webp" in ENLinetoAppend:
            anglais.seek(0)
            while ENLineAlea in ENExistingLines:
                ENLineAlea = randint(0, ENnumberLines)
            ENExistingLines.append(ENLineAlea)
            for k in range(ENLineAlea):
                anglais.readline()
            ENLinetoAppend = anglais.readline()
            dataLinetoAppend = traitementLigne(ENLinetoAppend)

            while not dataLinetoAppend:
                anglais.seek(0)
                while ENLineAlea in ENExistingLines:
                    ENLineAlea = randint(0, ENnumberLines)
                ENExistingLines.append(ENLineAlea)
                for k in range(ENLineAlea):
                    anglais.readline()
                ENLinetoAppend = anglais.readline()
                dataLinetoAppend = traitementLigne(ENLinetoAppend)

            if dataLinetoAppend[1] == "Pokémon" or not dataLinetoAppend[1] == "Pokemon":
                ENLinetoAppend = ENLinetoAppend.replace("attackName1:null", "attackName1:Bug de l'API").replace("attackName2:null", "attackName2:Bug de l'API")
        newSource.write(ENLinetoAppend)


    def __init__(self, fileName: str, extension: str):
        self.cible = open(fileName, "w+")
        self.extension = extension.capitalize()
        self.nameCible = fileName
        self.cardstoRemove = []

# ------------------------ SQL ------------------------------
    def sqlTable(self):
        types = ('Incolore', 'Feu', 'Eau', 'Plante', 'Combat', 'Métal', 'Électrique', 'Psy', 'Obscurité', 'Dragon',
                 'Colorless', 'Fire', 'Water', 'Grass', 'Fighting', 'Metal', 'Lightning', 'Psychic', 'Darkness')

        if self.extension == "Postgresql":
            auto = "SERIAL"
        else:
            auto = "INT AUTO_INCREMENT"

        tbl = "DROP TABLE IF EXISTS"
        drop = f"{tbl} P10_Contient;\n{tbl} P10_Collection;\n{tbl} P10_Card;\n{tbl} " \
               f"P10_Weakness;\n{tbl} P10_User;\n{tbl} P10_Ability;\n{tbl} P10_Resistance;\n{tbl} P10_Attack;\n"

        abilityTable = f"CREATE TABLE IF NOT EXISTS P10_Ability(\n\tabilityId {auto} PRIMARY KEY,\n\t" \
                       f"abilityName varchar(50),\n\tabilityEffect TEXT NOT NULL);\n"

        resistanceTable = f"CREATE TABLE IF NOT EXISTS P10_Resistance(\n\tresistanceId {auto} PRIMARY KEY,\n\t" \
                          f"resistanceType varchar(10) CHECK (resistanceType IN {types}),\n\tresistanceValue varchar(5) CHECK (resistanceValue IN ('/2','-20','-10','-30')));\n"

        weaknessTable = f"CREATE TABLE IF NOT EXISTS P10_Weakness(\n\tweaknessId {auto} PRIMARY KEY,\n\t" \
                        f"weaknessType varchar(10) CHECK (weaknessType IN {types}),\n\tweaknessValue varchar(5) CHECK (weaknessValue IN ('×2','x2','+20','+10','+30')));\n"

        attackTable = f"CREATE TABLE IF NOT EXISTS P10_Attack(\n\tattackId {auto} PRIMARY KEY,\n\t" \
                      f"attackName varchar(50) NOT NULL,\n\tattackCost varchar(50),\n\tattackDamage varchar(4)," \
                      f"\n\tattackEffect varchar(255));\n"

        cardTable = f"CREATE TABLE IF NOT EXISTS P10_Card(\n\tcardId {auto} PRIMARY KEY,\n\t" \
                    f"cardCategory varchar(50) DEFAULT 'Pokémon' CHECK (cardCategory IN ('Pokémon','Pokemon','Dresseur','Trainer','Énergie','Energy')),\n\tcardName varchar(50) NOT NULL,\n\tcardHP INT,\n\t" \
                    f"cardRarity varchar(50) DEFAULT 'Commune' CHECK (cardRarity IN ('Commune','Common','Uncommon','Peu Commune','Rare','Ultra Rare','Secret Rare','Magnifique','Magnifique rare')),\n\tcardImg varchar(100) NOT NULL,\n\tcardType varchar(10) CHECK (cardType IN {types}),\n\t" \
                    f"cardExtension TEXT NOT NULL,\n\tcardRetreat INT,\n\tcardLang varchar(20) CHECK(cardLang IN ('fr','en')),\n\t" \
                    f"abilityId INT REFERENCES P10_Ability(abilityId),\n\t" \
                    f"resistanceId INT REFERENCES P10_Resistance(resistanceId),\n\t" \
                    f"weaknessId INT REFERENCES P10_Weakness(weaknessId));\n"

        userTable = f"CREATE TABLE IF NOT EXISTS P10_User(\n\tuserId {auto} PRIMARY KEY,\n\t" \
                    f"userName varchar(20) NOT NULL,\n\tuserDob DATE NOT NULL,\n\tuserStatus varchar(10) CHECK(userStatus IN ('root','user'))," \
                    f"\n\tuserLogin varchar(255) NOT NULL,\n\tuserPass varchar(255) NOT NULL);\n"

        contientTable = f"CREATE TABLE IF NOT EXISTS P10_Contient(\n\tcardId INT REFERENCES P10_Card(cardId)" \
                        f",\n\tattackId INT REFERENCES P10_Attack(attackId));\n"

        collectionTable = f"CREATE TABLE IF NOT EXISTS P10_Collection(\n\tcardId INT REFERENCES P10_Card(cardId)" \
                          f",\n\tuserId INT REFERENCES P10_User(userId));\n"

        self.cible.write(
            f"{drop}\n{userTable}\n{abilityTable}\n{resistanceTable}\n{weaknessTable}\n{attackTable}\n{cardTable}\n{contientTable}\n{collectionTable}")

    def implementsUsersSQL(self):
        Gestionnaire.perso.seek(0)
        self.cible.write("\n\nINSERT INTO P10_User(userName,userDob,userStatus,userLogin,userPass) VALUES ")
        for lignes in self.perso.readlines():
            data = traitementLigne(lignes)
            date = data[1].split("-")
            self.cible.write(f"\n\t('{data[0]}','{date[2]}-{date[0]}-{date[1]}','{data[2]}','{data[3]}','{data[4]}'),")
        self.cible.seek(self.cible.tell() - 1)
        self.cible.write(";")

    def implementsAbilityNoOracle(self):
        Gestionnaire.newSource.seek(0)
        self.cible.write("\n\nINSERT INTO P10_Ability(abilityName,abilityEffect) VALUES")
        abilitiesExisting = []
        for lignes in Gestionnaire.newSource.readlines():
            data = traitementLigne(lignes)
            chaineImp = ""
            ability = (data[10],data[11])
            if ability not in abilitiesExisting and ability != ("null","null"):
                abilitiesExisting.append(ability)
                chaineImp += f"\n\t{ability},"
                self.cible.write(chaineImp)
        self.cible.seek(self.cible.tell() - 1)
        self.cible.write(";")

    @staticmethod
    def checkattacksareclean(data: list[str]):
        attack1bool = True
        if data[12] == "null" and (data[13],data[14]) != ("null", "null"):
            attack1bool = False
        attack2bool = True
        if data[16] == "null" and (data[17], data[18]) != ("null", "null"):
            attack2bool = False
        return [attack1bool, attack2bool]

    def implementsAttacksNoOracle(self):
        Gestionnaire.newSource.seek(0)
        self.cible.write("\n\nINSERT INTO P10_Attack(attackName,attackCost,attackDamage,attackEffect) VALUES")
        attacksExisting = []
        for lignes in Gestionnaire.newSource.readlines():
            data = traitementLigne(lignes)

            chaineImp = ""
            attacksareclean = self.checkattacksareclean(data)
            attack1 = (data[12],data[13],data[14],data[15])
            if attack1 not in attacksExisting and attack1 != ("null","null","null","null") and attacksareclean[0]:
                attacksExisting.append(attack1)
                chaineImp += f"\n\t{attack1},"
                self.cible.write(chaineImp)

            chaineImp = ""
            attack2 = (data[16], data[17], data[18], data[19])
            if attack2 not in attacksExisting and attack2 != ("null","null","null","null") and attacksareclean[1]:
                attacksExisting.append(attack2)
                chaineImp += f"\n\t{attack2},"
                self.cible.write(chaineImp)

        self.cible.seek(self.cible.tell() - 1)
        self.cible.write(";")

    def implementsResistancesNoOracle(self):
        Gestionnaire.newSource.seek(0)
        self.cible.write("\n\nINSERT INTO P10_Resistance(resistanceType,resistanceValue) VALUES")
        resistancesExisting = []
        for lignes in Gestionnaire.newSource.readlines():
            data = traitementLigne(lignes)
            chaineImp = ""
            data[20] = data[20].replace("Métal","Metal")
            resistance = (data[20],data[21])
            if resistance not in resistancesExisting and resistance != ("null","null"):
                resistancesExisting.append(resistance)
                chaineImp += f"\n\t{resistance},"
                self.cible.write(chaineImp)
        self.cible.seek(self.cible.tell() - 1)
        self.cible.write(";")

    def implementsWeaknessNoOracle(self):
        Gestionnaire.newSource.seek(0)
        self.cible.write("\n\nINSERT INTO P10_Weakness(weaknessType,weaknessValue) VALUES")
        weaknessExisting = []
        for lignes in Gestionnaire.newSource.readlines():
            data = traitementLigne(lignes)
            chaineImp = ""
            data[22] = data[22].replace("Métal","Metal")
            weakness = (data[22],data[23])
            if weakness not in weaknessExisting and weakness != ("null","null"):
                weaknessExisting.append(weakness)
                chaineImp += f"\n\t{weakness},"
                self.cible.write(chaineImp)
        self.cible.seek(self.cible.tell() - 1)
        self.cible.write(";")

    def implementsCardsNoOracle(self):
        Gestionnaire.newSource.seek(0)
        self.cible.write("\n\nINSERT INTO P10_Card(cardCategory,cardName,"
                         "cardHP,cardRarity,cardImg,cardType,cardExtension,"
                         "cardRetreat,cardLang,abilityId,weaknessId,resistanceId) VALUES")
        cardsExisting = []
        for lignes in Gestionnaire.newSource.readlines():
            donnees = traitementLigne(lignes)

            chaine = f"\n\t('{donnees[1]}','{donnees[2]}',{donnees[3]},'{donnees[4]}','{donnees[5]}','{donnees[6]}'," \
                     f"'{donnees[7]}',{donnees[8]},'{donnees[9]}'"

            if donnees[10] == "null" and donnees[11] != "null":
                chaine += f",(SELECT abilityId FROM P10_Ability WHERE abilityEffect = '{donnees[11]}')"

            elif donnees[10] != "null" and donnees[11] != "null":
                chaine += f",(SELECT abilityId FROM P10_Ability WHERE abilityName = '{donnees[10]}' " \
                          f"AND abilityEffect = '{donnees[11]}')"
            else:
                chaine += ",null"

            if donnees[22] != "null":
                chaine += f",(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = '{donnees[22]}' " \
                          f"AND weaknessValue = '{donnees[23]}')"
            else:
                chaine += ",null"

            if donnees[20] != "null":
                chaine += f",(SELECT resistanceId FROM P10_Resistance WHERE resistanceType = '{donnees[20]}' " \
                          f"AND resistanceValue = '{donnees[21]}')"
            else:
                chaine += ",null"

            chaine = chaine.replace("'null'", "null")
            attaquesClean = self.checkattacksareclean(donnees)
            if chaine not in cardsExisting and attaquesClean[0] and attaquesClean[1]:
                cardsExisting.append(chaine)
                self.cible.write(chaine + "),")
        self.cible.seek(self.cible.tell() - 1)
        self.cible.write(";")

    @staticmethod
    def checkifNull(data: list[str]):
        for i in range(12, 20):
            if data[i] == "null":
                data[i] = "IS NULL"
            else:
                data[i] = f"= '{data[i]}'"
        return data


    def implementsContientNoOracle(self):
        Gestionnaire.newSource.seek(0)
        self.cible.write("\n\nINSERT INTO P10_Contient(cardId,attackId) VALUES")
        for lignes in Gestionnaire.newSource.readlines(0):
            data = traitementLigne(lignes)
            attack1 = (data[12], data[13], data[14], data[15])
            attack2 = (data[16], data[17], data[18], data[19])
            data = self.checkifNull(data)
            attacksclean = self.checkattacksareclean(data)

            if attack1 != ("null", "null", "null", "null") and attacksclean[0]:
                self.cible.write(f"\n\t((SELECT cardId FROM P10_Card WHERE cardImg = '{data[5]}'),"
                                 f"(SELECT attackId FROM P10_Attack WHERE attackName {data[12]} AND "
                                 f"attackCost {data[13]} AND attackDamage {data[14]} AND attackEffect {data[15]})),")

            if attack2 != ("null", "null", "null", "null") and attacksclean[1]:
                self.cible.write(f"\n\t((SELECT cardId FROM P10_Card WHERE cardImg = '{data[5]}'),"
                                 f"(SELECT attackId FROM P10_Attack WHERE attackName {data[16]} AND "
                                 f"attackCost {data[17]} AND attackDamage {data[18]} AND attackEffect {data[19]})),")

        self.cible.seek(self.cible.tell() - 1)
        self.cible.write(";")

    def implementsCollectionNoOracle(self):
        Gestionnaire.newSource.seek(0)
        Gestionnaire.perso.seek(0)
        schoolNbLines = sum(1 for _ in Gestionnaire.newSource)
        self.cible.write(f"\n\n INSERT INTO P10_Collection(userId,cardId) VALUES ")
        for personnages in Gestionnaire.perso.readlines():
            personnagesData = traitementLigne(personnages)
            nombreAlea = randint(0, 7)
            for i in range(nombreAlea):
                Gestionnaire.newSource.seek(0)
                nbLigneAlea = randint(0, schoolNbLines-1)
                for j in range(nbLigneAlea):
                    Gestionnaire.newSource.readline()
                LinetoGive = Gestionnaire.newSource.readline()
                LinetoGive = traitementLigne(LinetoGive)
                self.cible.write(f"\n\t((SELECT userId FROM P10_User WHERE userName = '{personnagesData[0]}'),"
                                 f"(SELECT cardId FROM P10_Card WHERE cardImg = '{LinetoGive[5]}')),")
        self.cible.seek(self.cible.tell() - 1)
        self.cible.write(";")

# ------------------------ Oracle ---------------------------------------
    def oracleTable(self):
        types = ('Incolore', 'Feu', 'Eau', 'Plante', 'Combat', 'Métal', 'Électrique', 'Psy', 'Obscurité', 'Dragon',
                 'Colorless', 'Fire', 'Water', 'Grass', 'Fighting', 'Metal', 'Lightning', 'Psychic', 'Darkness')

        drops = "-- DROP TABLE P10_Card CASCADE CONSTRAINTS;\n" \
                "-- DROP TABLE P10_Ability CASCADE CONSTRAINTS;\n" \
                "-- DROP TABLE P10_Attack CASCADE CONSTRAINTS;\n" \
                "-- DROP TABLE P10_Resistance CASCADE CONSTRAINTS;\n" \
                "-- DROP TABLE P10_Weakness CASCADE CONSTRAINTS;\n" \
                "-- DROP TABLE P10_User CASCADE CONSTRAINTS;\n" \
                "-- DROP TABLE P10_Contient CASCADE CONSTRAINTS;\n" \
                "-- DROP TABLE P10_Collection CASCADE CONSTRAINTS;\n\n" \
                "-- DROP SEQUENCE seq_ability;\n" \
                "-- DROP SEQUENCE seq_resistance;\n" \
                "-- DROP SEQUENCE seq_weakness;\n" \
                "-- DROP SEQUENCE seq_attack;\n" \
                "-- DROP SEQUENCE seq_card;\n" \
                "-- DROP SEQUENCE seq_user;\n"

        sequences = "CREATE SEQUENCE seq_ability;\n" \
                    "CREATE SEQUENCE seq_resistance;\n" \
                    "CREATE SEQUENCE seq_weakness;\n" \
                    "CREATE SEQUENCE seq_attack;\n" \
                    "CREATE SEQUENCE seq_card;\n" \
                    "CREATE SEQUENCE seq_user;\n"

        abilityTable = f"CREATE TABLE P10_Ability(\n\tabilityId NUMBER DEFAULT seq_ability.nextval PRIMARY KEY,\n\t" \
                       "abilityName VARCHAR2(50),\n\tabilityEffect varchar2(500) NOT NULL);\n"

        resistanceTable = f"CREATE TABLE P10_Resistance(\n\tresistanceId NUMBER DEFAULT seq_resistance.nextval PRIMARY KEY,\n\t" \
                          "resistanceType VARCHAR2(20) NOT NULL,\n\tresistanceValue VARCHAR2(5) DEFAULT '-20',\n\t" \
                          f"CONSTRAINT CheckTypeResistance CHECK (resistanceType IN {types}),\n\t" \
                          f"CONSTRAINT CheckValueResistance CHECK (resistanceValue IN ('/2','-10','-20','-30')));\n"

        weaknessTable = f"CREATE TABLE P10_Weakness(\n\tweaknessId NUMBER DEFAULT seq_weakness.nextval PRIMARY KEY,\n\t" \
                        "weaknessType VARCHAR2(20) NOT NULL,\n\tweaknessValue VARCHAR2(5) DEFAULT '×2',\n\t" \
                        f"CONSTRAINT CheckTypeWeakness CHECK (weaknessType IN {types}),\n\t" \
                        f"CONSTRAINT CheckValueWeakness CHECK (weaknessValue IN ('×2','x2','+10','+20','+30')));\n"

        attackTable = f"CREATE TABLE P10_Attack(\n\tattackId NUMBER DEFAULT seq_attack.nextval PRIMARY KEY,\n\t" \
                      "attackName VARCHAR2(50) NOT NULL,\n\tattackCost VARCHAR2(50),\n\tattackDamage VARCHAR2(4)," \
                      "\n\tattackEffect VARCHAR2(255),\n\tattackLang VARCHAR2(20) DEFAULT 'fr',\n\t" \
                      "CONSTRAINT checkLang CHECK (attackLang IN ('fr','en')));\n"

        cardTable = f"CREATE TABLE P10_Card(\n\tcardId NUMBER DEFAULT seq_card.nextval PRIMARY KEY,\n\t" \
                    "cardCategory VARCHAR2(50) DEFAULT 'Pokémon',\n\tcardName VARCHAR2(50),\n\tcardHP NUMBER,\n\t" \
                    "cardRarity VARCHAR2(50) DEFAULT 'Commune',\n\tcardImg VARCHAR2(100),\n\tcardType VARCHAR2(20),\n\t" \
                    "cardExtension VARCHAR2(255),\n\tcardRetreat NUMBER DEFAULT 1,\n\tcardLang VARCHAR2(20) DEFAULT 'fr',\n\t" \
                    "abilityId NUMBER REFERENCES P10_Ability(abilityId),\n\t" \
                    "resistanceId NUMBER REFERENCES P10_Resistance(resistanceId),\n\t" \
                    "weaknessId NUMBER REFERENCES P10_Weakness(weaknessId),\n\t" \
                    f"CONSTRAINT CheckRarity CHECK (cardRarity IN ('Commune','Common','Uncommon','Peu Commune','Rare','Ultra Rare','Secret Rare','Magnifique','Magnifique rare')),\n\t" \
                    f"CONSTRAINT CheckCategory CHECK (cardCategory IN ('Pokémon','Pokemon','Dresseur','Trainer', 'Énergie', 'Energy')));\n"

        userTable = f"CREATE TABLE P10_User(\n\tuserId NUMBER DEFAULT seq_user.nextval PRIMARY KEY,\n\t" \
                    "userName VARCHAR2(20),\n\tuserDob DATE,\n\tuserStatus VARCHAR2(10) DEFAULT 'user'," \
                    "\n\tuserLogin VARCHAR2(255),\n\tuserPass VARCHAR2(255),\n\t" \
                    f"CONSTRAINT CheckStatus CHECK (userStatus IN ('root', 'user')));\n"

        contientTable = (f"CREATE TABLE P10_Contient(\n\tcardId NUMBER REFERENCES P10_Card(cardId)"
                         f",\n\tattackId NUMBER REFERENCES P10_Attack(attackId));\n")

        collectionTable = f"CREATE TABLE P10_Collection(\n\tcardId NUMBER REFERENCES P10_Card(cardId)" \
                          f",\n\tuserId NUMBER REFERENCES P10_User(userId));\n"

        self.cible.write(
            f"{drops}\n{sequences}\n{userTable}\n{abilityTable}\n{resistanceTable}\n{weaknessTable}\n{attackTable}\n{cardTable}\n{contientTable}\n{collectionTable}\n")

    def implementsUsersOracle(self):
        Gestionnaire.perso.seek(0)
        for lignes in self.perso.readlines():
            data = traitementLigne(lignes)
            date = data[1].split("-")
            self.cible.write(
                f"INSERT INTO P10_User(userName,userDob,userStatus,userLogin,userPass) VALUES ('{data[0]}',TO_DATE('{date[2]}/{date[0]}/{date[1]}','yyyy/mm/dd'),'{data[2]}','{data[3]}','{data[4]}');\n")

    def implementsAbilityOracle(self):
        Gestionnaire.newSource.seek(0)
        abilitiesExisting = []
        for lignes in Gestionnaire.newSource.readlines():
            data = traitementLigne(lignes)
            chaineImp = "\nINSERT INTO P10_Ability(abilityName,abilityEffect) VALUES "
            ability = (data[10],data[11])
            if ability not in abilitiesExisting and ability != ("null","null"):
                abilitiesExisting.append(ability)
                chaineImp += f"{ability};"
                self.cible.write(chaineImp)

    def implementsAttacksOracle(self):
        Gestionnaire.newSource.seek(0)
        attacksExisting = []
        for lignes in Gestionnaire.newSource.readlines():
            data = traitementLigne(lignes)

            chaineImp = "\nINSERT INTO P10_Attack(attackName,attackCost,attackDamage,attackEffect) VALUES "
            attacksareclean = self.checkattacksareclean(data)
            attack1 = (data[12],data[13],data[14],data[15])
            if attack1 not in attacksExisting and attack1 != ("null","null","null","null") and attacksareclean[0]:
                attacksExisting.append(attack1)
                chaineImp += f"{attack1};"
                self.cible.write(chaineImp)

            chaineImp = "\nINSERT INTO P10_Attack(attackName,attackCost,attackDamage,attackEffect) VALUES "
            attack2 = (data[16], data[17], data[18], data[19])
            if attack2 not in attacksExisting and attack2 != ("null","null","null","null") and attacksareclean[1]:
                attacksExisting.append(attack2)
                chaineImp += f"{attack2};"
                self.cible.write(chaineImp)

    def implementsResistancesOracle(self):
        Gestionnaire.newSource.seek(0)
        resistancesExisting = []
        for lignes in Gestionnaire.newSource.readlines():
            data = traitementLigne(lignes)
            chaineImp = "\nINSERT INTO P10_Resistance(resistanceType,resistanceValue) VALUES "
            data[20] = data[20].replace("Métal","Metal")
            resistance = (data[20],data[21])
            if resistance not in resistancesExisting and resistance != ("null","null"):
                resistancesExisting.append(resistance)
                chaineImp += f"{resistance};"
                self.cible.write(chaineImp)

    def implementsWeaknessOracle(self):
        Gestionnaire.newSource.seek(0)
        weaknessExisting = []
        for lignes in Gestionnaire.newSource.readlines():
            data = traitementLigne(lignes)
            chaineImp = "\nINSERT INTO P10_Weakness(weaknessType,weaknessValue) VALUES "
            data[22] = data[22].replace("Métal","Metal")
            weakness = (data[22],data[23])
            if weakness not in weaknessExisting and weakness != ("null","null"):
                weaknessExisting.append(weakness)
                chaineImp += f"{weakness};"
                self.cible.write(chaineImp)

    def implementsCardsOracle(self):
        Gestionnaire.newSource.seek(0)
        cardsExisting = []
        for lignes in Gestionnaire.newSource.readlines():
            donnees = traitementLigne(lignes)

            chaine = f"\nINSERT INTO P10_Card(cardCategory,cardName," \
                     f"cardHP,cardRarity,cardImg,cardType,cardExtension," \
                     f"cardRetreat,cardLang,abilityId,weaknessId,resistanceId) VALUES ('{donnees[1]}','{donnees[2]}',{donnees[3]},'{donnees[4]}','{donnees[5]}','{donnees[6]}'," \
                     f"'{donnees[7]}',{donnees[8]},'{donnees[9]}'"

            if donnees[10] == "null" and donnees[11] != "null":
                chaine += f",(SELECT abilityId FROM P10_Ability WHERE abilityEffect = '{donnees[11]}')"

            elif donnees[10] != "null" and donnees[11] != "null":
                chaine += f",(SELECT abilityId FROM P10_Ability WHERE abilityName = '{donnees[10]}' " \
                          f"AND abilityEffect = '{donnees[11]}')"
            else:
                chaine += ",null"

            if donnees[22] != "null":
                chaine += f",(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = '{donnees[22]}' " \
                          f"AND weaknessValue = '{donnees[23]}')"
            else:
                chaine += ",null"

            if donnees[20] != "null":
                chaine += f",(SELECT resistanceId FROM P10_Resistance WHERE resistanceType = '{donnees[20]}' " \
                          f"AND resistanceValue = '{donnees[21]}')"
            else:
                chaine += ",null"

            chaine = chaine.replace("'null'", "null")
            if chaine not in cardsExisting:
                cardsExisting.append(chaine)
                self.cible.write(chaine + ");")

    def implementsContientOracle(self):
        Gestionnaire.newSource.seek(0)
        header = "\nINSERT INTO P10_Contient(cardId,attackId) VALUES "
        for lignes in Gestionnaire.newSource.readlines(0):
            data = traitementLigne(lignes)
            attack1 = (data[12], data[13], data[14], data[15])
            attack2 = (data[16], data[17], data[18], data[19])
            data = self.checkifNull(data)
            attacksclean = self.checkattacksareclean(data)

            if attack1 != ("null", "null", "null", "null") and attacksclean[0]:
                self.cible.write(f"{header}((SELECT cardId FROM P10_Card WHERE cardImg = '{data[5]}'),"
                                 f"(SELECT attackId FROM P10_Attack WHERE attackName {data[12]} AND "
                                 f"attackCost {data[13]} AND attackDamage {data[14]} AND attackEffect {data[15]}));")

            if attack2 != ("null", "null", "null", "null") and attacksclean[1]:
                self.cible.write(f"{header}((SELECT cardId FROM P10_Card WHERE cardImg = '{data[5]}'),"
                                 f"(SELECT attackId FROM P10_Attack WHERE attackName {data[16]} AND "
                                 f"attackCost {data[17]} AND attackDamage {data[18]} AND attackEffect {data[19]}));")

    def implementsCollectionOracle(self):
        Gestionnaire.newSource.seek(0)
        Gestionnaire.perso.seek(0)
        schoolNbLines = sum(1 for _ in Gestionnaire.newSource)
        header = f"\nINSERT INTO P10_Collection(cardId,userId) VALUES "
        for personnages in Gestionnaire.perso.readlines():
            personnagesData = traitementLigne(personnages)
            nombreAlea = randint(0, 7)
            for i in range(nombreAlea):
                Gestionnaire.newSource.seek(0)
                nbLigneAlea = randint(0, schoolNbLines-1)
                for j in range(nbLigneAlea):
                    Gestionnaire.newSource.readline()
                LinetoGive = Gestionnaire.newSource.readline()
                LinetoGive = traitementLigne(LinetoGive)
                self.cible.write(f"{header}((SELECT userId FROM P10_User WHERE userName = '{personnagesData[0]}'),"
                                 f"(SELECT cardId FROM P10_Card WHERE cardImg = '{LinetoGive[5]}'));")
        self.cible.seek(self.cible.tell() - 1)
        self.cible.write(";")

    def nettoyage(self):
        self.cible.seek(0)
        lignes = self.cible.readlines()
        self.cible.close()

        fichier = open(self.nameCible, "w")
        for ligne in lignes:
            newLine = ligne.replace("'null'", "null").replace(" ", " ").replace("Métal", "Metal").replace("\\xa0", " ").replace('"', "'")
            fichier.write(newLine)



        fichier.close()
        self.cible.close()



if __name__ == "__main__":
    gesteSQL = Gestionnaire("P10_PokemonMySQL.sql", "mysql")
    gesteSQL.sqlTable()
    gesteSQL.implementsUsersSQL()
    gesteSQL.implementsAbilityNoOracle()
    gesteSQL.implementsAttacksNoOracle()
    gesteSQL.implementsResistancesNoOracle()
    gesteSQL.implementsWeaknessNoOracle()
    gesteSQL.implementsCardsNoOracle()
    gesteSQL.implementsContientNoOracle()
    gesteSQL.implementsCollectionNoOracle()
    gesteSQL.nettoyage()

    gestePostgreSQL = Gestionnaire("P10_PokemonPostgresql.sql", "postgresql")
    gestePostgreSQL.sqlTable()
    gestePostgreSQL.implementsUsersSQL()
    gestePostgreSQL.implementsAbilityNoOracle()
    gestePostgreSQL.implementsAttacksNoOracle()
    gestePostgreSQL.implementsResistancesNoOracle()
    gestePostgreSQL.implementsWeaknessNoOracle()
    gestePostgreSQL.implementsCardsNoOracle()
    gestePostgreSQL.implementsContientNoOracle()
    gestePostgreSQL.implementsCollectionNoOracle()
    gestePostgreSQL.nettoyage()

    gesteOracle = Gestionnaire("P10_PokemonOracle.sql", "oracle")
    gesteOracle.oracleTable()
    gesteOracle.implementsUsersOracle()
    gesteOracle.implementsAbilityOracle()
    gesteOracle.implementsAttacksOracle()
    gesteOracle.implementsResistancesOracle()
    gesteOracle.implementsWeaknessOracle()
    gesteOracle.implementsCardsOracle()
    gesteOracle.implementsContientOracle()
    gesteOracle.implementsCollectionOracle()
    gesteOracle.nettoyage()
