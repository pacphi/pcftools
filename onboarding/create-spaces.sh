# SIMPLE CREATE SPACES SCRIPT
# @author cphillipson@pivotal.io
# @version 0.1
#
# This script creates new spaces on a Pivotal Application Service foundation
# You must be logged in as an administrator to create spaces

set -e

org=$1
spaces=$2

if [ -z "$org" ] || [ -z "$spaces" ]; then
    echo "Usage: create-spaces.sh {org name} {comma-separated list of space names}";
    exit 1;
fi

IFS=","

space_namearray=($spaces)

for space in "${org_namearray[@]}"; do
    cf crate-space "$space" -o "$org";
done
