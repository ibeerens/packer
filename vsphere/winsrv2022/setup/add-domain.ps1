$domain = "lab.local"
$password = "VMware01!" | ConvertTo-SecureString -asPlainText -Force
$username = "$domain\administrator"
$strOU = "OU=GoldenImages,OU=VDI,DC=lab,DC=local"
$credential = New-Object System.Management.Automation.PSCredential($username,$password)
Add-Computer -DomainName $domain -OUPath $strOU -Credential $credential -Restart -force
