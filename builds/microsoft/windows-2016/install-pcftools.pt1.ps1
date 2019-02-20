<# Installs PCF Tools on Windows 2016 Server :: part 1 #>

[Net.ServicePointManager]::SecurityProtocol = "tls12, tls11, tls"
$sysdir = "C:\Windows\System32"
Install-Module -Name Carbon -Force
Install-Module -Name MSI -Force

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
Install-MSIProduct -Path $filename -PassThru -Force

<# azure-cli #>
$url = "https://aka.ms/installazurecliwindows"
$filename = "$PSScriptRoot\downloads\azure-cli.msi"
$start_time = Get-Date
Write-Output "Downloading azure-cli..."
Start-BitsTransfer -Source $url -Destination $filename
Write-Output "Time taken: $((Get-Date).Subtract($start_time).Seconds) second(s)"
Write-Output "Installing azure-cli..."
Install-MSIProduct -Path $filename -PassThru -Force

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
$url = "https://raw.githubusercontent.com/tomlarse/Install-Git/master/Install-Git/Install-Git.ps1"
$filename = "$PSScriptRoot\downloads\Install-Git.ps1"
Write-Output "Fetching install script for git..."
Invoke-WebRequest -Uri $url -OutFile $filename -PassThru
Write-Output "Installing git..."
& $filename

<# kubectl #>
$Downloadlocation = $sysdir
$uri = "https://kubernetes.io/docs/tasks/tools/install-kubectl/"
Write-Host -ForegroundColor White "==>Getting download link from $uri"
$req = Invoke-WebRequest -UseBasicParsing -Uri $uri
try
    {
        Write-Host -ForegroundColor White "==>analyzing Downloadlink"
        $downloadlink = ($req.Links | where href -Match "kubectl.exe").href
    }
catch
    {
        Write-Warning "Error Parsing Link"
        Break
    }
Write-Host -ForegroundColor White "==>starting Download from $downloadlink using Bitstransfer"
Start-BitsTransfer $downloadlink -DisplayName "Getting KubeCTL from $downloadlink" -Destination $Downloadlocation
$Downloadfile = Join-Path $Downloadlocation "kubectl.exe"
Unblock-File $Downloadfile
Write-Host -ForegroundColor White "==>starting '$Downloadfile version'"
.$Downloadfile version
$Kube_Local = New-Item -ItemType directory "$($HOME)/.kube" -force
Write-Host
Write-Host -ForegroundColor Magenta "You can now start kubectl from $Downloadfile copy your remote kubernetes cluster information to $($Kube_Local.fullname)/config "

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
Install-MSIProduct -Path $filename -PassThru -Force

<# .net framework 4.7.x #>
$url = "http://go.microsoft.com/fwlink/?linkid=863265"
$filename = "$PSScriptRoot\downloads\NDP472-KB4054530-x86-x64-AllOS-ENU.exe"
$start_time = Get-Date
Write-Output "Downloading .Net Framework 4.7.2..."
Start-BitsTransfer -Source $url -Destination $filename
Write-Output "Time taken: $((Get-Date).Subtract($start_time).Seconds) second(s)"
Write-Output "Installing .Net Framework 4.7.2..."
$exeProcess = Start-Process -FilePath $filename -ArgumentList "/q /norestart" -Wait -Verb RunAs 

<# nodejs #>
$url = "https://nodejs.org/dist/v10.15.1/node-v10.15.1-x64.msi"
$filename = "$PSScriptRoot\downloads\node.msi"
$start_time = Get-Date
Write-Output "Downloading nodejs..."
Start-BitsTransfer -Source $url -Destination $filename
Write-Output "Time taken: $((Get-Date).Subtract($start_time).Seconds) second(s)"
Write-Output "Installing nodejs..."
Install-MSIProduct -Path $filename -PassThru -Force

<# python #>
$url = "https://www.python.org/ftp/python/3.7.0/python-3.7.0-amd64.exe"
$filename = "$PSScriptRoot\downloads\python370-installer.exe"
$start_time = Get-Date
Write-Output "Downloading python..."
Start-BitsTransfer -Source $url -Destination $filename
Write-Output "Time taken: $((Get-Date).Subtract($start_time).Seconds) second(s)"
Write-Output "Installing python..."
$exeProcess = Start-Process -FilePath $filename -ArgumentList "/S","/v","/qn" -NoNewWindow -Wait -PassThru

