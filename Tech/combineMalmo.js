fs = require('fs');
var i = 0;
var mainObj = {};
fs.readFile("/Users/linuslofgren/Documents/Betyg/Betygen/malmo2016prelmerit.json", "utf8", function(err, preldata){
  if (err){
    return console.log(err);
  }
  else {
    fs.readFile("/Users/linuslofgren/Documents/Betyg/Betygen/malmo2016slutmerit.json", "utf8", function(err, slutdata){
      if (err){
        return console.log(err);
      }
      var master = [];
      slutdata = JSON.parse(slutdata.toString("utf8"));
      preldata = JSON.parse(preldata.toString("utf8"));
      for (var i = 0; i < slutdata.length; i++) {
        var slutprog = slutdata[i];
        var prelprog = preldata.find(function(obj){return obj.skola == slutprog.skola});
        console.log(slutprog);
        var obj = {
          namn: slutprog.skola.trim(),
          program: slutprog.program.trim(),
          antPrel: prelprog.antPrel=="A"?"1)":prelprog.antPrel=="B"?"3)":prelprog.antPrel,
          medPrel: prelprog.medPrel=="A"?"1)":prelprog.medPrel=="B"?"3)":prelprog.medPrel,
          antSlut: slutprog.antPrel=="A"?"1)":slutprog.antPrel=="B"?"3)":slutprog.antPrel,
          medSlut: slutprog.medPrel=="A"?"1)":slutprog.medPrel=="B"?"3)":slutprog.medPrel,
          antRes: null,
          medRes: null
        }
        //console.log(obj);
        master.push(obj)
      }
      fs.writeFile("/Users/linuslofgren/Documents/tmpMalmo.json", JSON.stringify(master), function(){});
    });
  }
});
