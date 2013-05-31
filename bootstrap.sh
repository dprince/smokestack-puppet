#!/bin/bash
IP=$1

PUB_KEY=$(cat ~/.ssh/id_rsa.pub)

ssh root@$IP bash <<-"EOF_BASH"
[ ! -f ~/.ssh/id_rsa ] && ssh-keygen -N '' -t rsa -q
if [ ! -f ~/.ssh/authorized_keys ]; then
 echo $PUB_KEY > .ssh/authorized_keys
fi
yum update -y
yum install -y puppet
yum install -y git
git clone git://github.com/dprince/smokestack-puppet.git
puppet apply --modulepath=`pwd`/smokestack-puppet/modules -e 'node default {class { "smokestack::worker": }}'
EOF_BASH
