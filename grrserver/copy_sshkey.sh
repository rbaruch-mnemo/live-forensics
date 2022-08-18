#Windows
scp ~/.ssh/id_rsa.pub <usuario>@<cliente>:%programdata%/ssh
#Agregar el otro

#Linux 
 echo "hola123.,"| sshpass ssh-copy-id -i ~/.ssh/id_rsa.pub -o StrictHostKeyChecking=no forense@172.20.4.101