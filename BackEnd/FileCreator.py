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
            print(tableauProvisoire)
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

    def __init__(self, fichierNameSource: str, fichierNameCible: str, extension: str):
        self.source = open(fichierNameSource, "r", encoding="UTF-8")
        self.lang = fichierNameSource[0].lower() + fichierNameSource[1].lower()
        self.cible = open(fichierNameCible, "w+")
        self.nameSource = fichierNameSource
        self.nameCible = fichierNameCible
        self.pourcentage = 0
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
        else:
            pass

    def writeDataInFile(self, attributs: list[int]):
        self.source.seek(0)
        Existing = []
        nbAttributs = len(attributs)
        attributsTable = getAttributsFromTable(self.source.readline(), attributs)
        nameTable = getNameTable(attributsTable[0])
        self.source.seek(0)

        if not self.oracle:
            self.writeRequestInFile(nameTable, attributsTable)

        for lignes in self.source.readlines():
            donnees = traitementLigne(lignes)

            if not self.oracle:
                if donnees[attributs[0]] != "null" and donnees[attributs[0]] not in Existing:
                    Existing.append(donnees[attributs[0]])
                    chaine = f"\n\t("
                    for i in range(nbAttributs):
                        if i == (nbAttributs - 1):
                            if nameTable == "Attack":
                                chaine += f"'{donnees[attributs[i]]}'),"
                            else:
                                chaine += f"'{donnees[attributs[i]]}'),"
                        else:
                            chaine += f"'{donnees[attributs[i]]}',"
                    self.cible.write(f"{chaine}")

            else:
                header = f"\n\tINTO P10_{nameTable}("
                for i in range(nbAttributs):
                    if i == nbAttributs - 1:
                        header += f"{attributsTable[i]}) VALUES ("
                    else:
                        header += f"{attributsTable[i]},"

                if donnees[attributs[0]] != "null" and donnees[attributs[0]] not in Existing:
                    Existing.append(donnees[attributs[0]])
                    chaine = header
                    for i in range(nbAttributs):
                        if i == nbAttributs - 1:
                            chaine += f"'{donnees[attributs[i]]}')"
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
        self.source.seek(0)
        self.cible.write("\n\nINSERT INTO Card(cardCatergory,cardName,"
                         "cardHP,cardRarity,cardImg,cardType,cardExtension"
                         "cardRetreat,cardLang,abilityId,resistanceId,weaknessId) VALUES")

        for lignes in self.source.readlines():
            donnees = traitementLigne(lignes)

            chaine = f"\n\t('{donnees[1]}','{donnees[2]}','{donnees[3]}','{donnees[4]}','{donnees[5]}','{donnees[6]}'," \
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
        self.source.seek(0)
        self.cible.write(f"\nINSERT ALL")
        for lignes in self.source.readlines():
            donnees = traitementLigne(lignes)

            chaine = "\n\tINTO P10_Card(cardCatergory,cardName," \
                     "cardHP,cardRarity,cardImg,cardType,cardExtension," \
                     "cardRetreat,cardLang,abilityId,resistanceId,weaknessId) VALUES "

            chaine += f"('{donnees[1]}','{donnees[2]}','{donnees[3]}','{donnees[4]}','{donnees[5]}','{donnees[6]}'," \
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
            self.cible.write(chaine + ")")
        self.cible.write("\nSELECT * FROM dual;")

    def sqlTable(self):
        if self.lang == "fr":
            types = ["Incolore", "Feu", "Eau", "Plante", "Combat", "Métal", "Électrique", "Psy", "Obscurité", "Dragon"]
        else:
            types = ["Colorless", "Fire", "Water", "Grass", "Fighting", "Metal", "Lightning", "Psychic", "Darkness",
                     "Dragon"]
        if self.extension == "Postgresql":
            auto = "SERIAL"
        else:
            auto = "INT AUTO_INCREMENT"

        tbl = "DROP TABLE IF EXISTS"
        drop = f"{tbl} P10_Card;\n{tbl} P10_Attack;\n{tbl} P10_Resistance;\n{tbl} " \
               f"P10_Weakness;\n{tbl} P10_User;\n{tbl} P10_Abitility;\n"

        abilityTable = f"CREATE TABLE IF NOT EXISTS P10_Ability(\n\tabilityId {auto} PRIMARY KEY,\n\t" \
                       f"abilityName varchar(50),\n\tabilityEffect varchar(255));\n"

        resistanceTable = f"CREATE TABLE IF NOT EXISTS P10_Resistance(\n\tresistanceId {auto} PRIMARY KEY,\n\t" \
                          f"resistanceType varchar(10) NOT NULL CHECK IN {types},\n\tresistanceValue varchar(5) NOT NULL DEFAULT '-20' CHECK IN ['x2',+20,+10,+30]);\n"

        weaknessTable = f"CREATE TABLE IF NOT EXISTS P10_Weakness(\n\tweaknessId {auto} PRIMARY KEY,\n\t" \
                        f"weaknessType varchar(10) NOT NULL CHECK IN {types},\n\tweaknessValue varchar(5) NOT NULL DEFAULT 'x2' CHECK IN ['x2',-20,-10,-30]);\n"

        attackTable = f"CREATE TABLE IF NOT EXISTS P10_Attack(\n\tattackId {auto} PRIMARY KEY,\n\t" \
                      f"attackName varchar(50) NOT NULL,\n\tattackCost varchar(50),\n\tattackDamage varchar(4)," \
                      f"\n\tattackEffect varchar(255),\n\tattackLang varchar(20) NOT NULL DEFAULT 'fr' CHECK IN ['fr','en']);\n"

        cardTable = f"CREATE TABLE IF NOT EXISTS P10_Card(\n\tcardId {auto} PRIMARY KEY,\n\t" \
                    f"cardCategory varchar(50) NOT NULL DEFAULT 'Pokémon' CHECK IN ['Pokémon','Pokemon','Dresseur','Trainer'],\n\tcardName varchar(50) NOT NULL,\n\tcardHP INT,\n\t" \
                    f"cardRarity varchar(50) NOT NULL DEFAULT 'Commune' CHECK IN ['Commune','Peu Commune','Rare','Ultra Rare','Magnifique'],\n\tcardImg varchar(20) NOT NULL,\n\tcardType varchar(10) CHECK IN {types},\n\t" \
                    f"cardExtension varchar(255) NOT NULL,\n\tcardRetreat INT,\n\tcardLang varchar(20) NOT NULL DEFAULT 'fr' CHECK IN ['fr','en'],\n\t" \
                    f"abilityId INT REFERENCES P10_Ability(abilityId) DEFAULT null,\n\t" \
                    f"resistanceId INT REFERENCES P10_Resistance(resistanceId) DEFAULT null,\n\t" \
                    f"weaknessId INT REFERENCES P10_Weakness(weaknessId) DEFAULT null);\n"

        userTable = f"CREATE TABLE IF NOT EXISTS P10_User(\n\tuserId {auto} PRIMARY KEY,\n\t" \
                    f"userName varchar(20) NOT NULL,\n\tuserDob date NOT NULL,\n\tuserStatus varchar(10) NOT NULL DEFAULT 'user' CHECK IN ['root','user']," \
                    f"\n\tuserLogin varchar(255) NOT NULL,\n\tuserPass varchar(255) NOT NULL);\n"

        contientTable = f"CREATE TABLE IF NOT EXISTS P10_Contient(\n\tcardId INT REFERENCES P10_Card(cardId)" \
                        f",\n\tattackId INT REFERENCES P10_Attack(attackId));\n"

        collectionTable = f"CREATE TABLE IF NOT EXISTS P10_Collection(\n\tcardId INT REFERENCES P10_Card(cardId)" \
                          f",\n\tuserId INT REFERENCES P10_User(userId));\n"

        self.cible.write(f"{drop}\n{userTable}\n{abilityTable}\n{resistanceTable}\n{weaknessTable}\n{attackTable}\n{cardTable}\n{contientTable}\n{collectionTable}")

    def oracleTable(self):
        if self.lang == "fr":
            types = ('Incolore', 'Feu', 'Eau', 'Plante', 'Combat', 'Métal', 'Électrique', 'Psy', 'Obscurité', 'Dragon')
        else:
            types = ('Colorless', 'Fire', 'Water', 'Grass', 'Fighting', 'Metal', 'Lightning', 'Psychic', 'Darkness', 'Dragon')
        drops = "-- DROP TABLE P10_Card;\n" \
                "-- DROP TABLE P10_Ability;\n" \
                "-- DROP TABLE P10_Attack;\n" \
                "-- DROP TABLE P10_Resistance;\n" \
                "-- DROP TABLE P10_Weakness;\n" \
                "-- DROP TABLE P10_User;\n"

        sequences = "CREATE SEQUENCE seq_ability;\n" \
                    "CREATE SEQUENCE seq_resistance;\n" \
                    "CREATE SEQUENCE seq_weakness;\n" \
                    "CREATE SEQUENCE seq_attack;\n" \
                    "CREATE SEQUENCE seq_card;\n" \
                    "CREATE SEQUENCE seq_user;\n"

        abilityTable = f"CREATE TABLE P10_Ability(\n\tabilityId NUMBER DEFAULT seq_ability.nextval PRIMARY KEY,\n\t" \
                       "abilityName VARCHAR2(50),\n\tabilityEffect VARCHAR2(255));\n"

        resistanceTable = f"CREATE TABLE P10_Resistance(\n\tresistanceId NUMBER DEFAULT seq_resistance.nextval PRIMARY KEY,\n\t" \
                          "resistanceType VARCHAR2(10) NOT NULL,\n\tresistanceValue VARCHAR2(5) NOT NULL DEFAULT '-20',\n\t" \
                          f"CONSTRAINT CheckType CHECK (resistanceType IN {types}));\n"

        weaknessTable = f"CREATE TABLE P10_Weakness(\n\tweaknessId NUMBER DEFAULT seq_weakness.nextval PRIMARY KEY,\n\t" \
                        "weaknessType VARCHAR2(10) NOT NULL,\n\tweaknessValue VARCHAR2(5) NOT NULL DEFAULT 'x2',\n\t" \
                        f"CONSTRAINT CheckType CHECK (weaknessType IN {types}));\n"

        attackTable = f"CREATE TABLE P10_Attack(\n\tattackId NUMBER DEFAULT seq_attack.nextval PRIMARY KEY,\n\t" \
                      "attackName VARCHAR2(50) NOT NULL,\n\tattackCost VARCHAR2(50),\n\tattackDamage VARCHAR2(4)," \
                      "\n\tattackEffect VARCHAR2(255),\n\tattackLang VARCHAR2(20) DEFAULT 'fr',\n\t" \
                      "CONSTRAINT checkLang CHECK (attackLang IN ('fr','en')));\n"

        cardTable = f"CREATE TABLE P10_Card(\n\tcardId INT DEFAULT seq_card.nextval PRIMARY KEY,\n\t" \
                    "cardCategory VARCHAR2(50) DEFAULT 'Pokémon',\n\tcardName VARCHAR2(50),\n\tcardHP NUMBER,\n\t" \
                    "cardRarity VARCHAR2(50) DEFAULT 'Commune',\n\tcardImg VARCHAR2(20),\n\tcardType VARCHAR2(10),\n\t" \
                    "cardExtension VARCHAR2(255),\n\tcardRetreat NUMBER DEFAULT 1,\n\tcardLang VARCHAR2(20) DEFAULT 'fr',\n\t" \
                    "abilityId NUMBER REFERENCES P10_Ability(abilityId) DEFAULT null,\n\t" \
                    "resistanceId NUMBER REFERENCES P10_Resistance(resistanceId) DEFAULT null,\n\t" \
                    "weaknessId NUMBER REFERENCES P10_Weakness(weaknessId) DEFAULT null,\n\t" \
                    f"CONSTRAINT CheckRarity CHECK (cardRarity IN ('Commune','Peu commune','Rare','Ultra Rare','Maginfique')),\n\t" \
                    f"CONSTRAINT CheckCategory CHECK (cardCategory IN ('Pokémon','Pokemon','Dresseur','Trainer')));\n"

        userTable = f"CREATE TABLE P10_User(\n\tuserId NUMBER DEFAULT seq_user.nextval PRIMARY KEY,\n\t" \
                    "userName VARCHAR2(20),\n\tuserDob date,\n\tuserStatus VARCHAR2(10) DEFAULT 'user'," \
                    "\n\tuserLogin VARCHAR2(255),\n\tuserPass VARCHAR2(255),\n\t" \
                    f"CONSTRAINT CheckStatus CHECK (cardCategory IN ('root', 'user')));\n"

        contientTable = (f"CREATE TABLE IF NOT EXISTS P10_Contient(\n\tcardId NUMBER REFERENCES P10_Card(cardId)"
                         f",\n\tattackId NUMBER REFERENCES P10_Attack(attackId));\n")

        collectionTable = f"CREATE TABLE IF NOT EXISTS P10_Collection(\n\tcardId NUMBER REFERENCES P10_Card(cardId)" \
                          f",\n\tuserId NUMBER REFERENCES P10_User(userId));\n"

        self.cible.write(f"{drops}\n{sequences}\n{userTable}\n{abilityTable}\n{resistanceTable}\n{weaknessTable}\n{attackTable}\n{cardTable}\n{contientTable}\n{collectionTable}\n")

    def assocTable(self):
        self.source.seek(0)
        if not self.oracle:
            self.cible.write("\n\nINSERT INTO P10_Contient(cardId, attackId) VALUES")
        else:
            self.cible.write("\n\nINSERT ALL")
        for lignes in self.source.readlines():
            donnes = traitementLigne(lignes)
            print(donnes[5])
            if donnes[12] != "null" and donnes[16] == "null":
                if not self.oracle:
                    self.cible.write(
                        f"\n\t((SELECT cardId FROM P10_Card WHERE cardImg = '{donnes[5]}'), (SELECT attackId FROM P10_Attack WHERE attackName = '{donnes[12]}' AND attackCost = '{donnes[13]}' AND attackDamage = '{donnes[14]}'))")
                else:
                    self.cible.write(
                        f"\n\tINTO P10_Contient(cardId,attackId) VALUES ((SELECT cardId FROM P10_Card WHERE cardImg = '{donnes[5]}'), (SELECT attackId FROM P10_Attack WHERE attackName = '{donnes[12]}' AND attackCost = '{donnes[13]}' AND attackDamage = '{donnes[14]}'))")

            elif donnes[12] != "null" and donnes[16] != "null":
                if not self.oracle:
                    self.cible.write(
                        f"\n\t((SELECT cardId FROM P10_Card WHERE cardImg = '{donnes[5]}'), (SELECT attackId FROM P10_Attack WHERE attackName = '{donnes[12]}' AND attackCost = '{donnes[13]}' AND attackDamage = '{donnes[14]}'))")
                    self.cible.write(
                        f"\n\t((SELECT cardId FROM P10_Card WHERE cardImg = '{donnes[5]}'), (SELECT attackId FROM P10_Attack WHERE attackName = '{donnes[16]}' AND attackCost = '{donnes[17]}' AND attackDamage = '{donnes[18]}'))")
                else:
                    self.cible.write(f"\n\tINTO P10_Contient(cardId,attackId) VALUES ((SELECT cardId FROM P10_Card "
                                     f"WHERE cardImg = '{donnes[5]}'), (SELECT attackId FROM P10_Attack "
                                     f"WHERE attackName = '{donnes[12]}' AND attackCost = '{donnes[13]}' AND "
                                     f"attackDamage = '{donnes[14]}'))")

                    self.cible.write(f"\n\tINTO P10_Contient(cardId,attackId) VALUES ((SELECT cardId FROM P10_Card "
                                     f"WHERE cardImg = '{donnes[5]}'), (SELECT attackId FROM P10_Attack "
                                     f"WHERE attackName = '{donnes[16]}' AND attackCost = '{donnes[17]}' AND "
                                     f"attackDamage = '{donnes[18]}'))")
        if self.oracle:
            self.cible.write("\nSELECT * FROM dual;")

    def nettoyage(self):
        self.cible.seek(0)
        lignes = self.cible.readlines()
        self.cible.close()
        fichier = open(self.nameCible, "w")
        for ligne in lignes:
            newLine = ligne.replace("'null'", "null")
            fichier.write(newLine)
        fichier.close()
        self.cible.close()


