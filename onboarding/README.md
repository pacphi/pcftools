# Simple CF Account Onboarding Script

Simple bash script that reads in a comma-separated value file parsing each line and creating a user account with a random password assigning an organization role and space role.

Additionally, before creating accounts, it will create a new organization and initialize three spaces: development, test, and staging.

## Usage

```bash
./create-accounts.sh {input file} {organization name}
```

See [accounts.csv](accounts.csv) for a sample `{input file}`