def getNameTable(chaine: str) -> str:
    for i, c in enumerate(chaine):
        if c.isupper():
            return chaine[:i].capitalize()
    return chaine.capitalize()


def traitementLigne(ligne: str) -> list[str]:
    attributs = ligne.split("|")
    attributsTraites = []
    for element in attributs:
        element = element.replace("\n", "").replace("'", "\\'")
        tableauProvisoire = element.split(":")
        if len(tableauProvisoire) > 2:
            tableauProvisoire[1] = tableauProvisoire[1] + ":" + tableauProvisoire[2]
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
        self.cible = open(fichierNameCible, "w")
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
                    self.cible.write(f"{nameAttributs[i]},{nameTable.lower()}lang) VALUES ")
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
                                chaine += f"\"{donnees[attributs[i]]}\", \"{self.lang}\"),"
                            else:
                                chaine += f"\"{donnees[attributs[i]]}\"),"
                        else:
                            chaine += f"\"{donnees[attributs[i]]}\","
                    self.cible.write(f"{chaine}")

            else:
                header = f"\n\tINTO P10_{nameTable}("
                for i in range(nbAttributs):
                    if i == nbAttributs - 1:
                        header += f"{attributsTable[i]},{nameTable.lower()}lang) VALUES ("
                    else:
                        header += f"{attributsTable[i]},"

                if donnees[attributs[0]] != "null" and donnees[attributs[0]] not in Existing:
                    Existing.append(donnees[attributs[0]])
                    chaine = header
                    for i in range(nbAttributs):
                        if i == nbAttributs - 1:
                            chaine += f"\"{donnees[attributs[i]]}\",\"{self.lang}\")"
                        else:
                            chaine += f"\"{donnees[attributs[i]]}\","

                    chaine = chaine.replace("\"null\"", "null")
                    self.cible.write(f"{chaine}")
        if not self.oracle:
            self.cible.seek(self.cible.tell() - 1)
            self.cible.write(";")
            # self.cible.write(f"\n\tINTO {attributsTable[0]}(abilityId, abilityName, abilityEffect) "
            #                 f"VALUES ({index}, \"{donnees[10]}\", \"{donnees[11]}\")")

    def implementsCardsNoOracle(self):
        self.source.seek(0)
        self.cible.write("\n\nINSERT INTO Card(cardCatergory,cardName,"
                         "cardHP,cardRarity,cardImg,cardType,cardExtension"
                         "cardRetreat,cardLang,abilityId,resistanceId,weaknessId) VALUES")

        for lignes in self.source.readlines():
            donnees = traitementLigne(lignes)

            chaine = f"\n\t(\"{donnees[1]}\",\"{donnees[2]}\",\"{donnees[3]}\",\"{donnees[4]}\",\"{donnees[5]}\",\"{donnees[6]}\"," \
                     f"\"{donnees[7]}\",{donnees[8]},\"{donnees[9]}\""

            if donnees[10] == "null" and donnees[11] != "null":
                chaine += f",(SELECT abilityId FROM P10_Ability WHERE abilityEffect = '{donnees[11]}')"

            elif donnees[10] != "null" and donnees[11] != "null":
                chaine += f",(SELECT abilityId FROM P10_Ability WHERE abilityName = '{donnees[10]}' " \
                          f"AND abilityEffect = '{donnees[11]}')"
            else:
                chaine += ",\"null\""

            if donnees[22] != "null":
                chaine += f",(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = '{donnees[22]}' " \
                          f"AND weaknessValue = '{donnees[23]}')"
            else:
                chaine += ",\"null\""

            if donnees[20] != "null":
                chaine += f",(SELECT resistanceId FROM P10_Resistance WHERE resistanceType = '{donnees[20]}' " \
                          f"AND resistanceValue = '{donnees[21]}')"
            else:
                chaine += ",\"null\""

            chaine = chaine.replace("\"null\"", "null")
            self.cible.write(chaine + "),")
        self.cible.seek(self.cible.tell() - 1)
        self.cible.write(";")

    def implentsCardOracle(self):
        self.source.seek(0)
        self.cible.write(f"\nINSERT ALL")
        for lignes in self.source.readlines():
            donnees = traitementLigne(lignes)

            chaine = "\n\tINTO P10_Card(cardCatergory,cardName," \
                     "cardHP,cardRarity,cardImg,cardType,cardExtension" \
                     "cardRetreat,cardLang,abilityId,resistanceId,weaknessId) VALUES "

            chaine += f"(\"{donnees[1]}\",\"{donnees[2]}\",\"{donnees[3]}\",\"{donnees[4]}\",\"{donnees[5]}\",\"{donnees[6]}\"," \
                      f"\"{donnees[7]}\",{donnees[8]},\"{donnees[9]}\""

            if donnees[10] == "null" and donnees[11] != "null":
                chaine += f",(SELECT abilityId FROM P10_Ability WHERE abilityEffect = '{donnees[11]}')"

            elif donnees[10] != "null" and donnees[11] != "null":
                chaine += f",(SELECT abilityId FROM P10_Ability WHERE abilityName = '{donnees[10]}' " \
                          f"AND abilityEffect = '{donnees[11]}')"
            else:
                chaine += ",\"null\""

            if donnees[22] != "null":
                chaine += f",(SELECT weaknessId FROM P10_Weakness WHERE weaknessType = '{donnees[22]}' " \
                          f"AND weaknessValue = '{donnees[23]}')"
            else:
                chaine += ",\"null\""

            if donnees[20] != "null":
                chaine += f",(SELECT resistanceId FROM P10_Resistance WHERE resistanceType = '{donnees[20]}' " \
                          f"AND resistanceValue = '{donnees[21]}')"

            else:
                chaine += ",\"null\""

            chaine = chaine.replace("\"null\"", "null")
            self.cible.write(chaine + ")")
        self.cible.write("\nSELECT * FROM dual;")

    def sqlTable(self):
        if self.extension == "Postgresql":
            auto = "SERIAL"
        else:
            auto = "INT AUTO_INCREMENT"
            
        tbl = "DROP TABLE IF NOT EXISTS"
        drop = f"{tbl} P10_Card;\n{tbl} P10_Attack;\n{tbl} P10_Resistance;\n{tbl} "\
               f"P10_Weakness;\n{tbl} P10_User;\n{tbl} P10_Abitility;\n"

        abilityTable = f"CREATE TABLE IF NOT EXISTS P10_Ability(\n\tabilityId {auto} PRIMARY KEY,\n\t" \
                       "abilityName varchar(50) NOT NULL,\n\tabilityEffect TEXT NOT NULL);\n"

        resistanceTable = f"CREATE TABLE IF NOT EXISTS P10_Resistance(\n\tresistanceId {auto} PRIMARY KEY,\n\t" \
                          "resistanceType varchar(10) NOT NULL,\n\tresistanceValue varchar(5) NOT NULL);\n"

        weaknessTable = f"CREATE TABLE IF NOT EXISTS P10_Weakness(\n\tweaknessId {auto} PRIMARY KEY,\n\t" \
                        "weaknessType varchar(10) NOT NULL,\n\tweaknessValue varchar(5) NOT NULL);\n"

        attackTable = f"CREATE TABLE IF NOT EXISTS P10_Attack(\n\tattackId {auto} PRIMARY KEY,\n\t" \
                      "attackName varchar(50) NOT NULL,\n\tattackCost varchar(50),\n\tattackDamage varchar(4)," \
                      "\n\tattackEffect TEXT,\n\tattackLang varchar(20) NOT NULL);\n"

        cardTable = f"CREATE TABLE IF NOT EXISTS P10_Card(\n\tcardId {auto} PRIMARY KEY,\n\t" \
                    "cardCategory varchar(50) NOT NULL,\n\tcardName varchar(50) NOT NULL,\n\tcardHP varchar(4),\n\t" \
                    "cardRarity varchar(50) NOT NULL,\n\tcardImg varchar(20) NOT NULL,\n\tcardType varchar(10),\n\t" \
                    "cardExtension TEXT NOT NULL,\n\tcardRetreat INT,\n\tcardLang varchar(20) NOT NULL,\n\t" \
                    "abilityId INT REFERENCES P10_Ability(abilityId),\n\t" \
                    "resistanceId INT REFERENCES P10_Resistance(resistanceId),\n\t" \
                    "weaknessId INT REFERENCES P10_Weakness(weaknessId));\n"

        userTable = f"CREATE TABLE IF NOT EXISTS P10_User(\n\tuserId {auto} PRIMARY KEY,\n\t" \
                    "userName varchar(20) NOT NULL,\n\tuserDob date NOT NULL,\n\tuserStatus varchar(10) NOT NULL," \
                    "\n\tuserLogin varchar(255) NOT NULL,\n\tuserPass varchar(255) NOT NULL);\n"

        self.cible.write(f"{drop}\n{userTable}\n{abilityTable}\n{resistanceTable}\n{weaknessTable}\n{attackTable}\n{cardTable}")


    def oracleTable(self):
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

        abilityTable = f"CREATE TABLE P10_Ability(\n\tabilityId INT DEFAULT seq_ability.nextval PRIMARY KEY,\n\t" \
                       "abilityName varchar(50),\n\tabilityEffect CLOB);\n"

        resistanceTable = f"CREATE TABLE P10_Resistance(\n\tresistanceId INT DEFAULT seq_resistance.nextval PRIMARY KEY,\n\t" \
                          "resistanceType varchar(10),\n\tresistanceValue varchar(5));\n"

        weaknessTable = f"CREATE TABLE P10_Weakness(\n\tweaknessId INT DEFAULT seq_weakness.nextval PRIMARY KEY,\n\t" \
                        "weaknessType varchar(10),\n\tweaknessValue varchar(5));\n"

        attackTable = f"CREATE TABLE P10_Attack(\n\tattackId INT DEFAULT seq_attack.nextval PRIMARY KEY,\n\t" \
                      "attackName varchar(50),\n\tattackCost varchar(50),\n\tattackDamage varchar(4)," \
                      "\n\tattackEffect CLOB,\n\tattackLang varchar(20));\n"

        cardTable = f"CREATE TABLE P10_Card(\n\tcardId INT DEFAULT seq_card.nextval PRIMARY KEY,\n\t" \
                    "cardCategory varchar(50),\n\tcardName varchar(50),\n\tcardHP varchar(4),\n\t" \
                    "cardRarity varchar(50),\n\tcardImg varchar(20),\n\tcardType varchar(10),\n\t" \
                    "cardExtension CLOB,\n\tcardRetreat INT,\n\tcardLang varchar(20),\n\t" \
                    "abilityId INT REFERENCES P10_Ability(abilityId),\n\t" \
                    "resistanceId INT REFERENCES P10_Resistance(resistanceId),\n\t" \
                    "weaknessId INT REFERENCES P10_Weakness(weaknessId));\n"

        userTable = f"CREATE TABLE P10_User(\n\tuserId INT DEFAULT seq_user.nextval PRIMARY KEY,\n\t" \
                    "userName varchar(20),\n\tuserDob date,\n\tuserStatus varchar(10)," \
                    "\n\tuserLogin varchar(255),\n\tuserPass varchar(255));\n"


        self.cible.write(f"{drops}\n{sequences}\n{userTable}\n{abilityTable}\n{resistanceTable}\n{weaknessTable}\n{attackTable}\n{cardTable}")

if __name__ == "__main__":
    gesteSQL = Gestionnaire("FR-DataBlackWhiteWithoutDoublon.txt", "FR-PokemonMySQL.sql", "mysql")
    gesteSQL.sqlTable()
    gesteSQL.writeDataInFile([10, 11])
    gesteSQL.writeDataInFile([12, 13, 14, 15])
    gesteSQL.writeDataInFile([16, 17, 18, 19])
    gesteSQL.writeDataInFile([20, 21])
    gesteSQL.writeDataInFile([22, 23])
    gesteSQL.implementsCardsNoOracle()

    gesteOracle = Gestionnaire("EN-DataBlackWhiteWithoutDoublon.txt", "EN-PokemonOracle.oracl", "oracle")
    gesteOracle.oracleTable()
    gesteOracle.cible.write("INSERT ALL")
    gesteOracle.writeDataInFile([10, 11])
    gesteOracle.writeDataInFile([12, 13, 14, 15])
    gesteOracle.writeDataInFile([16, 17, 18, 19])
    gesteOracle.writeDataInFile([20, 21])
    gesteOracle.writeDataInFile([22, 23])
    gesteOracle.cible.write("\nSELECT * FROM dual;")
    gesteOracle.implentsCardOracle()

