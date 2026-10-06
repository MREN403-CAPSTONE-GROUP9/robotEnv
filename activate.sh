#!/usr/bin/env bash

if [[ "${BASH_SOURCE[0]}" == "$0" ]]; then
    printf 'Run this script with: source %s\n' "$0" >&2
    exit 1
fi

_robot_env_root="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)" || return 1
_robot_env_venv="${_robot_env_root}/.venv/bin/activate"
_robot_env_ros="/opt/ros/lyrical/setup.bash"

if [[ ! -f "${_robot_env_venv}" ]]; then
    printf 'Virtual environment not found: %s\nRun ./setup.sh first.\n' \
        "${_robot_env_venv}" >&2
    unset _robot_env_root _robot_env_venv _robot_env_ros
    return 1
fi

if [[ ! -f "${_robot_env_ros}" ]]; then
    printf 'ROS setup not found: %s\nRun ./setup.sh first.\n' "${_robot_env_ros}" >&2
    unset _robot_env_root _robot_env_venv _robot_env_ros
    return 1
fi

_robot_env_restore_nounset=0
[[ "$-" == *u* ]] && _robot_env_restore_nounset=1
set +u
source "${_robot_env_venv}"
source "${_robot_env_ros}"
if (( _robot_env_restore_nounset )); then
    set -u
fi
unset _robot_env_root _robot_env_venv _robot_env_ros _robot_env_restore_nounset

printf 'Activated project venv and ROS 2 Lyrical.\n'