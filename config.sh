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

SONG="Art_Deco"

# Get song script

. "./music/$SONG.sh"