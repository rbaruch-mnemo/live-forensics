echo "192.168.100.100`tgrrserver" >> C:\Windows\System32\drivers\etc
type $env:USERPROFILE\.ssh\id_rsa.pub | ssh grrserver "cat >> .ssh/authorized_keys"