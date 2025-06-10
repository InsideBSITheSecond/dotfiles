#!/bin/sh

device=$(pactl list short sinks | grep RUNNING | awk '{print $2}')
if [[ -z "$device" ]]; then
    device=$(pactl get-default-sink)
fi

d1="alsa_output.usb-Generic_USB_Audio-00.HiFi_7_1__Speaker__sink"
d2="bluez_output.11_11_22_F3_6C_EC.1"

if [[ "$1" == "status" ]]; then
    status=$(headsetcontrol -b | awk '/Status/ {print $2}')
    level=$(headsetcontrol -b | awk '/Level/ {print $2}')

    if grep -qxF "$d1" <<< "$device"; then
        echo -n "<span font='24px' rise='3000'> </span>" #headset icon
#        echo -n "<span font='24px' rise='3000'>"
#        if [[ "$status" == "BATTERY_AVAILABLE" ]]; then
#            echo -n "󰁾 $level" #battery 50% icon
#        elif [[ "$status" == "BATTERY_CHARGING" ]]; then
#            echo -n "󰂄" #battery chargin icon
#        else
#            echo -n "󰂑" #battery unknown icon
#        fi
#        echo -n " </span>"
    elif grep -qxF "$d2" <<< "$device"; then
        echo -n "󱡏" #earbuds icon
#        echo -n "<span font='24px' rise='3000'>"
#        if [[ "$status" == "BATTERY_AVAILABLE" ]]; then
#            echo -n "󰁾 $level" #battery 50% icon
#        elif [[ "$status" == "BATTERY_CHARGING" ]]; then
#            echo -n "󰂄" #battery chargin icon
#        else
#            echo -n "󰂑" #battery unknown icon
#        fi
#        echo -n " </span>"
    else
        echo -n "unreconized device: $device" #error icon
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