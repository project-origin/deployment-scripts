
# How to setup

This is a small quick guide on how to run the entire platform on ones own setup, 

This guide is still work in progress.


## Prerequisites

### Azure storage

The energy-type-service requires a Azure Storage account, which should contain a list of files.
First step is to create the Storage account:

	https://docs.microsoft.com/en-us/azure/storage/common/storage-account-create?tabs=azure-portal

### PersistentVolumeClaims

In the current configuration, the Kubernetes cluster must support PersistentVolumeClaims.


## Kubernetes namespace

Next step is to create a namespace in ones kubernetes cluster
    
    kubectl create namespace dev-project-origin

## Helm 

Note: these lines assumes one is located in a folder containing all the different sub projects in the platform.

Helm is used to install the entire platform, there is one base script that enables the core to be created.

    helm install -n dev-project-origin base-setup deployment-scripts/chart

If one wants to override some of the default values, a value file can be passed along with the helm install

    helm install -n dev-project-origin base-setup deployment-scripts/chart --values deployment-scripts/example.values.yaml

Next all the individual services can be installed:

    helm install -n dev-project-origin account-service account-service/chart --set tag=v1.0.176-ge6df23f
    helm install -n dev-project-origin datahub-service datahub-service/chart --set tag=v1.0.148-gd762eb7
    helm install -n dev-project-origin energy-type-service energy-type-service/chart --set tag=v1.0.52-g7406400
    helm install -n dev-project-origin example-backend example-backend/chart --set tag=v1.0.135-g14b359e
    helm install -n dev-project-origin example-frontend example-frontend/chart --set tag=v1.0.77-g1fcc1ba
    helm install -n dev-project-origin identity-service identity-service/chart --set tag=v1.0.53-g9eb348b
    helm install -n dev-project-origin ledger-tp datahub_processor/chart --set tag=v1.0.105-gfa73356
