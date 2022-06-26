import os

from azure.storage.blob import BlobServiceClient


class BlobStorage:
    def __init__(self):
        connect_str = os.getenv("AZURE_STORAGE_CONNECTION_STRING")
        self.container_name = os.getenv("STORAGE_CONTAINER")
        self.blob_service_client = BlobServiceClient.from_connection_string(connect_str)

    def upload_photo(self, image_io, filename):
        blob_client = self.blob_service_client.get_blob_client(container=self.container_name, blob=filename)
        blob_client.upload_blob(image_io)
