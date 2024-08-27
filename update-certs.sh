#!/bin/bash

if [ "$(id -u)" -ne 0 ]; then
        echo 'This script must be run by root' >&2
        exit 1
fi

echo " >> $(hostname) >> Copying new certificate..."
cp ca.crt /usr/local/share/ca-certificates
echo " >> $(hostname) >> Copied successfully!"

echo " >> $(hostname) >> Updating CA Certs..."
update-ca-certificates
echo " >> $(hostname) >> Updated!"

echo " >> $(hostname) >> Restarting services..."
systemctl restart docker
systemctl restart containerd
systemctl restart k3s
systemctl restart k3s-agent
systemctl restart containerd
echo " >> $(hostname) >> All services restarted"
echo " >> $(hostname) >> Done!"

echo " >> $(hostname) >> Updating remote nodes..."
echo " >> $(hostname) >> Copying information to remote hosts..."
./copy-certs.sh
echo " >> $(hostname) >> Information copied!"

echo " >> $(hostname) >> Running update on remote hosts"
sshpass -p 'sistemas' ssh sistemas@kworker3.local 'echo sistemas | sudo -S /home/sistemas/update-certs.sh' &
sshpass -p 'sistemas' ssh sistemas@kworker4.local 'echo sistemas | sudo -S /home/sistemas/update-certs.sh' &
sshpass -p 'sistemas' ssh sistemas@kworker5.local 'echo sistemas | sudo -S /home/sistemas/update-certs.sh'
echo " >> $(hostname) >> Update finished on remote hosts!"


