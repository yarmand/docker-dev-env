#!/bin/sh

# Export local machine xauth information to a remote host.
# The remote host will be able to export X11 display on localhost.
# -- Y.ARMAND Xinet - 2008 --

X11_HOST=`hostname`
AUTH_FILE=$X11_HOST.auth
REMOTE_HOST=$1
# exrtact xauth infos
xauth extract $AUTH_FILE $X11_HOST:0
# copy auth infos to remote
scp $AUTH_FILE $REMOTE_HOST:
rm -f $AUTH_FILE
# add local xauth infos to the remote Xauthority file
ssh $REMOTE_HOST xauth merge .Xauthority $AUTH_FILE
ssh $REMOTE_HOST rm $AUTH_FILE
