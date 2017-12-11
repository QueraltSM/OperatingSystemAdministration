#!/bin/bash
if [ $(date +"%d") -le 7 ] 
then  
	if [[ ! -d "/backups" ]]
	then
		mkdir /backups
	fi

	find /home ! -user root -exec tar -rvf /backups/backup-home-$(date +"%Y%m%d")-level0.tgz \;
	touch /backups/flag0

fi
exit 0