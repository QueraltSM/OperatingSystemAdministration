#!/bin/bash
if(( $# >= 1 ))
nFile=1
then 
for file in $*
do
	cat $file | while read line
	do
	newFile=$(basename "$file").$nFile
	echo $line > $newFile
	(( nFile++ ))
	done	
done
exit 0

else
echo "Insufficient arguments."
exit 1
fi
