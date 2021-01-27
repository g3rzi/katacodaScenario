#!/bin/bash
hostIP=`kubectl get nodes -o jsonpath='{ $.items[?(@.metadata.name=="controlplane")].status.addresses[?(@.type=="InternalIP")].address }'` && sed 's/    Interface: "127.0.0.1"/    Interface: '"$hostIP"'/g' config.yaml`{{execute}}
Run the file `./merlinServer-Linux-x64