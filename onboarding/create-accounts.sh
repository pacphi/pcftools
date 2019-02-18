#!/bin/bash

# SIMPLE PAS ACCOUNT CREATION SCRIPT
# @author cphillipson@pivotal.io
# @version 0.1
#
# This script creates new user accounts on a Pivotal Application Service foundation
# You must be logged in as an administrator to create accounts
#
# The current implementation does not handle exceptional cases like
#    - account already exists
#    - organization already exists
#
set -e

org=$2
inputfile=$1

org_rolearray=( 'OrgManager' 'OrgAuditor' 'BillingManager' )
space_namearray=( 'development' 'test' 'staging')
space_rolearray=( 'SpaceManager' 'SpaceAuditor' 'SpaceDeveloper' )

array_contains () {
    local array="$1[@]"
    local seeking=$2
    local in=1
    for element in "${!array}"; do
        if [ $element == $seeking ]; then
            in=0
            break
        fi
    done
    return $in
}

if [ ! -f "$inputfile" ] || [ -z "$org" ]; then
    echo "Usage: create-accounts.sh {filename.csv} {organization name}";
    exit 1;
fi

cf create-org "$org"
cf t -o "$org"
for s in "${space_namearray[@]}"
do
	cf create-space "$s" -o "$org"
done


IFS=$'\n'
for j in $(cat $inputfile)
do
	succeeded=false
	user_name=$( echo "$j" | cut -d\, -f1)
	password="$(openssl rand -base64 16)
	org_role=$( echo "$j" | cut -d\, -f2)
	space_role=$( echo "$j" | cut -d\, -f3)

	echo -e "Processing account onboarding request for: \n\tusername=$user_name\n\torganization=$org\n\torg_role=$organization_role\n\tspace_role=$space_role"

	if [ -z "$user_name" ];then
		cf create-user "$user_name"
		if [ -z "$org_role" ]; then
			org_role="OrgAuditor"
			cf set-org-role "$user_name" $org_name "$org_role"
		else
			if array_contains org_rolearray "$org_role"; then
				cf set-org-role "$user_name" "$org_name" "$org_role"
			else
				echo -e "Org role $org_role is invalid for $user_name.  $user_name is not assigned to any organization!\n"
			fi
		fi
		if [ -z "$space_role" ]; then
			space_role="SpaceDeveloper"
			cf set-space-role "$user_name" "$org_name" "$space_name" "$space_role"
		else
			if array_contains space_rolearray "$space_role"; then
				cf set-org-role "$user_name" "$org_name" "$org_role" "$space_role"
			else
				echo -e "Space role $space_role is invalid for $user_name.  $user_name is not assigned to any space!\n"
			fi
		fi
		succeeded=true
	else
		echo -e "$j is not valid input!\n"
	fi

	if [ "$succeeded" = true]; then
		echo -e "Succeeded! Login credentials are $user_name / $password and this account has org_role set to $org_role and space_role set to $space_role".
	fi
done
