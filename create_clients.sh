


PASSWORD=$(cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 10 | head -n 1)
kubectl create secret generic "example-app-hydra-secret" -n "project-origin" \
    --from-literal=username=example-app \
    --from-literal=password="${PASSWORD}" 


kubectl exec -it $(kubectl get pods -n "project-origin" | grep hydra-service-deployment | cut -d' ' -f1) -n project-origin -- \
    hydra clients create \
        --endpoint http://localhost:4445 \
        --skip-tls-verify \
        --id example-app \
        --name 'Example Application' \
        --secret ${PASSWORD} \
        --grant-types authorization_code,refresh_token \
        --response-types token,code,id_token \
        --scope openid,offline,profile,email,meteringpoints.read,measurements.read,ggo.read,ggo.transfer,ggo.retire \
        --callbacks https://api.app.eloprindelse.dk/auth/login/callback

    
PASSWORD=$(cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 10 | head -n 1)
kubectl create secret generic "account-service-hydra-secret" -n "project-origin" \
    --from-literal=username=account-service \
    --from-literal=password="${PASSWORD}" 

kubectl exec -it $(kubectl get pods -n "project-origin" | grep hydra-service-deployment | cut -d' ' -f1) -n project-origin -- \
    hydra clients create \
        --endpoint http://localhost:4445 \
        --skip-tls-verify \
        --id account-service \
        --name 'Account Service' \
        --secret ${PASSWORD} \
        --grant-types authorization_code,refresh_token \
        --response-types token,code,id_token \
        --scope openid,offline,profile,email,meteringpoints.read,measurements.read,ggo.read,ggo.transfer,ggo.retire \
        --callbacks https://account.eloprindelse.dk/auth/login/callback


