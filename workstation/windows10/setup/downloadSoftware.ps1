[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12

# Ivanti AM client
$url = "http://10.31.13.142:8081/ivanti/RES-ONE-Automation-Agent+(x64)-10.2.100.0.msi"
$output = "c:\install\RES-ONE-Automation-Agent+(x64)-10.2.100.0.msi"
$ProgressPreference = 'SilentlyContinue'
Invoke-WebRequest -Uri $url -UseBasicParsing -OutFile $output