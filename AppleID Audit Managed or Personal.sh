#!/bin/bash
# Set the managed Apple ID domain
managedDomain="teamcomputers.com"

# Loop through users with UniqueID >= 500
for user in $(dscl . list /Users UniqueID | awk '$2 >= 500 {print $1}'); do
    userHome=$(dscl . read /Users/"$user" NFSHomeDirectory | sed 's/NFSHomeDirectory://' | grep "/" | sed 's/^[ \t]*//')
    appleid=$(dscl . readpl "${userHome}" dsAttrTypeNative:LinkedIdentity appleid.apple.com:linked\ identities:0:full\ name 2> /dev/null | awk -F'full name: ' '{print $2}')

    if [[ -z "${appleid}" ]]; then
        echo "User:${user} has not signed in with an Apple ID"
    else
        # Check if the Apple ID contains the managed domain
        if [[ "${appleid}" == *"${managedDomain}" ]]; then
            echo "User:${user} is signed in with a managed Apple ID:${appleid}"
        else
            echo "User:${user} is signed in with a personal Apple ID:${appleid}"
        fi
    fi
done