# variables
$packer_win_variables = 'C:\Iac\github-ivo\packer\vsphere\winsrv2025\win2025-std.auto.pkrvars.hcl'
$packer_win_config = 'C:\Iac\github-ivo\packer\vsphere\winsrv2025\win2025-std-config.pkr.hcl'
$winconfig = 'vsphere-iso.winsrv2025'
$filepath = 'packer.exe'

# Packer Version
$arguments = "-v"
Start-Process -FilePath $filepath -ArgumentList $arguments -wait -NoNewWindow 

# Packer download plugins
 $arguments = "init -upgrade $packer_win_config"
 Start-Process -FilePath $filepath -Argumentlist $arguments -Wait -NoNewWindow

# Packer Format
 $arguments = "fmt -var-file=$packer_win_variables -only=$winconfig $packer_win_config"
 Start-Process -FilePath $filepath -ArgumentList $arguments -wait -NoNewWindow

# Packer Validate
 $arguments = "validate -var-file=$packer_win_variables -only=$winconfig $packer_win_config"
 Start-Process -FilePath $filepath -ArgumentList $arguments -wait -NoNewWindow

# Packer build	
$arguments = "build -force -var-file=$packer_win_variables -only=$winconfig $packer_win_config"
Start-Process -FilePath $filepath -ArgumentList $arguments -wait -NoNewWindow