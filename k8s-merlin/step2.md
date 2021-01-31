Here we will see the basic settings of Kubessss.

## Basics of Kubessss

#### Server

	
The server is located in the `controlplane` with a configuration file `config.yaml`.    
The server uses this file to create a listener to a given protocol, interface and port.   
The server IP that should be inside the Interface is `kubectl get nodes -o jsonpath='{ $.items[?(@.metadata.name=="controlplane")].status.addresses[?(@.type=="InternalIP")].address }{"\n"}'`{{execute}}.  

Verify that the `config.yaml` file contains the server IP address: `cat config.yaml`{{execute}}

Start the server `./server`{{execute}}.    
To view the menu, run `help`{{execute}} and to see the list of modules run `use module <TAB>`.  
*You can use the `TAB` in any place to see the list commands.  

Let's continue and see examples.  

Start this vulnerable container `kubectl run priv-container --image=alpine --overrides='{"spec": {"template": {"spec": {"containers": [{"name": "priv-container", "image": "alpine", "command": ["sh", "-c", "sleep infinity"], "securityContext": {"privileged": true} }]}}}}' -- sh -c 'sleep infinity'`{{execute}}


