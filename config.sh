#!/bin/sh

cd $(dirname $0)

# Config

SOURCE_DIR=./md
TEMPLATE_DIR=./src
GENERATED_DIR=./gen
FILE_BUILD=./every.sh

# Custom variables

DATE=$(date +"%F %T.%N %::z")
SECONDS=$(date +"%s")
FOOTER_TEXT=$(cat ./src/footer-text.htm)

SONG="Bad_At_Love"

# Get song script

. "./music/$SONG.sh"

A_CONTENT="OTAKUSPEEDVIBE"
A_HREF="https://www.youtube.com/watch?v=rN2mtNvDVGw"

if [ -n "$song_of_the_day_quote" ]
then

  A_CONTENT="$song_of_the_day_quote"
  A_HREF="$song_of_the_day_youtube"

fi

SUBTITLE="<em><sub><a href=\"$A_HREF\">$A_CONTENT</a></sub></em>"