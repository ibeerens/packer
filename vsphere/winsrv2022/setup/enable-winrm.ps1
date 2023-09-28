$ErrorActionPreference = "Stop"

# Switch network connection to private mode
# Required for WinRM firewall rules
# $profile = Get-NetConnectionProfile
# Set-NetConnectionProfile -Name $profile.Name -NetworkCategory Private
# Disable Network discovery
# reg ADD HKLM\SYSTEM\CurrentControlSet\Control\Network\NewNetworkWindowOff /f

$profile = Get-NetConnectionProfile
While ($profile.Name -eq "Identifying..."){
    Start-Sleep -Seconds 10
    $profile = Get-NetConnectionProfile
}
Set-NetConnectionProfile -Name $profile.Name -NetworkCategory Private

# Enable WinRM service
winrm quickconfig -quiet
winrm set winrm/config/service '@{AllowUnencrypted="true"}'
winrm set winrm/config/service/auth '@{Basic="true"}'

# Make sure appropriate firewall port openings exist
cmd.exe /c netsh advfirewall firewall set rule group="remote administration" new enable=yes
cmd.exe /c netsh firewall add portopening TCP 5986 "Port 5986"

netsh advfirewall firewall add rule name="winRM HTTP" dir=in action=allow protocol=TCP localport=5985

# Restart WinRM, and set it so that it auto-launches on startup.
cmd.exe /c net stop winrm
cmd.exe /c sc config winrm start= auto
cmd.exe /c net start winrm