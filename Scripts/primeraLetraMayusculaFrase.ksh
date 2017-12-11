Solo al comienzo de la linea


#!/bin/bash
if (( $# >= 1 ))
then
	for file in $*
	do
		sed -e "s/^\(.\)/\U\1/" $file > newFile.txt
		cat newFile.txt > $file
		rm newFile.txt


	done
	echo "Change was successful!"
	exit 0

else
	echo "ERROR. Insufficient arguments."
	exit 1
fi

