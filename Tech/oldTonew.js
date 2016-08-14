fs = require('fs');
var i = 0;
var mainObj = {};
fs.readFile("/Users/linuslofgren/Documents/Betyg/2016 data per munic/Stockholms län 2016.json", "utf8", function(err, data){
  if (err){
    return console.log(err);
  }
  else {
    data = JSON.parse(data.toString("utf8"));

    var holderObj = data;
    var län = [];
    for (var municipality in holderObj) {
      if (holderObj.hasOwnProperty(municipality)) {
        console.log(municipality);
        for (var i = 0; i < holderObj[municipality].length; i++) {
          var obj = holderObj[municipality][i];
          obj.kommun = municipality
          län.push(obj);
        }
      }
    }
    fs.writeFile("/Users/linuslofgren/Documents/tmpSTHLM.json", JSON.stringify(län), function(){});
  }
});
