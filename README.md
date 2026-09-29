# Capstone Robot

ROS 2 workspace for the capstone robot.

## Setup (Ubuntu 26.04 confimred; see ros.org for extra Raspberry Pi and WSL2 steps)
1. run `git clone https://github.com/MREN403-CAPSTONE-GROUP9/robotEnv.git  && cd robotEnv`
2. then `./setup.sh` and `ros2 run demo_nodes_cpp talker` (smoke test)
4. In a new terminal, cd to robotEnv, activate the project environment, and run:
 - `cd robotEnv`
 - `source ./activate.sh`
 - `ros2 run <your_package> <your_node>`

The script installs ROS 2 Lyrical if it is not already installed, then installs
the ROS packages listed in `requirements.txt` and Python packages into `.venv`.

## For Windows Testng
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
