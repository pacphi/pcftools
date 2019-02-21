#!/bin/bash

# SIMPLE PAS ACCOUNT CREATION SCRIPT
# @author cphillipson@pivotal.io
# @version 0.1
#
# This script creates new user accounts, creates orgs and spaces, 
# then assigns org and space roles to all org/space combinations on a Pivotal Application Service foundation
# You must be logged in as an administrator to create accounts
#
# The current implementation does not handle exceptional cases like
#    - account already exists
#    - organization already exists
#
set -e

inputfile=$1
org=$2
spaces=$3
api_endpoint=$4

org_rolearray=( 'OrgManager' 'OrgAuditor' 'BillingManager' )
space_rolearray=( 'SpaceManager' 'SpaceAuditor' 'SpaceDeveloper' )

IFS=","
space_namearray=($spaces)

in_array() {
    local haystack=${1}[@]
    local needle=${2}
    for i in ${!haystack}; do
        if [[ ${i} == ${needle} ]]; then
            return 0
        fi
    done
    return 1
}

join_by () {
	local d=$1
	shift
	echo -n "$1"
	shift
	printf "%s" "${@/#/$d}"
}

if [ ! -f "$inputfile" ] || [ -z "$org" ] || [ -z "$spaces" ] || [ -z "$api_endpoint" ]; then
    echo "Usage: create-accounts.sh {filename.csv} {comma-separated list of organization names} {comma-separated list of space names} {api endpoint}";
    exit 1;
fi

for org in "${org_namearray[@]}"
do
	cf create-org "$org"
	for s in "${space_namearray[@]}"
	do
		cf create-space "$s" -o "$org";
	done
done

unset IFS

while read -r line
do
	succeeded=false;
	user_name=$( echo "$line" | cut -d\, -f1 | tr -d '\r');
	password=$(openssl rand -base64 16);
	org_role=$( echo "$line" | cut -d\, -f2 | tr -d '\r');
	space_role=$( echo "$line" | cut -d\, -f3 | tr -d '\r');

	echo -e "Processing account onboarding request for: \n\tusername=$user_name\n\torg_role=$org_role\n\tspace_role=$space_role";

	if [ -n "$user_name" ] && [ "$user_name" != " " ]
	then
		cf create-user "$user_name" "$password";
		if [ -z "$org_role" ]
		then
			org_role="OrgAuditor";
		fi

		if in_array org_rolearray "$org_role"; then
			for org in "${org_namearray[@]}"; do
				cf set-org-role "$user_name" "$org" "$org_role";
			done
		else
			echo -e "Org role $org_role is invalid for $user_name.  $user_name is not assigned to any organization!\n";
		fi

		if [ -z "$space_role" ]
		then
			space_role="SpaceDeveloper";
		fi

		if in_array space_rolearray "$space_role"; then
			for org in "${org_namearray[@]}"; do
				for space in "${space_namearray[@]}"; do
					cf set-space-role "$user_name" "$org" "$space" "$space_role";
				done
			done
			succeeded=true;
		else
			echo -e "Space role $space_role is invalid for $user_name.  $user_name is not assigned to any space!\n";
		fi

	else
		echo -e "$line is not valid input!\n";
	fi

	if [ $succeeded = true ]
	then
		spaces=$(join_by , "${space_namearray[@]}");
		echo "Succeeded!";
		echo "Login credentials are $user_name / $password";
		echo "This user may log in with [ cf login -u $user_name -p $password -a $api_endpoint --skip-ssl-validation ]";
		echo "This account has access to organizations [ $orgs ] and spaces [ $spaces ]";
		echo "where the organization role is set to $org_role";
		echo -e "and space role for each space is set to $space_role\n";
	fi
done < "$inputfile";
