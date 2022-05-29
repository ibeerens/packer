# Packer VMware Workstation Windows 10

Steps

Packer build

```
packer build -force -var-file=C:\Github\Packer-VM-WS\win10-std.auto.pkrvars.hcl -var "winrm_username=administrator" -var "winrm_password=ThisisagoodPassword!" Windows.json.pkr.hcl
```
