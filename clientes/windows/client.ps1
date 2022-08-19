# Configuración inicial. Creacion de usuario grrserver con permisos
$exPol = Get-ExecutionPolicy
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Force
$user = "grragent"; $grrserver = "192.168.100.100"
$password = ConvertTo-SecureString "hola123.," -AsPlainText -Force
New-LocalUser -Name $user -Password $password -FullName $user -Description $user
Add-LocalGroupMember -Group "Administrators" -Member $user
Add-Content -Path $env:windir\System32\drivers\etc\hosts -Value "`n$grrserver`tgrrserver" -Force
# SSH config para grrserver
Add-WindowsCapability -Online -Name OpenSSH.Server~~~~0.0.1.0
#Aceptar PubKey
Start-Service sshd
Set-Service -Name sshd -StartupType 'Automatic'
# Generación de llave y envío a servidor
$cred = New-Object System.Management.Automation.PSCredential -ArgumentList $user,$password
$cmds = {"New-Item $home\.ssh -Type Directory";"cd ~\.ssh; ssh-keygen -b 4096 -t rsa -f id_rsa -q -N ''";"type id_rsa.pub | ssh -o 'StrictHostKeyChecking No' grr@grrserver 'cat >> .ssh/authorized_keys'"}
Start-Process powershell -Credential $cred -ArgumentList $cmds -Wait -NoNewWindow
Set-ExecutionPolicy -ExecutionPolicy $exPol -Force