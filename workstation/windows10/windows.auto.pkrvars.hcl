// VM config
vm_name                 = "GI-W10-001"
operating_system_vm     = "windows9-64"
vm_firmware             = "bios"
vm_cdrom_type           = "ide"
vm_cpus                 = "2"
vm_cores                = "1"
vm_memory               = "4096"
vm_disk_controller_type = "nvme"
vm_disk_size            = "65536"
vm_network_adapter_type = "e1000e"
// Use the NAT Network
vm_network         = "VMnet8"
vm_hardwareversion = "19"

// Removeable media
win10_iso = "c:/iso/feb2024/en-us_windows_10_business_editions_version_22h2_updated_feb_2024_x64_dvd_732d1707.iso"
// In Powershell use the "get-filehash" command to find the checksum of the ISO
win10_iso_checksum = "E433ADA123A50DBDEE946FEA5B34BD40038891F5C0ADBB1D72CACF5A633AD391"