# Variables
$downloadfolder = 'C:\packer\'

# Go to the Packer download folder
Set-Location $downloadfolder

# Show Packer Version
.\packer.exe -v

# Download Packer plugins
.\packer.exe init "${downloadfolder}windows.json.pkr.hcl"


# Packer build
.\packer.exe build -force -var-file="${downloadfolder}win10-std.auto.pkrvars.hcl" -var "winrm_username=administrator" -var "winrm_password=ThisisagoodPassword!" "${downloadfolder}windows.json.pkr.hcl"