#!/bin/bash
source $(cd $(dirname $0);pwd)/../variables/env

## create storage account
az storage account create --resource-group ${RESOURCE_GROUP} --location ${LOCATION} --name ${STORAGE_ACCOUNT} --sku Standard_ZRS --encryption-services blob
sleep 10

## create a container
ACCOUNT_KEY=$(az storage account keys list --resource-group ${RESOURCE_GROUP} --account-name ${STORAGE_ACCOUNT} --query "[?keyName=='key1'].value" -o tsv)
az storage container create --account-name ${STORAGE_ACCOUNT} --name ${STORAGE_CONTAINER} --account-key ${ACCOUNT_KEY} --auth-mode key
