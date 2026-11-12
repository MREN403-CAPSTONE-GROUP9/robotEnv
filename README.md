# Capstone Robot Environment

ROS 2 workspace and Python environment for the capstone robot, intended for
Ubuntu 26.04 in WSL2 and Raspberry Pi 5.

Raspberry Pi 5 uses LXQT desktop environment.  
IP: 10.75.188.136  
Username: frosty  
Password: group9

## Setup (Ubuntu 26.04 confimred; see ros.org for extra Raspberry Pi and WSL2 steps)
1. run `git clone https://github.com/MREN403-CAPSTONE-GROUP9/robotEnv.git  && cd robotEnv`
2. then `./setup.sh` and `ros2 run demo_nodes_cpp talker` (smoke test)
4. In a new terminal, cd to robotEnv, activate the project environment, and run:
 - `cd robotEnv`
 - `source ./activate.sh`
 - `ros2 run demo_nodes_cpp listener`

```bash
git clone https://github.com/MREN403-CAPSTONE-GROUP9/robotEnv.git
cd robotEnv
./setup.sh
```

`setup.sh` installs ROS 2 Lyrical, the ROS packages listed in
`requirements.txt`, the Python venv, and the `direnv` Bash hook. It then
approves this repository's `.envrc`. Open a new WSL terminal after setup.

## Daily use

When you enter the repository directory in Bash, `.envrc` automatically
activates the ROS and Python environments. Leaving the directory removes the
directory-specific environment.

To activate manually, use:

```bash
source ./activate.sh
```

You can check the ROS installation with:

```bash
ros2 run demo_nodes_cpp talker
```

## Python environment and Git

The `.venv` directory is intentionally excluded from Git. A virtual
environment contains machine-specific executables and paths, so a copy
committed from one computer would not be reliable on another computer or
clone. Instead, `requirements.txt` is tracked and `./setup.sh` creates the
local `.venv` and installs its dependencies. Run the setup script once after
cloning on each computer.

## Windows and WSL2

Ideally do not run ROS 2 natively on Windows. robotControl has code to setup and run on windows. This repo is for running on a robot. If needed to activate on windows run in WSL.

From an elevated PowerShell prompt:

```powershell
wsl --install -d Ubuntu-26.04
```

Restart Windows if prompted, open Ubuntu 26.04, and follow the first-time
setup steps above. WSLg can display graphical ROS applications such as RViz.

For USB devices, install `usbipd` on Windows, then use `usbipd list`,
`usbipd bind --busid <BUSID>` from elevated PowerShell, and
`usbipd attach --wsl --busid <BUSID>` from WSL.

open powershell and enter `wsl.exe` to launch wsl then clone repo and run setup.sh

## Layout

- `src/` — ROS 2 packages (colcon workspace)
- `setup.sh` — one-time ROS and dependency setup
- `activate.sh` — manual ROS and venv activation
- `.envrc` — automatic activation when entering the repository with direnv



# for Viewing image
when opencv_tools papackage is running use `rviz2` to view
if using on wsl may need to install packages to ensure driver comapatablity

```
sudo apt install mesa-utils
```
or try 
```
export QT_QPA_PLATFORM=xcb
```


# for issues with networking from pi to wsl try mirror mode

https://learn.microsoft.com/en-us/windows/wsl/wsl-config#configuration-settings-for-wslconfig

and then enable firewall passthrough
```
Set-NetFirewallHyperVVMSetting -Name '{40E0AC32-46A5-438A-A0B2-2B479E8F2E90}' -DefaultInboundAction Allow
```
