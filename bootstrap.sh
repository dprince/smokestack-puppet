#!/bin/bash
IP=$1

PUB_KEY=$(cat ~/.ssh/id_rsa.pub)

ssh root@$IP bash <<-EOF_BASH
[ ! -d ~/.ssh ] && ssh-keygen -N '' -t rsa -q
if [ ! -f ~/.ssh/authorized_keys ]; then
 echo $PUB_KEY > .ssh/authorized_keys
fi
EOF_BASH
