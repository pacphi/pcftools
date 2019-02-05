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
