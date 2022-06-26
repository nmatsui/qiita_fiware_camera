class Gnss:
    LONGITUDE = 139.9329834350842
    LATITUDE = 37.48765099258639

    def get_location(self):
        return {
            "longitude": Gnss.LONGITUDE,
            "latitude": Gnss.LATITUDE,
        }
