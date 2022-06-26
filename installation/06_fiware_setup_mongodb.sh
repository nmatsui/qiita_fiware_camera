#!/bin/bash
source $(cd $(dirname $0);pwd)/../variables/env

# setup replicaset
kubectl run mongodb-client --rm --tty -i --restart='Never' --image marketplace.azurecr.io/bitnami/mongodb:4.4.15-debian-10-r2 --command -- \
  mongosh admin --host 'mongodb-0.mongodb-headless.default.svc.cluster.local:27017,mongodb-1.mongodb-headless.default.svc.cluster.local:27017,mongodb-2.mongodb-headless.default.svc.cluster.local:27017' \
  --eval 'rs.add("mongodb-1.mongodb-headless.default.svc.cluster.local:27017")'
sleep 10
kubectl run mongodb-client --rm --tty -i --restart='Never' --image marketplace.azurecr.io/bitnami/mongodb:4.4.15-debian-10-r2 --command -- \
  mongosh admin --host 'mongodb-0.mongodb-headless.default.svc.cluster.local:27017,mongodb-1.mongodb-headless.default.svc.cluster.local:27017,mongodb-2.mongodb-headless.default.svc.cluster.local:27017' \
  --eval 'rs.add("mongodb-2.mongodb-headless.default.svc.cluster.local:27017")'
sleep 5
# show replicaset status
kubectl run mongodb-client --rm --tty -i --restart='Never' --image marketplace.azurecr.io/bitnami/mongodb:4.4.15-debian-10-r2 --command -- \
  mongosh admin --host 'mongodb-0.mongodb-headless.default.svc.cluster.local:27017,mongodb-1.mongodb-headless.default.svc.cluster.local:27017,mongodb-2.mongodb-headless.default.svc.cluster.local:27017' \
  --eval 'rs.status().members.map(function(e) {return {name: e.name, stateStr:e.stateStr};})'

