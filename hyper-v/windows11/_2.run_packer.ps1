# Show Packer Version
.\packer.exe -v

# Download Packer plugins
.\packer.exe init "${$win11_downloadfolder}${packer_config}"

# Packer Format configuration files (.pkr.hcl) and variable files (.pkrvars.hcl) are updated.
.\packer.exe fmt -var-file="${$win11_downloadfolder}{$packer_variable}" "${$win11_downloadfolder}${packer_config}"

# Packer validate
.\packer.exe validate .

# Packer build
# .\packer.exe build -force -var-file="${$win11_downloadfolder}${packer_variable}" -var "winrm_username=$env:winrm_admin" -var "winrm_password=$env:winrm_password" "${$win11_downloadfolder}${packer_config}"
.\packer.exe build -force -var-file="${$win11_downloadfolder}${packer_variable}" "${$win11_downloadfolder}${packer_config}"