while True:
    f = open("/Users/linuslofgren/Documents/Betyg/DATA/betyg.json", "r")
    txt = f.read()
    txt1 = txt[:-5]
    txt2 = txt[-5:]
    # print txt[-8]
    school = raw_input("skola ")
    prog = raw_input("prog ")
    anp = raw_input("ant prel ") or "null"
    mep = raw_input("med prel ") or "null"
    ans = raw_input("ant slut ") or "null"
    mes = raw_input("med slut ") or "null"
    anr = raw_input("ant res ") or "null"
    mer = raw_input("med res ") or "null"
    #if(txt[-8] == "["):
    st = "{\"namn\":\"" + school + "\",\"program\":\"" + prog + "\",\"antPrel\":" + anp + ",\"medPrel\":" + mep + ",\"antSlut\":" + ans + ",\"medSlut\":" + mes + ",\"antRes\":" + anr + ",\"medRes\":" + mer + "}"

    #else:
    #    st = ",{\"namn\":\"" + school + "\",\"program\":\"" + prog + "\",\"antPrel\":" + anp + ",\"medPrel\":" + mep + ",\"antSlut\":" + ans + ",\"medSlut\":" + mes + ",\"antRes\":" + anr + ",\"medRes\":" + mer + "}"

    strFull = txt1+st+txt2
    f = open("/Users/linuslofgren/Documents/Betyg/DATA/betyg.json.tmp", "w")
    f.write(strFull)
    f = open("/Users/linuslofgren/Documents/Betyg/DATA/betyg.json.tmp", "r")
    txt = f.read()

    f = open("/Users/linuslofgren/Documents/Betyg/DATA/betyg.json", "w")
    f.write(txt)
