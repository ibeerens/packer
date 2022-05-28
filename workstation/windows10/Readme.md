Packer VMware Workstation Windows 10

Packer build

packer build -force -var-file=C:\\Github\\Packer-VM-WS\\win10-std.auto.pkrvars.hcl -var "winrm\_username=administrator" -var "winrm\_password=ThisisagoodPassword!" Windows.json.pkr.hcl
