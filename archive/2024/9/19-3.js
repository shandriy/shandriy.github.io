var hash;
var map = [];
var cache = [];
var hashes = [];
var references = {
  "home": "home",
  "2024.9.19": "blog/2024/9/19",
  "changelog": "changelog"
};
var element = document.getElementById("xhr-response-content");
setInterval(function() {
  if (location.hash !== hash) {
    hash = location.hash;
    element.innerHTML = "";
    var hashIndex = hashes.indexOf(hash);
    if (hashIndex === -1) {
      var xhr = new XMLHttpRequest();
      xhr.onreadystatechange = function() {
        if (xhr.readyState === 4 && xhr.status === 200) {
          element.innerHTML = xhr.responseText;
          var response = xhr.responseText;
          hashes.push(hash);
          var index = cache.indexOf(response);
          if (index === -1) {
            map.push(cache.length);
            cache.push(response);
          } else {
            map.push(index);
          }
        }
      };
      var url = references[hash.substring(1)];
      if (url === undefined) {
        url = "404";
        if (hash.substring(1) === "") {
          url = "home"
        }
      }
      xhr.open("GET", "pages/" + url + ".html")
      xhr.send();
    } else {
      element.innerHTML = cache[map[hashIndex]];
    }
  } else {
    hash = location.hash;
  }
}, 200)