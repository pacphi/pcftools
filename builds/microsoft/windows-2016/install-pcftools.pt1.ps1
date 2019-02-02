<# Installs PCF Tools on Windows 2016 Server :: part 1 #>

Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::tls12

<# Import helper function for installing MSI #>
. $PSScriptRoot\install-msi.ps1

<# Create a directory that will be the home for all downloaded artifacts #>
Write-Output "Creating downloads directory..."
New-Item -ItemType directory -Path $PSScriptRoot\downloads


<# Now let's start to download and install products that are packaged in MSI format #>

<# aws-cli #>
$url = "https://s3.amazonaws.com/aws-cli/AWSCLI64PY3.msi"
$filename = "$PSScriptRoot\downloads\aws-cli.msi"
$start_time = Get-Date
Write-Output "Downloading aws-cli..."
Start-BitsTransfer -Source $url -Destination $filename
Write-Output "Time taken: $((Get-Date).Subtract($start_time).Seconds) second(s)"
Write-Output "Installing aws-cli..."
Install-Msi -Path $filename

<# azure-cli #>
$url = "https://aka.ms/installazurecliwindows"
$filename = "$PSScriptRoot\downloads\azure-cli.msi"
$start_time = Get-Date
Write-Output "Downloading azure-cli..."
Start-BitsTransfer -Source $url -Destination $filename
Write-Output "Time taken: $((Get-Date).Subtract($start_time).Seconds) second(s)"
Write-Output "Installing azure-cli..."
Install-Msi -Path $filename

<# google cloud sdk #>
$url = "https://dl.google.com/dl/cloudsdk/channels/rapid/GoogleCloudSDKInstaller.exe"
$filename = "$PSScriptRoot\downloads\gcloudsdk-installer.exe"
$start_time = Get-Date
Write-Output "Downloading gcloud-sdk..."
Start-BitsTransfer -Source $url -Destination $filename
Write-Output "Time taken: $((Get-Date).Subtract($start_time).Seconds) second(s)"
Write-Output "Installing gcloud-sdk..."
$exeProcess = Start-Process -FilePath $filename -ArgumentList "/S","/v","/qn" -NoNewWindow -Wait -PassThru

<# git #>
$url = "https://github.com/git-for-windows/git/releases/download/v2.20.1.windows.1/Git-2.20.1-64-bit.exe"
$filename = "$PSScriptRoot\downloads\git-installer.exe"
$start_time = Get-Date
Write-Output "Downloading git..."
Start-BitsTransfer -Source $url -Destination $filename
Write-Output "Time taken: $((Get-Date).Subtract($start_time).Seconds) second(s)"
Write-Output "Installing git..."
$exeProcess = Start-Process -FilePath $filename -ArgumentList "/S","/v","/qn" -NoNewWindow -Wait -PassThru

<# kubectl #>
Write-Output "Installing kubectl..."
Install-Script -Name install-kubectl -Scope CurrentUser -Force
install-kubectl.ps1 -DownloadLocation ./kubeadmin

<# firefox #>
$url = "https://download.mozilla.org/?product=firefox-latest-ssl&os=win64&lang=en-US"
$filename = "$PSScriptRoot\downloads\firefox-installer.exe"
$start_time = Get-Date
Write-Output "Downloading firefox..."
Start-BitsTransfer -Source $url -Destination $filename
Write-Output "Time taken: $((Get-Date).Subtract($start_time).Seconds) second(s)"
Write-Output "Installing firefox..."
$exeProcess = Start-Process -FilePath $filename -ArgumentList "/S","/v","/qn" -NoNewWindow -Wait -PassThru

<# go-lang #>
$url = "https://dl.google.com/go/go1.11.5.windows-amd64.msi"
$filename = "$PSScriptRoot\downloads\go-lang.msi"
$start_time = Get-Date
Write-Output "Downloading go-lang..."
Start-BitsTransfer -Source $url -Destination $filename
Write-Output "Time taken: $((Get-Date).Subtract($start_time).Seconds) second(s)"
Write-Output "Installing go-lang..."
Install-Msi -Path $filename

