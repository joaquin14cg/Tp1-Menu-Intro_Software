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

#3

if test -f "$ALUMNOS"; then
    sort -k1,1n "$ALUMNOS"
else
    echo "No se encuentra el archivo $FILENAME.txt"
fi


#4

if test -f "$ALUMNOS"; then
    sort -k5,5nr "$ALUMNOS" | head -n 10
else
    echo "No se encuentra el archivo $FILENAME.txt"
fi
