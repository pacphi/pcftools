# Windows script

We're going to use a package manager for Windows 10 called [Chocolatey](https://chocolatey.org) to install the majority of tools.  For a handful more we'll source release binaries directly from Github repositories.

## Supported versions

> See Chocolatey installation requirements [here](https://github.com/chocolatey/choco/wiki/Installation#requirements).

- [x] Windows 10

and backwards compatible with

- [x] Windows 7
- [x] Windows 8

## How to clone

```
git clone https://github/pacphi/pcftools
```

## How to install

Open a [cmd](https://docs.microsoft.com/en-us/windows-server/administration/windows-commands/windows-commands#BKMK_OVR) shell as the Administrator

```
cd builds\microsoft\windows-10
install-pcftools.pt1.bat
```

Open another cmd shell as the Administrator

```
install-pcftools.pt2.bat
```

## What's missing? =(

* uaac
