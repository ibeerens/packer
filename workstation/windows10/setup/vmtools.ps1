$ErrorActionPreference = "SilentlyContinue"
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12

# Create folder c:\install
New-Item -Path 'c:\install' -ItemType Directory

# Download VMware Tools
# Check the latest release by using the following link: 
# https://packages.vmware.com/tools/releases/latest/windows/x64/
$url = "https://packages.vmware.com/tools/releases/latest/windows/x64/VMware-tools-12.0.5-19716617-x86_64.exe"
$output = "c:\install\VMware-tools-12.0.5-19716617-x86_64.exe"

Invoke-WebRequest -Uri $url -UseBasicParsing -OutFile $output

# Install VMware Tools
Start-Process -Wait `
    -FilePath $output `
    -ArgumentList '/S /v"/qn REBOOT=R" /l c:\windows\temp\vmware_tools_install.log'