# Install
should be setup and ready to go just need
```
rosdep install -i --from-path src --rosdistro lyrical -y
```

and 

```
colcon build
```

may need to set camera permisions with

```
sudo usermod -aG video $USER
SUBSYSTEM=="video4linux", GROUP="video", MODE="0660"
sudo udevadm control --reload-rules
sudo udevadm trigger
```
need to reboot device after

```
sudo reboot now
```

can test with
```
sudo apt install fswebcam
fswebcam -d /dev/video0 -r 1280x720 test.jpg
```