#!/bin/bash
# Configuracion inicial del servidor
timedatectl set-timezone America/Mexico_City
apt update -y && apt install -y whois ssh sshfs sshpass net-tools vim mysql-server
echo "grrserver" > /etc/hostname && hostname grrserver
# Creación usuario con permisos y llaves de SSH
username=grr
string="hola123.,"
export string
password=$(mkpasswd $string)
useradd -m $username -p $password -s /bin/bash
echo "${username} ALL=(ALL:ALL) ALL" >> /etc/sudoers
su -c 'mkdir ~/.ssh && cd ~/.ssh && ssh-keygen -b 4096 -t rsa -f id_rsa -q -N ""' $username
#su -c 'mkdir ~/.ssh && cd ~/.ssh && ssh-keygen -b 4096 -t rsa -f id_rsa -q' $username #SIN PASSWD
wget -O /home/$username/grr-server_3.4.6-0_amd64.deb https://storage.googleapis.com/releases.grr-response.com/grr-server_3.4.6-0_amd64.deb 
# Configuración MySQL 
echo -e "SET GLOBAL max_allowed_packet=41943040;\nCREATE USER 'grr'@'localhost' IDENTIFIED BY 'hola123.,';\nCREATE DATABASE grr;\nGRANT ALL ON grr.* TO 'grr'@'localhost';\nCREATE USER 'fleetspeak'@'localhost' IDENTIFIED BY 'hola123.,';\nCREATE DATABASE fleetspeak;\nGRANT ALL ON fleetspeak.* TO 'fleetspeak'@'localhost';" > ~/sql.txt
echo -e "[mysql]\nuser = root\npassword = hola123.,\n\n[mysqldump]\nuser = root\npassword = hola123.," > ~/.my.cnf && chmod 600 ~/.my.cnf
mysql -u root < ~/sql.txt && rm ~/sql.txt
# Configuración de red
interface=$(nmcli device status | grep "ethernet" | cut -d " " -f 1) # ens33 por defecto
ipmask="192.168.100.100/24"
gw="192.168.100.1"
dns="1.1.1.1, 8.8.8.8"
echo -e "  ethernets:\n    $interface:\n      dhcp4: no\n      addresses:\n        - $ipmask\n      gateway4: $gw\n      nameservers:\n        addresses: [$dns]" >> /etc/netplan/01-network-manager-all.yaml
netplan apply
# Instalación paquete GRR
cd /home/$username && apt install -y ./grr-server_3.4.6-0_amd64.deb
mkdir -p /cases/GRR_Server

reboot
# Reiniciar el frontend de GRR
# sudo grr_server --component frontend