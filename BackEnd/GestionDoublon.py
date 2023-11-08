if __name__ == "__main__":
    EN = open("sc", "r")
    ENSansDoublon = open("school_data2", "w")

    line = EN.readline()
    while line:
        lignePrecedente = line
        line = EN.readline()
        if lignePrecedente != line:
            ENSansDoublon.write(lignePrecedente)

    EN.close()
    ENSansDoublon.close()
