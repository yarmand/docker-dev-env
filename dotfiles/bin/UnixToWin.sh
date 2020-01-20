#!/bin/sh

SRC=$1
TMP=/tmp/UnixToWin.$$

CR=`printf "\r"` 

sed -e "s:$:$CR:g" -e "s:$CR$CR:$CR:g" "$SRC" >$TMP
grep -v -e "^$CR" "$TMP" >$SRC
rm "$TMP"

