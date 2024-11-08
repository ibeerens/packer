# vCenter Server / ESXi 
vcenter_host            = "vcsa03.lab.local"
vcenter_cluster         = "CL-MGNT"
vcenter_datastore       = "VMFS-LOC-ESXI02-1"
host                    = "192.168.11.11"
vcenter_network         = "vlan13-srv"

# Hardware specifications
name                    = "winsrv2025-01"
operating_system_vm     = "windows2022srvNext_64Guest" # windows2022srvNext_64Guest Microsoft Windows Server 2025 (64-bit)
vm_firmware             = "efi-secure"
vm_cdrom_type           = "sata"
vm_cpus                 = "2"
vm_cores                = "1"
vbs_enabled             = "true"
vvtd_enabled            = "true"
vm_memory               = "4096"
vm_memory_reserve_all   = "false"
vm_disk_controller_type = ["pvscsi"]
vm_disk_size            = "102400"
vm_disk_thin            = "true"
# VMware Hardware versions https://kb.vmware.com/s/article/1003746
vm_hardwareversion      = "21" # VMware ESXi 8
vm_hotplug              = "FALSE"
vm_logging              = "FALSE"
vm_network_card         = "vmxnet3"
vm_vgpu                 = "none"
common_remove_cdrom     = "true"
create_snapshot         = "false"
remove_cdrom            = "true"
# Boot Settings
vm_boot_order           = "disk,cdrom"
vm_boot_wait            = "3s"
vm_boot_command         = ["<spacebar><spacebar>"]
vm_shutdown_command     = "shutdown /s /t 10 /f /d p:4:1 /c \"Shutdown by Packer\""

# ISO location
winsrv_iso              = "[VMFS-LOC-ESXI02-1] iso/en-us_windows_server_2025_x64_dvd_b7ec10f3.iso"