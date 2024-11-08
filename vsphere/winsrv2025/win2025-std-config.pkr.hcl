# Windows Server 2025 deployment
# Change log:
#   Ivo Beerens November 8, 2024, Creation

locals {
  SSHUser          = "administrator"
  SSHPass          = "P@ssword01!"
  vcenter_admin    = "administrator@vsphere.local"
  vcenter_password = "P@ssword01!"
  timestamp        = regex_replace(timestamp(), "[- TZ:01]", "")
  buildtime        = formatdate("DD-MM-YYYY hh:mm ZZZ", timestamp())
  manifest_date    = formatdate("DD-MM-YYYY hh:mm:ss", timestamp())
}

# Plug-ins

# Windows Update plug-in
# https://github.com/rgl/packer-plugin-windows-update

packer {
  required_version = ">= 1.9.0"
  required_plugins {
    vsphere = {
      version = ">= v1.4.2"
      source  = "github.com/hashicorp/vsphere"
    }
  }
  required_plugins {
    windows-update = {
      version = ">= 0.16.8"
      source  = "github.com/rgl/windows-update"
    }
  }
}

variable "host" {
  type        = string
  description = "VMware ESXi host"
}

variable "name" {
  type        = string
  description = "Golden Image name"
}

variable "operating_system_vm" {
  type        = string
  description = "OS Guest OS"
}

variable "vcenter_cluster" {
  type        = string
  description = "vCenter cluster name"
}

variable "vcenter_datastore" {
  type        = string
  description = "vSphere datastore"
}

variable "vcenter_host" {
  type        = string
  description = "vCenter Server"
}

variable "vcenter_network" {
  type        = string
  description = "Portgroup name"
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
  type        = list(string)
  description = "Controller type"
}

variable "vm_disk_size" {
  type        = string
  description = "Harddisk size"
}

variable "vm_disk_thin" {
  type        = string
  description = "Enable/Disable thin provisioning"
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

variable "common_remove_cdrom" {
  type        = bool
  description = "Remove the virtual CD-ROM(s)."
  default     = true
}

variable "vm_hotplug" {
  type        = string
  description = "Enable/Disable hotplug?"
}

variable "vm_logging" {
  type        = string
  description = "Enable/Disable VM Logging"
}

variable "vm_memory" {
  type        = string
  description = "VM Memory"
}

variable "vm_memory_reserve_all" {
  type        = string
  description = "Reserve all memory?"
}

variable "vm_network_card" {
  type        = string
  description = "Networkcard type"
}

variable "winsrv_iso" {
  type        = string
  description = "Windows Server ISO location"
}

variable "vm_vgpu" {
  type        = string
  description = "VM vGPU size"
}

variable "vm_boot_order" {
  type        = string
  description = "The boot order for virtual machines devices. (e.g. 'disk,cdrom')"
  default     = "disk,cdrom"
}

variable "vm_boot_wait" {
  type        = string
  description = "The time to wait before boot."
}

variable "vm_boot_command" {
  type        = list(string)
  description = "The virtual machine boot command."
  default     = []
}

variable "vm_shutdown_command" {
  type        = string
  description = "Command(s) for guest operating system shutdown."
}

variable "vm_tpm" {
  type    = string
  default = "false"
}

variable "create_snapshot" {
  type = string
}

variable "remove_cdrom" {
  type = string
}

variable "vbs_enabled" {
  type = string
}

variable "vvtd_enabled" {
  type = string
}

source "vsphere-iso" "winsrv2025" {
  CPUs     = var.vm_cpus
  notes    = "Built by HashiCorp Packer on ${local.buildtime}."
  RAM      = var.vm_memory
  firmware = var.vm_firmware
  # Enable nested hardware virtualization for the virtual machine.
  NestedHV        = true
  RAM_reserve_all = var.vm_memory_reserve_all
  cluster         = var.vcenter_cluster
  configuration_parameters = {
    "devices.hotplug"  = var.vm_hotplug
    "logging"          = var.vm_logging
    "svga.autodetect"  = "FALSE"
    "svga.numDisplays" = "2"
  }
  create_snapshot      = var.create_snapshot
  remove_cdrom         = var.remove_cdrom
  cpu_cores            = var.vm_cores
  datastore            = var.vcenter_datastore
  disk_controller_type = var.vm_disk_controller_type
  floppy_files         = ["${path.root}/setup/"]
  guest_os_type        = var.operating_system_vm
  host                 = var.host
  iso_paths            = [var.winsrv_iso]
  network_adapters {
    network      = var.vcenter_network
    network_card = var.vm_network_card
  }
  storage {
    disk_size             = var.vm_disk_size
    disk_thin_provisioned = var.vm_disk_thin
  }
  username       = local.vcenter_admin
  password       = local.vcenter_password
  vcenter_server = var.vcenter_host
  vm_name        = var.name
  vm_version     = var.vm_hardwareversion
  # CPU
  vTPM = var.vm_tpm
  # Enable VBS
  vbs_enabled  = var.vbs_enabled
  vvtd_enabled = var.vvtd_enabled
  # SSH
  communicator              = "ssh"
  ssh_username              = local.SSHUser
  ssh_password              = local.SSHPass
  ssh_timeout               = "2h"
  ssh_clear_authorized_keys = "true"

  // Boot and Provisioning Settings
  boot_order       = var.vm_boot_order
  boot_wait        = var.vm_boot_wait
  boot_command     = var.vm_boot_command
  shutdown_command = var.vm_shutdown_command
}

build {
  sources = ["source.vsphere-iso.winsrv2025"]

  provisioner "windows-update" {
    pause_before    = "30s"
    search_criteria = "IsInstalled=0"
    filters = [
      "exclude:$_.Title -like '*Preview*'",
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
    elevated_user     = local.SSHUser
    elevated_password = local.SSHPass
    inline = [
      "Winget install -e --id Microsoft.VisualStudioCode --accept-source-agreements --accept-package-agreements",
      "Winget upgrade --all"
    ]
  }

  provisioner "powershell" {
    elevated_user     = local.SSHUser
    elevated_password = local.SSHPass
    scripts = [
      "./setup/disable-autolog.ps1",
      "./setup/disable-ssh.ps1"
    ]
  }
}