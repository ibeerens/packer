# $ErrorActionPreference = "SilentlyContinue"
# Enable TLS 1.2
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
 
# Variables
$downloadfolder = 'C:\packer\win10\'
$github = 'https://github.com/ibeerens/Packer/archive/refs/heads/main.zip'
 
# Create Folder
$checkdir = Test-Path -Path $downloadfolder
if ($checkdir -eq $false){
    Write-Verbose "Creating '$downloadfolder' folder"
    New-Item -Path $downloadfolder -ItemType Directory | Out-Null
}
else {
    Write-Verbose "Folder '$downloadfolder' already exists."
}
 
# Go to the Packer download folder
Set-Location $downloadfolder
 
# Download Github files
Invoke-WebRequest -Uri $github -OutFile ${downloadfolder}packer.zip
Expand-Archive ${downloadfolder}packer.zip -DestinationPath $downloadfolder
# Remove the packer.zip
Remove-Item -Path ${downloadfolder}packer.zip 
 
# Create the folder structure
Move-Item ${downloadfolder}packer-main\workstation\windows10\setup -Destination $downloadfolder 
Move-Item ${downloadfolder}Packer-main\workstation\windows10\*.* -Destination $downloadfolder
# Remove the Github structure
Remove-Item -Path ${downloadfolder}Packer-main -Recurse -Confirm:$false -Force