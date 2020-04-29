

kubectl exec -it $(kubectl get pods -n "project-origin" | grep hydra-service-deployment | cut -d' ' -f1) -n project-origin -- \
    hydra clients delete \
        --endpoint https://localhost:4445 \
        --skip-tls-verify \
        example-app


kubectl exec -it $(kubectl get pods -n "project-origin" | grep hydra-service-deployment | cut -d' ' -f1) -n project-origin -- \
    hydra clients delete \
        --endpoint https://localhost:4445 \
        --skip-tls-verify \
        account-service 

kubectl delete secret "example-app-hydra-secret" -n "project-origin"     
kubectl delete secret generic "account-service-hydra-secret" -n "project-origin" 

