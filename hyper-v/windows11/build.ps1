# Enable TLS 1.2
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12

# Packer Run Script
$ProgressPreference = 'SilentlyContinue'

# Variables
$downloadfolder = 'C:\temp\packer-hyper-v\' # Packer location installed
$packer_config = "windows.json.pkr.hcl" #Packer config file
$packer_variable = "windows.auto.pkrvars.hcl" # Packer variable file
$winrm_admin = "admin" 
$winrm_password = "password"
$github = 'https://github.com/ibeerens/Packer/archive/refs/heads/main.zip'

# Check if download folder exist
If(!(test-path -PathType container $downloadfolder))
    {
      New-Item -ItemType Directory -Path $downloadfolder
}

# Go to the Packer download folder
Set-Location $downloadfolder

# Download the latest version of Packer
$packurl = Invoke-WebRequest -Uri https://developer.hashicorp.com/packer/downloads | Select-Object -Expand links | Where-Object href -match "//releases\.hashicorp\.com/$product/\d.*/$product_.*_windows_amd64\.zip$" | Select-Object -Expand href
$packdown = $packurl | Split-Path -Leaf
$packdownload = $downloadfolder + $packdown
Invoke-WebRequest $packurl -outfile $packdownload

# Unzip Packer 
Expand-Archive $packdownload -DestinationPath $downloadfolder
# Remove the Packer ZIP file
Remove-Item $packdownload

# Download Github files

Invoke-WebRequest -Uri "https://raw.githubusercontent.com/ibeerens/packer/main/hyper-v/windows11/readme.md" -OutFile $downloadfolder

Invoke-WebRequest -Uri $github -OutFile ${downloadfolder}packer.zip
Expand-Archive ${downloadfolder}packer.zip -DestinationPath $downloadfolder
# Remove the packer.zip
Remove-Item -Path ${downloadfolder}packer.zip 

# Show Packer Version
.\packer.exe -v

# Download Packer plugins
.\packer.exe init "${downloadfolder}${packer_config}"

# Packer Format configuration files (.pkr.hcl) and variable files (.pkrvars.hcl) are updated.
.\packer.exe fmt -var-file="${downloadfolder}{$packer_variable}" "${downloadfolder}${packer_config}"

# Packer build
# .\packer.exe build -force -var-file="${downloadfolder}${packer_variable}" -var "winrm_username=Admin" -var "winrm_password=password" "${downloadfolder}${packer_config}"
.\packer.exe build -force -var-file="${downloadfolder}${packer_variable}" -var "winrm_username=$winrm_admin" -var "winrm_password=$winrm_password" "${downloadfolder}${packer_config}"
