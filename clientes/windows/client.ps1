# Configuración inicial. Creacion de usuario grrserver con permisos
$user = "grrclient"
$password = ConvertTo-SecureString "hola123.," -AsPlainText -Force
New-LocalUser -Name $user -Password $password -FullName "grr" -Description "grr client user"
Add-LocalGroupMember -Group "Administrators" -Member $user
Add-Content -Path $env:windir\System32\drivers\etc\hosts -Value "`n192.168.100.100`tgrrserver" -Force
# SSH config para grrserver
Add-WindowsCapability -Online -Name OpenSSH.Server~~~~0.0.1.0
Start-Service sshd
Set-Service -Name sshd -StartupType 'Automatic'
# Generación de llave y envío a servidor
$cred = New-Object System.Management.Automation.PSCredential -ArgumentList $user,$password
#$secpasswd = ConvertTo-SecureString $Password -AsPlainText -Force
$Password1 = "hola123.,"
$User1 = "forense"
$Credentials = New-Object System.Management.Automation.PSCredential($user1, $password1)
$session = New-SSHSession -ComputerName grrserver -Credential $Credentials
#Invoke-SSHCommand -Index $session.sessionid -Command "type id_rsa.pub | ssh -o 'StrictHostKeyChecking No' forense@grrserver 'cat >> .ssh/authorized_keys'" # Invoke Command Over SSH
$cmds = {"New-Item $home\.ssh -Type Directory";"cd ~\.ssh; ssh-keygen -b 4096 -t rsa -f id_rsa -q -N 'hola123.,'";"type id_rsa.pub | ssh -o 'StrictHostKeyChecking No' forense@grrserver 'cat >> .ssh/authorized_keys'"}
Start-Process powershell -Credential $cred -ArgumentList $cmds -Wait -NoNewWindow