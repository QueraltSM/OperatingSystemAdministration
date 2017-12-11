#!/bin/bash
if [ $(date +"%d") -gt 7 ] 
then 
	if [[ ! -d "/backups" ]]
	then
		mkdir /backups
	fi

	find /home ! -user root -type f -newer /backups/flag0 -exec tar -rvf /backups/backup-home-$(date +"%Y%m%d")-level1.tgz
	touch /backups/flag1

fi
exit 0
