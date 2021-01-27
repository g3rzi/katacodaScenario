#!/bin/bash

touch /root/aaaaaaaaa
echo 

cat <<EOT >> config.yaml

AutoStart: true
Listeners:
  - Name: "Default"
    Protocol: "http2"
    Interface: "127.0.0.1"
    Port: "443"
	
EOT


HOST=`hostname`
if [ "$HOST" == "controlplane" ]; then
	  touch /root/thisisthehost
	  #wget https://github.com/g3rzi/katacodaScenario/releases/download/0.1/merlinServerAndData.tar
	  mkdir /root/merlin
	  #tar -xf merlinServerAndData.tar --directory /root/merlin
	  cd merlin
	  export HOST_IP=`ip addr show ens3  | awk '$1 == "inet" { print $2 }' | cut -d/ -f1`
      sed -i 's/    Interface: "127.0.0.1"/    Interface: '"$HOST_IP"'/g' config.yaml

	else
      #wget https://github.com/g3rzi/katacodaScenario/releases/download/0.1/merlinAgent-Linux-x64
	    
fi

clear