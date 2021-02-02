#!/bin/bash

touch /root/aaaaaaaaa

HOST=`hostname`
if [ "$HOST" == "controlplane" ]; then
	  echo "This is the Host"
	  wget https://github.com/g3rzi/katacodaScenario/releases/download/0.1/merlinServerAndData.tar
	  mkdir /root/merlin
	  tar -xf merlinServerAndData.tar --directory /root/merlin
	  cd merlin
	  cat <<EOT >> config.yaml
AutoStart: true
Listeners:
  - Name: "Default"
    Protocol: "http2"
    Interface: "127.0.0.1"
    Port: "443"
EOT
	  export HOST_IP=`ip addr show ens3  | awk '$1 == "inet" { print $2 }' | cut -d/ -f1`
      sed -i 's/    Interface: "127.0.0.1"/    Interface: '"$HOST_IP"'/g' config.yaml
	  echo "HOST_IP=$HOST_IP" >> /etc/environment
	  source /etc/environment
     ./launch.sh
	 
	else
       mkdir var/lib/kubelet/
cat <<EOT >> /lib/kubelet/config.yaml
apiVersion: kubelet.config.k8s.io/v1beta1
authentication:
  anonymous:
    enabled: true
  webhook:
    cacheTTL: 0s
    enabled: true
  x509:
    clientCAFile: /etc/kubernetes/pki/ca.crt
authorization:
  mode: AlwaysAllow
  webhook:
    cacheAuthorizedTTL: 0s
    cacheUnauthorizedTTL: 0s
clusterDNS:
- 10.96.0.10
clusterDomain: cluster.local
cpuManagerReconcilePeriod: 0s
evictionPressureTransitionPeriod: 0s
fileCheckFrequency: 0s
healthzBindAddress: 127.0.0.1
healthzPort: 10248
httpCheckFrequency: 0s
imageMinimumGCAge: 0s
kind: KubeletConfiguration
nodeStatusReportFrequency: 0s
nodeStatusUpdateFrequency: 0s
rotateCertificates: true
runtimeRequestTimeout: 0s
staticPodPath: /etc/kubernetes/manifests
streamingConnectionIdleTimeout: 0s
syncFrequency: 0s
volumeStatsAggPeriod: 0s
EOT
      wget https://github.com/g3rzi/katacodaScenario/releases/download/0.1/merlinAgent-Linux-x64
	  chmod +x merlinAgent-Linux-x64
	  sed -i 's/    enabled: false/    enabled: true/g' /var/lib/kubelet/config.yaml
      sed -i 's/  mode: Webhook/  mode: AlwaysAllow/g' /var/lib/kubelet/config.yaml
	  service kubelet restart
      echo "This is the Worker"
fi

#clear


