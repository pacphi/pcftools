# Windows 10 script

We're going to use a package manager for [Windows 10](https://www.microsoft.com/en-us/windows/get-windows-10) called [Chocolatey](https://chocolatey.org) to install the majority of tools.  For a handful more we'll source release binaries directly from Github repositories.

> See Chocolatey installation requirements [here](https://github.com/chocolatey/choco/wiki/Installation#requirements).

## Supported versions

- [x] Windows 10

and backwards compatible with

- [x] Windows 7
- [x] Windows 8

## How to install

Open a [cmd](https://docs.microsoft.com/en-us/windows-server/administration/windows-commands/windows-commands#BKMK_OVR) shell as the Administrator

```
cd builds\microsoft\windows-10
install-pcftools.pt1.bat
```

Open another cmd shell as the Administrator

```
cd builds\microsoft\windows-10
install-pcftools.pt2.bat
```

## What's missing? =(

* cred-alert
* texplate
* uaac


## Post install notes

If you really, really want `uaac` available, visit https://rubyinstaller.org, then download and install the [latest](https://github.com/oneclick/rubyinstaller2/releases/download/RubyInstaller-2.6.1-1/rubyinstaller-devkit-2.6.1-1-x64.exe) available version of RubyInstaller for Windows.

Then open a `cmd` shell as an Administrator and run

```
gem uninstall eventmachine
gem install eventmachine --platform ruby
git clone https://github.com/cloudfoundry/cf-uaac.git
cd cf-uaac
bundle install 
gem build cf-uaac.gemspec 
gem install cf-uaac*.gem
```
