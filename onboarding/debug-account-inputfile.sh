#!/bin/bash

# SIMPLE PAS ACCOUNT SHADOW CREATION SCRIPT
# @author cphillipson@pivotal.io
# @version 0.1
#
# This script only echos the cf CLI commands that will be used to creates new user accounts on a Pivotal Application Service foundation
# Use it to troubleshoot your input file

set -e

org=$2
inputfile=$1

org_rolearray=( 'OrgManager' 'OrgAuditor' 'BillingManager' )
space_rolearray=( 'SpaceManager' 'SpaceAuditor' 'SpaceDeveloper' )
space_namearray=( 'development' 'test' 'stage')

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

if [ ! -f "$inputfile" ] || [ -z "$org" ]; then
    echo "Usage: create-accounts.sh {filename.csv} {organization name}";
    exit 1;
fi

echo "cf create-org \"$org\""
echo "cf t -o \"$org\""
for s in "${space_namearray[@]}"
do
	echo "cf create-space \"$s\" -o \"$org\"";
done


while read -r line
do
	succeeded=false;
	user_name=$( echo "$line" | cut -d\, -f1 | tr -d '\r');
	password=$(openssl rand -base64 16);
	org_role=$( echo "$line" | cut -d\, -f2 | tr -d '\r');
	space_role=$( echo "$line" | cut -d\, -f3 | tr -d '\r');

	echo -e "Processing account onboarding request for: \n\tusername=$user_name\n\torganization=$org\n\torg_role=$org_role\n\tspace_role=$space_role";

	if [ -n "$user_name" ] && [ "$user_name" != " " ]
	then
		echo "cf create-user \"$user_name\" \"$password\"";
		if [ -z "$org_role" ]
		then
			org_role="OrgAuditor";
		fi

		if in_array org_rolearray "$org_role"
		then
			echo "cf set-org-role \"$user_name\" \"$org\" \"$org_role\"";
		else
			echo -e "Org role $org_role is invalid for $user_name.  $user_name is not assigned to any organization!\n";
		fi

		if [ -z "$space_role" ]
		then
			space_role="SpaceDeveloper";
		fi

		if in_array space_rolearray "$space_role"; then
			for space in "${space_namearray[@]}"; do
				echo "cf set-space-role \"$user_name\" \"$org\" \"$space\" \"$space_role\"";
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
		echo "This account has access to org [ $org ] and spaces [ $spaces ]";
		echo "where the organization role is set to $org_role";
		echo -e "and space role for each space is set to $space_role\n";
	fi
done < "$inputfile";
