#!/bin/bash

# emulator -avd Android25 -wipe-data -no-snapshot &
~/android_sdk/emulator/emulator -avd Android33 -noaudio -no-window -accel on -ports 5556,5557 &

ANDROID_SERIAL=emulator-5556

# wait for emulator to be up and fully booted, unlock screen

$ANDROID_HOME/platform-tools/adb wait-for-device shell 'while [[ -z $(getprop sys.boot_completed) ]]; do sleep 1; done; input keyevent 82'