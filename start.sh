#!/bin/bash

mkdir -p /home/developer/.ssh
chmod 0700 /home/developer/.ssh
chown developer /home/developer/.ssh
if [ ! -f /home/developer/.ssh/authorized_keys ] ; then
  cp /home/id_rsa.pub /home/developer/.ssh/authorized_keys
fi
chmod 644 /home/developer/.ssh/authorized_keys
chown developer /home/developer/.ssh/authorized_keys

/etc/init.d/ssh start

while true ; do
  sleep 10000
done

