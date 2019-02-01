@echo off

REM This script installs the majority of PCF Tools on Windows using a package manager
REM @author Chris Phillipson

REM Install Chocolatey package manager
@"%SystemRoot%\System32\WindowsPowerShell\v1.0\powershell.exe" -NoProfile -InputFormat None -ExecutionPolicy Bypass -Command "iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))" && SET "PATH=%PATH%;%ALLUSERSPROFILE%\chocolatey\bin"

REM Declare packages to install
set Arr[0]=awscli
set Arr[1]=azure-cli
set Arr[2]=cloudfoundry-cli
set Arr[3]=golang
set Arr[4]=jq
set Arr[5]=kubernetes-cli
set Arr[6]=git
set Arr[7]=python3
set Arr[8]=terraform
set Arr[9]=gcloudsdk
set Arr[10]=sourcetree
set Arr[11]=vscode
set Arr[12]=firefox
set Arr[13]=superputty
set Arr[14]=winscp
set Arr[15]=notepadplusplus
set Arr[16]=wget
set Arr[17]=curl
set Arr[18]=7zip
set Arr[19]=postman

set "x=0"

:SymLoop
if defined Arr[%x%] (
    call choco install %%Arr[%x%]%% -y
    set /a "x+=1"
    GOTO :SymLoop
)
