#!/bin/bash
source $(cd $(dirname $0);pwd)/../variables/env

## login azure
az login --tenant ${TENANT}
