window.onload = function(){
  inp(false);
  hide();

}
var saker = []
var exp;
function proc(data){
  exp = data.förklaring;
  for (var utb in data.utbildningar[0]) {
    if (data.utbildningar[0].hasOwnProperty(utb)) {
      var a = data.utbildningar[0][utb]
      for (var i = 0; i < a.length; i++) {
        saker.push(a[i]);
      }
    }
  }
}
function hide(){
  if(!document.getElementById("number").checked == true){
    document.getElementById("hid").style.display = "none";
    if(document.getElementById("over")!=undefined)
      document.getElementById("over").style.display = "none";
  }
  else{
    document.getElementById("hid").style.display = "inline-block";
    if(document.getElementById("over")!=undefined)
      document.getElementById("over").style.display = "inline-block";
  }
}
function get(str){
  stuff = []
  for (var i = 0; i < saker.length; i++) {
    if(saker[i].namn.toLowerCase().indexOf(str)>=0){
      if(typeof saker[i].antSlut == "string"){
        stuff.push({"namn": saker[i].namn, "program": saker[i].program, "poäng": saker[i].antSlut, needExp: true, use: true});
      }
      else{
        stuff.push({"namn": saker[i].namn, "program": saker[i].program, "poäng": saker[i].antSlut, needExp: false, use: true});
      }
    }
  }
  return stuff
}
function inp(p){
  p = true;

  var input = document.getElementById("i");
  var stuff = get(input.value);
  var ht = "";
  for (var f in exp) {
    if (exp.hasOwnProperty(f)) {
      ht += f + ": " + exp[f] + "<br>"
    }
  }
  ht += "<div id='over'><div class='box red'></div>: Över 340 poäng - antagning sker på test</div>"
  ht += "<table><th>Skola</th><th>Program</th><th>Lägsta antagningspoäng</th>";
  var str = "";
  if(document.getElementById("number").checked == true){
    var goodStuff = [];
    for (var i = 0; i < stuff.length; i++) {
      if(!stuff[i].needExp){
        goodStuff.push(stuff[i])
        stuff[i].use = false
      }
    }
    goodStuff.sort(function(a, b){
      return b.poäng - a.poäng
    });
    for (var i = 0; i < goodStuff.length; i++) {
      str = "";
      if(p){
        var points = document.getElementById("points").value
        points = points.replace(",",".")
        if(points[points.length-1] == "."){
          points+="0";
        }
        if(!isNaN(points)){
          if(points>=goodStuff[i].poäng){
            str = "class='lower'";
          }
        }
      }
      if(goodStuff[i].poäng>340){
        ht += "<tr class='red'><td>" + goodStuff[i].namn + "</td><td>" + goodStuff[i].program + "</td><td>" + goodStuff[i].poäng + "</td></tr>";
      }
      else{
        ht += "<tr " + str + " ><td>" + goodStuff[i].namn + "</td><td>" + goodStuff[i].program + "</td><td>" + goodStuff[i].poäng + "</td></tr>";
      }
    }
    str = "class='lower'";
  }
  for (var i = 0; i < stuff.length; i++) {
    if(stuff[i].use){
      ht += "<tr " + str + "><td>" + stuff[i].namn + "</td><td>" + stuff[i].program + "</td><td>" + stuff[i].poäng + "</td></tr>";
    }
  }
  ht += "</table>"
  document.getElementById("output").innerHTML = ht;
}
