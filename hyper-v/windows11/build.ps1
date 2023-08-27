# Packer Run Script
# Enable TLS 1.2
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
# Speed up the invoke-webrequest command
$ProgressPreference = 'SilentlyContinue'

# Variables
$downloadfolder = "C:\temp\" # Packer location installed
$win11_downloadfolder = "C:\Temp\packer-main\hyper-v\windows11\"
$packer_config = "windows.json.pkr.hcl" #Packer config file
$packer_variable = "windows.auto.pkrvars.hcl" # Packer variable file
$winrm_admin = "admin" 
$winrm_password = "password"
$github = "https://github.com/ibeerens/packer/archive/refs/heads/main.zip"

# Check if the temp folder exist
If(!(test-path -PathType container $downloadfolder))
    {
      New-Item -ItemType Directory -Path $downloadfolder
}

# Go to the Packer download folder
Set-Location $downloadfolder

# Download Github files
Invoke-WebRequest -Uri $github -OutFile ${downloadfolder}packer.zip
Expand-Archive ${downloadfolder}packer.zip -DestinationPath $downloadfolder

# Remove zip file
Remove-Item -Path ${downloadfolder}packer.zip 

# Download the latest version of Packer
$packurl = Invoke-WebRequest -Uri https://developer.hashicorp.com/packer/downloads | Select-Object -Expand links | Where-Object href -match "//releases\.hashicorp\.com/$product/\d.*/$product_.*_windows_amd64\.zip$" | Select-Object -Expand href
$packdown = $packurl | Split-Path -Leaf
$packdownload = $downloadfolder + $packdown
Invoke-WebRequest $packurl -outfile $packdownload

# Unzip Packer 
Expand-Archive $packdownload -DestinationPath $win11_downloadfolder
# Remove the Packer ZIP file
Remove-Item $packdownload

# Go to the Packer download folder
Set-Location $win11_downloadfolder

# Show Packer Version
.\packer.exe -v

# Download Packer plugins
.\packer.exe init "${$win11_downloadfolder}${packer_config}"

# Packer Format configuration files (.pkr.hcl) and variable files (.pkrvars.hcl) are updated.
.\packer.exe fmt -var-file="${$win11_downloadfolder}{$packer_variable}" "${$win11_downloadfolder}${packer_config}"

# Packer build
.\packer.exe build -force -var-file="${$win11_downloadfolder}${packer_variable}" -var "winrm_username=$winrm_admin" -var "winrm_password=$winrm_password" "${$win11_downloadfolder}${packer_config}"
