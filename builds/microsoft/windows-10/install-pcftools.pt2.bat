@echo off

REM This script completes the installation of PCF Tools on Windows by sourcing binary releases from select Github repositories
REM @author Chris Phillipson

cd %HOMEDRIVE%%HOMEPATH
cd Downloads

REM We're cheating here a bit and relocating all binaries we download from Github into 
REM the C:\Windows\System32 folder so that they are automatically on the PATH

REM bosh-cli
wget https://github.com/cloudfoundry/bosh-cli/releases/download/v5.4.0/bosh-cli-5.4.0-windows-amd64.exe
ren bosh-cli-5.4.0-windows-amd64.exe bosh.exe
move /y bosh.exe %SystemRoot%\System32

REM credhub-cli
wget https://github.com/cloudfoundry-incubator/credhub-cli/releases/download/2.2.1/credhub-windows-2.2.1.tgz
7z x credhub-windows-2.2.1.tgz
7z x credhub-windows-2.2.1.tar
move /y credhub.exe %SystemRoot%\System32

REM om
wget https://github.com/pivotal-cf/om/releases/download/0.51.0/om-windows.exe
ren om-windows.exe om.exe
move /y om.exe %SystemRoot%\System32

REM pivnet-cli
wget https://github.com/pivotal-cf/pivnet-cli/releases/download/v0.0.55/pivnet-windows-amd64-0.0.55
ren pivnet-windows-amd64-0.0.55 pivnet.exe
move /y pivnet.exe %SystemRoot%\System32