#!/bin/sh

# Sets directory to that in which the script is located

cd $(dirname $0)

# Search for configuration script and execute it
# Initilizes constant variables and paths

if [ -f "./config.sh" ]
then

  . "./config.sh"

elif [ -f "./config" ]
then

  . "./config"

else

  # If no configuration file has been found,
  # initalize global variables to defaults

  SOURCE_DIR="./.src"
  TEMPLATE_DIR="./.tmp"
  GENERATED_DIR="./.gen"

fi

# If generated files exist, delete all of them

GENERATED_LISTING="$GENERATED_DIR/generated_list.txt"
GENERATED_SOURCE_LISTING="$GENERATED_DIR/generated_source.txt"

if [ -f $GENERATED_LISTING ]
then

  # Loop over every file listed, and delete all

  while read line
  do

    rm -rf "$line"

  done < "$GENERATED_LISTING"

fi

# Reset the generated directory

rm -rf "$GENERATED_DIR"
mkdir "$GENERATED_DIR"

# Create files needed for the generated dir;
# Needed later in script

touch "$GENERATED_LISTING"
touch "$GENERATED_SOURCE_LISTING"

# Begin collecting a list of source files
# If the source directory does not exist, replace
# it with an empty one. If it is a file, replace it
# with an empty directory as well.

if [ ! -d "$SOURCE_DIR" ]
then

  rm -f "$SOURCE_DIR"
  mkdir "$SOURCE_DIR"

fi

find "$SOURCE_DIR" > "$GENERATED_SOURCE_LISTING"

# Loop other every path listed in the source directory

while read line
do

  # Get path relative to the source directory for output

  relative_path=$(realpath -m --relative-to="$SOURCE_DIR" "$line")
  output_path="./$relative_path"

  if [ -d "$line" ]
  then

    # Source listing will also include the working
    # directory. Since it already exists, a check
    # needs to be done first. Prevents it from being
    # added to the clean list

    if [ ! -d "$output_path" ]
    then

      mkdir "$output_path"
      echo "$output_path" >> "$GENERATED_LISTING"

    fi

  elif [ "${output_path##*.}" = "md" ]
  then

    tail -n +2 "$line" > "$GENERATED_DIR/tmp.txt"

    # markdown-smart disables curly qoutes
    # Using markdown+smart enables it

    markdown_contents=$(pandoc "$GENERATED_DIR/tmp.txt" -f markdown-smart)
    #markdown_contents=$(cat "$GENERATED_DIR/tmp.txt" | sed -f tests/markdown.sed)
    #markdown_contents=$(awk -f "tests/markdown.awk" "$GENERATED_DIR/tmp.txt")
    template_name=$(head -n 1 "$line")
    template_text=""

    # Check that the provided template exists

    if [ -f "$TEMPLATE_DIR/$template_name" ]
    then

      template_text=$(cat "$TEMPLATE_DIR/$template_name")

    fi

    is_looping=""
    output_text=""
    current_text="$template_text"

    if [ -f "./$FILE_BUILD" ]
    then
      . "./$FILE_BUILD"
    fi

    # Loop to substitute variables
    # Empty string means loop continues
    # Once it is any non-empty value, the loop ends

    while [ -z "$is_looping" ]
    do

      output_text="$output_text"${current_text%%"{{"*}

      if [ "${current_text%%"{{"*}" != "$current_text" ]
      then

        # I have no idea how this is working but it's working

        split=${current_text#*"{{"}
        eval var_value="\$${split%%"}}"*}"
        output_text="$output_text""$var_value"
        current_text=${current_text#*"}}"}

        if [ -z "$current_text" ]
        then

          is_looping="1"

        fi

      else

        is_looping="1"

      fi

    done
    echo "$output_text" > ${output_path%.md}.htm
    echo ${output_path%.md}.htm >> "$GENERATED_LISTING"

  fi

done < "$GENERATED_SOURCE_LISTING"

# Clear no longer needed files

rm -f "$GENERATED_DIR/tmp.txt"
