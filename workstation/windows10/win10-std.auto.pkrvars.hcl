// VM config
vm_name					= 	"GI-W10-001" 
operating_system_vm 	= 	"windows9-64"
vm_firmware				=	"bios"
vm_cdrom_type			=	"ide"
vm_cpus					= 	"2"
vm_cores				= 	"1"
vm_memory				= 	"2048"
vm_disk_controller_type = 	"nvme"
vm_disk_size			= 	"32768"
vm_network_adapter_type =   "e1000e"
// Use the NAT Network
vm_network              =   "VMnet8"
vm_hardwareversion 		= 	"19"

// Removeable media
win10_iso				= 	"c:/iso/en-us_windows_10_business_editions_version_21h2_x64_dvd_ce067768.iso"
// In Powershell use the "get-filehash" command to find the checksum of the ISO
win10_iso_checksum      =   "1323FD1EF0CBFD4BF23FA56A6538FF69DD410AD49969983FEE3DF936A6C811C5"