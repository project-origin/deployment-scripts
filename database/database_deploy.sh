#!/bin/bash
 
kubectl apply -f database_deployment.yml
echo "Waiting for Postgres to start..."
sleep 15

declare -a SERVICES=("EXAMPLE_APP" "ACCOUNT_SERVICE" "DATAHUB_SERVICE" "HYDRA" "IDENTITY_SERVICE")

for SERVICE_NAME in "${SERVICES[@]}"
do
   echo "$SERVICE_NAME"

   USERNAME="${SERVICE_NAME}_USER"
   DB_NAME="${SERVICE_NAME}_DB"
   PASSWORD=$(cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 10 | head -n 1)

   kubectl exec -it $(kubectl get pods | grep postgres | cut -d' ' -f1) -- psql -U sa \
    --command "CREATE USER ${USERNAME,,} WITH PASSWORD '${PASSWORD}';" \
    --command "CREATE DATABASE ${DB_NAME,,} OWNER ${USERNAME,,};"

    SECRET_NAME=`echo "${SERVICE_NAME,,}" | sed -r 's/_/-/g'`

    kubectl create secret generic "${SECRET_NAME}-db-secret" \
        --from-literal=database="${DB_NAME,,}" \
        --from-literal=username="${USERNAME,,}" \
        --from-literal=password="${PASSWORD}" \
        --from-literal=connection-string="postgres://${USERNAME,,}:${PASSWORD}@postgres:5432/${DB_NAME,,}?sslmode=disable"
        
done