<# sourcetree #>
$url = "https://product-downloads.atlassian.com/software/sourcetree/windows/ga/SourceTreeSetup-3.0.15.exe"
$filename = "$PSScriptRoot\downloads\sourcetree-installer.exe"
$start_time = Get-Date
Write-Output "Downloading sourcetree..."
Start-BitsTransfer -Source $url -Destination $filename
Write-Output "Time taken: $((Get-Date).Subtract($start_time).Seconds) second(s)"
Write-Output "Installing sourcetree..."
$exeProcess = Start-Process -FilePath $filename -ArgumentList "/S","/v","/qn" -NoNewWindow -Wait -PassThru

<# vscode #>
$url = "https://go.microsoft.com/fwlink/?Linkid=852157"
$filename = "$PSScriptRoot\downloads\vscode-installer.exe"
$start_time = Get-Date
Write-Output "Downloading vscode..."
Start-BitsTransfer -Source $url -Destination $filename
Write-Output "Time taken: $((Get-Date).Subtract($start_time).Seconds) second(s)"
Write-Output "Installing vscode..."
$exeProcess = Start-Process -FilePath $filename -ArgumentList "/S","/v","/qn" -NoNewWindow -Wait -PassThru

<# 7zip #>
$url = "https://www.7-zip.org/a/7z1806-x64.msi"
$filename = "$PSScriptRoot\downloads\7z.msi"
$start_time = Get-Date
Write-Output "Downloading 7zip..."
Start-BitsTransfer -Source $url -Destination $filename
Write-Output "Time taken: $((Get-Date).Subtract($start_time).Seconds) second(s)"
Write-Output "Installing 7zip..."
Install-Msi -Path $filename


<# We're cheating here a bit and relocating all binaries we download from Github into #>
<# the C:\Windows\System32 folder so that they are automatically on the PATH #>

<# bosh #>
$url = "https://github.com/cloudfoundry/bosh-cli/releases/download/v5.4.0/bosh-cli-5.4.0-windows-amd64.exe"
$filename = "$PSScriptRoot\downloads\bosh.exe"
$start_time = Get-Date
Write-Output "Downloading bosh..."
Start-BitsTransfer -Source $url -Destination $filename
Write-Output "Time taken: $((Get-Date).Subtract($start_time).Seconds) second(s)"
Write-Output "Installing bosh..."
Move-Item -Path $filename -Destination [System.Environment]::SystemDirectory

<# fly #>
$url = "https://github.com/concourse/fly/releases/download/v4.2.2/fly_windows_amd64.exe"
$filename = "$PSScriptRoot\downloads\fly.exe"
$start_time = Get-Date
Write-Output "Downloading fly..."
Start-BitsTransfer -Source $url -Destination $filename
Write-Output "Time taken: $((Get-Date).Subtract($start_time).Seconds) second(s)"
Write-Output "Installing fly..."
Move-Item -Path $filename -Destination [System.Environment]::SystemDirectory

<# jq #>
$url = "https://github.com/stedolan/jq/releases/download/jq-1.6/jq-win64.exe"
$filename = "$PSScriptRoot\downloads\jq.exe"
$start_time = Get-Date
Write-Output "Downloading jq..."
Start-BitsTransfer -Source $url -Destination $filename
Write-Output "Time taken: $((Get-Date).Subtract($start_time).Seconds) second(s)"
Write-Output "Installing jq..."
Move-Item -Path $filename -Destination [System.Environment]::SystemDirectory

<# om #>
$url = "https://github.com/pivotal-cf/om/releases/download/0.51.0/om-windows.exe"
$filename = "$PSScriptRoot\downloads\om.exe"
$start_time = Get-Date
Write-Output "Downloading om..."
Start-BitsTransfer -Source $url -Destination $filename
Write-Output "Time taken: $((Get-Date).Subtract($start_time).Seconds) second(s)"
Write-Output "Installing om..."
Move-Item -Path $filename -Destination [System.Environment]::SystemDirectory

<# pivnet #>
$url = "https://github.com/pivotal-cf/pivnet-cli/releases/download/v0.0.55/pivnet-windows-amd64-0.0.55"
$filename = "$PSScriptRoot\downloads\pivnet.exe"
$start_time = Get-Date
Write-Output "Downloading pivnet..."
Start-BitsTransfer -Source $url -Destination $filename
Write-Output "Time taken: $((Get-Date).Subtract($start_time).Seconds) second(s)"
Write-Output "Installing pivnet..."
Move-Item -Path $filename -Destination [System.Environment]::SystemDirectory
