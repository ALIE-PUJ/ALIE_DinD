#!/bin/bash

if [ "$(id -u)" -ne 0 ]; then
        echo 'This script must be run by root' >&2
        exit 1
fi

echo "Copying new certificate..."
cp ca.crt /usr/local/share/ca-certificates
echo "Copied successfully!"

echo "Updating CA Certs..."
update-ca-certificates
echo "Updated!"

echo "Restarting services..."
systemctl restart docker
systemctl restart containerd
systemctl restart k3s
systemctl restart k3s-agent
systemctl restart containerd
echo "All services restarted"
echo "Done!"

