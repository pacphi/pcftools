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
space_namearray=( 'development' 'test' 'stage')
space_rolearray=( 'SpaceManager' 'SpaceAuditor' 'SpaceDeveloper' )

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

cf create-org "$org"
cf t -o "$org"
for s in "${space_namearray[@]}"
do
	cf create-space "$s" -o "$org";
done


while read -r line
do
	succeeded=false;
	user_name=$( echo "$line" | cut -d\, -f1);
	password=$(openssl rand -base64 16);
	org_role=$( echo "$line" | cut -d\, -f2);
	space_role=$( echo "$line" | cut -d\, -f3);

	echo -e "Processing account onboarding request for: \n\tusername=$user_name\n\torganization=$org\n\torg_role=$org_role\n\tspace_role=$space_role";

	if [ -n "$user_name" ] && [ "$user_name" != " " ]
	then
		cf create-user "$user_name" "$password";
		if [ -z "$org_role" ]
		then
			org_role="OrgAuditor";
		fi

		if array_contains org_rolearray "$org_role"
		then
			cf set-org-role "$user_name" "$org" "$org_role";
		else
			echo -e "Org role $org_role is invalid for $user_name.  $user_name is not assigned to any organization!\n";
		fi

		if [ -z "$space_role" ]
		then
			space_role="SpaceDeveloper";
		fi

		for space in "${space_namearray[@]}"
		do
			if array_contains space_rolearray "$space_role"
			then
				cf set-space-role "$user_name" "$org" "$space" "$space_role";
			else
				echo -e "Space role $space_role is invalid for $user_name.  $user_name is not assigned to any space!\n";
				break;
			fi
		done

		succeeded=true;
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
		echo "and space role for each space is set to $space_role";
	fi
done < "$inputfile";
