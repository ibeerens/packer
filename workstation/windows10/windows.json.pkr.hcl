// https://www.packer.io/plugins/builders/vmware/iso

// Plugins
// Windows Update plug-in https://github.com/rgl/packer-plugin-windows-update
// https://github.com/hashicorp/packer-plugin-vmware/releases

packer {
  required_version = ">= 1.9.4"
  required_plugins {
    vmware = {
      version = ">= 1.0.7"
      source  = "github.com/hashicorp/vmware"
    }
  }

  required_plugins {
    windows-update = {
      version = ">= 0.14.3"
      source  = "github.com/rgl/windows-update"
    }
  }
}

variable "vm_name" {
  type        = string
  description = "Image name"
}

variable "operating_system_vm" {
  type        = string
  description = "OS Guest OS"
}

variable "vm_cores" {
  type        = string
  description = "Amount of cores"
}

variable "vm_cpus" {
  type        = string
  description = "amount of vCPUs"
}

variable "vm_disk_controller_type" {
  type        = string
  description = "Controller type"
}

variable "vm_disk_size" {
  type        = string
  description = "Harddisk size"
}

variable "vm_hardwareversion" {
  type        = string
  description = "VM hardware version"
}

variable "vm_firmware" {
  type        = string
  description = "The virtual machine firmware. (e.g. 'efi-secure'. 'efi', or 'bios')"
  default     = "efi-secure"
}

variable "vm_cdrom_type" {
  type        = string
  description = "The virtual machine CD-ROM type. (e.g. 'sata', or 'ide')"
  default     = "sata"
}

variable "vm_memory" {
  type        = string
  description = "VM Memory"
}

variable "vm_network_adapter_type" {
  type        = string
  description = "Networkadapter type"
}

variable "vm_network" {
  type        = string
  description = "Network"
}

variable "win10_iso" {
  type        = string
  description = "Windows 10 ISO location"
}

variable "win10_iso_checksum" {
  type        = string
  description = "Windows 10 ISO checksum"
}

variable "winrm_username" {
  type        = string
  description = "winrm username"
}

variable "winrm_password" {
  type        = string
  description = "winrm password"
}

source "vmware-iso" "windows10" {
  vm_name = var.vm_name
  // Hardware specs
  cpus                 = var.vm_cpus
  cores                = var.vm_cores
  memory               = var.vm_memory
  disk_size            = var.vm_disk_size
  disk_adapter_type    = var.vm_disk_controller_type
  network_adapter_type = var.vm_network_adapter_type
  network              = var.vm_network
  cdrom_adapter_type   = "ide"

  // Guest OS Windows 10
  guest_os_type = var.operating_system_vm
  version       = var.vm_hardwareversion
  iso_checksum  = var.win10_iso_checksum
  iso_url       = var.win10_iso
  floppy_files  = ["${path.root}/setup/"]
  floppy_label  = "floppy"

  // WinRM 
  insecure_connection = "true"
  communicator        = "winrm"
  winrm_port          = "5985"
  winrm_username      = var.winrm_username
  winrm_password      = var.winrm_password
  winrm_timeout       = "12h"
  shutdown_command    = "shutdown /s /t 10 /f"
}

build {
  sources = ["source.vmware-iso.windows10"]

  provisioner "windows-update" {
    pause_before    = "30s"
    search_criteria = "IsInstalled=0"
    filters = [
      "exclude:$_.Title -like '*Preview*'",
      "exclude:$_.Title -like '*Defender*'",
      "exclude:$_.InstallationBehavior.CanRequestUserInput",
      "include:$true"
    ]
    restart_timeout = "120m"
  }

  provisioner "windows-restart" {
    restart_check_command = "powershell -command \"& {Write-Output 'restarted.'}\""
    restart_timeout       = "20m"
  }

  provisioner "powershell" {
    elevated_user     = var.winrm_username
    elevated_password = var.winrm_password
    scripts           = ["./setup/disable-autolog.ps1"]
  }
}