# SIMPLE DELETE ORGANIZATIONS SCRIPT
# @author cphillipson@pivotal.io
# @version 0.1
#
# This script deletes existing organizations on a Pivotal Application Service foundation
# You must be logged in as an administrator to delete organizations

set -e

orgs=$1

if [ -z "$orgs" ]; then
    echo "Usage: delete-orgs.sh {comma-separated list of organization names}";
    exit 1;
fi

IFS=","

org_namearray=($orgs)

for org in "${org_namearray[@]}"; do
    cf delete-org "$org" -f;
done
