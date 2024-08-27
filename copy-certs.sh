#!/bin/bash

sshpass -p 'sistemas' scp ca.crt sistemas@kworker3.local:/home/sistemas
sshpass -p 'sistemas' scp update-certs.sh sistemas@kworker3.local:/home/sistemas
sshpass -p 'sistemas' scp ca.crt sistemas@kworker4.local:/home/sistemas
sshpass -p 'sistemas' scp update-certs.sh sistemas@kworker4.local:/home/sistemas
sshpass -p 'sistemas' scp ca.crt sistemas@kworker5.local:/home/sistemas
sshpass -p 'sistemas' scp update-certs.sh sistemas@kworker5.local:/home/sistemas
