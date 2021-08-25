// function myFunction() {
//   document.getElementById("article").innerHTML = "";
// }

//
// const targetDiv = document.getElementById("article");
// const btn = document.getElementById("toggle");
// btn.onclick = function () {
//   if (targetDiv.style.display !== "none") {
//     targetDiv.style.display = "none";
//   } else {
//     targetDiv.style.display = "block";
//   }
// };


var divs = ["Div1", "Div2", "Div3", "Div4", "Div5", "Div6", "Div7", "Div8", "Div9", "Div10"
, "Div11", "Div12", "Div13", "Div14", "Div15", "Div16", "Div17", "Div18", "Div19"
, "Div20", "Div21", "Div22", "Div23", "Div24", "Div25", "Div26", "Div27", "Div28"
, "Div29", "Div30", "Div31", "Div32"];
    // var visibleDivId = null;
    function divVisibility(divId) {
      const targetDiv = document.getElementById(divId);
      // console.log(targetDiv);
      if (targetDiv.style.display !== "none") {
        targetDiv.style.display = "none";
      } else {
        targetDiv.style.display = "block";
      }
      // hideNonVisibleDivs();
    }
    function hideNonVisibleDivs() {
      var i, divId, div;
      for(i = 0; i < divs.length; i++) {
        divId = divs[i];
        div = document.getElementById(divId);
        if(visibleDivId === divId) {
          div.style.display = "block";
        } else {
          div.style.display = "none";
        }
      }
    }
