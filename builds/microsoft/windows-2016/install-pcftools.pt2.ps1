<# Installs PCF Tools on Windows 2016 Server :: part 2 #>


<# cf #>
$url = "https://cli.run.pivotal.io/stable?release=windows64&source=github"
$filename = "$PSScriptRoot\downloads\cfcli-installer.zip"
$start_time = Get-Date
Write-Output "Downloading cf-cli..."
Start-BitsTransfer -Source $url -Destination $filename
Write-Output "Time taken: $((Get-Date).Subtract($start_time).Seconds) second(s)"
Start-Process -FilePath "7z x cfcli-installer.zip"
Write-Output "Installing cf-cli..."
$f = "$PSScriptRoot\downloads\cf_installer.exe"
$exeProcess = Start-Process -FilePath $f -ArgumentList "/S","/v","/qn" -NoNewWindow -Wait -PassThru

<# credhub #>
$url = "https://github.com/cloudfoundry-incubator/credhub-cli/releases/download/2.2.1/credhub-windows-2.2.1.tgz"
$filename = "$PSScriptRoot\downloads\credhub-cli.tgz"
$start_time = Get-Date
Write-Output "Downloading credhub-cli..."
Start-BitsTransfer -Source $url -Destination $filename
Write-Output "Time taken: $((Get-Date).Subtract($start_time).Seconds) second(s)"
Start-Process -FilePath "7z x credhub-cli.tgz"
Start-Process -FilePath "7z x credhub-cli.tar"
Write-Output "Installing credhub-cli..."
Move-Item -Path "$PSScriptRoot\downloads\credhub.exe" -Destination [System.Environment]::SystemDirectory

<# terraform #>
$url = "https://releases.hashicorp.com/terraform/0.11.11/terraform_0.11.11_windows_amd64.zip"
$filename = "$PSScriptRoot\downloads\terraform.zip"
$start_time = Get-Date
Write-Output "Downloading terraform..."
Start-BitsTransfer -Source $url -Destination $filename
Write-Output "Time taken: $((Get-Date).Subtract($start_time).Seconds) second(s)"
Start-Process -FilePath "7z x terraform.zip"
Write-Output "Installing terraform..."
Move-Item -Path "$PSScriptRoot\downloads\terraform.exe" -Destination [System.Environment]::SystemDirectory

<# Now we'll cleanup after ourselves #>
Write-Output "Deleting downloads directory..."
Remove-Item $PSScriptRoot\downloads -Force -Recurse
