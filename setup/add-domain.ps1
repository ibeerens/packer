$domain = "domain.org"
$password = "oFughwewewererererreepszdwj5UWrIad" | ConvertTo-SecureString -asPlainText -Force
$username = "$domain\sa_packer"
$strOU = "OU=goldenImages,DC=domain,DC=org"
$credential = New-Object System.Management.Automation.PSCredential($username,$password)
Add-Computer -DomainName $domain -Credential $credential -OUPath $strOU -Restart -Force
