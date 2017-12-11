#!/bin/bash
counter=1

groupadd myusers
mkdir -p /Users/myusers
chmod 770 /Users/myusers
chgrp myusers /Users/myusers

useradd -g myusers -M poweruser
gpasswd -A poweruser myusers

while(( $counter <= 40 ))
do
	if [ $counter -lt 10 ]
	then
		username="user0$counter"
	else 
		username="user$counter"
	fi	

	useradd -g myusers -m -d /Users/$username $username
	chage -M 30 -m 15 -W 7 -I 7 $username
	(( counter++ ))

done
exit 0