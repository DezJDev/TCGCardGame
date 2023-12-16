if __name__ == "__main__":
    SourceTest = open("school_data.txt", "r")
    Source = open("school_data.txt", "r")
    Cible = open("school_dataWithoutDoublon.txt", "w")

    indexTest = 0
    indexLine = 0
    for sc_lignestestees in SourceTest.readlines():
        Source.seek(0)
        indexLine = 0
        for sc_lignes in Source.readlines():
            if sc_lignestestees == sc_lignes and indexLine == indexTest:
                Cible.write(sc_lignestestees)
            indexLine += 1

        indexTest += 1

    SourceTest.close()
    Source.close()
    Cible.close()
