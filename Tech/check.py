f = open("/Users/linuslofgren/Documents/Betyg/DATA/betyg.json.tmp", "r")
txt = f.read()

f = open("/Users/linuslofgren/Documents/Betyg/DATA/betyg.json", "w")
f.write(txt)
