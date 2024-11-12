AppleID Audit

This script identifies whether the logged-in user on a Mac is signed into iCloud and checks if the iCloud account is a managed Apple ID from a specified domain. It logs the results in the user's home directory.

Prerequisites

macOS
Access to user preferences (MobileMeAccounts.plist)
Usage

Set the Managed Domain:
Update managedDomain in the script to your organization’s domain (e.g., example.com).
Run the Script:
Execute the script to check the iCloud account status of the currently logged-in user.
Example: ./icloud_check.sh
Log Output:
The results are saved to a log file named icloud_account_check.log in the logged-in user’s home directory.
Output

The script outputs:

No Accounts Signed In: if no iCloud account is signed in.
Managed Apple ID: if the account matches the specified managed domain.
Personal Apple ID: if the account does not match the managed domain.
Notes

This script is useful for auditing managed versus personal iCloud usage on organization-managed Macs.
