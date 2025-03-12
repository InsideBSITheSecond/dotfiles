#!/bin/sh

device=$(pactl list short sinks | grep RUNNING | awk '{print $2}')
if [[ -z "$device" ]]; then
    device=$(pactl get-default-sink)
fi

d1="alsa_output.usb-Logitech_Logitech_G933_Gaming_Wireless_Headset-00.analog-stereo"
d2="ROC"

if [[ "$1" == "status" ]]; then
    status=$(headsetcontrol -b | awk '/Status/ {print $2}')
    level=$(headsetcontrol -b | awk '/Level/ {print $2}')

    if grep -qxF "$d1" <<< "$device"; then
        echo -n "" #headset icon
        if [[ "$status" == "BATTERY_AVAILABLE" ]]; then
            echo -n "󰁾 $level" #battery 50% icon
        elif [[ "$status" == "BATTERY_CHARGING" ]]; then
            echo -n "󰂄" #battery chargin icon
        else
            echo -n "󰂑" #battery unknown icon
        fi
    elif grep -qxF "$d2" <<< "$device"; then
        echo -n "󱡏" #earbuds icon
        echo -n "(" #headset icon
        if [[ "$status" == "BATTERY_AVAILABLE" ]]; then
            echo -n "󰁾 $level" #battery 50% icon
        elif [[ "$status" == "BATTERY_CHARGING" ]]; then
            echo -n "󰂄" #battery chargin icon
        else
            echo -n "󰂑" #battery unknown icon
        fi
        echo -n ")"
    else
        echo -n "device: $device" #error icon
    fi
elif [[ "$1" == "switch" ]]; then
    if grep -qxF "$d1" <<< "$device"; then
        echo uwu
        pactl set-default-sink $d2
    elif grep -qxF "$d2" <<< "$device"; then
        echo owo
        pactl set-default-sink $d1
    fi
else
    echo "error"
fi