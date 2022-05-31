$ErrorActionPreference = "SilentlyContinue"
# Enable TLS 1.2
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12

# Variables
$downloadfolder = 'C:\packer\'

# Create folder
New-Item -Path $downloadfolder -ItemType Directory

# Create Folder
$checkdir = Test-Path -Path $downloadfolder
if ($checkdir -eq $false){
    Write-Verbose "Creating '$downloadfolder' folder"
    New-Item -Path $downloadfolder -ItemType Directory | Out-Null
}
else {
    Write-Verbose "Folder '$downloadfolder' already exists."
}

# Download latest Packer
$product='packer'
$packurl = Invoke-WebRequest -Uri https://www.$product.io/downloads.html | Select-Object -Expand links | Where-Object href -match "//releases\.hashicorp\.com/$product/\d.*/$product_.*_windows_amd64\.zip$" | Select-Object -Expand href
$packdown = $packurl | Split-Path -Leaf
$packdownload = $downloadfolder + $packdown
$webclient = New-object -TypeName System.Net.WebClient
$webclient.DownloadFile($packurl, $packdownload)

# Unzip Packer
Expand-Archive $packdownload -DestinationPath $downloadfolder
# Remove *.zip
Remove-Item $packdownload

Set-Location $downloadfolder

# Packer Version
.\packer.exe -v

# Pabuilcker Init
.\packer.exe init c:\packer\Windows.json.pkr.hcl

# Packer
.\packer.exe build -force -var-file=C:\packer\win10-std.auto.pkrvars.hcl -var "winrm_username=administrator" -var "winrm_password=ThisisagoodPassword!" Windows.json.pkr.hcl