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

SONG="Eyes_That_Gaze_into_the_Nexus_The_Ones_Who_Gather_Stars_in_the_Night"

# Get song script

. "music/$SONG.sh"