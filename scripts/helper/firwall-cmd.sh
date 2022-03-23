sudo firewall-cmd  --zone=public --add-port=53/udp 
sudo firewall-cmd  --zone=public --add-port=53/tcp 
sudo firewall-cmd  --zone=public --add-port=8000/tcp 
sudo firewall-cmd  --zone=public --add-port=9191/tcp 
sudo firewall-cmd  --zone=public --add-port=9090/tcp
sudo firewall-cmd --zone=public --list-all