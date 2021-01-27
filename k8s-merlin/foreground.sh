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
	else
      #wget https://github.com/g3rzi/katacodaScenario/releases/download/0.1/merlinAgent-Linux-x64
	    
fi
