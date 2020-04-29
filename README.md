# deployment-scripts
This contains yml for deployment and debug.


cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 32 | head -n 1

# To delete namespace

    sudo kubectl delete -f deployment-scripts/namespace.yml

# to create new setup
## create minikube

    sudo minikube start --driver=none
    sudo minikube addons enable ingress

## create setup

    sudo kubectl apply -f deployment-scripts/dns.yml
    sudo kubectl apply -f deployment-scripts/namespace.yml
    sudo kubectl apply -f deployment-scripts/secret.yml
    sudo kubectl apply -f deployment-scripts/database_deployment.yml
    sudo kubectl apply -f deployment-scripts/jobs.yml

    sudo kubectl apply -f identity-service/deployment.yml

    sudo kubectl apply -f deployment-scripts/redis/redis_deployment.yml
    sudo kubectl apply -f energy-type-service/deployment.yml
    sudo kubectl apply -f datahub_processor/deployment_dev.yml
    sudo kubectl apply -f datahub-service/deployment.yml
    sudo kubectl apply -f account-service/deployment.yml
    sudo kubectl apply -f example-backend/deployment.yml
    sudo kubectl apply -f example-frontend/deployment.yml


 //sleep 30 
    //sudo deployment-scripts/create_clients.sh


## Get status

sudo kubectl get pods -n project-origin


## Crazy stuff

sudo kubectl delete -f deployment-scripts/namespace.yml

sudo kubectl apply -f deployment-scripts/namespace.yml
sudo kubectl apply -f deployment-scripts/secret.yml

sudo kubectl apply -f deployment-scripts/database_deployment.yml


sudo kubectl apply -f deployment-scripts/jobs.yml



sudo deployment-scripts/database/database_deploy.sh
sudo kubectl apply -f deployment-scripts/secret.yml
sudo kubectl apply -f identity-service/deployment.yml

sudo kubectl apply -f deployment-scripts/jobs.yml