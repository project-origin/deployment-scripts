
status:
	sudo kubectl get pods -n project-origin
	sudo kubectl get jobs -n project-origin

pods:
	sudo kubectl get pods -n project-origin

jobs:
	sudo kubectl get jobs -n project-origin

build-dev-containers:
	docker build -t projectorigin/account-service:dev ../account-service
	docker build -t projectorigin/ledger_tp:dev ../datahub_processor
	docker build -t projectorigin/datahub-service:dev ../datahub-service
	docker build -t projectorigin/energy-type-service:dev ../energy-type-service
	docker build -t projectorigin/example-backend:dev ../example-backend
	docker build -t projectorigin/example-frontend:dev ../example-frontend
	docker build -t projectorigin/identity-service:dev ../identity-service

install:
	helm install --debug po ./pochart --namespace=project-origin --create-namespace --set domain=dev.eloprindelse.dk --set tls.issuer=letsencrypt-staging > out2.txt

	helm install --debug account-service ../account-service/chart --namespace=project-origin --set tag=dev >> out2.txt
	helm install identity-service ../identity-service/chart --namespace=project-origin --set tag=dev >> out2.txt
	helm install example-frontend ../example-frontend/chart --namespace=project-origin --set tag=dev >> out2.txt
	helm install example-backend ../example-backend/chart --namespace=project-origin --set tag=dev >> out2.txt
	helm install energy-type-service ../energy-type-service/chart --namespace=project-origin --set tag=dev >> out2.txt
	helm install datahub-service ../datahub-service/chart --namespace=project-origin --set tag=dev >> out2.txt
	helm install datahub-tp ../datahub_processor/chart --namespace=project-origin --set tag=dev >> out2.txt

install-services:
	sudo kubectl apply -f account-service/deployment.yml


	sudo kubectl apply -f ../identity-service/deployment.yml
	sudo kubectl apply -f ../example-frontend/deployment.yml
	sudo kubectl apply -f ../example-backend/deployment.yml
	sudo kubectl apply -f ../energy-type-service/deployment.yml
	sudo kubectl apply -f ../datahub-service/deployment.yml
	sudo kubectl apply -f ../datahub_processor/deployment_dev.yml

delete:
	sudo helm delete --debug test --namespace=project-origin > out.txt
	sudo kubectl delete namespace project-origin



setup-cert-staging:
	helm repo add jetstack https://charts.jetstack.io
	kubectl create namespace cert-manager
	kubectl apply --validate=false -f https://github.com/jetstack/cert-manager/releases/download/v0.14.1/cert-manager.crds.yaml
	kubectl apply -f letsencrypt-staging.yaml
	helm install cert-manager --namespace cert-manager jetstack/cert-manager --version v0.14.1

setup-cert-prod:

	# setup an ingress service
	helm repo add stable https://kubernetes-charts.storage.googleapis.com/
	helm install nginx stable/nginx-ingress \
		--namespace ingress-basic \
		--set controller.replicaCount=2 \
		--set controller.nodeSelector."beta\.kubernetes\.io/os"=linux \
		--set defaultBackend.nodeSelector."beta\.kubernetes\.io/os"=linux

	# setup certs.
	helm repo add jetstack https://charts.jetstack.io
	kubectl create namespace cert-manager
	kubectl apply --validate=false -f https://github.com/jetstack/cert-manager/releases/download/v0.14.1/cert-manager.crds.yaml
	kubectl apply -f letsencrypt-prod.yaml
	helm install cert-manager --namespace cert-manager jetstack/cert-manager --version v0.14.1