#!/bin/bash

# MENU DE AYUDA

if [ $1 = "-h" ]; then
	echo
  	echo BIENVENIDO AL MENU DE AYUDA
  	echo
  	echo 1 – Crear lista de usuarios
  	echo $'\t' Crea un usuario nuevo por cada elemento en la lista recogida por teclado. La clave será el nombre-del-usuario_iso2122. 
	echo
	echo 2 – Crear directorios
	echo $'\t' Crea un directorio por cada elemento en la lista recogida por teclado.
	echo
	echo 3 – Mover elementos
	echo $'\t' Mueve un fichero o patrón de un directorio origen a uno destino.
	echo
	echo 4 – Replicar estructura directorio
	echo $'\t' Replica una estructura de directorios en otra ruta, copiando el directorio origen y todo el contenido del mismo a la ruta de destino.
	echo
	echo 5 – Buscador de archivos
	echo $'\t' Realiza una búsqueda de acuerdo a los parámetro recogidos por teclado.
	echo
	echo 6 – Cambiar permisos
	echo $'\t' Haciendo uso del comando chmod, se hacen cambios sobre los permisos de un archivo o directorio.
	echo
	echo 7 – Crear archivo encriptado zip
	echo $'\t' Empaqueta archivos o directorios completos y los guarda bajo contraseña.
	echo
	echo 0 – Salir
	echo $'\t' Bastante obvio.
	echo	
  
# MUESTRA EL USUARIO Y VERSION DEL BASH

elif [ $1 = "-v" ]; then

	echo Creador del script: $USER 
  	echo Bash version: $BASH_VERSION
 
# MENU INTERACTIVO

