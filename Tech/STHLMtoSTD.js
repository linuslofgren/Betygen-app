fs = require('fs');
var i = 0;
var mainObj = {};
fs.readFile("/Users/linuslofgren/Documents/STHLM.json", "utf-8", function(err, data){
  if (err){
    return console.log(err);
  }
  else {
    data = JSON.parse(data);

    for (var i = 0; i < data.length; i++) {
      i++

      var object = {
        namn: data[i].school,
        program: data[i].program,
        antPrel: null,
        medPrel: null,
        antSlut: data[i].points_limit=="-"?null:parseFloat(data[i].points_limit),
        medSlut: data[i].points_median=="-"?null:parseFloat(data[i].points_median),
        antRes: null,
        medRes: null
      };
      if(mainObj[data[i].location]==undefined){
        mainObj[data[i].location] = [object]
      }
      else{
        mainObj[data[i].location].push(object)
      }
    }
    console.log(i);
    console.log(mainObj);
    fs.writeFile("/Users/linuslofgren/Documents/STHLMoutput.json", JSON.stringify(mainObj), function(){});
  }
});
