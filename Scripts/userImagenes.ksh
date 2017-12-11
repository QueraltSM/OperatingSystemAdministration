#!/bin/bash
function giveResult(){
	if [[ $(echo $inicia | grep -c "k") -gt 0 ]]
	then
		$2=$(echo |awk '{print $2*0.001}')
	fi
	echo $1 $2
}

function findPics() {
for argument in $*
do
	if [ $argument != '-k' ] && [ $argument != '-m' ]
	then
		(( validArguments+=$argument ))
	
	fi
done

for validArgument in $validArguments
do
	user=$validArgument
	for line in $(cat /etc/passwd)
	do
		if [[ $(echo $line | cut -f3 -d':') == $user ]]
		then
		user=$(echo $line | cut -f1 -d':')
		fi
	done
		
pics=$(find /home -user $user -iname "*.jpg" -o -iname ".jpeg" -o -iname "*.gif" -o -iname "*.png" -o -iname "*.bmp")
	
	for pic in $pics
	do
		(( count+=$(stat -c %s $pic) ))
	done

	giveResult $user $count
	count=0
done	
}

if (( $# >= 1 ))
then
	inicia=$*
	findPics $*
	exit 0
else
	echo "ERROR. Insufficient arguments."
	exit 1

fi
