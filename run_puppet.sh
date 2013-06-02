#!/bin/bash

if ! test -z $1 ; then
  BASE_DIR=$1
else
  BASE_DIR=`pwd`
fi

MODULE_DIR=${BASE_DIR}/modules
MODULE_PATH=${MODULE_DIR}:/etc/puppet/modules
PUPPET_LOG=/var/log/puppet.log

cd $BASE_DIR/
/usr/bin/puppet apply -l $PUPPET_LOG --modulepath=$MODULE_PATH manifests/site.pp
