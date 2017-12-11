#!/bin/bash

if [[ ! -d "/backups" ]]
then
	mkdir /backups
fi

find /home ! -user root -type f -newer "/backups/$(ls /backups -tr | egrep '*1.cpio' | tail -1)" | cpio -o > "/backups/$(date +"%Y-%m-%d")-incremental2.cpio"

exit 0