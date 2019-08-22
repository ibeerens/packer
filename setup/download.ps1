[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12

# Download Horizon Client
$url = "https://www.ivobeerens.nl/VMware-Horizon-Agent-x86_64-7.9.0-13938590.msi"
$output = "c:\install\VMware-Horizon-Agent-x86_64-7.9.0-13938590.exe"
$ProgressPreference = 'SilentlyContinue'
Invoke-WebRequest -Uri $url -UseBasicParsing -OutFile $output

# Download UEM Agent
$url = "https://www.ivobeerens.nl/VMware User Environment Manager 9.8 x64.msi"
$output = "c:\install\VMware User Environment Manager 9.8 x64.msi"
$ProgressPreference = 'SilentlyContinue'
Invoke-WebRequest -Uri $url -UseBasicParsing -OutFile $output

# Download App Volumes Agent
$url = "https://www.ivobeerens.nl/App Volumes Agent.msi"
$output = "c:\install\App Volumes Agent.msi"
$ProgressPreference = 'SilentlyContinue'
Invoke-WebRequest -Uri $url -UseBasicParsing -OutFile $output

# Download Citrix optimzer  
$url = "https://www.ivobeerens.nl/CitrixOptimizer.zip"
$output = "c:\install\CitrixOptimzer.zip"
$ProgressPreference = 'SilentlyContinue'
Invoke-WebRequest -Uri $url -UseBasicParsing -OutFile $output

# Download BIS-F
$url = "https://www.ivobeerens.nl/setup-BIS-F-6.1.3_build01.110.exe"
$output = "c:\install\setup-BIS-F-6.1.3_build01.110.exe"
$ProgressPreference = 'SilentlyContinue'
Invoke-WebRequest -Uri $url -UseBasicParsing -OutFile $output