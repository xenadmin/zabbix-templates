#!/bin/bash
export PATH=${PATH}:/usr/local/sbin:/sbin:/usr/sbin:/bin:/usr/bin

FOLDER="$1"

FILEPATH="$(find $FOLDER -type f -printf '%T+ %p\n' | sort | head -n 1 | cut -d ' ' -f 2)"
if [ ! "$FILEPATH" ]; then
    echo 0
else
    NOW="$(date +%s)"
    OLD="$(stat -c %Z $FILEPATH)"
    AGE="$((NOW-OLD))"
    echo $AGE
fi