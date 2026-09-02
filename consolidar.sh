#!/bin/bash


while true
do 
    for archivo in entrada/*.txt
    do 
        FECHA_HORA=$(date "+%d/%m/%Y %T")
        cat "$archivo" >> salida/$FILENAME.txt
        mv "$archivo" procesado/
        echo "$FECHA_HORA - Procesado archivo $(basename "$archivo")" >> procesado/procesado.log
    done
sleep 30    
done                            
