#!/bin/bash

set -e  # Exit immediately if a command exits with a non-zero status.

for p in $(cat projects.conf); do
   echo
   echo
   echo Clean unit and Android tests environemnts in $p
   echo "====================================================================="
   echo "Cleaning $p"
   pushd $p > /dev/null  # Silent pushd
   ./gradlew $@ clean | sed "s@^@$p @"  # Prefix every line with directory
   code=${PIPESTATUS[0]}
   if [ "$code" -ne "0" ]; then
       exit $code
   fi
   popd > /dev/null  # Silent popd
done

echo
echo "ALL TESTS PASS"
