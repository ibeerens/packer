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
// vm_network      = "VMnet8"

// WinRM 
winrm_username  = "admin"
winrm_password  = "password"

// Removeable media
win_iso         = "c:/iso/windows11-us-ent.iso"
// In Powershell use the "get-filehash" command to find the checksum of the ISO
win_checksum    = "B4FB9A56E1A7B940B97664CE26E2B27E467A1E0F0058D8BE7781920D8E6A6FF5"