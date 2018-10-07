#!/bin/bash
wvdialconf
gammu -f /var/log/gammulog identify
mkdir /var/log/gammu
chown gammu:gammu /var/log/gammu
service gammu-smsd start
###
chmod 600 /root/.ssh/authorized_keys
chmod 700 /root/.ssh
chown root:root /root/.ssh
sed -i 's/PermitRootLogin\ yes/PermitRootLogin\ without-password/g' /etc/ssh/sshd_config
sed -i 's/\#AuthorizedKeysFile/AuthorizedKeysFile/g' /etc/ssh/sshd_config
sed -i 's/\#PasswordAuthentication\ yes/PasswordAuthentication\ no/g' /etc/ssh/sshd_config
sed -i 's/\UsePAM\ yes/UsePAM\ no/g' /etc/ssh/sshd_config
#sed -i 's/\%h/\/root/g' /etc/ssh/sshd_config
### Rename to authorized_keys ###
#cd /root/.ssh
#mv id_rsa.pub authorized_keys
service ssh restart
