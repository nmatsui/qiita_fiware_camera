#!/usr/bin/env python

from datetime import datetime, timedelta, timezone

from camera_client.blob_storage import BlobStorage
from camera_client.camera import Camera
from camera_client.fiware import Fiware
from camera_client.gnss import Gnss

TZ = timezone(timedelta(hours=+9))
FMT = "jpg"


def main():
    print("start script")
    storage = BlobStorage()
    gnss = Gnss()
    fiware = Fiware()

    with Camera() as camera:
        t = datetime.now(TZ)
        filename = f"{t:%Y-%m-%dT%H_%M_%S.%f}.{FMT}"
        location = gnss.get_location()

        image_io = camera.take_photo(t, FMT)

        storage.upload_photo(image_io, filename)

        fiware.update_entity(t, location, filename)

    print("finish script")


if __name__ == "__main__":
    main()
