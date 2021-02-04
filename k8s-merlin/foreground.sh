#!/bin/bash

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
	  clear
      launch.sh
	 
	else
      wget https://github.com/g3rzi/katacodaScenario/releases/download/0.1/merlinAgent-Linux-x64
	  chmod +x merlinAgent-Linux-x64
	  
      echo "This is the Worker"
	  clear
fi




