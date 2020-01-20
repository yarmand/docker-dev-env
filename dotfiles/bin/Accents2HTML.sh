#!/bin/bash

echo "FILE=$1"

cat "$1" | sed "s/&/&amp;/g" | sed "s/à/&agrave;/g" | sed "s/À/&Agrave;/g" | sed "s/â/&acirc;/g" | sed "s/Â/&Acirc;/g" | sed "s/ä/&auml;/g" | sed "s/Ä/&Auml;/g" | sed "s/å/&aring;/g" | sed "s/Å/&Aring;/g" | sed "s/æ/&aelig;/g" | sed "s/Æ/&AElig;/g" | sed "s/ç/&ccedil;/g" | sed "s/Ç/&Ccedil;/g" | sed "s/é/&eacute;/g" | sed "s/É/&Eacute;/g" | sed "s/è/&egrave;/g" | sed "s/È/&Egrave;/g" | sed "s/ê/&ecirc;/g" | sed "s/Ê/&Ecirc;/g" | sed "s/ë/&euml;/g" | sed "s/Ë/&Euml;/g" | sed "s/ï/&iuml;/g" | sed "s/Ï/&Iuml;/g" | sed "s/ô/&ocirc;/g" | sed "s/Ô/&Ocirc;/g" | sed "s/ö/&ouml;/g" | sed "s/Ö/&Ouml;/g" | sed "s/ø/&oslash;/g" | sed "s/Ø/&Oslash;/g" | sed "s/ß/&szlig;/g" | sed "s/ù/&ugrave;/g" | sed "s/Ù/&Ugrave;/g" | sed "s/û/&ucirc;/g" | sed "s/Û/&Ucirc;/g" | sed "s/ü/&uuml;/g" | sed "s/Ü/&Uuml;/g" | sed "s/®/&reg;/g" | sed "s/©/&copy;/g" 
