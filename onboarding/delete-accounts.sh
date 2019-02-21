#!/bin/bash

# SIMPLE PAS ACCOUNT DELETION SCRIPT
# @author cphillipson@pivotal.io
# @version 0.1
#
# This script deletes existing user accounts on a Pivotal Application Service foundation
# You must be logged in as an administrator to delete accounts

#
set -e

inputfile=$1

if [ ! -f "$inputfile" ]; then
    echo "Usage: delete-accounts.sh {filename.csv}";
    exit 1;
fi

while read -r line
do
    user_name=$(echo "$line" | tr -d '\r')

	echo -e "Processing account deletion request for: \n\tusername=$user_name";

	if [ -n "$user_name" ] && [ "$user_name" != " " ]
	then
		cf delete-user "$user_name" -f;
	fi
done < "$inputfile";

