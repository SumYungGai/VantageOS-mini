#!/bin/bash
# VantageOS mini - Clamshell Power & Audio Management

ACTION=$1

if [ "$ACTION" == "lid_close" ]; then
    # 1. Instantly mute audio hardware to prevent the Linux speaker pop
    amixer set Master mute
    
    # 2. Suspend the active DraStic/RetroArch process so the game pauses
    killall -STOP drastic
    killall -STOP retroarch
    
    # 3. Drop the RK3568 SoC into deep 'freeze' state to save battery
    echo freeze > /sys/power/state

elif [ "$ACTION" == "lid_open" ]; then
    # 1. Hardware wakes up from freeze automatically
    # 2. Resume the emulator processes
    killall -CONT drastic
    killall -CONT retroarch
    
    # 3. Unmute audio
    amixer set Master unmute
fi
