sudo apt install -y mysql-server
mysql -u root -p
SET GLOBAL max_allowed_packet=41943040;
CREATE USER 'grr'@'localhost' IDENTIFIED BY 'hola123.,';
CREATE DATABASE grr;
GRANT ALL ON grr.* TO 'grr'@'localhost';
CREATE USER 'fleetspeak'@'localhost' IDENTIFIED BY 'hola123.,';
CREATE DATABASE fleetspeak;
GRANT ALL ON fleetspeak.* TO 'fleetspeak'@'localhost';
exit