if __name__ == "__main__":
    gesteSQL = Gestionnaire("FR-DataBlackWhiteWithoutDoublon.txt", "FR-PokemonMySQL.sql", "mysql")
    gesteSQL.sqlTable()
    gesteSQL.writeDataInFile([10, 11])
    gesteSQL.writeDataInFile([12, 13, 14, 15])
    gesteSQL.writeDataInFile([16, 17, 18, 19])
    gesteSQL.writeDataInFile([20, 21])
    gesteSQL.writeDataInFile([22, 23])
    gesteSQL.implementsCardsNoOracle()
    gesteSQL.assocTable()
    gesteSQL.nettoyage()

    gestePostgreSQL = Gestionnaire("FR-DataBlackWhiteWithoutDoublon.txt", "FR-PokemonPostgresql.sql", "postgresql")
    gestePostgreSQL.sqlTable()
    gestePostgreSQL.writeDataInFile([10, 11])
    gestePostgreSQL.writeDataInFile([12, 13, 14, 15])
    gestePostgreSQL.writeDataInFile([16, 17, 18, 19])
    gestePostgreSQL.writeDataInFile([20, 21])
    gestePostgreSQL.writeDataInFile([22, 23])
    gestePostgreSQL.implementsCardsNoOracle()
    gestePostgreSQL.assocTable()
    gestePostgreSQL.nettoyage()

    gesteOracle = Gestionnaire("FR-DataBlackWhiteWithoutDoublon.txt", "FR-PokemonOracle.sql", "oracle")
    gesteOracle.oracleTable()
    gesteOracle.cible.write("INSERT ALL")
    gesteOracle.writeDataInFile([10, 11])
    gesteOracle.writeDataInFile([12, 13, 14, 15])
    gesteOracle.writeDataInFile([16, 17, 18, 19])
    gesteOracle.writeDataInFile([20, 21])
    gesteOracle.writeDataInFile([22, 23])
    gesteOracle.cible.write("\nSELECT * FROM dual;")
    gesteOracle.implementsCardOracle()
    gesteOracle.assocTable()
    gesteOracle.nettoyage()
