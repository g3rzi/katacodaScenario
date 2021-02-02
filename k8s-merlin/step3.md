#### Scenario 1  


`use module linux/go/cluster`{{execute}}

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