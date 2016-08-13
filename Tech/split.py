# coding:utf8
fil = open("/Users/linuslofgren/Documents/STHLM kopia.txt.txt", "r")
fullText = fil.read()#.decode(encoding="utf-16le", errors="strict").encode(encoding="utf-8", errors="strict")
outputStr = ""
for i,c in enumerate(fullText):
    if c != "\n":
        outputStr += c



outFile = open("/Users/linuslofgren/Documents/STHLM.json", "w")
outFile.write(outputStr)
