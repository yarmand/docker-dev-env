WINDOWS_USER=yann

alias win="ssh -p 9922 ${WINDOWS_USER}@10.0.75.1"

function code() {
  OPTIONS=""
  while [[ -n "$2" ]] ; do OPTIONS="$OPTIONS $1" ; shift ; done
  test -d $1 && TYPE=folder || TYPE=file
  if [ $(echo $1 | head -c 1) = '/' ] ; then
    MY_PATH=''
  else
    MY_PATH=$(pwd)
  fi
  set -x
  win code $OPTIONS --$TYPE-uri vscode-remote://ssh-remote+dev$MY_PATH/$1
}

function dev_to_windows()
{
  echo $* | sed -e 's:/src:S\::g' -e 's:/:\\:g' 
}

# execute a windows command
function start() {
  test -d $1 && START=start || START=''
  DIR=$(cd $(dirname $1);pwd)
  BASE=$(basename $1)
  win $START $(dev_to_windows $DIR/$BASE)
}