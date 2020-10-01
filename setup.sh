#!/bin/bash

GREEN="\033[0;32m"
RED="\033[0;31m"
NO_COLOR="\033[0m"

if [ "$1" != "-p" ] ; then

	echo "--------------------------------------------------------"
	echo "--------------------- CLEAN UP -------------------------"
	echo "--------------------------------------------------------"

	# rm -rf srcs/SSL
	pkill -f dashboard
	minikube delete

	echo "--------------------------------------------------------"
	echo "----------------- STARTING MINIKUBE --------------------"
	echo "--------------------------------------------------------"

	CPU_COUNT=$(cat /proc/cpuinfo | grep "cpu cores" | tail -n1 | rev | cut -d" " -f1 | rev)
	if [ $CPU_COUNT -lt 2 ] ; then
		>&2 echo -e "
	$RED Minikube needs at least 2 CPUs to run properly. You only have $CPU_COUNT available.
		Please reload your VM with more CPU. $NO_COLOR
	"
		exit
	fi

	minikube start --vm-driver=docker #
	minikube dashboard &
fi
eval $(minikube docker-env) #utiliser le docker de minikube
# sudo usermod -aG docker user42 ## CHECK IF DOCKER WORKS BEFORE

echo "--------------------------------------------------------"
echo "-------------- BUILDING DOCKER IMAGES ------------------"
echo "--------------------------------------------------------"

docker build -t nginx srcs/nginx

echo "--------------------------------------------------------"
echo "---------------- CREATING CONTAINERS -------------------"
echo "--------------------------------------------------------"

kubectl apply -f https://raw.githubusercontent.com/metallb/metallb/v0.9.3/manifests/namespace.yaml
kubectl apply -f https://raw.githubusercontent.com/metallb/metallb/v0.9.3/manifests/metallb.yaml
kubectl apply -f srcs/metallb
kubectl apply -f srcs/nginx

# kubectl apply -f srcs/MySQL
