#!/bin/bash
source $(cd $(dirname $0);pwd)/../variables/env

## subscribe entity
curl -i https://${HOST}.${DOMAIN}/v2/subscriptions/ \
     -H "Content-Type: application/json" \
     -H "Authorization: ${API_TOKEN}" \
     -H "Fiware-Service: ${FIWARE_SERVICE}" \
     -X POST -d @- <<__EOS__
{
  "subject": {
    "entities": [
      { "idPattern": ".*", "type": "camera" }
    ],
    "condition": {
      "attrs": [ "created_at", "location", "path" ]
    }
  },
  "notification": {
    "http": {
      "url": "http://cygnus:5051/notify"
    },
    "attrs": [ "created_at", "location", "path" ]
  }
}
__EOS__
