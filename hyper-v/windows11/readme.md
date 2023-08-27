# Create a Windows 11 VM in Hyper-V with Packer

Tested:
- Windows 11 Enterprise with the Hyper-V role enabled

Pre-requested:
- Download the Windows 11 ISO and save the ISO to the following location:  c:\iso
- Example: https://www.ivobeerens.nl/2021/05/19/quick-tip-download-the-latest-windows-10-iso-file/
- Get the hash of the ISO file with the Powershell get-filehash command

Steps:
- Change the windows-auto-pkvars.hcl file and adjust the variables
- Install the Windows Assessment and Deployment Kit (32-bits version). https://learn.microsoft.com/en-us/windows-hardware/get-started/adk-install#download-the-adk-for-windows-11-version-22h2
- Add the following location the the system path variable: 
    C:\Program Files (x86)\Windows Kits\10\Assessment and Deployment Kit\Deployment Tools\x86\Oscdimg
![Alt text](path.png)

