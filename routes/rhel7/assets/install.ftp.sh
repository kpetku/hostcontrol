#!/bin/bash

sed -i '/chroot_local_user=/c\chroot_local_user=YES' /etc/vsftpd/vsftpd.conf
if ! grep ^chroot_local_user /etc/vsftpd/vsftpd.conf | grep YES; then
	echo Ensuring VSFTPD is chrooted.
	echo 'chroot_local_user=YES' >> /etc/vsftpd/vsftpd.conf
fi

systemctl enable vsftpd

if [ -f /var/lock/subsys/vsftpd ]; then
	systemctl restart vsftpd
else
	systemctl start vsftpd
fi
