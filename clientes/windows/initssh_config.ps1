echo "192.168.100.100`tgrrserver" >> C:\Windows\System32\drivers\etc
Add-WindowsCapability -Online -Name OpenSSH.Server~~~~0.0.1.0
Start-Service sshd
Set-Service -Name sshd -StartupType 'Automatic'
ssh-keygen