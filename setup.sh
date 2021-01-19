#!/bin/bash

GREEN="\033[0;32m"
RED="\033[0;31m"
NO_COLOR="\033[0m"

unexpected_error() {
	>&2 echo -e "
	$RED Error : UNEXPECTED ERROR from $1, error code $2 $NO_COLOR
	"
		exit
}

if [ "$1" != "-p" ] ; then

	echo "--------------------------------------------------------"
	echo "-------------------- CLEANING UP -----------------------"
	echo "--------------------------------------------------------"

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
	minikube start --vm-driver=docker || unexpected_error "minikube launcher" $?
	minikube dashboard &
fi
eval $(minikube docker-env) #utiliser le docker de minikube

echo "--------------------------------------------------------"
echo "-------------- BUILDING DOCKER IMAGES ------------------"
echo "--------------------------------------------------------"

docker build -t nginx srcs/nginx || unexpected_error "nginx in docker" $?
docker build -t mysql srcs/mysql || unexpected_error "mysql in docker" $?
docker build -t phpmyadmin srcs/phpmyadmin || unexpected_error "phpmyadmin in docker" $?
docker build -t wordpress srcs/wordpress || unexpected_error "wordpress in docker" $?

echo "--------------------------------------------------------"
echo "---------------- CREATING CONTAINERS -------------------"
echo "--------------------------------------------------------"

kubectl apply -f srcs/metallb/namespace.yaml || unexpected_error "metallb in kubernetes" $?
kubectl apply -f srcs/metallb/metallb.yaml || unexpected_error "metallb in kubernetes" $?
kubectl apply -f srcs/metallb/conf.yaml || unexpected_error "metallb in kubernetes" $?
kubectl apply -f srcs/nginx || unexpected_error "nginx in kubernetes" $?
kubectl apply -f srcs/mysql || unexpected_error "mysql in kubernetes" $?
kubectl apply -f srcs/phpmyadmin || unexpected_error "phpmyadmin in kubernetes" $?
kubectl apply -f srcs/wordpress || unexpected_error "wordpress in kubernetes" $?
