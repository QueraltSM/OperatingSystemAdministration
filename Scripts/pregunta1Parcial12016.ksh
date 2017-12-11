#!/bin/bash

echo "There are $(wc -w /usr/share/dict/words | cut -f1 -d' ') words"

function moreThan() {
countmoreThan18=0
while read word
do
	if [[ $(echo $word | wc -c) -gt 18 ]]
	then
		(( countMoreThan18++ ))
	fi
done < /usr/share/dict/words
echo "There are $countMoreThan18 words with more than 18 letters."
}

function noTienenVocal() {
sinvocal=0
while read word
do
	if [[ ! $(echo $word | grep [aeiouAEIOU])  ]]
	then
		(( sinvocal++ ))
	fi
done < /usr/share/dict/words
echo "Hay $sinvocal palabras sin vocal."

}

function recuento() {
count=0
while read word
do
		if [[ $(echo $word | grep -Eo "$1*") ]]
		then
			echo $1 $count
			(( count++ ))	
		fi

done < /usr/share/dict/words
echo "$1 ($count)"
}

recuento "A"
recuento "B"
exit 0
