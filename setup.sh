#!/usr/bin/env bash
#writen by CHATGPT Sep-29-2026
#Owner Lucas Balog Lucas.Balog@queensu.ca
#installs ROS 2 Lyrical and project dependencies in a virtual environment
#updates:
#   None
set -euo pipefail

ROS_DISTRO=lyrical
ROS_SETUP="/opt/ros/${ROS_DISTRO}/setup.bash"
ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REQUIREMENTS_FILE="${ROOT_DIR}/requirements.txt"

if [[ ! -f "${REQUIREMENTS_FILE}" ]]; then
    printf 'Requirements file not found: %s\n' "${REQUIREMENTS_FILE}" >&2
    exit 1
fi

if [[ ! -f "${ROS_SETUP}" ]]; then
    if [[ ! -r /etc/os-release ]]; then
        printf 'Cannot determine the operating system.\n' >&2
        exit 1
    fi

    . /etc/os-release
    if [[ "${ID:-}" != ubuntu || "${VERSION_ID:-}" != 26.04 ]]; then
        printf 'ROS 2 Lyrical installation requires Ubuntu 26.04; found %s %s.\n' \
            "${ID:-unknown}" "${VERSION_ID:-unknown}" >&2
        exit 1
    fi

    sudo apt-get update
    sudo apt-get install -y curl ca-certificates

    source_version="$(curl -fsSL https://api.github.com/repos/ros-infrastructure/ros-apt-source/releases/latest \
        | sed -n 's/.*"tag_name"[[:space:]]*:[[:space:]]*"\([^"]*\)".*/\1/p' | head -n 1)"
    if [[ -z "${source_version}" ]]; then
        printf 'Could not determine the latest ROS apt source version.\n' >&2
        exit 1
    fi

    ubuntu_codename="${UBUNTU_CODENAME:-${VERSION_CODENAME:-}}"
    if [[ -z "${ubuntu_codename}" ]]; then
        printf 'Could not determine the Ubuntu codename.\n' >&2
        exit 1
    fi

    source_package="ros2-apt-source_${source_version}.${ubuntu_codename}_all.deb"
    source_url="https://github.com/ros-infrastructure/ros-apt-source/releases/download/${source_version}/${source_package}"
    curl -fsSL "${source_url}" -o "/tmp/${source_package}"
    sudo dpkg -i "/tmp/${source_package}"
    sudo apt-get update
    sudo apt-get install -y ros-lyrical-desktop
fi

sudo apt-get update
sudo apt-get install -y python3-pip python3-venv python3-rosdep \
    python3-colcon-common-extensions

source "${ROS_SETUP}"

ros_packages=()
while IFS= read -r line || [[ -n "${line}" ]]; do
    case "${line}" in
        '# ros: '*)
            package="${line#\# ros: }"
            [[ -z "${package}" ]] || ros_packages+=("${package}")
            ;;
    esac
done < "${REQUIREMENTS_FILE}"

if (( ${#ros_packages[@]} > 0 )); then
    sudo apt-get install -y "${ros_packages[@]}"
fi

python3 -m venv "${ROOT_DIR}/.venv"
"${ROOT_DIR}/.venv/bin/python" -m pip install --upgrade pip
"${ROOT_DIR}/.venv/bin/python" -m pip install -r "${REQUIREMENTS_FILE}"

printf '\nROS 2 %s and project dependencies are installed.\n' "${ROS_DISTRO}"
printf 'To use ROS in a new terminal, run: source %s\n' "${ROS_SETUP}"
printf 'Python dependencies are available in: %s/.venv\n' "${ROOT_DIR}"