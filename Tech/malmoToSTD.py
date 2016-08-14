# coding:utf8
fil = open("/Users/linuslofgren/Documents/Betyg/Betygen/malmoRawData2016slutmerit.txt", "r")
fullText = fil.read()#.decode(encoding="utf-16le", errors="strict").encode(encoding="utf-8", errors="strict")
fullText = fullText.splitlines()
text = ""
buff = ""
offset = 0
outputStr = ""
informationIdent = 0
def getLowestMean(parts):
    program = parts[0]
    schoolAndPoints = parts[1]
    arraySN = schoolAndPoints.split(" ")
    newArr = []
    nameList = []
    for p in arraySN:
        try:
            fl = float(p)
            newArr.append(fl)
        except ValueError:
            if len(p)==1:
                fl = p
                newArr.append(fl.strip())
            else:
                nameList.append(p)
    name = " ".join(nameList)
    lowest = None
    mean = None
    if len(newArr)==2:
        lowest = newArr[0]
        mean = newArr[1]
    elif len(newArr)==1:
        lowest = newArr[0]
    return (lowest, mean, name)
def isnumber(n):
    try:
        float(n)
        return True
    except ValueError:
        if (n != "null"):
            return False
        else:
            return True
output = "["
for i,row in enumerate(fullText):
    #print row
    parts = row.split(",")
    tup = (None, None, None)
    name = ""
    if len(parts) == 2:
        tup = getLowestMean(parts)
        name = parts[0]
    elif len(parts) == 3:
        name = "".join(parts[:2])
        tup = getLowestMean(parts[1:])
    else:
        continue

    antSlut = "null"
    if tup[0]=="B":
        antSlut="\"B\""
    elif tup[0]=="A":
        print "AN A"
        antSlut="\"A\""
        print antSlut
    elif tup[0]=="C":
        antSlut="\"C\""
    elif tup[0]==None:
        antSlut="null"
    else:
        try:
            antSlut=float(tup[0])
        except ValueError:
            antSlut="\""+tup[0]+"\""
    medSlut = "null"
    if tup[1]=="B":
        medSlut="\"B\""
    elif tup[1]=="A":
        medSlut="\"A\""
    elif tup[1]=="C":
        medSlut="\"C\""
    elif tup[1]==None:
        medSlut="null"
    else:
        try:
            medSlut=float(tup[1])
        except ValueError:
            medSlut="\""+tup[1]+"\""
    print name
    print medSlut
    print tup[1]
    print antSlut
    print tup[0]
    output += "{\"skola\":\""+tup[2]+"\",\"program\":\""+name+"\",\"antPrel\":"+str(antSlut)+",\"medPrel\":"+str(medSlut)+"},"


output = output[:-1]+"]"

outFile = open("/Users/linuslofgren/Documents/Betyg/Betygen/malmo2016slutmerit.json", "w")
outFile.write(output)
