#!/bin/bash
function changeToLowercase(){
	files=$(find $1 -iname "*.doc" -o -iname "*.docx" | grep -e '[[:upper:]]')
	for file in $files
	do		
		fileModified=$(echo $(basename $file) | awk '{print tolower($0)}') 
		mv $file $(dirname $file)/$fileModified
		echo $(date --rfc-3339=seconds) $file $fileModified >> /var/log/cambiosDoc
	done
}

if [ $# -eq 1 ]
then
	changeToLowecase $1
	exit 0 

elif [ $# -eq 0 ]
then
	changeToLowercase $pwd
	exit 1

else
	echo "Error in arguments."
	exit 2
fi
