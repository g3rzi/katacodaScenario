#!/bin/bash

touch /root/aaaaaaaaa
HOST=`hostname`
if [ "$HOST" == "controlplane" ]; then
	touch /root/thisisthehost
fi
#wget https://github.com/g3rzi/katacodaScenario/releases/download/0.1/merlin.tar
#tar -xf merlin.tar
#cd merlin