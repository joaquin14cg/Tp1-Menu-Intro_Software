#!/bin/bash

#test lo que hace es evaluar una codicion y devuelve 0 si paso con exito o 1 en caso contrario, al ponerle la flag -f
#lo que evalua es si existe algo en la ubicacion que le pase a continuacion y si es un archivo

# sort lo que hace es ordenar de menor a mayor, y con las flags le decimos que es lo que tiene que ordenar
# con -k1,1 lo que le decimos es agarra la columna 1 hasta la columna 1, entonces solo ordena la 1
# con la n que va seguida del segundo 1 en verdad es la flag -n y sirve para que interprete los valores como numeros y no como texto

#head muestra los primeros elementos de una lista y con -n le podemos decir cuantos queremos que nos muestre

if [[ -z $FILENAME ]]; then
    FILENAME="alumnos"
fi

if [[ $1 = "-d" ]]; then
        echo "ejecutando limpieza"
        pkill -f $CONSOLIDAR
        rm -r -f $DIRECTORIO_EPNRO1
fi

ALUMNOS="$HOME/EPNro1/salida/$FILENAME.txt"
DIRECTORIO_EPNRO1="$HOME/EPNro1"
CARPETA_ENTRADA="$DIRECTORIO_EPNRO1/entrada"
CARPETA_SALIDA="$DIRECTORIO_EPNRO1/salida"
CARPETA_PROCESADO="$DIRECTORIO_EPNRO1/procesado"
ARCHIVO_FINAL="$CARPETA_SALIDA/$FILENAME.txt"
ARCHIVO_LOG="$CARPETA_PROCESADO/procesado.log"
CONSOLIDAR="$DIRECTORIO_EPNRO1/consolidar.sh"
opcion=0
until [ $opcion -eq 7 ]; do
echo "1- Crear Entorno"
echo "2- Correr Proceso"
echo "3- Ordenar por numero de padron"
echo "4- Mostrar las 10 notas mas altas"
echo "5- Datos de Alumno"
echo "6- Visualizar log"
echo "7- Salir"
read -p "Elija una opcion" opcion
case $opcion in
        1)
          echo "Creando entorno..."
          mkdir -p $DIRECTORIO_EPNRO1/{entrada,salida,procesado}
          if [[ -f consolidar.sh ]]; then
                  cp consolidar.sh $DIRECTORIO_EPNRO1
                  chmod +x $CONSOLIDAR
          else
                  echo "No se encuentra el archivo consolidar.sh"
          fi
          echo "Entorno creado"
          ;;
        2)
          if [[ -f $CONSOLIDAR ]]; then
                    echo "Corriendo proceso..."
                    $CONSOLIDAR &
          else
             echo -n "No se ha encontrado consolidar.sh"
             echo "Debe seleccionar la Opcion 1 primero"
          fi
          ;;
        3) 
        if test -f "$ALUMNOS"; then
        sort -k1,1n "$ALUMNOS"
        else
        echo "No se encuentra el archivo $FILENAME.txt"
        fi
        ;;
        4) 
        if test -f "$ALUMNOS"; then
        sort -k5,5nr "$ALUMNOS" | head -n 10
        else
        echo "No se encuentra el archivo $FILENAME.txt"
        fi
        ;;
        5) 
        echo "Ingrese un número de padrón (solo números):"
        read numeropadron

        buscar=$(grep -w "$numeropadron" padronprueba.txt)

        until [[ "$numeropadron" =~ ^[0-9]+$ ]] && [[ -n "$buscar" ]]
        do 
        echo "Número de padrón no encontrado. Ingrese uno válido (solo números): "
        read numeropadron
        buscar=$(grep -w "$numeropadron" padronprueba.txt)

        done
        echo "Datos del padrón:"
        echo "$buscar"

        ;;
        7)echo "Saliendo..."
                exit 0
          ;;
        *)echo "Opcion invalida, intente nuevamente"
          ;;
esac
done