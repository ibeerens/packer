# Onedrive uninstall
taskkill.exe /F /IM "OneDrive.exe"
Sleep 5
C:\Windows\SysWOW64\OneDriveSetup.exe /uninstall
Sleep 15
rm -Recurse -Force -ErrorAction SilentlyContinue "$env:localappdata\Microsoft\OneDrive"
rm -Recurse -Force -ErrorAction SilentlyContinue "$env:programdata\Microsoft OneDrive"
rm -Recurse -Force -ErrorAction SilentlyContinue "$env:userprofile\OneDrive"
rm -Recurse -Force -ErrorAction SilentlyContinue "C:\OneDriveTemp"

echo "Disable OneDrive via Group Policies"
mkdir -Force "HKLM:\SOFTWARE\Wow6432Node\Policies\Microsoft\Windows\OneDrive"
sp "HKLM:\SOFTWARE\Wow6432Node\Policies\Microsoft\Windows\OneDrive" "DisableFileSyncNGSC" 1

reg load "hku\Default" "C:\Users\Default\NTUSER.DAT"
reg delete HKU\default\software\Microsoft\Windows\CurrentVersion\Run /v OneDriveSetup /f 
reg unload "hku\Default"

echo "Removing startmenu entry"
rm -Force -ErrorAction SilentlyContinue "$env:userprofile\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\OneDrive.lnk"