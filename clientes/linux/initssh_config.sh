echo -e "192.168.100.100\tgrrserver" >> /etc/hosts
apt install -y ssh
sed -i '/Port 22/s/^#//g' /etc/ssh/sshd_config
sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/g' /etc/ssh/sshd_config
mkdir ~/.ssh && cd ~/.ssh
ssh-keygen
systemctl restart sshd.service
ssh-copy-id -i ~/.ssh/id_rsa.pub forense@grrserver