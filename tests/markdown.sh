#!/bin/sh

cat $1 | sed -f markdown.sed > $2