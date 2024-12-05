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

SONG="Im_so_Concerned_About_the_Ending_That_I_Dont_Even_Know_the_Plot"

# Get song script

. "./music/$SONG.sh"