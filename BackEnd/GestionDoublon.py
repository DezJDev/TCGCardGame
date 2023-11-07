if __name__ == "__main__":
    EN = open("../../en-DataBlackWhite.txt", "r")
    ENSansDoublon = open("../en-DataBlackWhiteWithoutDoublon.txt", "w")

    line = EN.readline()
    while line:
        lignePrecedente = line
        line = EN.readline()
        if lignePrecedente != line:
            ENSansDoublon.write(lignePrecedente)

    EN.close()
    ENSansDoublon.close()
