#!/bin/bash

# SIMPLE PAS ACCOUNT DELETION SCRIPT
# @author cphillipson@pivotal.io
# @version 0.1
#
# This script deletes existing user accounts on a Pivotal Application Service foundation
# You must be logged in as an administrator to delete accounts

#
set -e

org=$2
inputfile=$1

array_contains () {
    local array="$1[@]"
    local seeking=$2
    local in=1
    for element in "${!array}"; do
        if [ "$element" == "$seeking" ]; then
            in=0
            break
        fi
    done
    return $in
}

if [ ! -f "$inputfile" ] || [ -z "$org" ]; then
    echo "Usage: delete-accounts.sh {filename.csv} {organization name}";
    exit 1;
fi

cf delete-org "$org" -f

while read -r line
do
    user_name=$(echo "$line" | tr -d '\r')

	echo -e "Processing account deletion request for: \n\tusername=$user_name";

	if [ -n "$user_name" ] && [ "$user_name" != " " ]
	then
		cf delete-user "$user_name" -f;
	fi
done < "$inputfile";

