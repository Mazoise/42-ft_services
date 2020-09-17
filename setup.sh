rm -rf srcs/SSL
echo "--------------------------------------------------------"
echo "----------------- STARTING MINIKUBE --------------------"
echo "--------------------------------------------------------"

# minikube start --vm-driver docker #
# eval $(minikube docker-env) #utiliser le docker de minikube
#sudo usermod -aG docker user42 ## CHECK IF DOCKER WORKS BEFORE

echo "--------------------------------------------------------"
echo "-------------- BUILDING DOCKER IMAGES ------------------"
echo "--------------------------------------------------------"

docker build -t nginx srcs/nginx
docker run -itd -p 8080:80 --name nginx nginx

echo "--------------------------------------------------------"
echo "---------------- CREATING CONTAINERS -------------------"
echo "--------------------------------------------------------"

# kubectl apply -f srcs/Nginx
# kubectl apply -f srcs/MySQL
