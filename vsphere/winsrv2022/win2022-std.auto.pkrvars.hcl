// vCenter Server
vcenter_host            = "vcsa03.lab.local"
vcenter_cluster         = "CL-MGNT"
vcenter_datastore       = "VMFS-LOC-ESXI02-1"
host                    = "192.168.11.11"
vcenter_network         = "vlan13-srv"

// Hardware specifications
name                    = "winsrv2022-01" 
operating_system_vm     = "windows2019srv_64Guest"
vm_firmware             = "efi-secure"
vm_cdrom_type           = "sata"
vm_cpus                 = "2"
vm_cores                = "1"
vm_memory               = "4096"
vm_memory_reserve_all   = "false"
vm_disk_controller_type = ["pvscsi"]
vm_disk_size            = "102400"
vm_disk_thin            = "true"
# VMware Hardware versions https://kb.vmware.com/s/article/1003746
vm_hardwareversion  = "20"
vm_hotplug          = "FALSE"
vm_logging          = "FALSE"
vm_network_card     = "vmxnet3"
vm_vgpu             = "none"
common_remove_cdrom = "true"

// Boot Settings
vm_boot_order       = "disk,cdrom"
vm_boot_wait        = "3s"
vm_boot_command     = ["<spacebar><spacebar>"]
vm_shutdown_command = "shutdown /s /t 10 /f /d p:4:1 /c \"Shutdown by Packer\""

// Latest VMware tools https://packages.vmware.com/tools/releases/latest/windows/x64/ 
vmware_tools_iso = "[VMFS-LOC-ESXI02-1] iso/VMware-tools-windows-12.2.5-21855600.iso"
# Find File hash by using the Get-FileHash PS command
winsrv_iso          = "[VMFS-LOC-ESXI02-1] iso/en-us_windows_server_2022_updated_may_2023_x64_dvd_7eb3ad7c.iso"
# winsrv_iso_checksum = "FE76026E6A6FDA954D5D2CD110A03428A73D5B2294AACA5C49936304A938494B"
floppy_img_path     = "[VMFS-LOC-ESXI02-1] iso/pvscsi-Windows8.flp"