#!/bin/bash

#Creacion de usuario y asignacion de permisos elevados
timedatectl set-timezone America/Mexico_City
servergrr="172.20.40.100"
username=grragent
string=$(cat /dev/urandom | tr -dc "[:alnum:]" | fold -w ${1:-30} | head -n 1)
export string
password=$(mkpasswd $string)
useradd -m $username -p $password -s /bin/bash
echo "${username} ALL=(ALL:ALL) ALL" >> /etc/sudoers
echo $string 

#Configuracion GRR
echo -e "$servergrr\tgrrserver" >> /etc/hosts

#Configuracion SSH
apt update -y && apt install -y ssh sshpass sshfs
sed -i '/Port 22/s/^#//g' /etc/ssh/sshd_config
systemctl restart sshd.service
service ssh restart
su grragent -
mkdir ~/.ssh && cd ~/.ssh
ssh-keygen -b 4096 -t rsa -f id_rsa -q -N $string
echo "hola123.," | sshpass ssh-copy-id -i id_rsa.pub -o StrictHostKeyChecking=no forense@grrserver

#Instalacion cliente GRR
cd ~/Downloads
wget grrserver:8000/cliente_linux.deb
dpkg -i cliente_linux.deb