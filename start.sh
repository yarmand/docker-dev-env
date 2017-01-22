#!/bin/bash

mkdir -p /root/.ssh
chmod 0700 /root/.ssh
if [ ! -f /root/.ssh/authorized_keys ] ; then
  cp /home/id_rsa.pub /root/.ssh/authorized_keys
fi
chmod 644 /root/.ssh/authorized_keys

/etc/init.d/ssh start

while true ; do
  sleep 10000
done

