# coding:utf8
fil = open("/Users/linuslofgren/Documents/Betyg/Betygen/malmoRaw2016prelmerit.txt", "r")
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
                newArr.append(fl)
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
        print "ERROROROR"
        print parts
        continue
    print name
    print tup[2]
    print tup[:2]
    antSlut = "null"
    try:
        if tup[0] == None:
            antSlut = "null"
        else:
            antSlut = float(tup[0])
    except ValueError:
        antSlut = "\""+tup[0]+"\""
    medSlut = "null"
    try:
        if tup[1] == None:
            antSlut = "null"
        else:
            medSlut = float(tup[1])
    except ValueError:
        medSlut = "\""+tup[1]+"\""

    output += "{\"skola\":\""+tup[2]+"\",\"program\":\""+name+"\",\"antPrel\":"+str(antSlut)+",\"medPrel\":"+str(medSlut)+"},"


output = output[:-1]+"]"

outFile = open("/Users/linuslofgren/Documents/Betyg/Betygen/malmo2016prelmerit.json", "w")
outFile.write(output)
