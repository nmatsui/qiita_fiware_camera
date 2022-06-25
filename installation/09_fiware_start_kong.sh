#!/bin/bash
source $(cd $(dirname $0);pwd)/../variables/env
CWD=$(cd $(dirname $0);pwd)

## start kong
kubectl create -f https://bit.ly/k4k8s
kubectl -n kong scale deployments.v1.apps/ingress-kong --replicas=3

