<#
  Description: Download the latest version of Hashicorp Packer version and create a Windows 11 VM in Hyper-V
  Created by: Ivo Beerens www.ivobeerens.nl
  Change Log: Augustus 29, 2023 v1.0 Final version by Ivo Beerens
#>

# Enable TLS 1.2
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
# Speed up the invoke-webrequest command
$ProgressPreference = 'SilentlyContinue'

# Variables
$downloadfolder = "C:\temp\" # Packer location installed
$win10_downloadfolder = "C:\Temp\packer-main\workstation\windows10\"
$packer_config = "windows.json.pkr.hcl" #Packer config file
$packer_variable = "windows.auto.pkrvars.hcl" # Packer variable file
$github = "https://github.com/ibeerens/packer/archive/refs/heads/main.zip"
$product = "packer"
$packer_uri = "https://developer.hashicorp.com/packer/downloads"

# Check if the temp folder exist
If(!(test-path -PathType container $downloadfolder))
    {
      New-Item -ItemType Directory -Path $downloadfolder
}

# Go to the Packer download folder
Set-Location $downloadfolder

# Download Github files
Invoke-WebRequest -Uri $github -OutFile ${downloadfolder}packer.zip
Expand-Archive ${downloadfolder}packer.zip -DestinationPath $downloadfolder -Force

# Remove zip file
Remove-Item -Path ${downloadfolder}packer.zip 

# Download the latest version of Packer
$packurl = Invoke-WebRequest -Uri $packer_uri| Select-Object -Expand links | Where-Object href -match "//releases\.hashicorp\.com/$product/\d.*/$product_.*_windows_amd64\.zip$" | Select-Object -Expand href
$packdown = $packurl | Split-Path -Leaf
$packdownload = $downloadfolder + $packdown
Invoke-WebRequest $packurl -outfile $packdownload

# Unzip Packer 
Expand-Archive $packdownload -DestinationPath $win10_downloadfolder -Force
# Remove the Packer ZIP file
Remove-Item $packdownload

# Go to the Packer download folder
Set-Location $win10_downloadfolder

# Show Packer Version
.\packer.exe -v

# Download Packer plugins
.\packer.exe init "${$win10_downloadfolder}${packer_config}"

# Packer Format configuration files (.pkr.hcl) and variable files (.pkrvars.hcl) are updated.
.\packer.exe fmt -var-file="${$win10_downloadfolder}{$packer_variable}" "${$win10_downloadfolder}${packer_config}"

# Packer validate
.\packer.exe validate .

# Packer build
# .\packer.exe build -force -var-file="${$win11_downloadfolder}${packer_variable}" "${$win11_downloadfolder}${packer_config}"
.\packer.exe build -force -var-file="${win10_downloadfolder}${packer_variable}" -var "winrm_username=administrator" -var "winrm_password=ThisisagoodPassword!" "${win10_downloadfolder}${packer_config}"
