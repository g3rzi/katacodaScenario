This is a Kubernetes environment with Master ("controlplane") and Worker ("node01").
Start the cluster by running `launch.sh`{{execute}}.  

Make sure both of them are ready with `kubectl get nodes`{{execute}}.  
If they are not, wait couple of seconds and try again.   


`Open`{{execute T3}} new terminal and start a computer with the following information: 
```
kubectl apply -f - <<EOF
apiVersion: v1
kind: Pod
metadata:
  name: nginx
spec:
  containers:
  - name: nginx
    image: nginx
EOF```{{execute T2}}  
