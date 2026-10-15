from pathlib import Path
import cv2
import time

cap = cv2.VideoCapture(0)
if not cap.isOpened():
    raise RuntimeError("Could not open camera")

ok, frame = cap.read()
cap.release()
if not ok:
    raise RuntimeError("Could not read a frame from camera")

output_dir = Path.home() / "robotEnv" / "bin"
output_dir.mkdir(parents=True, exist_ok=True)

timestamp = time.strftime("%Y-%m-%d_%H-%M-%S")
output_file = output_dir / f"test_{timestamp}.jpg"

if not cv2.imwrite(str(output_file), frame):
    raise RuntimeError(f"Could not save image to {output_file}")

print(f"Saved image to {output_file}")