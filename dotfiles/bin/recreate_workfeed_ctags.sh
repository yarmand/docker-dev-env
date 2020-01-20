#!/bin/bash

#WORKFEED=~/Code/workfeed
DIRS="app config lib public/javascripts"


#cd $WORKFEED

find $DIRS | ctags --extra=+f -L -

