# Variables
$downloadfolder = 'C:\packer1\'

# Go to the Packer download folder
Set-Location $downloadfolder

# Show Packer Version
.\packer.exe -v

# Download Packer plugins
.\packer.exe init c:\packer\Windows.json.pkr.hcl

# Packer build
.\packer.exe build -force -var-file=C:\packer\win10-std.auto.pkrvars.hcl -var "winrm_username=administrator" -var "winrm_password=ThisisagoodPassword!" windows.json.pkr.hcl