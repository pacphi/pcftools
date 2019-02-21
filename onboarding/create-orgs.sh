# SIMPLE CREATE ORGANIZATIONS SCRIPT
# @author cphillipson@pivotal.io
# @version 0.1
#
# This script creates new organizations on a Pivotal Application Service foundation
# You must be logged in as an administrator to create organizations

set -e

orgs=$1

if [ -z "$orgs" ]; then
    echo "Usage: create-orgs.sh {comma-separated list of organization names}";
    exit 1;
fi

IFS=","

org_namearray=($orgs)

for org in "${org_namearray[@]}"; do
    cf create-org "$org";
done
