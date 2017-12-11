ELIMINA TODOS LOS ESPACIOS DE UN FICHERO

#!/bin/bash
if (($# >= 1 ))
then
	for file in $*
	do
		sed 's/ //g' $file > newFile.txt
		cat newFile.txt > $file
		rm newFile.txt
	done
	echo "Remove of blank spaces was successful!"
	exit 0

else
	echo "ERROR. Insufficient arguments."
	exit 1
fi
