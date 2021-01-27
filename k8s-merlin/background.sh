#!/bin/bash
#HOST_IP=`ip addr show ens3  | awk '$1 == "inet" { print $2 }' | cut -d/ -f1`
#sed 's/    Interface: "127.0.0.1"/    Interface: '"$HOST_IP"'/g' config.yaml
#HOST_IP=`kubectl get nodes -o jsonpath='{ $.items[?(@.metadata.name=="controlplane")].status.addresses[?(@.type=="InternalIP")].address }'` && sed 's/    Interface: "127.0.0.1"/    Interface: '"$HOST_IP"'/g' config.yaml`{{execute}}
#Run the file `./merlinServer-Linux-x64