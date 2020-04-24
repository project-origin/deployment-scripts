#!/bin/bash

kubectl delete -f database_deployment.yml

declare -a SERVICES=("EXAMPLE_APP" "ACCOUNT_SERVICE" "DATAHUB_SERVICE" "HYDRA" "IDENTITY_SERVICE")

for SERVICE_NAME in "${SERVICES[@]}"
do
    SECRET_NAME=`echo "${SERVICE_NAME,,}" | sed -r 's/_/-/g'`
    kubectl delete secret "${SECRET_NAME}-db-secret"
done
