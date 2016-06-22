# coding:utf8
fil = open("/Users/linuslofgren/Documents/Betyg/DATA/gymAleAliGbg.txt", "r")
fullText = fil.read().decode(encoding="utf-16le", errors="strict").encode(encoding="utf-8", errors="strict")
fullText = fullText.splitlines()
fullText = ''.join(fullText)
fullText = fullText.replace(",", ".")
fullText = fullText.replace("NULL", "null")
print fullText
text = ""
buff = ""
offset = 0
outputStr = ""
outputStr += "{\"förklaring\":{\"1)\":\"Alla behöriga sökande är antagna. Se behörighetsregler på www.grkom.se/gymnasieantagningen under rubriken Gymnasievalet\",\"2)\":\"Enbart test. Utbildningen har inte antagning på betyg utan enbart på test\",\"3)\":\"Ingen antagen på poäng. Det finns ingen behörig sökande\",\"4)\":\"Till Introduktionsprogram görs ej preliminärantagning\",\"5)\":\"Placering sker manuellt, ingen antagningspoäng. Mottagande skola har gjort antagningen\"},\"utbildningar\":[{"
informationIdent = 0
def isnumber(n):
    try:
        float(n)
        return True
    except ValueError:
        if (n != "null"):
            return False
        else:
            return True
for i,c in enumerate(fullText):
    if(i+offset == len(fullText)):
        break
    if(fullText[i+offset] == "|" and fullText[i+1+offset] == "-" and fullText[i+2+offset] == "-"):
        a = 0
        city = ""
        while a < len(fullText):
            if(fullText[i+3+a+offset] == "-" and fullText[i+3+a+1+offset] == "-" and fullText[i+3+a+2+offset] == "|"):
                offset += 3+a+2
                break
            city += fullText[i+3+a+offset]
            a += 1
        print city
        if(outputStr[len(outputStr)-1] == "{"):
            outputStr += "\"" + city + "\":["
        else:
            outputStr += "],\"" + city + "\":["
        continue
    if(fullText[i+offset] == "\\"):
        print  "slash " + buff
        if informationIdent == 7:
            if(isnumber(buff)):
                outputStr += "\"medRes\":" + buff + "}"
            else:
                outputStr += "\"medRes\":\"" + buff + "\"}"
            informationIdent = 0
        buff = ""
        continue
    else:
        pass
    if((fullText[i+offset] == "+" and fullText[i+offset+1] == "+") or (fullText[i+offset] == "+" and fullText[i-1+offset] == "+")):
        if buff != "":
            buff = buff.lstrip(".")
            buff = buff.rstrip(".")
            if informationIdent == 0:
                if(outputStr[len(outputStr)-1] == "["):
                    outputStr += "{\"namn\":\"" + buff + "\","
                else:
                    outputStr += ",{\"namn\":\"" + buff + "\","
                informationIdent = 1
            elif informationIdent == 1:
                outputStr += "\"program\":\"" + buff + "\","
                informationIdent = 2
            elif informationIdent == 2:
                if(isnumber(buff)):
                    outputStr += "\"antPrel\":" + buff + ","
                else:
                    outputStr += "\"antPrel\":\"" + buff + "\","

                informationIdent = 3
            elif informationIdent == 3:
                if(isnumber(buff)):
                    outputStr += "\"medPrel\":" + buff + ","
                else:
                    outputStr += "\"medPrel\":\"" + buff + "\","
                informationIdent = 4
            elif informationIdent == 4:
                if(isnumber(buff)):
                    outputStr += "\"antSlut\":" + buff + ","
                else:
                    outputStr += "\"antSlut\":\"" + buff + "\","
                informationIdent = 5
            elif informationIdent == 5:
                if(isnumber(buff)):
                    outputStr += "\"medSlut\":" + buff + ","
                else:
                    outputStr += "\"medSlut\":\"" + buff + "\","
                informationIdent = 6
            elif informationIdent == 6:
                if(isnumber(buff)):
                    outputStr += "\"antRes\":" + buff + ","
                else:
                    outputStr += "\"antRes\":\"" + buff + "\","
                informationIdent = 7

            print buff
            buff = ""
        pass
    else:
        buff += fullText[i+offset]
        #print buff
        pass
outputStr += "]}]}"



outFile = open("/Users/linuslofgren/Documents/Betyg/DATA/output.json", "w")
outFile.write(outputStr)
