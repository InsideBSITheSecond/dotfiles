#!/usr/bin/expect -f

#set device "11:11:22:F3:6C:EC"
set device "91:7F:3B:C9:89:5D"
set timeout 60
spawn bluetoothctl
send -- "scan on\r"
expect "$device"
#send -- "pair $device\r"
#expect "Pairing successful"
send -- "connect $device\r"
expect "Connection successful"
send -- "trust $device\r"
expect "trust succeeded"
send -- "exit\r"
expect eof