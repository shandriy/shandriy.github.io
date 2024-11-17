s/^$//g

# Custom start list and end list tags
# To start a list, use an empty line with "-" on it
# To close a list, use an empty line with "--" on it

s/^-$/<ul>/g
s/^--$/<\/ul>/g
s/^- \(.*\)/<li>\1<\/li>/g

# Subscript

s/~\([^~]*\)~/<sub>\1<\/sub>/g

# Headings

s/^# \(.*\)/<h1>\1<\/h1>/g
s/^## \(.*\)/<h2>\1<\/h2>/g
s/^### \(.*\)/<h3>\1<\/h3>/g
s/^#### \(.*\)/<h4>\1<\/h4>/g
s/^##### \(.*\)/<h5>\1<\/h5>/g
s/^###### \(.*\)/<h6>\1<\/h6>/g

# Everything that hasn't been edited, add a <p> tag

s/^\([^<].*\)$/<p>\1<\/p>/g

# Bold

s/\*\*\([^\*]\{1,\}\)\*\*/<b>\1<\/b>/g

# Italic

s/\*\([^\*]\{1,\}\)\*/<em>\1<\/em>/g

# Links

s/\[\([^]]*\)\](\([^)]*\))/<a href="\2">\1<\/a>/g