(function(global) {
  if (
    !global.document.body.outerHTML &&
    !global.HTMLDetailsElement &&
    !global.HTMLCanvasElement &&
    !global.HTMLAudioElement
  ) {
    global.location.replace()
  }
})(window);