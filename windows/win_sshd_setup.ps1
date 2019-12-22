# install open SSH and setup firewall rules to access from localhost
#
# this PowerShell Script need to be executed as anadministrator

Add-WindowsCapability -Online -Name OpenSSH.Server~~~~0.0.1.0
# Start-Service sshd
# Set-Service -Name sshd -StartupType 'Automatic'
Get-NetFirewallRule -Name *ssh*
New-NetFirewallRule -Name sshd9922 -DisplayName 'OpenSSH on 9922' -Enabled True -Direction Inbound -Protocol TCP -Action Allow -LocalPort 9922

