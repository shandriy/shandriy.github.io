BEGIN {
  state = 0
}

{
  initial = $0
  current = $0
  matching = 1
  while (matching) {
    possible_matches = 7

    if (match(current, /^-\s{1,}(.*)$/, capture)) {
      new = "<li>" capture[1] "</li>"
      if (state == 0) {
        state = 1
        new = "<ul>" new
      }
      current = new
    } else {
      if (state == 1 && !match(current, /^(<ul>|<li>)(.*)$/)) {
        state = 0
        current = "</ul>" current
      }
      possible_matches--
    }

    if (match(current, /^(.*)\*{2}([^\*]{1,})\*{2}(.*)$/, capture)) {
      new = capture[1] "<strong>" capture[2] "</strong>" capture[3]
      current = new
    } else {
      possible_matches--
    }

    if (match(current, /^(.*)\*([^\*]{1,})\*(.*)$/, capture)) {
      new = capture[1] "<em>" capture[2] "</em>" capture[3]
      current = new
    } else {
      possible_matches--
    }

    if (match(current, /^(.*)~{2}([^~]{1,})~{2}(.*)$/, capture)) {
      new = capture[1] "<del>" capture[2] "</del>" capture[3]
      current = new
    } else {
      possible_matches--
    }

    if (match(current, /^(.*)~([^~]{1,})~(.*)$/, capture)) {
      new = capture[1] "<sub>" capture[2] "</sub>" capture[3]
      current = new
    } else {
      possible_matches--
    }

    if (match(current, /^(.*)`([^`]{1,})`(.*)$/, capture)) {
      new = capture[1] "<code>" capture[2] "</code>" capture[3]
      current = new
    } else {
      possible_matches--
    }

    if (match(current, /^(#{1,6})\s{1,}(.*)$/, capture)) {
      new = "<h" length(capture[1]) ">" capture[2] "</h" length(capture[1]) ">"
      current = new
    } else {
      possible_matches--
    }

    if (match(current, /^(.*)\[([^\]]*)\]\(([^\)]*)\)(.*)$/, capture)) {
      new = capture[1] "<a href=\"" capture[3] "\">" capture[2] "</a>" capture[4]
      current = new
    } else {
      possible_matches--
    }

    if (possible_matches <= 0) {
      matching = 0
    }
  }

  if (match(current, /^([^<].*)/, capture)) {
    new = "<p>" capture[1] "</p>"
    current = new
  }

  if (match(current, /^<\/ul>(.*)/, capture)) {
    new = "</ul><p>" capture[1] "</p>"
    current = new
  }

  print current
}