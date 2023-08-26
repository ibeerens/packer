# Download the latest Packer version
$product='packer'
$packurl = Invoke-WebRequest -Uri https://www.$product.io/downloads.html | Select-Object -Expand links | Where-Object href -match "//releases\.hashicorp\.com/$product/\d.*/$product_.*_windows_amd64\.zip$" | Select-Object -Expand href
$packdown = $packurl | Split-Path -Leaf
$packdownload = $downloadfolder + $packdown
$webclient = New-object -TypeName System.Net.WebClient
$webclient.DownloadFile($packurl, $packdownload)




# Download the latest Packer version
$product='packer'
$packurl = Invoke-WebRequest -Uri https://developer.hashicorp.com/packer/downloads | Select-Object -Expand links | Where-Object href -match "//releases\.hashicorp\.com/$product/\d.*/$product_.*_windows_amd64\.zip$" | Select-Object -Expand href
$packdown = $packurl | Split-Path -Leaf
$packdownload = $downloadfolder + $packdown
$webclient = New-object -TypeName System.Net.WebClient
$webclient.DownloadFile($packurl, $packdownload)

