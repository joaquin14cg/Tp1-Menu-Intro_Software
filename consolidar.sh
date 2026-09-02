#!/bin/bash


while true
do 
    for archivo in $HOME/EPNro1/entrada/*.txt
    do 
        FECHA_HORA=$(date "+%d/%m/%Y %T")
        cat "$archivo" >> $HOME/EPNro1/salida/$FILENAME.txt
        mv "$archivo" $HOME/EPNro1/procesado/
        echo "$FECHA_HORA - Procesado archivo $(basename "$archivo")" >> $HOME/EPNro1/procesado/procesado.log
    done
sleep 30    
done                            
