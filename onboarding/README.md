# Scripts for onboarding and deleting user accounts, organizations and spaces

## Plan to create accounts

```bash
./plan-to-create-accounts.sh {input file} {comma-separated list of organization names} {comma-separated list of space names}
```

> Use this script to debug issues with the `{input file}`.  It will log out all cf CLI commands that will be invoked when you run `./create-accounts.sh`.

## Create accounts

```bash
./create-accounts.sh {input file} {comma-separated list of organization names} {comma-separated list of space names}
```

See [create-accounts-sample.csv](create-accounts-sample.csv) for a sample `{input file}`

## Onboard accounts

```bash
./onboard-accounts.sh {input file} {comma-separated list of organization names} {comma-separated list of space names}
```

> Differs from `create-accounts.sh` in that each user account in the input file must already exist. The script will invoke `cf set-org-role` and `cf set-space-role` for each org, space and user account.

## Delete accounts

```bash
./delete-accounts.sh {input file}
```

> Use with caution!

See [delete-accounts-sample.csv](delete-accounts-sample.csv) for a sample `{input file}`

## Create organizations

```bash
./create-orgs.sh {comma-separated list of organization names}
```

## Delete organizations

```bash
./delete-orgs.sh {comma-separated list of organization names}
```

> Use with caution!

## Create spaces

```bash
./create-spaces.sh {organization name} {comma-separated list of space names}
```

## Delete spaces

```bash
./delete-spaces.sh {organization name} {comma-separated list of space names}
```

> Use with caution!
