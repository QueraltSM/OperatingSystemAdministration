#!/bin/bash
function count() {
letterCounter=0
spacesCounter=0

for argument in $*
do
	if [[ -e $argument ]]
	then
		(( letterCounter+=$(cat $argument | grep -o $1 | wc -l) ))
		(( spacesCounter+=$(cat $argument | grep -o ' ' | wc -l) ))
	fi
done
echo "Hay $letterCounter -> $1's."
echo "Hay $spacesCounter -> espacios."
}

if (( $# > 1 ))
then
	count $*
	exit 0
else
	echo "Error in arguments."
	exit 1
fi
