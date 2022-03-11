#!/bin/sh

 errorExit() {
     echo "*** $*" 1>&2
     exit 1
 }

 curl --silent --max-time 2 --insecure https://localhost:8443/ -o /dev/null || errorExit "Error GET https://localhost:8443/"
 if ip addr | grep -q {{ LEO_CLUSTER_K8S_API_SERVER_ADVERTISE_ADDRESS }}; then
     curl --silent --max-time 2 --insecure https://{{ LEO_CLUSTER_K8S_API_SERVER_ADVERTISE_ADDRESS }}:8443/ -o /dev/null || errorExit "Error GET https://{{ LEO_CLUSTER_K8S_API_SERVER_ADVERTISE_ADDRESS }}:8443/"
 fi
