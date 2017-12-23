#!/bin/bash
#Authors: Jaime Barreto García, Giovanni Cabrera Moreno y Queralt Sosa Mompel
#Group: t3_42_02

#Imprimimos el resultado por pantalla, proceso a proceso

function getResult() {

	if [[ $fread == 0 ]] && [[ $fwrite == 0 ]]; then
		flag=0
	fi

	if [[ $flag -eq 1 ]];then
		echo -e "Proceso:$process\nUser:$user\nProcess: $processName\nRead: $fread Write: $fwrite\nFiles open:\n$openFiles\n\n\n" 	
	else
		echo -e "User:$user\nProcess: $processName\nThere are no files open\n\n\n" 		
	fi

}

#Comprobamos los permisos de cada descriptor de fichero para averiguar si está abierto en lectura, escritura o ambas

function getPerm() {
	perm=$(stat -c "%a" $1)
	if [[ $perm == "700" ]] || [[ $perm == "600" ]]; then
		(( fread++ ))
		(( fwrite++ ))	
		openFiles+="$2\n"
	elif [[ $perm == "400" ]] || [[ $perm == "500" ]]; then
		(( fread++ ))
		openFiles+="$2\n"
	elif [[ $perm == "200" ]] || [[ $perm == "300" ]]; then
		(( fwrite++ ))
		openFiles+="$2\n"
	fi

	
}

#Buscamos todos los ficheros abiertos de cada proceso

function getOpenFiles() {
	for process in $path; do
		if [[ -d $process ]]; then

			if [[ $1 -eq 1 ]]; then
				UIDF=$(grep Uid $process/status 2>/dev/null | tr -s '\t' : | cut -d : -f 2) 
				user=$(grep :$UIDF:[0-9] /etc/passwd | cut -d: -f 1  2>/dev/null)	    
			fi

			processName=$(cut -d ' ' -f 2 $process/stat 2>/dev/null  | cut -f 2 -d '(' | cut -f 1 -d ')')
			fdCount=$(ls $process/fd 2>/dev/null | wc -l )

			if [[ $fdCount -gt 0 ]];then
				i=0
				while [[ $i -lt $fdCount ]]; do
					file=$(readlink $process/fd/$i)
					if [[ -f $file ]]; then
						getPerm $process/fd/$i $file
					fi
					(( i++ ))
				done
			else
				flag=0
			fi	
	
			getResult 

			flag=1
			fread=0
			fwrite=0
			openFiles=""
		else	
			echo -e "$process is not in execution anymore\n"
		fi
	done 
}

#Obtenemos la lista de usuarios que componen cada grupo

function getGroups(){
	groups=$(echo $1 | tr ',' '\n')
	for group in $groups
	do	
		if [[ $(cat /etc/group | grep $group) ]]
		then
			realGroups+="$group,"
		else 
			echo -e "$group does not exists in the system\n"
		fi    
	done
	getUsers $realGroups
}

#Obtenemos el listado de usuarios introducido por parámetro o desde getGroups y buscamos sus procesos usuario a usuario

function getUsers(){
	users=$(echo $1 | tr ',' '\n')
	for user in $users
	do	
		if [[ $(cat /etc/passwd | grep $user) ]] 
		then
        		path=$(find /proc -maxdepth 1 -name [0-9]* -user $user  2>/dev/null ) 
        		getOpenFiles $user 
		else 
			echo -e "$user does not exists in the system\n"	
			
		fi    
	done
}

#Comprobamos los parámetros introducidos

if [[ $# -eq 0 ]] 
then
	path=$(find /proc -maxdepth 1 -name [0-9]* )
	getOpenFiles 1

	elif [[ $1 == "-u" ]];then 
		getUsers $2
		
	elif [[ $1 == "-g" ]]; then 
		getGroups $2
	else
    		echo This is not valid. Please try again
fi
