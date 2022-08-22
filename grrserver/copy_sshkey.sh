#Windows
scp ~/.ssh/id_rsa.pub grragent@192.168.100.101:%programdata%/ssh/grrPubKey.pub # Implementar SSH PASS
echo "hola123.," | sshpass ssh grragent@192.168.100.101 "cd %programdata%\ssh && type grrPubKey.pub >> administrators_authorized_keys" #Tunear
#echo "hola123.," | sshpass ssh grragent@192.168.100.101 "cd %programdata%\ssh && type grrPubKey.pub >> administrators_authorized_keys && icacls administrators_authorized_keys /inheritance:r /grant 'Administrators:F' /grant 'SYSTEM:F'" #Tunear

#Linux 
 echo "hola123.,"| sshpass ssh-copy-id -i ~/.ssh/id_rsa.pub -o StrictHostKeyChecking=no grragent@192.168.100.20