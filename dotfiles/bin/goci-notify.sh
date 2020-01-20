#!/bin/bash

pass=$1
if [ "$pass" = "[PASS]" ] ; then
  type=pass
  color=green
else
  type=fail
  color=red
fi

# reattach-to-user-namespace osx-notifier --type $type --title "go test" --message $type

all="status-left-bg status-bg pane-active-border-fg pane-border-fg"
bar=status-bg

function change_color(){
c=$1
where=$2
for location in $where ; do
  tmux set $location $c >/dev/null
done
}

change_color yellow "$all"
sleep 0.5
change_color $color "$all"
sleep 2
change_color green "$bar"
