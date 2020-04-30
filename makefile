
status:
	sudo kubectl get pods -n project-origin
	sudo kubectl get jobs -n project-origin

pods:
	sudo kubectl get pods -n project-origin

jobs:
	sudo kubectl get jobs -n project-origin

install-all:
	sudo helm install --debug test ./pochart --namespace=project-origin --create-namespace > out.txt
	sudo kubectl apply -f identity-service/deployment.yml
	sudo kubectl apply -f example-frontend/deployment.yml
	sudo kubectl apply -f example-backend/deployment.yml
	sudo kubectl apply -f energy-type-service/deployment.yml
	sudo kubectl apply -f datahub-service/deployment.yml
	sudo kubectl apply -f account-service/deployment.yml
	sudo kubectl apply -f datahub_processor/deployment_dev.yml

install:
	sudo helm install --debug test ./pochart --namespace=project-origin --create-namespace > out.txt

install-services:
	sudo kubectl apply -f identity-service/deployment.yml
	sudo kubectl apply -f example-frontend/deployment.yml
	sudo kubectl apply -f example-backend/deployment.yml
	sudo kubectl apply -f energy-type-service/deployment.yml
	sudo kubectl apply -f datahub-service/deployment.yml
	sudo kubectl apply -f account-service/deployment.yml
	sudo kubectl apply -f datahub_processor/deployment_dev.yml

delete:
	sudo helm delete --debug test --namespace=project-origin > out.txt
	sudo kubectl delete namespace project-origin

setup-cert:
	sudo helm repo add jetstack https://charts.jetstack.io
	sudo kubectl create namespace cert-manager
	sudo kubectl apply --validate=false -f https://github.com/jetstack/cert-manager/releases/download/v0.14.1/cert-manager.crds.yaml
	sudo kubectl apply -f letsencrypt-prod.yaml
	sudo helm install cert-manager --namespace cert-manager jetstack/cert-manager --version v0.14.1