todas minúsculas
y luego la primera letra de la frase en mayúscula

#!/bin/bash
if (( $# >= 1 ))
then
	for file in $*
	do
		awk '{print tolower($0)}' $file > newFile.txt 
		sed -e "s/\b\(.\)/\u\1/g" "newFile.txt" > newLastFile.txt
		cat newLastFile.txt > $file
		rm newFile.txt
		rm newLastFile.txt


	done
	echo "Change was successful!"
	exit 0

else
	echo "ERROR. Insufficient arguments."
	exit 1
fi

