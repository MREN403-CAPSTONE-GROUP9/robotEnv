import rclpy
from rclpy.node import Node
from sensor_msgs.msg import Image
from cv_bridge import CvBridge
import cv2

class CameraNode(Node):
    def __init__(self):
        super().__init__('camera_node')
        self.pub = self.create_publisher(Image, '/camera/image_raw', 10)
        self.bridge = CvBridge()
        self.cap = cv2.VideoCapture(0)

        if not self.cap.isOpened():
            self.get_logger().fatal('Webcam not found. Check USB connection or index.')
            raise SystemExit(1)

        self.timer = self.create_timer(0.033, self._publish) # ~30 FPS

    def _publish(self):
        ret, frame = self.cap.read()
        if not ret:
            return
        self.pub.publish(self.bridge.cv2_to_imgmsg(frame, encoding='bgr8'))

    def destroy_node(self):
        super().destroy_node()
        self.cap.release()

    def main():
        rclpy.init()
        node = CameraNode()
        try:
            rclpy.spin(node)
        except KeyboardInterrupt:
            pass
        finally:
            node.destroy_node()
            rclpy.shutdown()

if __name__ == '__main__':
    main()