#!/bin/bash

#Creacion de usuario y asignacion de permisos elevados
timedatectl set-timezone America/Mexico_City
apt update -y && apt install -y whois ssh sshpass sshfs
servergrr="192.168.100.100"
username=grragent
#string=$(cat /dev/urandom | tr -dc "[:alnum:]" | fold -w ${1:-30} | head -n 1)
string="hola123.,"
export string
password=$(mkpasswd $string)
useradd -m $username -p $password -s /bin/bash
echo "${username} ALL=(ALL:ALL) ALL" >> /etc/sudoers
echo $string 

#Configuracion GRR
echo -e "$servergrr\tgrrserver" >> /etc/hosts

#Configuracion SSH

sed -i '/Port 22/s/^#//g' /etc/ssh/sshd_config
systemctl restart sshd.service
service ssh restart
mkdir ~/.ssh && cd ~/.ssh && ssh-keygen -b 4096 -t rsa -f id_rsa -q -N "" && echo "hola123.," | sshpass ssh-copy-id -i id_rsa.pub -o StrictHostKeyChecking=no grr@grrserver
su -c 'mkdir ~/.ssh && cd ~/.ssh && ssh-keygen -b 4096 -t rsa -f id_rsa -q -N "" && echo "hola123.," | sshpass ssh-copy-id -i id_rsa.pub -o StrictHostKeyChecking=no grr@grrserver' $username
#ssh-keygen -b 4096 -t rsa -f id_rsa -q -N $string



#Instalacion cliente GRR
#cd ~/Downloads
#wget grrserver:8000/cliente_linux.deb
#dpkg -i cliente_linux.deb