# Install Evergreen

If (Get-PSRepository | Where-Object { $_.Name -eq "PSGallery" -and $_.InstallationPolicy -ne "Trusted" }) {
    Install-PackageProvider -Name "NuGet" -MinimumVersion 2.8.5.208 -Force
    Set-PSRepository -Name "PSGallery" -InstallationPolicy "Trusted"
}

Install-Module -Name Evergreen
Import-Module -Name Evergreen

# Find app
# Find-EvergreenApp

# Download Visual Studio code

$code = Get-EvergreenApp -Name MicrosoftVisualStudioCode | Where-Object { $_.Architecture -eq "x64" -and $_.Channel -eq "Stable" -and $_.Platform -eq "win32-x64-user" }
$codeInstaller = Split-Path -Path $code.Uri -Leaf
Invoke-WebRequest -Uri $code.Uri -OutFile "c:\temp" -UseBasicParsing



