#!/bin/bash

DIRECTORIO_EPNRO1="$HOME/EPNro1"
CONSOLIDAR="$DIRECTORIO_EPNRO1/consolidar.sh"
ARCHIVO_LOG="$DIRECTORIO_EPNRO1/procesado/procesado.log"
ARCHIVO_FINAL="$DIRECTORIO_EPNRO1/salida/$FILENAME.txt"

if [[ $1 = "-d" ]]; then
        echo "Ejecutando limpieza."
        pkill -f $CONSOLIDAR
        rm -r -f $DIRECTORIO_EPNRO1
fi

opcion=0

until [ $opcion -eq 7 ]; do
echo "1- Crear Entorno"
echo "2- Correr Proceso"
echo "3- Ordenar por numero de padron"
echo "4- Mostrar las 10 notas mas altas"
echo "5- Datos de Alumno"
echo "6- Visualizar log"
echo "7- Salir"
read -p "Elija una opcion: " opcion

        case $opcion in
                1)
                  echo "Creando entorno..."
                  mkdir -p $DIRECTORIO_EPNRO1/{entrada,salida,procesado}
                  if [[ -f consolidar.sh ]]; then
                          cp consolidar.sh $DIRECTORIO_EPNRO1
                          chmod +x $CONSOLIDAR
                  else
                          echo "No se encuentra el archivo consolidar.sh."
                  fi
                  echo "Entorno creado"
                ;;
                2)
                  if [[ -f $CONSOLIDAR ]]; then
                          echo "Corriendo proceso..."
                          $CONSOLIDAR &
                  else
                          echo "No se ha encontrado consolidar.sh. Debe seleccionar la Opcion 1 primero."
                  fi
                ;;
                3) 
                  if test -f "$ARCHIVO_FINAL"; then
                          sort -k1,1n "$ARCHIVO_FINAL"
                  else
                          echo "No se encuentra el archivo $FILENAME.txt."
                  fi
                ;;
                4) 
                  if test -f "$ARCHIVO_FINAL"; then
                          sort -k5,5nr "$ARCHIVO_FINAL" | head -n 10
                  else 
                          echo "No se encuentra el archivo $FILENAME.txt."
                  fi
                ;;
                5) 
                  echo "Ingrese un número de padrón (solo números):"
                  read numeropadron

                  buscar=$(grep -w "^$numeropadron" $ARCHIVO_FINAL)

                  until [[ "$numeropadron" =~ ^[0-9]+$ ]] && [[ -n "$buscar" ]]
                  do 
                          echo "Número de padrón no encontrado. Ingrese uno válido (solo números): "
                          read numeropadron
                          buscar=$(grep -w "^$numeropadron" $ARCHIVO_FINAL)

                  done
                  echo "Datos del padrón:"
                  echo "$buscar"
                ;;
                6)
                  cat $ARCHIVO_LOG
                ;;
                7)
                  echo "Saliendo..."
                          exit 0
                ;;
                *)
                  echo "Opcion invalida, intente nuevamente."
                ;;
        esac
done
