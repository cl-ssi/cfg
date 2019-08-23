#!/bin/bash
cd /mnt/respaldo

hoy=`date +%F`
echo "Hoy: $hoy"
ayer=`date +%F --date="today - 1 days"`
echo "Ayer: $ayer"
max_backup=`date +%F --date="today - 60 days"`
echo "Ultimo backup $max_backup"


# Sólo si no existe el directorio max_bacukp
if [ ! -d ${max_backup} ]; then
        echo "Directorio $max_backup no existe, creado."
        mkdir ${max_backup}
fi

echo "Moviendo directorio $max_backup a $hoy"
mv ${max_backup} ${hoy}
echo "Sincronizando archivos entre $max_backup ($hoy) con el dia de ayer"
cp -al ${ayer}/. ${hoy}
echo "Sincronizando archivos con directorio $hoy"
rsync -a --delete /home/compartidor/ ${hoy}/


#mv backup.3 backup.tmp
#mv backup.2 backup.3
#mv backup.1 backup.2
#mv backup.0 backup.1
#mv backup.tmp backup.0
#cp -al backup.1/. backup.0
#rsync -a --delete /home/compartidor/ backup.0/
# Si existe respaldo de bd rem
#if [ -f ${max_backup} ]; then
#       rm -rf ${max_backup}
#fi
