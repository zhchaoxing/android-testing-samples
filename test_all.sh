#!/bin/bash

set -e  # Exit immediately if a command exits with a non-zero status.

ANDROID_SERIAL=emulator-5556

# wait for emulator to be up and fully booted, unlock screen

$ANDROID_HOME/platform-tools/adb wait-for-device shell 'while [[ -z $(getprop sys.boot_completed) ]]; do sleep 1; done; input keyevent 82'


for p in $(cat projects.conf); do
   echo
   echo
   echo Running unit and Android tests in $p
   echo "====================================================================="
   
   pushd $p > /dev/null  # Silent pushd
   ./gradlew $@ testDebug connectedAndroidTest | sed "s@^@$p @"  # Prefix every line with directory
   code=${PIPESTATUS[0]}
   if [ "$code" -ne "0" ]; then
       exit $code
   fi
   popd > /dev/null  # Silent popd
done

echo
echo "ALL TESTS PASS"
