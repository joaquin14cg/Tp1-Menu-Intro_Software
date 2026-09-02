#!/bin/bash


while true
do 
    for archivo in entrada/*.txt
    do 
        FECHA_HORA=$(date "+%d/%m/%Y %T")
        cat "$archivo" >> $CARPETA_SALIDA/$FILENAME.txt
        mv "$archivo" $CARPETA_PROCESADO
        echo "$FECHA_HORA - Procesado archivo $(basename "$archivo")" >> $ARCHIVO_LOG
    done
sleep 30    
done                            
