#!/bin/bash
touch fileTar
files=$(find / -group profesores -and -size +2048k)
echo $files > fileTar
tar -cf fileTar.tar fileTar
rm -rf fileTar
exit 0
