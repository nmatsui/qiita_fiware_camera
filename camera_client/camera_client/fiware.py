import copy
import os

import requests


class Fiware:
    PAYLOAD = {
        "created_at": {
            "type": "ISO8601",
            "value": "",
        },
        "location": {
            "type": "geo:json",
            "value": {
                "type": "Point",
                "coordinates": [],
            },
        },
        "path": {"type": "string", "value": ""},
    }

    def __init__(self):
        self.container_name = os.getenv("STORAGE_CONTAINER")
        self.headers = {
            "Content-Type": "application/json",
            "Authorization": os.getenv("API_TOKEN"),
            "Fiware-Service": os.getenv("FIWARE_SERVICE"),
        }
        self.url = f"https://{os.getenv('HOST')}.{os.getenv('DOMAIN')}/v2/entities/{os.getenv('ENTITY_ID')}/attrs"

    def update_entity(self, t, location, filename):
        payload = copy.deepcopy(Fiware.PAYLOAD)
        payload["created_at"]["value"] = t.isoformat(timespec="milliseconds")
        payload["location"]["value"]["coordinates"] = [location["longitude"], location["latitude"]]
        payload["path"]["value"] = os.path.join(self.container_name, filename)

        ret = requests.patch(self.url, headers=self.headers, json=payload)
        if ret.status_code not in (200, 201, 204):
            raise Exception(f"patch status error: {ret.status_code}, {ret.text}")
