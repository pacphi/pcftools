#!/bin/bash

# SIMPLE PAS ACCOUNT ONBOARD SCRIPT
# @author cphillipson@pivotal.io
# @version 0.1
#
# Existing user accounts are assigned org and space roles for existing org and spaces on a Pivotal Application Service foundation
# You must be logged in as an administrator to onboard accounts

set -e

inputfile=$1
orgs=$2
spaces=$3

org_rolearray=( 'OrgManager' 'OrgAuditor' 'BillingManager' )
space_rolearray=( 'SpaceManager' 'SpaceAuditor' 'SpaceDeveloper' )

IFS=","
org_namearray=($orgs)
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

if [ ! -f "$inputfile" ] || [ -z "$orgs" ] || [ -z "$spaces" ]; then
    echo "Usage: onboard-accounts.sh {filename.csv} {comma-separated list of organization names} {comma-separated list of space names}";
    exit 1;
fi

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
		if [ -z "$org_role" ]
		then
			org_role="OrgAuditor";
		fi

		if in_array org_rolearray "$org_role"; then
			for org in "${org_namearray[@]}"; do
				cf set-org-role "$user_name" "$org" "$org_role";
			done
		else
			echo -e "Org role $org_role is invalid for $user_name.\n";
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
			echo -e "Space role $space_role is invalid for $user_name.\n";
		fi

	else
		echo -e "$line is not valid input!\n";
	fi

	if [ $succeeded = true ]
	then
		spaces=$(join_by , "${space_namearray[@]}");
		echo "Succeeded!";
		echo "This account has access to organizations [ $orgs ] and spaces [ $spaces ]";
		echo "where the organization role is set to $org_role";
		echo -e "and space role for each space is set to $space_role\n";
	fi
done < "$inputfile";
