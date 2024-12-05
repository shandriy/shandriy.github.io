var left, right;
var leftButton, rightButton;
addEventListener("DOMContentLoaded", function() {
  left = document.getElementsByClassName("left")[0];
  right = document.getElementsByClassName("right")[0];
  leftButton = document.getElementById("left-button");
  rightButton = document.getElementById("right-button");
});
addEventListener("resize", function() {
  if (innerWidth <= 640) {
    if (left.style.display !== "none" && right.style.display !== "none") {
      left.style.display = "none";
      right.style.display = "none";
    } else {
      if (left.style.display === "none" && right.style.display !== "none") leftButton.style.display = "none";
      if (left.style.display !== "none" && right.style.display === "none") rightButton.style.display = "none";
    }
  } else {
    if (left.style.display === "none" && right.style.display === "none") {
      left.style.display = "table-cell";
      right.style.display = "table-cell";
    }
    leftButton.style.display = "inline-block";
    rightButton.style.display = "inline-block";
  }
});
function toggleLeft() {
  var computed = getComputedStyle(left);
  var display = computed.getPropertyValue("display");
  if (display !== "none") {
    left.style.display = "none";
    rightButton.style.display = "inline-block";
  }
  else {
    left.style.display = "table-cell";
    if (innerWidth <= 640) {
      right.style.display = "none";
      rightButton.style.display = "none";
    }
  }
}
function toggleRight() {
  var computed = getComputedStyle(right);
  var display = computed.getPropertyValue("display");
  if (display !== "none") {
    right.style.display = "none";
    leftButton.style.display = "inline-block";
  } else {
    right.style.display = "table-cell";
    if (innerWidth <= 640) {
      left.style.display = "none";
      leftButton.style.display = "none";
    }
  }
}
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
      console.log(document.getElementById("stats"))
    };
  }
  xhr.open("GET", "https://nekoweb.org/api/site/info/enty");
  xhr.send();
});