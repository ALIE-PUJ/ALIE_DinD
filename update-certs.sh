#!/bin/bash

if [ "$(id -u)" -ne 0 ]; then
        echo 'This script must be run by root' >&2
        exit 1
fi

echo " >> Copying new certificate..."
cp ca.crt /usr/local/share/ca-certificates
echo " >> Copied successfully!"

echo " >> Updating CA Certs..."
update-ca-certificates
echo " >> Updated!"

echo " >> Restarting services..."
systemctl restart docker
systemctl restart containerd
systemctl restart k3s
systemctl restart k3s-agent
systemctl restart containerd
echo " >> All services restarted"
echo " >> Done!"

echo " >> Updating remote nodes..."
echo " >> Copying information to remote hosts..."
./copy-certs.sh
echo " >> Information copied!"

echo " >> Running update on remote hosts"
sshpass -p 'sistemas' ssh sistemas@kworker3.local 'echo sistemas | sudo -S /home/sistemas/update-certs.sh' 
sshpass -p 'sistemas' ssh sistemas@kworker4.local 'echo sistemas | sudo -S /home/sistemas/update-certs.sh'
sshpass -p 'sistemas' ssh sistemas@kworker5.local 'echo sistemas | sudo -S /home/sistemas/update-certs.sh'
echo " >> Update finished on remote hosts!"


