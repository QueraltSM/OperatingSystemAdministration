#!/bin/bash
function calculate(){
count=0
words=$(cat $*)

for word in $words
	do
		echo "palabra = $word"
		if [ ${#word} -eq $1 ];
		then
			(( count++ ))
		fi
	done
echo "There is in total $count words with $1 letters."	
}

if(( $# >= 2 ))
then
	calculate $* 
	exit 0
else
	echo "Error. Insufficient arguments."
	exit 1
fi
