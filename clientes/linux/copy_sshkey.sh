echo -e "192.168.100.100\tgrrserver" >> /etc/hosts
ssh-copy-id -i ~/.ssh/id_rsa.pub forense@grrserver