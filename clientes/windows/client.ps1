# Configuración inicial. Creacion de usuario grrserver con permisos
$user = "grragent"
$password = ConvertTo-SecureString "hola123.," -AsPlainText -Force
New-LocalUser -Name $user -Password $password -FullName $user -Description $user
Add-LocalGroupMember -Group "Administrators" -Member $user
Add-Content -Path $env:windir\System32\drivers\etc\hosts -Value "`n192.168.100.100`tgrrserver" -Force
# SSH config para grrserver
Add-WindowsCapability -Online -Name OpenSSH.Server~~~~0.0.1.0
Start-Service sshd
Set-Service -Name sshd -StartupType 'Automatic'
# Generación de llave y envío a servidor
$cred = New-Object System.Management.Automation.PSCredential -ArgumentList $user,$password
#$secpasswd = ConvertTo-SecureString $Password -AsPlainText -Force
#Invoke-SSHCommand -Index $session.sessionid -Command "cat /home/$user/.ssh/id_rsa.pub"#ssh forense@grrserver cat C:\Users\$user\.ssh\id_rsa.pub >> /home/forense/.ssh/id_rsa.pub authorized_keys" # Invoke Command Over SSH
$cmds = {"New-Item $home\.ssh -Type Directory";"cd ~\.ssh; ssh-keygen -b 4096 -t rsa -f id_rsa -q -N 'hola123.,'"}
#'-type id_rsa.pub | ssh -o 'StrictHostKeyChecking No' forense@grrserver 'cat >> .ssh/authorized_keys'
Start-Process powershell -Credential $cred -ArgumentList $cmds -Wait -NoNewWindow


$Password1 = ConvertTo-SecureString "hola123.," -AsPlainText -Force
$User1 = "forense"
$Credentials = New-Object System.Management.Automation.PSCredential($User1, $Password1)
$session = New-SSHSession -ComputerName grrserver -Credential $Credentials
$cmds2 = {"cd ~\.ssh"; "type id_rsa.pub | ssh -o 'StrictHostKeyChecking No' forense@grrserver 'cat >> .ssh/authorized_keys'"}
Start-Process powershell -Credential $cred -ArgumentList $cmds2 -Wait -NoNewWindow
#Invoke-SSHCommand -Index $session.sessionid -Command "type id_rsa.pub | ssh -o 'StrictHostKeyChecking No' forense@grrserver 'cat >> .ssh/authorized_keys'" # Invoke Command Over SSH
