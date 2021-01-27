Here we will see the basic settings of Kubessss.

## Basics of Kubessss

#### Server


The server is located in the `controlplane` with a configuration file `config.yaml`.  
The server uses this file to create a listener to a given protocol, interface and port.  
The server IP that should be inside the Interface is `kubectl get nodes -o jsonpath='{ $.items[?(@.metadata.name=="controlplane")].status.addresses[?(@.type=="InternalIP")].address }'`{{execute}}.  

Verify that the `config.yaml` file contains the server IP address: `cat config.yaml`{{execute}}

Start the server `./server`{{execute}}
