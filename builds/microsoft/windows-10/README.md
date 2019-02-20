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
* kibosh
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

## to enable Windows Subsystem for Linux

Have a look a look at both the [installation](https://docs.microsoft.com/en-us/windows/wsl/install-win10) and [troubleshooting](https://docs.microsoft.com/en-us/windows/wsl/troubleshooting) guides.

> You'll need to upgrade to Windows 10 build 16215 or later

### tl;dr

1. Open Powershell as an Administrator and execute

    ```
    Enable-WindowsOptionalFeature -Online -FeatureName Microsoft-Windows-Subsystem-Linux
    ```

2. Reboot

3. Visit the Microsoft Store and choose your [favorite](https://www.microsoft.com/en-us/p/ubuntu/9nblggh4msv6?activetab=pivot:overviewtab) Linux distribution to install