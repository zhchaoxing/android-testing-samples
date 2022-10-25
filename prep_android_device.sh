#!/bin/bash

 # Disable exit on non 0
"$ANDROID_HOME/platform-tools/adb" kill-server
set +e

#kill "$(ps aux | grep '[e]mulator' | awk '{print $2}')"
kill "$(pgrep '[e]mulator' | awk '{print $2}')"

# Enable exit on non 0
set -e

sleep 20s # TODO: will optimize later

# emulator -avd Android25 -wipe-data -no-snapshot &
"$ANDROID_HOME/emulator/emulator" -avd Android33 -noaudio -no-window -accel on -ports 5556,5557 &

ANDROID_SERIAL=emulator-5556

# wait for emulator to be up and fully booted, unlock screen

"$ANDROID_HOME/platform-tools/adb" wait-for-device shell 'while [[ -z $(getprop sys.boot_completed) ]]; do sleep 1; done; input keyevent 82'