elif [ $1 = "-i" ]; then

	# BUCLE WHILE INFINITO. SOLO SE PUEDE SALIR MEDIANTE BREAK.
	
   	while true   	
   	do

		echo 
	  	echo ----------- MENU ------------
	  	echo  1 - Crear lista de usuarios
	  	echo  2 - Crear directorios
	  	echo  3 - Mover elementos
	  	echo  4 - Replicar estructura directorio
	  	echo  5 - Buscador de archivos
	  	echo  6 - Cambiar permisos
	  	echo  7 - Utilidad propuesta por ti
	  	echo  0 - Salir
	  	echo -----------------------------
	  	echo 
	  	
	  	# ELECCION DE LA OPCION MEDIANTE UNA DECLARACION CASE
	  	
	  	read -p "Introduzca la operacion que desea realizar: " opt
	  	
	  	case $opt in
	  	
		  	1)
		  		# OPCION 1
		  		
		    		echo
		    		echo "Introduzca lista de usuarios:" 
		    		read userslist
		    		
		    		# BUCLE PARA CREAR UNA CUENTA Y ASIGNAR CONTRASEÑA A CADA UNO DE LOS ELEMENTOS DE LA LISTA.
		    		
		    		for user in $userslist
		    		do
		    			# TAMBIEN GUARDA EL SALTO DE LINEA
		    			    			
		    			password="${user}_iso2122\n${user}_iso2122"		    			
		    			useradd -m $user
		    			
		    			echo
		    			echo -e $password | passwd $user
		    		done
		    		
		    		echo
		    		echo "Usuarios creados con exito."
		  		;;
		  		
		  	2)
		  		# OPCION 2
		  		
		    		echo
		    		echo "Introduzca la ruta absoluta donde se almacenaran los directorios:"
		    		read ruta
		    		
		    		# COMPRUEBA SI LA RUTA EXISTE. SI NO EXISTE LA CREA.
		    		
		    		if [ ! -e $ruta ]; then
		    			mkdir $ruta
		    		fi
		    		
		    		# BUCLE PARA CREAR UN DIRECTORIO POR CADA ELEMENTO DE LA LISTA
		    		
		    		echo
		    		echo "Introduzca lista de directorios que desea crear:"
		    		read dirlist
		    		
		    		for dir in $dirlist
		    		do
		    			mkdir $ruta/$dir
		    		done
		    		
		    		echo
		    		echo "Directorios creados con exito."	    		
		  		;;
		  		
		  	3)		    		
		    		# OPCION 3
		    		
		    		echo
		    		echo "Introduzca el directorio origen:"
		    		read src
		    		
		    		# COMPRUEBA SI EL ORIGEN EXISTE
		    		
		    		if [ ! -e $src ]; then
		    		
		    			echo
		    			echo "El directorio origen no existe."
		    			
		    		else		    		
			    		echo
			    		echo "Introduzca el directorio destino:"
			    		read dest
			    		
			    		# COMPRUEBA SI EL DESTINO EXISTE
			    		
			    		if [ ! -e $dest ]; then
			    		
			    			echo
		    				echo "El directorio destino no existe."
		    				
		    			else
				    		echo
				    		echo "Introduzca el fichero o patron que desea mover:"
				    		read file
				    		
				    		# COMPRUEBA SI EL FICHERO EXISTE
				    		
				    		if [ ! -e ${src}/${file} ]; then
				    		
		    					echo
		    					echo "El fichero no existe."
		    					
		    				else	
		    					
				    			mv ${src}/${file} $dest
				    			
		    					echo
		    					echo "Ficheros movidos con exito."
		    				fi
		    			fi
		    		fi
		  		;;
		  		
		  	4)
		  		# OPCION 4
		  		
		    		echo
		    		echo "Introduzca el directorio origen:"
		    		read src
		    		
		    		# COMPRUEBA SI EL ORIGEN EXISTE
		    		
		    		if [ ! -e $src ]; then
		    		
		    			echo
		    			echo "El directorio origen no existe."
		    			
		    		else		    		
			    		echo
			    		echo "Introduzca el directorio destino:"
			    		read dest
			    		
			    		# COMPRUEBA SI EL DESTINO EXISTE
			    		
			    		if [ ! -e $dest ]; then
			    		
			    			echo
		    				echo "El directorio destino no existe."
		    			else
		    			
				    		cp -R $src $dest	
				    					    		
				    		echo
				    		echo "Estructura replicada con exito."
				    		
		    			fi
		    		fi
		  		;;
		  		
		  	5)
		  		# OPCION 5
		  		
		    		echo
		    		echo "1 - Indique la ubicación a partir de la que comenzará la búsqueda: "
		    		read src 
		    		
		    		# COMPRUEBA SI EL DESTINO EXISTE
		    		
		    		if [ ! -e $src ]; then
		    		
		    			echo
		    			echo "El directorio origen no existe."
		    			
		    		else	
		    			# SEGUN LA ELECCION DEL USUARIO, SE CREARAN, A PARES, VARIABLES CON LA OPCION Y EL VALOR DE LA OPCION.
		    			# EN CASO DE SALTARNOS UNA OPCION, AMBOS PARAMETROS QUEDARAN VACIOS AL LLEGAR AL FINAL.
		    				    		
			    		echo
			    		echo "2 – Indique si va a buscar por nombre (S/I/N):" 
			    		read pornombre
			    		
			    		if [ $pornombre = "S" ]; then	
			    		
			    			optnombre="-name"
			    				    			
			    			echo
			    			echo "3 – Introduzca el nombre de lo que está buscando (Admite patrones con *):"
			    			read nombre
			    			
			    			nombre=""\""$nombre"\"""
			    			
			    		elif [ $pornombre = "I" ]; then	
			    		
			    			optnombre="-iname"
			    				    			
			    			echo
			    			echo "3 – Introduzca el nombre de lo que está buscando (Admite patrones con *):"
			    			read nombre
			    			
			    			nombre=""\""$nombre"\"""
			  		fi
			  		
			  		echo
			  		echo "4 – Indique si va a buscar por tipo de archivo (S/N):" 
			  		read portipo
			  		
			  		if [ $portipo = "S" ]; then
			  		
			  			opttipo="-type"
		    			
			    			echo
			    			echo "b: Ficheros tipo bloque."
						echo "c: Ficheros tipo carácter."
						echo "d: dicheros tipo directorio."
						echo "f: ficheros tipo ordinario."
						echo "l: ficheros tipo simbólico."
						echo "p: ficheros tipo tubería con nombre."
						echo "s: socket conexión a red."

			    			echo
			    			echo "5 – Seleccione el tipo de archivo:" 
			    			read tipo		    			
			    			
			  		fi
			  		
			  		echo
			  		echo "6 – Indique si desea buscar por usuario (S/N):" 
			  		read porusuario
			  		
			  		if [ $porusuario = "S" ]; then
			  		
			  			optusuario="-user"
		    			
			    			echo
			    			echo "7 – Introduzca el usuario o el UID por el que quiere filtrar:" 
			    			read usuario		    				
			  		fi
			  		
			  		echo
			  		echo "8 – Indique si va a buscar por tamaño en Megas (S/N):" 
			  		read pormegas
			  		
			  		if [ $pormegas = "S" ]; then	
		    				
			    			echo
			    			echo "9 – Introduzca el numero de megabytes minimo y maximo entre los que quiere buscar: " 
			    			read min max
			    			
			    			# SI LOS VALORES NO CUMPLEN CON LA RESTRICCION, LOS DATOS NO SE GUARDAN EN LAS VARIABLES.
			    			
			    			if [ $max -lt $min ]; then
		    			
				    			echo
				    			echo "¡Cuidado! El minimo no puede ser mayor que el máximo."

			  			else
				  			optsize="-size"
				  			minformat="+${min}M"
				  			maxformat="-${max}M"
				  		fi
			  		fi
			  		
			  		echo
			  		echo "10 – Indique si desea hacer un print (P) o un ls (L): " 
			  		read comomostrar
			  		
			  		if [ $comomostrar = "L" ]; then
		    			
			    			mostrar="-ls"		    				
			  		else 
			  			mostrar="-print"
			  			
			  		fi
			  			  		
			  		echo
			  		echo "11 – Indique si desea volcar la salida en un fichero (S/N): " 
			  		read sivolcar
			  		
			  		if [ $sivolcar = "S" ]; then
		    			
			    			echo
			    			echo "12 – Indique la ruta del fichero que almacenará la salida: " 
			    			read fichero
			    			
			    			eval find $src $optnombre "$nombre" $opttipo $tipo $optusuario $usuario $optsize $minformat $optsize $maxformat $mostrar > $fichero
			    			
			    			echo
			    			echo "Fichero creado con exito."   				
			  		else 
			  			eval find $src $optnombre "$nombre" $opttipo $tipo $optusuario $usuario $optsize $minformat $optsize $maxformat $mostrar
			  			
			  		fi			  		
		    		fi		    		
		  		;;
		  		
		  	6)
		  		# OPCION 6		  	
		  		
		  		# SEGUN LA ELECCION DEL USUARIO, CREAREMOS VARIABLES QUE JUNTAS COMPLETAN LA SINTAXIS DEL COMANDO CHMOD.
		  		
		  		echo
		    		echo "¿Desea cambiar permisos a un fichero (F) o directorio (D)?: " 
		    		read tipo
		    		
		    		if [ $tipo = D ]; then
		    			echo
		    			echo "¿El permiso se aplica solo al directorio (S) o de forma recursiva (R)?: " 
		    			read modo
		    			
		    			# PARAMETRO OPCIONAL
		    			
		    			if [ $modo = R ]; then
			    			recursiva="-R"
			    		fi		    		
		    		fi
		    		
		    		echo
		    		read -p "Indique la ruta del fichero o directorio: " ruta
		    		
		    		# COMPRUEBA SI LA RUTA EXISTE
		    		
		    		if [ ! -e $ruta ]; then
		    		
		    			echo
		    			echo "El directorio origen no existe."
		    			
		    		else
		    		
			    		echo
			    		echo "Indique a quien se le modificará el permiso: u – usuario, g – grupo, o – otros: " 
			    		read quien
			    		
			    		echo
			    		echo "¿Desea quitar (-) o añadir (+) permisos?: " 
			    		read accion
			    		
			    		echo
			    		echo "Indique los permisos que desea añadir o quitar: " 
			    		read permisos
			    		
			    		chmod $recursive ${quien}${accion}${permisos} $ruta
			    		
			    		echo
			    		echo "Permisos cambiados con exito."
			    	fi		    		
		  		;;
		  		
		  	7)
		  		# OPCION 7
		  		
		  		# SEGUN LA ELECCION DEL USUARIO, CREAREMOS VARIABLES QUE JUNTAS COMPLETAN LA SINTAXIS DEL COMANDO ZIP.
		  		
		  		echo
		    		echo "¿Desea comprimir un fichero (F) o un directorio (D)?: " 
		    		read tipo
		    		
		    		# PARAMETRO OPCIONAL
		    		
		  		if [ $tipo = D ]; then
		    			recursiva="-r"		    		
		    		fi
		    		
		    		echo
		    		echo "Indique la ruta del fichero o directorio que desea comprimir: " 
		    		read ruta
		    		
		    		if [ ! -e $ruta ]; then
		    		
		    			echo
		    			echo "El directorio origen no existe."
		    			
		    		else
		    		
			    		echo
			    		echo "Indique el nombre del comprimido: " 
			    		read nombre
			    		
			    		comprimido="${nombre}.zip"
			    		
			    		echo
			    		echo "Indique donde desee almacenar el comprimido: " 
			    		read dest
			  		
			  		encriptado="-e"
			  		rutabasura="-j"
			  		
			  		echo
			    		zip $recursiva $encriptado $rutabasura ${dest}/${nombre} $ruta
			    		
			    		echo
			    		echo "Comprimido creado con exito."
			    		
			    	fi			    		
		  		;;
		  		
		  	0)
		  		# OPCION 0
		  		
		  		# ROMPE EL WHILE Y SALE DEL PROGRAMA.
		  		
		    		echo ¡Adios!
		    		break		    		
		  		;;
		  		
		  	*)
		  		# GENERA ERROR PARA CUALQUIER OTRO PARAMETRO QUE NO APAREZCA EN EL MENU.
		  		
		    		echo ERROR: Parámetro inválido.
		  		;;
		esac
		
	done


else

	# GENERA ERROR PARA CUALQUIER OTRO PARAMETRO INICIAL.

	echo ERROR: Parámetro incorrecto.
	
fi