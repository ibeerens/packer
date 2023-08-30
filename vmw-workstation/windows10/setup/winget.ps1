# Visual Studio Code
winget install Microsoft.VisualStudioCode

# Azure Tools
winget install Microsoft.AzureStorageExplorer
winget install Microsoft.Bicep
winget install Microsoft.AzureCLI

# PowerShell 7
winget install Microsoft.PowerShell

# Windows Terminal (if on Windows 10)
winget install Microsoft.WindowsTerminal

# Git and GitHub CLI
winget install Git.Git
winget install GitHub.cli
git config --global user.name "John Doe"
git config --global user.email johndoe@example.com

# Azure PowerShell
pwsh (Make sure to start your terminal session with PowerShell 7)
Install-Module Az

# Visual Code Extensions

code --install-extension eamodio.gitlens
code --install-extension telesoho.vscode-markdown-paste-image
code --install-extension ms-azuretools.vscode-bicep
code --install-extension ms-azuretools.vscode-docker
code --install-extension ms-vscode-remote.remote-containers
code --install-extension ms-vscode-remote.remote-ssh
code --install-extension ms-vscode-remote.remote-wsl
code --install-extension ms-vscode.azurecli
code --install-extension ms-vscode.powershell