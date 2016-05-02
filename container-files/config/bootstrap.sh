#!/bin/sh

set -e

# User params
# ETCD_TARGET_HOST
if [ -z "$ETCD_TARGET_HOST" ]; then
	RUN_ETCD_HOST="127.0.0.1" 
else
	RUN_ETCD_HOST=${ETCD_TARGET_HOST}
fi

# ETCD_TARGET_PORT
if [ -z "$ETCD_TARGET_PORT" ]; then
	RUN_ETCD_PORT="4001" 
else
	RUN_ETCD_PORT=${ETCD_TARGET_PORT}
fi

# REGISTRATOR_PATH
if [ -z "$REGISTRATOR_PATH" ]; then
	RUN_REGISTRATOR_PATH="/registrator" 
else
	RUN_REGISTRATOR_PATH=${REGISTRATOR_PATH}
fi

# GLUEOPS_CONFIG
if [ -z "$GLUEOPS_CONFIG" ]; then
	RUN_GLUEOPS_CONFIG="/glueOps" 
else
	RUN_GLUEOPS_CONFIG=${GLUEOPS_CONFIG}
fi


# Test for Interactiveness
if test -t 0; then

  if [[ $@ ]]; then 
    eval $@
  else 
    export PS1='[\u@\h : \w]\$ '
    /bin/sh
  fi

else
  if [[ $@ ]]; then 
    eval $@
  fi
  /usr/local/bin/etcdctl --endpoints http://${RUN_ETCD_HOST}:${RUN_ETCD_PORT} exec-watch --recursive ${RUN_REGISTRATOR_PATH} -- sh -c "/usr/local/etcd-glueops/glueops.rb -H ${RUN_ETCD_HOST} -p ${RUN_ETCD_PORT} -c ${RUN_GLUEOPS_CONFIG}"
fi
