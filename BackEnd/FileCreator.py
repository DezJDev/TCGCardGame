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
    newSource = open("school_data.txt", "w+")
    francais = open("FR-DataBlackWhiteWithoutDoublon.txt", "r", encoding="UTF-8")
    anglais = open("EN-DataBlackWhiteWithoutDoublon.txt", "r", encoding="UTF-8")

    numberLignes = sum(1 for _ in francais)
    ExistingLines = []
    for i in range(50):
        francais.seek(0)
        anglais.seek(0)
        nblignealea = randint(0, numberLignes)
        while nblignealea in ExistingLines:
            nblignealea = randint(0, numberLignes)
        ExistingLines.append(nblignealea)
        for j in range(nblignealea):
            francais.readline()
            anglais.readline()

        newSource.write(francais.readline())
        newSource.write(anglais.readline())

    def __init__(self, fichierNameCible: str, extension: str):
        self.cible = open(fichierNameCible, "w+")
        self.nameCible = fichierNameCible
        self.extension = extension.capitalize()

        if extension.capitalize() == "Oracle":
            self.oracle = True
        else:
            self.oracle = False

    def writeRequestInFile(self, nameTable: str, nameAttributs: list[str], isoracle=False):
        if not isoracle:
            self.cible.write(f"\n\nINSERT INTO P10_{nameTable}(")
            for i in range(len(nameAttributs)):
                if i == len(nameAttributs) - 1:
                    self.cible.write(f"{nameAttributs[i]}) VALUES ")
                else:
                    self.cible.write(f"{nameAttributs[i]},")

    def writeDataInFile(self, attributs: list[int]):
        Gestionnaire.newSource.seek(0)
        Existing = []
        ExistingAbility = []

        nbAttributs = len(attributs)
        attributsTable = getAttributsFromTable(Gestionnaire.newSource.readline(), attributs)
        nameTable = getNameTable(attributsTable[0])
        Gestionnaire.newSource.seek(0)

        if not self.oracle:
            self.writeRequestInFile(nameTable, attributsTable)

        for lignes in Gestionnaire.newSource.readlines():
            donnees = traitementLigne(lignes)

            if donnees[attributs[0]] == "Métal":
                donnees[attributs[0]] = "Metal"
            if not self.oracle:
                if donnees[attributs[0]] != "null" and donnees[attributs[0]] not in Existing and donnees[attributs[0]] not in ExistingAbility:
                    if attributs[0] == 10:
                        ExistingAbility.append(donnees[attributs[0]])
                    if not nbAttributs > 3:
                        Existing.append(donnees[attributs[0]])
                    chaine = f"\n\t("
                    for i in range(nbAttributs):
                        if i == (nbAttributs - 1):
                            chaine += f"'{donnees[attributs[i]]}'),"
                        else:
                            chaine += f"'{donnees[attributs[i]]}',"
                    self.cible.write(f"{chaine}")

            else:
                header = f"\nINSERT INTO P10_{nameTable}({nameTable.lower()}Id,"
                for i in range(nbAttributs):
                    if i == nbAttributs - 1:
                        header += f"{attributsTable[i]}) VALUES (seq_{nameTable.lower()}.nextval,"
                    else:
                        header += f"{attributsTable[i]},"

                if donnees[attributs[0]] != "null" and donnees[attributs[0]] not in Existing:
                    Existing.append(donnees[attributs[0]])
                    chaine = header
                    for i in range(nbAttributs):
                        if i == nbAttributs - 1:
                            chaine += f"'{donnees[attributs[i]]}');"
                        else:
                            chaine += f"'{donnees[attributs[i]]}',"

                    chaine = chaine.replace("'null'", "null")
                    self.cible.write(f"{chaine}")

        if not self.oracle:
            self.cible.seek(self.cible.tell() - 1)
            self.cible.write(";")
            # self.cible.write(f"\n\tINTO {attributsTable[0]}(abilityId, abilityName, abilityEffect) "
            #                 f"VALUES ({index}, '{donnees[10]}', '{donnees[11]}')")

    def implementsCardsNoOracle(self):
        Gestionnaire.newSource.seek(0)
        self.cible.write("\n\nINSERT INTO P10_Card(cardCategory,cardName,"
                         "cardHP,cardRarity,cardImg,cardType,cardExtension,"
                         "cardRetreat,cardLang,abilityId,weaknessId,resistanceId) VALUES")

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
            self.cible.write(chaine + "),")
        self.cible.seek(self.cible.tell() - 1)
        self.cible.write(";")

    def implementsCardOracle(self):
        Gestionnaire.newSource.seek(0)
        for lignes in Gestionnaire.newSource.readlines():
            donnees = traitementLigne(lignes)

            chaine = "\nINSERT INTO P10_Card(cardId,cardCategory,cardName," \
                     "cardHP,cardRarity,cardImg,cardType,cardExtension," \
                     "cardRetreat,cardLang,abilityId,resistanceId,weaknessId) VALUES "

            chaine += f"(seq_card.nextval,'{donnees[1]}','{donnees[2]}',{donnees[3]},'{donnees[4]}','{donnees[5]}','{donnees[6]}'," \
                      f"'{donnees[7]}',{donnees[8]},'{donnees[9]}'"

            if donnees[10] == "null" and donnees[11] != "null":
                chaine += f",(SELECT abilityId FROM P10_Ability WHERE abilityEffect = '{donnees[11]}')"

            elif donnees[10] != "null" and donnees[11] != "null":
                chaine += f",(SELECT abilityId FROM P10_Ability WHERE abilityName = '{donnees[10]}' " \
                          f"AND abilityEffect = '{donnees[11]}')"
            else:
                chaine += ",'null'"

            if donnees[22] != "null":
                chaine += f",(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = '{donnees[22]}' " \
                          f"AND weaknessValue = '{donnees[23]}')"
            else:
                chaine += ",'null'"

            if donnees[20] != "null":
                chaine += f",(SELECT resistanceId FROM P10_Resistance WHERE resistanceType = '{donnees[20]}' " \
                          f"AND resistanceValue = '{donnees[21]}')"

            else:
                chaine += ",'null'"

            chaine = chaine.replace("'null'", "null")
            self.cible.write(chaine + ");")

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
                       f"abilityName varchar(50) NOT NULL,\n\tabilityEffect TEXT NOT NULL);\n"

        resistanceTable = f"CREATE TABLE IF NOT EXISTS P10_Resistance(\n\tresistanceId {auto} PRIMARY KEY,\n\t" \
                          f"resistanceType varchar(10) CHECK (resistanceType IN {types}),\n\tresistanceValue varchar(5) CHECK (resistanceValue IN ('/2','-20','-10','-30')));\n"

        weaknessTable = f"CREATE TABLE IF NOT EXISTS P10_Weakness(\n\tweaknessId {auto} PRIMARY KEY,\n\t" \
                        f"weaknessType varchar(10) CHECK (weaknessType IN {types}),\n\tweaknessValue varchar(5) CHECK (weaknessValue IN ('×2','+20','+10','+30')));\n"

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

        abilityTable = f"CREATE TABLE P10_Ability(\n\tabilityId NUMBER PRIMARY KEY,\n\t" \
                       "abilityName VARCHAR2(50) NOT NULL,\n\tabilityEffect varchar2(500) NOT NULL);\n"

        resistanceTable = f"CREATE TABLE P10_Resistance(\n\tresistanceId NUMBER PRIMARY KEY,\n\t" \
                          "resistanceType VARCHAR2(20) NOT NULL,\n\tresistanceValue VARCHAR2(5) DEFAULT '-20',\n\t" \
                          f"CONSTRAINT CheckTypeResistance CHECK (resistanceType IN {types}),\n\t" \
                          f"CONSTRAINT CheckValueResistance CHECK (resistanceValue IN ('/2','-10','-20','-30')));\n"

        weaknessTable = f"CREATE TABLE P10_Weakness(\n\tweaknessId NUMBER PRIMARY KEY,\n\t" \
                        "weaknessType VARCHAR2(20) NOT NULL,\n\tweaknessValue VARCHAR2(5) DEFAULT '×2',\n\t" \
                        f"CONSTRAINT CheckTypeWeakness CHECK (weaknessType IN {types}),\n\t" \
                        f"CONSTRAINT CheckValueWeakness CHECK (weaknessValue IN ('×2','+10','+20','+30')));\n"

        attackTable = f"CREATE TABLE P10_Attack(\n\tattackId NUMBER PRIMARY KEY,\n\t" \
                      "attackName VARCHAR2(50) NOT NULL,\n\tattackCost VARCHAR2(50),\n\tattackDamage VARCHAR2(4)," \
                      "\n\tattackEffect VARCHAR2(255),\n\tattackLang VARCHAR2(20) DEFAULT 'fr',\n\t" \
                      "CONSTRAINT checkLang CHECK (attackLang IN ('fr','en')));\n"

        cardTable = f"CREATE TABLE P10_Card(\n\tcardId NUMBER PRIMARY KEY,\n\t" \
                    "cardCategory VARCHAR2(50) DEFAULT 'Pokémon',\n\tcardName VARCHAR2(50),\n\tcardHP NUMBER,\n\t" \
                    "cardRarity VARCHAR2(50) DEFAULT 'Commune',\n\tcardImg VARCHAR2(100),\n\tcardType VARCHAR2(10),\n\t" \
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

    def assocTable(self):
        Gestionnaire.newSource.seek(0)
        if not self.oracle:
            self.cible.write("\n\nINSERT INTO P10_Contient(cardId, attackId) VALUES")

        for lignes in Gestionnaire.newSource.readlines():
            donnes = traitementLigne(lignes)

            data12 = f"= '{donnes[12]}'"
            if donnes[12] == "null":
                data12 = data12.replace("= 'null'", "IS NULL")

            data13 = f"= '{donnes[13]}'"
            if donnes[13] == "null":
                data13 = data13.replace("= 'null'", "IS NULL")

            data14 = f"= '{donnes[14]}'"
            if donnes[14] == "null":
                data14 = data14.replace("= 'null'", "IS NULL")

            data16 = f"= '{donnes[16]}'"
            if donnes[16] == "null":
                data16 = data16.replace("= 'null'", "IS NULL")

            data17 = f"= '{donnes[17]}'"
            if donnes[17] == "null":
                data17 = data17.replace("= 'null'", "IS NULL")

            data18 = f"= '{donnes[18]}'"
            if donnes[18] == "null":
                data18 = data18.replace("= 'null'", "IS NULL")

            if donnes[12] != "null" and donnes[16] == "null":
                if not self.oracle:
                    self.cible.write(
                        f"\n\t((SELECT cardId FROM P10_Card WHERE cardImg = '{donnes[5]}'), "
                        f"(SELECT attackId FROM P10_Attack WHERE attackName {data12} "
                        f"AND attackCost {data13} AND attackDamage {data14})),")
                else:
                    self.cible.write(
                        f"\nINSERT INTO P10_Contient(cardId,attackId) VALUES "
                        f"((SELECT cardId FROM P10_Card WHERE cardImg = '{donnes[5]}'), "
                        f"(SELECT attackId FROM P10_Attack WHERE attackName {data12} "
                        f"AND attackCost {data13} AND attackDamage {data14}));")

            elif donnes[12] != "null" and donnes[16] != "null":
                if not self.oracle:
                    self.cible.write(
                        f"\n\t((SELECT cardId FROM P10_Card WHERE cardImg = '{donnes[5]}'), (SELECT attackId FROM P10_Attack WHERE attackName {data12} AND attackCost {data13} AND attackDamage {data14})),")
                    self.cible.write(
                        f"\n\t((SELECT cardId FROM P10_Card WHERE cardImg = '{donnes[5]}'), (SELECT attackId FROM P10_Attack WHERE attackName {data16} AND attackCost {data17} AND attackDamage {data18})),")
                else:
                    self.cible.write(
                        f"\nINSERT INTO P10_Contient(cardId,attackId) VALUES ((SELECT cardId FROM P10_Card "
                        f"WHERE cardImg = '{donnes[5]}'), (SELECT attackId FROM P10_Attack "
                        f"WHERE attackName {data12} AND attackCost {data13} AND "
                        f"attackDamage {data14}));")

                    self.cible.write(
                        f"\nINSERT INTO P10_Contient(cardId,attackId) VALUES ((SELECT cardId FROM P10_Card "
                        f"WHERE cardImg = '{donnes[5]}'), (SELECT attackId FROM P10_Attack "
                        f"WHERE attackName {data16} AND attackCost {data17} AND "
                        f"attackDamage {data18}));")
        if not self.oracle:
            self.cible.seek(self.cible.tell() - 1)
            self.cible.write(";")

    def nettoyage(self):
        self.cible.seek(0)
        lignes = self.cible.readlines()
        self.cible.close()
        fichier = open(self.nameCible, "w")
        for ligne in lignes:
            newLine = ligne.replace("'null'", "null").replace(" ", " ").replace("Métal", "Metal")
            fichier.write(newLine)
        fichier.close()
        self.cible.close()


