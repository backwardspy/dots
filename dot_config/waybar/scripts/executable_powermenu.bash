#!/bin/bash
set -euo pipefail
IFS=$'\n\t'
cmd=$(echo -e "Sleep\nReboot\nShutdown\nCancel" | yofi dialog | awk '{print tolower($0)}')
case $cmd in
  sleep)
    systemctl suspend
    ;;
  reboot)
    systemctl reboot
    ;;
  shutdown)
    systemctl poweroff
    ;;
  cancel)
    ;;
esac
