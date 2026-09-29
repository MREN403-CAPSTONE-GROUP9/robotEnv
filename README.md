# Capstone Robot

ROS 2 workspace for the capstone robot.

## Setup (Ubuntu 26.04, Raspberry Pi, WSL2)
1. `git clone https://github.com/MREN403-CAPSTONE-GROUP9/robotEnv.git  && cd robotEnv`
2. `./setup.sh`
3. In a new terminal, source ROS and run:
 - `source /opt/ros/lyrical/setup.bash`
 - `ros2 run demo_nodes_cpp talker` (smoke test)
 - `ros2 run <your_package> <your_node>`

The script installs ROS 2 Lyrical if it is not already installed, then installs
the ROS packages listed in `requirements.txt` and Python packages into `.venv`.

## Windows
Do **not** install ROS 2 natively. Use WSL2:
1. PowerShell (Admin): `wsl --install -d Ubuntu-26.04` → reboot
2. Open "Ubuntu 26.04" from the Start menu
3. Follow the Setup steps above
4. RViz/Gazebo windows appear automatically (WSLg)

USB devices (controller, camera):
- `winget install usbipd`
- In WSL2: `usbipd list`
- Admin PowerShell: `usbipd bind --busid <BUSID>`
- In WSL2: `usbipd attach --wsl --busid <BUSID>`

## Layout
- `src/` — ROS 2 packages (colcon workspace)
- `setup.sh` — one-time environment setup# robotEnv
main eviroment
