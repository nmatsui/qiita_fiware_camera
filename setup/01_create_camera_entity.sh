#!/bin/bash
source $(cd $(dirname $0);pwd)/../variables/env

## create entity
curl -i https://${HOST}.${DOMAIN}/v2/entities/ \
     -H "Content-Type: application/json" \
     -H "Authorization: ${API_TOKEN}" \
     -H "Fiware-Service: ${FIWARE_SERVICE}" \
     -X POST -d @- <<__EOS__
{
  "id": "camera1",
  "type": "camera",
  "created_at": {
    "value": "$(date '+%Y-%m-%dT%H:%M:%S%z')",
    "type": "ISO8601"
  },
  "location": {
    "value": {
      "type": "Point",
      "coordinates": [0.0, 0.0]
    },
    "type": "geo:json"
  },
  "path": {
    "value": "/",
    "type": "string"
  }
}
__EOS__


