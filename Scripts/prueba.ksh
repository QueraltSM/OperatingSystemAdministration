#!/bin/bash
function getResult(){
result=$(( today-dayChange ))
if [[ "$result" -lt "$1" ]]
then
	echo $userFinal
fi
}

function getMon(){
month=""
	case "$mon" in
	"Jan")
		month="01"
		;;
	"Feb")
		month="02"
		;;
	"Mar")
		month="03"
		;;
	"Apr") 
		month="04"
		;;
	"May")
		month="05"
		;;
	"Jun")
		month="06"
		;;
	"Jul")
		month="07"
		;;
	"Aug")
		month="08"
		;;
	"Sep")
		month="09"
		;;
	"Oct")
		month="10"
		;;
	"Nov")
		month="11"
		;;
	*)
		month="12"
		;;
	esac
}

function inicializa(){
mon=$(echo $* | cut -f1 -d' ')
day=$(echo $* | cut -f2 -d' ' | cut -f1 -d',')
year=$(echo $* | cut -f3 -d ' ')
getMon

fecha=$(echo $year$month$day)
dayChange=$(date -d $fecha +"%j")
today=$(date +"%j")
getResult $today $dayChange

}

if (( $# == 1 ))
then
	userFinal=""
	users=$(cat /etc/passwd | cut -f1 -d':')
	for user in $users
	do
		passwordLastModified=$(chage -l $user | cut -f2 -d':' | sed -n '1p')
		inicializa $passwordLastModified 
		userFinal=$user
	done
	exit 0
else
	echo "Error. Insufficient arguments."
	exit 1
fi
