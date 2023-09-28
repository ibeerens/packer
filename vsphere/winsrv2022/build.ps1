#variables
$packer_win10std_var = 'C:\Iac\Packer\VMware\winsrv2022wv\win2022-std.auto.pkrvars.hcl'
$packer_win10std_config = 'C:\Iac\Packer\VMware\winsrv2022wv\win2022-std-config.pkr.hcl'
$win10basic = 'vsphere-iso.winsrv2022'
$filepath = 'packer.exe'

# Packer Version
$arguments = "-v"
Start-Process -FilePath $filepath -ArgumentList $arguments -wait -NoNewWindow 

# Packer download plugins
 $arguments = "init -upgrade $packer_win10std_config"
 Start-Process -FilePath $filepath -Argumentlist $arguments -Wait -NoNewWindow

# Packer Format
 $arguments = "fmt -var-file=$packer_win10std_var -only=$win10basic $packer_win10std_config"
 Start-Process -FilePath $filepath -ArgumentList $arguments -wait -NoNewWindow

# Packer Validate
 $arguments = "validate -var-file=$packer_win10std_var -only=$win10basic $packer_win10std_config"
 Start-Process -FilePath $filepath -ArgumentList $arguments -wait -NoNewWindow    

# Packer build	
$arguments = "build -force -var-file=$packer_win10std_var -only=$win10basic $packer_win10std_config"
Start-Process -FilePath $filepath -ArgumentList $arguments -wait -NoNewWindow

