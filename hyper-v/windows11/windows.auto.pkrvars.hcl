// VM hardware specs
vm_name         = "GI-W11-001"
vm_cpus         = "2"
vm_memory       = "4096"
vm_disk_size    = "65536"
switch_name     = "Default Switch"
dynamic_memory  = "true"
secure_boot     = "true"
tpm             = "true"
generation      = "2" 
headless        = "false"
skip_export     = "false"
enable_virtualization_extensions = "false"
guest_additions_mode = "disable"

// Use the NAT Network
vm_network      = "VMnet8"

// Removeable media
win_iso         = "c:/iso/en-us_windows_11_business_editions_version_22h2_updated_june_2023_x64_dvd_69a45bf5.iso"
// In Powershell use the "get-filehash" command to find the checksum of the ISO
win_checksum    = "0AF18150D416D0449938203370DBC60EA5D78AFE0779E2732795982DB787BB03"