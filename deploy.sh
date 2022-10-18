#!/usr/bin/env bash

traefik_status=$(helm status traefik)
echo $traefik_status | grep 'STATUS: deployed' > /dev/null
if [[ $? -ne 0 ]]; then
    echo "traefik helm chart not installed, installing..."
    helm repo add traefik https://helm.traefik.io/traefik && \
    helm repo update && \
    helm install traefik traefik/traefik
    if [[ $? -ne 0 ]]; then
        echo "traefik helm chart install failed, exiting"
        exit 1
    fi
    echo "traefik helm chart installed"
fi

echo "traefik is deployed, starting services..."

kubectl apply -f ./
