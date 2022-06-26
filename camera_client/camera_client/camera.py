import io

import cv2


class Camera:
    CAMERA_ID = 0
    FONT_POS = (0, 30)
    FONT_COLOR = (0, 255, 0)
    FONT_SCALE = 1.0
    FONT_THICKNESS = 2

    def __enter__(self):
        self.cap = cv2.VideoCapture(Camera.CAMERA_ID)
        if not self.cap.isOpened():
            raise Exception("camera open error")
        return self

    def __exit__(self, exc_type, exc_value, traceback):
        self.cap.release()

    def take_photo(self, t, fmt):
        timestamp = t.isoformat(timespec="milliseconds")
        ret, frame = self.cap.read()
        if not ret:
            raise Exception("camera capture error")

        cv2.putText(
            frame,
            text=timestamp,
            org=Camera.FONT_POS,
            fontFace=cv2.FONT_HERSHEY_SIMPLEX,
            fontScale=Camera.FONT_SCALE,
            color=Camera.FONT_COLOR,
            thickness=Camera.FONT_THICKNESS,
            lineType=cv2.LINE_AA,
        )

        ret, buffer = cv2.imencode(f".{fmt}", frame)
        if not ret:
            raise Exception("frame encode error")
        return io.BytesIO(buffer)