if __name__ == "__main__":
    gesteSQL = Gestionnaire("P10_PokemonMySQL.sql", "mysql")
    gesteSQL.sqlTable()
    gesteSQL.writeDataInFile([10, 11])
    gesteSQL.writeDataInFile([12, 13, 14, 15])
    gesteSQL.writeDataInFile([16, 17, 18, 19])
    gesteSQL.writeDataInFile([20, 21])
    gesteSQL.writeDataInFile([22, 23])
    gesteSQL.implementsCardsNoOracle()
    gesteSQL.assocTable()
    gesteSQL.nettoyage()

    gestePostgreSQL = Gestionnaire("P10_PokemonPostgresql.sql", "postgresql")
    gestePostgreSQL.sqlTable()
    gestePostgreSQL.writeDataInFile([10, 11])
    gestePostgreSQL.writeDataInFile([12, 13, 14, 15])
    gestePostgreSQL.writeDataInFile([16, 17, 18, 19])
    gestePostgreSQL.writeDataInFile([20, 21])
    gestePostgreSQL.writeDataInFile([22, 23])
    gestePostgreSQL.implementsCardsNoOracle()
    gestePostgreSQL.assocTable()
    gestePostgreSQL.nettoyage()

    gesteOracle = Gestionnaire("P10_PokemonOracle.sql", "oracle")
    gesteOracle.oracleTable()
    gesteOracle.writeDataInFile([10, 11])
    gesteOracle.writeDataInFile([12, 13, 14, 15])
    gesteOracle.writeDataInFile([16, 17, 18, 19])
    gesteOracle.writeDataInFile([20, 21])
    gesteOracle.writeDataInFile([22, 23])
    gesteOracle.implementsCardOracle()
    gesteOracle.assocTable()
    gesteOracle.nettoyage()
