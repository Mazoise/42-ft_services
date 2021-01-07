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
	$RED Error : Minikube needs at least 2 CPUs to run properly. You only have $CPU_COUNT available.
		Please reload your VM with more CPU. $NO_COLOR
	"
		exit
	fi
	DOCKER_RIGHT=$(id -nG $USER | grep docker)
	if [ "$DOCKER_RIGHT" == "" ] ; then
		>&2 echo -e "
	$RED Error : Docker does not have the rights for $USER, please enter your password to accept this change. $NO_COLOR
	"
		sudo usermod -aG docker $USER
		>&2 echo -e "
	$RED You must now logout and back in for it to take effect. $NO_COLOR
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
