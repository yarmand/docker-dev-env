#!/bin/bash

echo "FILE=$1"

cat "$1" | sed "s/&/&amp;/g" | sed "s/�/&agrave;/g" | sed "s/�/&Agrave;/g" | sed "s/�/&acirc;/g" | sed "s/�/&Acirc;/g" | sed "s/�/&auml;/g" | sed "s/�/&Auml;/g" | sed "s/�/&aring;/g" | sed "s/�/&Aring;/g" | sed "s/�/&aelig;/g" | sed "s/�/&AElig;/g" | sed "s/�/&ccedil;/g" | sed "s/�/&Ccedil;/g" | sed "s/�/&eacute;/g" | sed "s/�/&Eacute;/g" | sed "s/�/&egrave;/g" | sed "s/�/&Egrave;/g" | sed "s/�/&ecirc;/g" | sed "s/�/&Ecirc;/g" | sed "s/�/&euml;/g" | sed "s/�/&Euml;/g" | sed "s/�/&iuml;/g" | sed "s/�/&Iuml;/g" | sed "s/�/&ocirc;/g" | sed "s/�/&Ocirc;/g" | sed "s/�/&ouml;/g" | sed "s/�/&Ouml;/g" | sed "s/�/&oslash;/g" | sed "s/�/&Oslash;/g" | sed "s/�/&szlig;/g" | sed "s/�/&ugrave;/g" | sed "s/�/&Ugrave;/g" | sed "s/�/&ucirc;/g" | sed "s/�/&Ucirc;/g" | sed "s/�/&uuml;/g" | sed "s/�/&Uuml;/g" | sed "s/�/&reg;/g" | sed "s/�/&copy;/g" 
