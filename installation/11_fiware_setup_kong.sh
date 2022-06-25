#!/bin/bash
source $(cd $(dirname $0);pwd)/../variables/env
CWD=$(cd $(dirname $0);pwd)

## setup kong
kubectl apply -f ${CWD}/yaml/kong-ingress.yaml
kubectl create secret generic kong-keyauth --from-literal=kongCredType=key-auth --from-literal=key=${API_TOKEN}
kubectl apply -f ${CWD}/yaml/kong-consumers.yaml
kubectl apply -f ${CWD}/yaml/kong-plugins.yaml
HOST=${HOST} DOMAIN=${DOMAIN} envsubst < ${CWD}/yaml/orion-ingress.yaml | kubectl apply -f -
