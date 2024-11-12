#!/bin/sh

#AppleID Audit Managed or Personal

# Author: Yogesh Surwase
# Date: November 12, 2024

#This script checks if a Mac user is signed into iCloud and identifies if the account 
#is a managed or personal Apple ID,logging the results in the user's home directory.


# Set the managed iCloud domain
managedDomain="example.com"

# Define the log file path in the user's home directory
loggedInUser=$(stat -f%Su /dev/console)
logFile="/Users/$loggedInUser/icloud_account_check.log"

# Function to write logs with date and time
log_message() {
    local message="$1"
    echo "$(date '+%Y-%m-%d %H:%M:%S') - $message" >> "$logFile"
}

# Log start of the check
log_message "Checking iCloud account for user: $loggedInUser"

# Retrieve iCloud account ID if available
icloudaccount=$(defaults read /Users/$loggedInUser/Library/Preferences/MobileMeAccounts.plist Accounts | grep AccountID | cut -d '"' -f 2)

# Check if the iCloud account is empty
if [ -z "$icloudaccount" ]; then
    echo "<result>No Accounts Signed In</result>"
    log_message "No iCloud account signed in for user: $loggedInUser"
else
    # Check if the iCloud account matches the managed domain
    if [[ "$icloudaccount" == *"$managedDomain" ]]; then
        echo "<result>Managed Apple ID: $icloudaccount</result>"
        log_message "Managed Apple ID detected for user $loggedInUser: $icloudaccount"
    else
        echo "<result>Personal Apple ID: $icloudaccount</result>"
        log_message "Personal Apple ID detected for user $loggedInUser: $icloudaccount"
    fi
fi
