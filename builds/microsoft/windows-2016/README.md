# Windows 2016 script

We're going to employ a Powershell script to install the majority of tools.  We'll target release binaries directly from public sources like product site download pages and Github repositories.

## Supported versions

- [x] Windows 2016

and backwards compatible with

- [x] Windows 2012 R2

## How to install

Open a Powershell shell as the Administrator

```
cd builds\microsoft\windows-2016
install-pcftools.pt1.ps1
```

Open another Powershell shell as the Administrator

```
cd builds\microsoft\windows-2016
install-pcftools.pt2.ps1
```

## What's missing? =(

* cred-alert
* texplate
* uaac
