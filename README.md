
# How to setup

This is a small quick guide on how to run the entire platform on ones own setup, 

This guide is still work in progress.

## DNS

localhost.eloprindelse.dk and *.localhost.eloprindelse.dk routes to 127.0.0.1 and should help 
local development.


## Prerequisites

### Ingress

The platform requires an ingress controller to be configures.

The platform has been testet and works with nginx ingress controller.

A guide on how to install it can be found here https://kubernetes.github.io/ingress-nginx/deploy/



## Kubernetes namespace

Next step is to create a namespace in ones kubernetes cluster
    
    kubectl create namespace {your-namespace}

## Helm 

The platform is most easily install with the help of helm. 
This repository contains an example.values.yaml file, which configures the system as a demo system,
it bootstraps the entire system

    helm install -n {your-namespace} project-origin deployment-scripts/chart --values deployment-scripts/example.values.yaml

To see when the system is ready, use the following command:

    kubectl get pods -n {your-namespace}

It can take a couple of minutes for the entire system to stabilize (all containers either being Running or Completed) 

