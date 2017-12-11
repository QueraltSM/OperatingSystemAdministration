#!/bin/bash

if [[ ! -d "/backups" ]]
then
	mkdir /backups
fi

find /home ! -user root | cpio -o > "/backups/$(date +"%Y%m%d")-copia-completa.cpio"

exit 0
