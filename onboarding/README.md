# Simple CF Account Onboarding and Deletion Scripts

## Onboarding

Simple bash script that reads in a comma-separated value file parsing each line and creating a user account with a random password assigning an organization role and space role.

Additionally, before creating accounts, it will create a new organization and initialize three spaces: development, test, and staging.

### Usage

```bash
./create-accounts.sh {input file} {organization name}
```

See [create-accounts-sample.csv](create-accounts-sample.csv) for a sample `{input file}`


## Deletion

This script will delete existing user accounts.  Use with caution!

### Usage

```bash
./delete-accounts.sh {input file} {organization name}
```

See [delete-accounts-sample.csv](delete-accounts-sample.csv) for a sample `{input file}`

