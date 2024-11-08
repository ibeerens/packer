# # Start the sshd service
Start-Service sshd
 
# Start the SSH service automatic at startup
Set-Service -Name sshd -StartupType 'Automatic'
 
# Open Firewall Port
Set-NetFirewallRule -Name "OpenSSH-Server-In-TCP" -Profile Private,Public,Domain -Enabled True