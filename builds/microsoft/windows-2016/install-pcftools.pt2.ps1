<# Installs PCF Tools on Windows 2016 Server :: part 2 #>

[Net.ServicePointManager]::SecurityProtocol = "tls12, tls11, tls"
if (-not (test-path "$env:ProgramFiles\7-Zip\7z.exe")) { throw "$env:ProgramFiles\7-Zip\7z.exe needed" }
set-alias 7z "$env:ProgramFiles\7-Zip\7z.exe" 
$sysdir = "C:\Windows\System32"

<# cf #>
$url = "https://packages.cloudfoundry.org/stable?release=windows64-exe&version=6.42.0&source=github-rel"
$filename = "$PSScriptRoot\downloads\cf-cli_6.42.0_winx64.zip"
$start_time = Get-Date
Write-Output "Downloading cf-cli..."
Invoke-WebRequest -Uri $url -OutFile $filename -PassThru
Write-Output "Time taken: $((Get-Date).Subtract($start_time).Seconds) second(s)"
7z x $filename -o"$PSScriptRoot\downloads"
Write-Output "Installing cf-cli..."
Move-Item -Path "$PSScriptRoot\downloads\cf.exe" -Destination $sysdir

<# credhub #>
$url = "https://github.com/cloudfoundry-incubator/credhub-cli/releases/download/2.2.1/credhub-windows-2.2.1.tgz"
$filename = "$PSScriptRoot\downloads\credhub-cli.tgz"
$start_time = Get-Date
Write-Output "Downloading credhub-cli..."
Invoke-WebRequest -Uri $url -OutFile $filename -PassThru
Write-Output "Time taken: $((Get-Date).Subtract($start_time).Seconds) second(s)"
7z x $filename -o"$PSScriptRoot\downloads"
7z x "$PSScriptRoot\downloads\credhub-cli.tar" -o"$PSScriptRoot\downloads"
Write-Output "Installing credhub-cli..."
Move-Item -Path "$PSScriptRoot\downloads\credhub.exe" -Destination $sysdir

<# terraform #>
$url = "https://releases.hashicorp.com/terraform/0.11.11/terraform_0.11.11_windows_amd64.zip"
$filename = "$PSScriptRoot\downloads\terraform.zip"
$start_time = Get-Date
Write-Output "Downloading terraform..."
Invoke-WebRequest -Uri $url -OutFile $filename -PassThru
Write-Output "Time taken: $((Get-Date).Subtract($start_time).Seconds) second(s)"
7z x $filename -o"$PSScriptRoot\downloads"
Write-Output "Installing terraform..."
Move-Item -Path "$PSScriptRoot\downloads\terraform.exe" -Destination $sysdir

<# atom #>
$url = "https://github.com/atom/atom/releases/download/v1.34.0/AtomSetup-x64.exe"
$filename = "$PSScriptRoot\downloads\AtomSetup-x64.exe"
$start_time = Get-Date
Write-Output "Downloading atom..."
Invoke-WebRequest -Uri $url -OutFile $filename -PassThru
Write-Output "Time taken: $((Get-Date).Subtract($start_time).Seconds) second(s)"
Write-Output "Installing atom..."
$exeProcess = Start-Process -FilePath $filename -ArgumentList "/S","/v","/qn" -NoNewWindow -Wait -PassThru

<# Now we'll cleanup after ourselves #>
Write-Output "Deleting downloads directory..."
Remove-Item $PSScriptRoot\downloads -Force -Recurse
