rm -rf srcs/SSL
echo "--------------------------------------------------------"
echo "----------------- STARTING MINIKUBE --------------------"
echo "--------------------------------------------------------"

minikube start --cpus=4 --memory 4000 --disk-size 11000 --vm-driver virtualbox --extra-config=apiserver.service-node-port-range=1-35000
minikube addons enable ingress
eval $(minikube docker-env)

echo "--------------------------------------------------------"
echo "---------------- CREATING CONTAINERS -------------------"
echo "--------------------------------------------------------"

kubectl apply -f srcs/Nginx
kubectl apply -f srcs/Ingress-controller
kubectl apply -f srcs/MySQL


