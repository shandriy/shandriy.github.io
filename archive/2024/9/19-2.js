addEventListener("DOMContentLoaded", function() {
  var xhr = new XMLHttpRequest();
  xhr.onreadystatechange = function() {
    if (xhr.readyState === 4 && xhr.status === 200) {
      var text = xhr.responseText;
      var ul = document.createElement("ul");
      var props = [
        "updates",
        "followers",
        "views",
        "updated_at"
      ]
      var texts = [
        "number of updates: ",
        "followers: ",
        "total views: ",
        "last update: "
      ]
      for (var i = 0; i < props.length; i += 1) {
        var li = document.createElement("li");
        var value = parseInt(text.substring(text.indexOf("\"" + props[i] + "\":") + props[i].length + 3));
        li.innerHTML = texts[i] + value;
        if (i === 3) li.innerHTML = texts[i] + new Date(value);
        ul.appendChild(li);
      }
      document.getElementById("stats").appendChild(ul);
    };
  }
  xhr.open("GET", "https://nekoweb.org/api/site/info/enty"); 
  xhr.send();
});