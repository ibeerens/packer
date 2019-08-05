# Onedrive Kill
taskkill.exe /F /IM "OneDrive.exe"

# Copy Horizon client
#$url = "http://192.168.13.131:81/VMware-Horizon-Agent-x86_64-7.9.0-13938590.exe"
$url = "https://dl.dropboxusercontent.com/s/fd7k5z80dfb3b2t/VMware-Horizon-Agent-x86_64-7.9.0-13938590.exe"
$output = "c:\install\VMware-Horizon-Agent-x86_64-7.9.0-13938590.exe"
$ProgressPreference = 'SilentlyContinue'
Invoke-WebRequest -Uri $url -UseBasicParsing -OutFile $output
sleep 2

# Install Horizon Agent
# https://kb.vmware.com/s/article/1019862
write-host "Install Horizon Agent"
Start-Process -FilePath "c:\install\VMware-Horizon-Agent-x86_64-7.9.0-13938590.exe" -ArgumentList "/s /v /qn VDM_VC_MANAGED_AGENT=1 VDM_FLASH_URL_REDIRECTION=1 ADDLOCAL=ALL REBOOT=Reallysuppress" -Wait
# InstallMSI -MSIName "VMware Horizon View Agent" -MSIArgs "/qb- REBOOT=ReallySuppress VDM_FLASH_URL_REDIRECTION=1 RDP_CHOICE=1 ADDLOCAL=Core,USB,NGVC,RTAV,ClientDriveRedirection,FlashURLRedirection,FLASHMMR,ThinPrint,V4V,VmwVaudio,TSMMR,RDP,VMWMediaProviderProxy"
sleep 2

# Disable Hybernate
powercfg.exe /h off

# Rename PC
Rename-Computer -NewName w10-1809tmplt