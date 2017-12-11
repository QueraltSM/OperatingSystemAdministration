#!/bin/bash

# Creamos usuarios Miguel y Esther

useradd Miguel
useradd Esther

# Creamos el grupo profesores
groupadd Profesores

# Miguel y Esther tienen como grupo primario Profesores

usermod -g Profesores Miguel
usermod -g Profesores Esther

# Miguel y Esther como grupo secundario ASO

groupadd ASO
usermod -G ASO Miguel
usermod -G ASO Esther

# Cuentas caducan el 31 de Julio de 2015

chage -E 20150531 Miguel
chage -E 20150531 Esther

# Sus palabras de paso no pueden estar más de 30 días desactualizadas
chage -M 30 Miguel
chage -M 30 Esther

# Damos margen de 7 días más antes de desactivar la palabra de paso
passwd Miguel -i 7
passwd Esther -i 7

# El sistema tiene que avisar 5 días antes de que la palabra de paso caduque

chage -W 7 Miguel
chage -W 7 Esther

# Grupo ASO tiene que tener de administradores a Miguel y Esther 

groupadd ASO
gpasswd -A Miguel ASO
gpasswd -A Esther ASO

# Palabra de paso del grupo ASO: 2014.ASO¿?

gpasswd ASO

