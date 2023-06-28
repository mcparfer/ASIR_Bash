#!/bin/bash

# Obtención de variables del fichero de configuración.
source '/etc/servicio.prueba.conf'
tiempo=$TIEMPO
fichero=$FICHERO

# Bucle
while true
do
  vmstat -d | awk '/sd/ {print $1, $2, $6}' | while read disco
  do
    valor=$(echo "$disco" | awk '{print $3}')    
    if [ "$valor" -gt 10000 ]; then
      echo "   $disco ¡ATENCIÓN!" >> $fichero  
    else
      echo "   $disco" >> $fichero 
    fi
  done
  sleep $tiempo
done
