import cv2
from cv2 import VideoCapture

cap = VideoCapture('../data/video.mp4')
print(cap.get(cv2.CAP_PROP_FPS))
cap.set(cv2.CAP_PROP_FPS, 30)


while(cap.isOpened()):
    ret, frame = cap.read()

    gray = cv2.cvtColor(frame, cv2.COLOR_BGR2GRAY)
    gray = cv2.GaussianBlur(gray, (21, 21), 0)

    cv2.imshow('frame', gray)
    if cv2.waitKey(33) & 0xFF == ord('q'):
        break

cap.release()
cv2.destroyAllWindows()
