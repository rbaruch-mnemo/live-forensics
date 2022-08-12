setxkbmap latam
apt install net-tools ssh vim -y
ssh-keygen
wget https://storage.googleapis.com/releases.grr-response.com/grr-server_3.4.6-0_amd64.deb
sudo apt install -y ./grr-server_3.4.6-0_amd64.deb

# Reiniciar el frontend de GRR
# sudo grr_server --component frontend