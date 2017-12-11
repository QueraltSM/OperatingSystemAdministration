#!/bin/bash
if (( $# == 1 ))
then
	number=$1
	result=""
	xFile=0

	if [ $number -lt 500 ] 
	then 
		echo "The argument must be greater or equal than 500" 
		exit 1
	else 
		usersInfo=$(awk -F: '{if ($3 >= '$number') print $1}' < /etc/passwd)
		IFS=$'\n'
		for userLine in $usersInfo
		do
			newX=$(find /home -depth -user $userLine | wc -l)
			if [ $xFile -lt $newX ]
			then
				xFile=$newX
				result="User $userLine has $(find /home -user $userLine | wc -l) 
from $(getent passwd $userLine | cut -f6 -d:)" 
			fi
		done 
		echo $result
	fi
	exit 0
else
	echo "You have to enter only 1 argument."
	exit 1
fi
