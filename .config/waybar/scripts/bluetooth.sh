#!/bin/sh

add="11:11:22:F3:6C:EC"

connected=$(bluetoothctl info 11:11:22:F3:6C:EC | awk '/Connected/ {print $2}')

if [[ "$1" == "connect" ]]; then
    bluetoothctl connect $add
fi

if grep -qxF "$connected" <<< "yes"; then
    echo "<span font='24px' rise='3000'>󰂰 </span>"
elif grep -qxF "$connected" <<< "no"; then
    echo "<span font='24px' rise='3000'>󰂲 </span>"
else
    echo "error"
fi