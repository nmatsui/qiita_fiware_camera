#!/bin/bash
source $(cd $(dirname $0);pwd)/../variables/env
CWD=$(cd $(dirname $0);pwd)

## start mongodb
helm repo add azure-marketplace https://marketplace.azurecr.io/helm/v1/repo
helm repo update
helm install azure-marketplace/mongodb --name-template mongodb -f ${CWD}/yaml/mongodb-values.yaml