<# 7zip #>
$url = "https://www.7-zip.org/a/7z1806-x64.msi"
$filename = "$PSScriptRoot\downloads\7z.msi"
$start_time = Get-Date
Write-Output "Downloading 7zip..."
Start-BitsTransfer -Source $url -Destination $filename
Write-Output "Time taken: $((Get-Date).Subtract($start_time).Seconds) second(s)"
Write-Output "Installing 7zip..."
Install-MSIProduct -Path $filename -PassThru -Force

$url = "https://winscp.net/download/WinSCP-5.13.7-Setup.exe"
$filename = "$PSScriptRoot\downloads\winscp-installer.exe"
$start_time = Get-Date
Write-Output "Downloading winscp..."
Start-BitsTransfer -Source $url -Destination $filename
Write-Output "Time taken: $((Get-Date).Subtract($start_time).Seconds) second(s)"
Write-Output "Installing winscp..."
$exeProcess = Start-Process -FilePath $filename -ArgumentList "/S","/v","/qn" -NoNewWindow -Wait -PassThru


<# We're cheating here a bit and relocating all binaries we download from Github into #>
<# the C:\Windows\System32 folder so that they are automatically on the PATH #>

<# bosh #>
$url = "https://github.com/cloudfoundry/bosh-cli/releases/download/v5.4.0/bosh-cli-5.4.0-windows-amd64.exe"
$filename = "$PSScriptRoot\downloads\bosh.exe"
$start_time = Get-Date
Write-Output "Downloading bosh..."
Invoke-WebRequest -Uri $url -OutFile $filename -PassThru
Write-Output "Time taken: $((Get-Date).Subtract($start_time).Seconds) second(s)"
Write-Output "Installing bosh..."
Move-Item -Path $filename -Destination $sysdir

<# fly #>
$url = "https://github.com/concourse/fly/releases/download/v4.2.2/fly_windows_amd64.exe"
$filename = "$PSScriptRoot\downloads\fly.exe"
$start_time = Get-Date
Write-Output "Downloading fly..."
Invoke-WebRequest -Uri $url -OutFile $filename -PassThru
Write-Output "Time taken: $((Get-Date).Subtract($start_time).Seconds) second(s)"
Write-Output "Installing fly..."
Move-Item -Path $filename -Destination $sysdir

<# jq #>
$url = "https://github.com/stedolan/jq/releases/download/jq-1.6/jq-win64.exe"
$filename = "$PSScriptRoot\downloads\jq.exe"
$start_time = Get-Date
Write-Output "Downloading jq..."
Invoke-WebRequest -Uri $url -OutFile $filename -PassThru
Write-Output "Time taken: $((Get-Date).Subtract($start_time).Seconds) second(s)"
Write-Output "Installing jq..."
Move-Item -Path $filename -Destination $sysdir

<# mc #>
$url = "https://dl.minio.io/client/mc/release/windows-amd64/mc.exe"
$filename = "$PSScriptRoot\downloads\mc.exe"
$start_time = Get-Date
Write-Output "Downloading mc..."
Invoke-WebRequest -Uri $url -OutFile $filename -PassThru
Write-Output "Time taken: $((Get-Date).Subtract($start_time).Seconds) second(s)"
Write-Output "Installing mc..."
Move-Item -Path $filename -Destination $sysdir

<# om #>
$url = "https://github.com/pivotal-cf/om/releases/download/0.51.0/om-windows.exe"
$filename = "$PSScriptRoot\downloads\om.exe"
$start_time = Get-Date
Write-Output "Downloading om..."
Invoke-WebRequest -Uri $url -OutFile $filename -PassThru
Write-Output "Time taken: $((Get-Date).Subtract($start_time).Seconds) second(s)"
Write-Output "Installing om..."
Move-Item -Path $filename -Destination $sysdir

<# pivnet #>
$url = "https://github.com/pivotal-cf/pivnet-cli/releases/download/v0.0.55/pivnet-windows-amd64-0.0.55"
$filename = "$PSScriptRoot\downloads\pivnet.exe"
$start_time = Get-Date
Write-Output "Downloading pivnet..."
Invoke-WebRequest -Uri $url -OutFile $filename -PassThru
Write-Output "Time taken: $((Get-Date).Subtract($start_time).Seconds) second(s)"
Write-Output "Installing pivnet..."
Move-Item -Path $filename -Destination $sysdir
