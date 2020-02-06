minikube start --cpus=4 --memory 4000 --disk-size 11000 --vm-driver virtualbox --extra-config=apiserver.service-node-port-range=1-35000
# minikube dashboard
kubectl apply -f srcs/nginx-deployment.yaml
kubectl apply -f srcs/nginx-service.yaml
kubectl apply -f srcs/ingress.yaml
kubectl get ingress test-ingress
eval $(minikube docker-env)
