#!/bin/bash
if [[ ! -d "/backups" ]]
then
	mkdir /backups
fi

find /home ! -user root -type f -newer /backups/flag1 -exec tar -rvf /backups/backup-home-$(date +"%Y%m%d")-level2.tgz \;

exit 0