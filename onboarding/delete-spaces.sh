# SIMPLE DELETE SPACES SCRIPT
# @author cphillipson@pivotal.io
# @version 0.1
#
# This script deletes existing spaces on a Pivotal Application Service foundation
# You must be logged in as an administrator to delete spaces

set -e

org=$1
spaces=$2

if [ -z "$org" ] || [ -z "$spaces" ]; then
    echo "Usage: delete-spaces.sh {organization name} {comma-separated list of space names}";
    exit 1;
fi

IFS=","

space_namearray=($spaces)

for space in "${space_namearray[@]}"; do
    cf delete-space "$space" -o "$org" -f;
done
