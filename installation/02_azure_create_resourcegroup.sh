#!/bin/bash
source $(cd $(dirname $0);pwd)/../variables/env

## create resource group
az group create --name ${RESOURCE_GROUP} --location ${LOCATION}
