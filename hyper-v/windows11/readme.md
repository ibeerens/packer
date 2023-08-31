# Create a Windows 11 VM in Hyper-V with Packer

Tested on:
- Windows 11 Enterprise with the Hyper-V role enabled

Prerequisites:
- Make sure the Hyper-V role is enabled in Windows 10/11
- Install the Windows Assessment and Deployment Kit (32-bit version). https://learn.microsoft.com/en-us/windows-hardware/get-started/adk-install#download-the-adk-for-windows-11-version-22h2
- Add the following location the the system path variable: C:\Program Files (x86)\Windows Kits\10\Assessment and Deployment Kit\Deployment Tools\x86\Oscdimg
![Alt text](img/path.png)
- Download the Windows 11 ISO and save the ISO to the following location: c:\iso
  Example for downloading and creating a Windows 10/11 ISO: https://www.ivobeerens.nl/2021/05/19/quick-tip-download-the-latest-windows-10-iso-file/
- Run the _1.build.ps1 script. This script will download the latest version of Packer and create a Windows 11 VM with secure boot and TPM enabled.
![Alt text](img/install.png)
- Get the hash of the ISO file with the Powershell get-filehash command and change the variable in the windows-auto-pkvars.hcl file
- Change the other variables in the windows-auto-pkvars.hcl such as win_iso for the exact iso name
- Run the _2.run_packer.ps1 script. Packer will create a Windows 11 VM with the latest updates installed. 
- Import the Windows 11 in Hyper-V Manager:
  - Start the Hyper-V Manager
  - Select Import Virtual Machine
  - Browse to the created image folder C:\Temp\packer-main\hyper-v\windows11\output-windows11\
  - Select the VM
  - Register the VM in-place
  - Start the VM

![Alt text](img/win11.png)
