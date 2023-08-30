$ErrorActionPreference = "SilentlyContinue"

# Switch network connection to private mode
# Required for WinRM firewall rules
$profile = Get-NetConnectionProfile
Set-NetConnectionProfile -Name $profile.Name -NetworkCategory Private
# Disable Network discovery
reg ADD HKLM\SYSTEM\CurrentControlSet\Control\Network\NewNetworkWindowOff /f
netsh advfirewall firewall set rule group="Network Discovery" new enable=No

# $profile = Get-NetConnectionProfile
# While ($profile.Name -eq "Identifying..."){
#    Start-Sleep -Seconds 10
#     $profile = Get-NetConnectionProfile
# }
Set-NetConnectionProfile -Name $profile.Name -NetworkCategory Private

# Enable Windows Remote Management in the Windows Firewall.
Write-Output "Enabling Windows Remote Management in the Windows Firewall..."
$NetworkListManager = [Activator]::CreateInstance([Type]::GetTypeFromCLSID([Guid]"{DCB00C01-570F-4A9B-8D69-199FDBA5723B}"))
$Connections = $NetworkListManager.GetNetworkConnections()
$Connections | ForEach-Object { $_.GetNetwork().SetCategory(1) }

# Set the Windows Remote Management configuration.
Write-Output "Setting the Windows Remote Management configuration..."
Enable-PSRemoting -Force
winrm quickconfig -q
winrm quickconfig -transport:http
winrm set winrm/config '@{MaxTimeoutms="1800000"}'
winrm set winrm/config/winrs '@{MaxMemoryPerShellMB="800"}'
winrm set winrm/config/service '@{AllowUnencrypted="true"}'
winrm set winrm/config/service/auth '@{Basic="true"}'
winrm set winrm/config/client/auth '@{Basic="true"}'
winrm set winrm/config/listener?Address=*+Transport=HTTP '@{Port="5985"}'

# Allow Windows Remote Management in the Windows Firewall.
Write-Output "Allowing Windows Remote Management in the Windows Firewall..."
netsh advfirewall firewall set rule group="Windows Remote Administration" new enable=yes
netsh advfirewall firewall set rule name="Windows Remote Management (HTTP-In)" new enable=yes action=allow

# Restart Windows Remote Management service.
Write-Output "Restarting Windows Remote Management service..."
Set-Service winrm -startuptype "auto"
Restart-Service winrm