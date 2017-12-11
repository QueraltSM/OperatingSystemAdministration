#!/bin/bash
for group in $(cat /etc/group)
do
uid=$(echo $group | cut -f3 -d':')
	if [ "$uid" -gt 499  ]
	then
		finalGroup=$(echo $group | cut -f4 -d':' | tr ',' ' ')
		echo $uid $finalGroup
	fi	

done
exit 0
