#!/bin/bash
source $(cd $(dirname $0);pwd)/../variables/env

## show connection string
az storage account show-connection-string --resource-group ${RESOURCE_GROUP} --name ${STORAGE_ACCOUNT} -o tsv

