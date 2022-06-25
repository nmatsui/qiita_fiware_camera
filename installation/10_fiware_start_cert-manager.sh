#!/bin/bash
source $(cd $(dirname $0);pwd)/../variables/env
CWD=$(cd $(dirname $0);pwd)

# start cert-manager
kubectl apply -f https://github.com/cert-manager/cert-manager/releases/download/v1.8.2/cert-manager.yaml

# get external ip
EXTERNAL_IP=$(kubectl get -o jsonpath="{.status.loadBalancer.ingress[0].ip}" service -n kong kong-proxy)

# set dns a record
az network dns record-set a add-record --resource-group ${DNS_ZONE_RG} --zone-name "${DOMAIN}" --record-set-name "${HOST}" --ipv4-address "${EXTERNAL_IP}"
sleep 10

# request TLS certificate
EMAIL=${EMAIL} envsubst < ${CWD}/yaml/certmanager-clusterissure.yaml | kubectl apply -f -
