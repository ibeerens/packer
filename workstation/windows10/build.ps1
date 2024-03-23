<#
  Description: Create VM
  Created by: Ivo Beerens www.ivobeerens.nl
  Change Log: 
      March 23, 2024 Adjusting parameters
      Augustus 29, 2023 v1.0 Final version by Ivo Beerens
#>

# Enable TLS 1.2
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
# Speed up the invoke-webrequest command
$ProgressPreference = 'SilentlyContinue'

# Variables
$downloadfolder = 'C:\packer\win10\'
$packer_config = "windows.json.pkr.hcl" #Packer config file
$packer_variable = "windows.auto.pkrvars.hcl" # Packer variable file

# Show Packer Version
packer.exe -v

# Download Packer plugins
packer.exe init "$downloadfolder$packer_config"

# Packer Format configuration files (.pkr.hcl) and variable files (.pkrvars.hcl) are updated.
packer.exe fmt -var-file="$downloadfolder$packer_variable" "$downloadfolder$packer_config"

# Packer validate
# packer.exe validate .

# Packer build
# .\packer.exe build -force -var-file="${$win11_downloadfolder}${packer_variable}" "${$win11_downloadfolder}${packer_config}"
packer.exe build -force -var-file="$downloadfolder$packer_variable" -var "winrm_username=administrator" -var "winrm_password=ThisisagoodPassword!" "$downloadfolder$packer_config"