#!/bin/bash

ME=$0
DEBUG=0
function fail()
{
  MSG=$1
  echo $MSG
  echo "$ME [--debug] src dest"
}
if [ "$1" = '--debug' ] ; then
  DEBUG=1
  shift
fi

SRC=$1
DEST=$2

if [ -z "$DEST" ] ; then
  DEST='.'
fi

if echo "$SRC" | grep -q ':' ; then
  ACTION=pull
  BNAME=`basename $SRC`
fi

if echo "$DEST" | grep -q ':' ; then
  if [ "$ACTION" = 'push' ] ; then
    fail 'SRC and DEST cannot be both remotes'
  fi
  ACTION=push
  BNAME=`echo $SRC| cut -d: -f 2 | xargs basename`
fi

function debug()
{
  MSG=$1
  if [ $DEBUG -eq 1 ] ; then
    echo $MSG
  fi
}

function local_src_to_jumphost()
{
  debug "copy $SRC to $JUMPHOST"
  scp "$SRC" $JUMPHOST:
}

function jumphost_to_remote()
{
  debug "copy $BNAME to $DEST"
  ssh -t -A $JUMPHOST exec "scp $BNAME $DEST && rm -f $BNAME"
}

function remote_src_to_jumphost()
{
  debug "copy via jumphost  $SRC to $JUMPHOST"
  ssh -t -A $JUMPHOST exec "scp $SRC $BNAME "
}

function jumphost_to_local()
{
  debug "copy $BNAME from $JUMPHOST to $DEST"
  scp $JUMPHOST:$BNAME $DEST
}

case $ACTION in
  push)
    local_src_to_jumphost
    jumphost_to_remote
    ;;
  pull)
    remote_src_to_jumphost
    jumphost_to_local
    ;;
esac
