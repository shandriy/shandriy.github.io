// (c) 2024 Shandriy, K
// SPDX-License-Identifier: MIT
// XMLHttpRequest polyfill for IE

void function() {
  if (typeof XMLHttpRequest != "undefined")
    return;

  var str = "MSXML.HttpRequest";

  try {
    new ActiveXObject("Msxml2.XMLHTTP");
    str = "Msxml2.XMLHTTP";
  } catch (_) {};

  try {
    new ActiveXObject("Microsoft.XMLHTTP");
    str = "Microsoft.XMLHTTP";
  } catch (_) {};

  window.XMLHttpRequest = function() {
    if (this instanceof XMLHttpRequest)
      return new ActiveXObject(str);
    else
      throw new TypeError();
  }
}()