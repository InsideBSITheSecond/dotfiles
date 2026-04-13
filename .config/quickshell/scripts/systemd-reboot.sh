#!/usr/bin/env bash

set -e

if [[ "$(id -u)" -ne 0 ]]; then
  echo >&2 "ERROR: This script must be run as root (e.g. via pkexec)."
  exit 1
fi

case "$1" in
  arch)
    bootctl set-oneshot arch-linx.efi
    ;;
  win)
    bootctl set-oneshot auto-windows
    ;;
  *)
    echo "Usage: $0 [arch|win]"
    exit 1
    ;;
esac

#bootctl set-timeout-oneshot 0
exec /usr/bin/systemctl reboot