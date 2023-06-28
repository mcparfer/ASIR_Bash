#!/bin/bash

# Comprobación del número de parámetros.
if [ $# -ne 1 ]; then
  echo "servicio.prueba: número de parámetros incorrecto."
  echo "Escriba 'servicio.prueba --help' para más información."
  exit 1
fi

# Comprobación del archivo de configuración.
conf="/etc/servicio.prueba.conf"
if [ ! -f $conf ]; then
  echo "¡ERROR! El fichero de configuración $conf no existe."
  exit 1
fi
source $conf

# Comprobación del archivo ejecutable prueba.sh.
ejecutable="/etc/init.d/prueba.sh"
if [ ! -x $ejecutable ]; then
  echo "¡ERROR! El fichero $ejecutable no existe o no tiene permisos de ejecución."
  exit 1
fi 

# Asignación de variables
## Acción a realizar
accion=$1
## Pid del proceso
pid=$(pgrep -f 'prueba.sh')
## Fecha-hora actual
today="$(date '+%m-%d-%Y %T')"
## Fichero de salida
salida=$FICHERO


# EJECUCIÓN DEL EJERCICIO
case $accion in

  --help)
  
    # Muestra una ayuda visual.
    echo "Sintáxis: servicio.prueba { start | stop | reload | status }"
    echo "  start: inicia el servicio prueba.sh"
    echo "  stop: detiene el servicio prueba.sh"
    echo "  reload: recarga el servicio prueba.sh"
    echo "  status: muestra el estado del servicio prueba.sh"
  ;;
  
  start)
  
    # Si no hay pid = proceso detenido = podemos iniciarlo.
    if [ -z $pid ]; then
      echo "$today $accion" >> $salida
      $ejecutable &
      echo "El servicio ha sido activado correctamente."
    
    # Si hay pid = proceso en ejecución.
    else      
      echo "Error: el servicio ya está en ejecución (pid $pid)."
    fi
  ;;
  
  stop)
  
    # Si hay pid = proceso en ejecución = podemos detenerlo.
    if [ ! -z $pid ]; then
      echo "$today $accion" >> $salida
      kill $pid
      echo "El servicio ha sido detenido correctamente."
    
    # Si no hay pid = proceso detenido.
    else
      echo "Error: el servicio no está en ejecución."
    fi
  ;;
  
  reload)
  
    # Si hay pid = proceso en ejecución = podemos recargarlo.
    if [ ! -z $pid ]; then
      echo "$today $accion" >> $salida
      kill $pid
      $ejecutable &
      echo "El servicio ha sido recargado." 
    
    # Si no hay pid = proceso detenido.
    else
      echo "Error: el servicio no está en ejecución. Primero inicie el servicio."
    fi
  ;;
  
  status)
    
    # Si hay pid = proceso en ejecución = podemos mostrar su status.
    if [ ! -z $pid ]; then
      echo "$today $accion" >> $salida
      echo "El servicio se está ejecutando."
      echo "Aquí tienes información de la ejecución del servicio..."
      ps -p $pid -o pid,user,%cpu,%mem,cmd
    
    # Si no hay pid = proceso detenido. 
    else
      echo "El servicio no se encuentra en ejecución en este momento."
    fi   
  ;;
  
  *)
  
    # Comprobación de la opción seleccionada.
    echo "servicio.prueba: opción incorrecta -- «$accion»"
    echo "Escriba 'servicio.prueba --help' para más información."
  ;;
  
esac
