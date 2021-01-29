#!/bin/bash

GREEN="\033[0;32m"
RED="\033[0;31m"
BOLD_CYAN="\033[1;96m"
BOLD_YELLOW="\033[1;93m"
NO_COLOR="\033[0m"

TITLE_COLOR=$BOLD_YELLOW

print_title() {
	echo -e $TITLE_COLOR
	DECORATION_LINE="========================================================"
	DECORATION_LEN=${#DECORATION_LINE}
	TITLE_LEN=1
	for word in $@
		do let "TITLE_LEN += ${#word} + 1"
	done
	let "TITLE_LEN += 1"
	TMP_LEN=$(($DECORATION_LEN - $TITLE_LEN))
	LENGTH_BEG=$(($TMP_LEN / 2))
	START_END=$(($LENGTH_BEG + $TITLE_LEN))
	END_DECORATION=$(echo $DECORATION_LINE | cut -c$START_END-)
	echo
	echo "$DECORATION_LINE"
	printf "%.*s %s %s\n" $LENGTH_BEG $DECORATION_LINE "${*^^}" $END_DECORATION
	echo $DECORATION_LINE
	echo -e $NO_COLOR
}

run_service() {
	print_title $1
	docker build -t $1 srcs/$1 || unexpected_error "$1 in docker" $?
	kubectl apply -f srcs/$1 || unexpected_error "$1 in kubernetes" $?
}

unexpected_error() {
	>&2 echo -e "
	$RED Error : UNEXPECTED ERROR from $1, error code $2 $NO_COLOR
	"
		exit
}

prerequirement_check() {
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
}

if [ "$1" != "-p" ] ; then

	print_title "CLEANING UP"

	pkill -f dashboard
	minikube delete

	print_title "STARTING MINIKUBE"
	prerequirement_check
	minikube start --vm-driver=docker || unexpected_error "minikube launcher" $?
	minikube dashboard &
fi
eval $(minikube docker-env)

print_title "METALLB"

kubectl apply -f srcs/metallb/metallb-install.yaml || unexpected_error "metallb in kubernetes" $?
kubectl apply -f srcs/metallb/conf.yaml || unexpected_error "metallb in kubernetes" $?

services="nginx mysql influxdb phpmyadmin wordpress ftps grafana"
for service in $services
	do run_service $service
done
