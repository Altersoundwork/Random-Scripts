#!/bin/bash

# date: 18/03/2021
# dev: @Altersoundwork

clear
sudo apt install sysstat sysbench hdparm iotop fio ioping -y
mkdir ~/benchmark
cd ~/benchmark
clear
#################################
echo ${bold}
echo "##########################"
echo "Prueba de velocidad HDParm"
echo "##########################"
echo ${normal}
#################################
sudo hdparm -tT /dev/disk/by-partuuid/8757600c-01
#######################################
echo ${bold}
echo "################################"
echo "Prueba de velocidad escritura DD"
echo "################################"
echo ${normal}
#######################################
dd if=/dev/zero of=benchfile bs=4k count=200000 && sync; rm benchfile
#######################################
echo ${bold}
echo "################################"
echo "Prueba de velocidad lectura DD"
echo "################################"
echo ${normal}
#######################################
dd if=/dev/zero of=/dev/null count=1000000 && sync
######################################################
echo ${bold}
echo "###############################################"
echo "SysBench (fijaos primordialmente en Throughput)"
echo "###############################################"
echo ${normal}
######################################################
sysbench fileio prepare >/dev/null
sysbench fileio --file-test-mode=rndrw run
rm test_file.*
###################################################
echo ${bold}
echo "############################################"
echo "FIO - Test Lectura y Escritura aleatoria 3/1"
echo "############################################"
echo "Esto creará un archivo de 4 GB y realizará lecturas y escrituras de 4 KB utilizando un 75% / 25% (es decir, se realizan 3 lecturas por cada 1 escritura) con 64 operaciones ejecutándose a la vez. La proporción de 3:1 es una aproximación aproximada a una db típica."
echo ${normal}
###################################################
fio --randrepeat=1 --ioengine=libaio --direct=1 --gtod_reduce=1 --name=test --filename=test --bs=4k --iodepth=64 --size=4G --readwrite=randrw --rwmixread=75
##############################
echo ${bold}
echo "#######################"
echo "FIO - Lectura aleatoria"
echo "#######################"
echo ${normal}
##############################
fio --randrepeat=1 --ioengine=libaio --direct=1 --gtod_reduce=1 --name=test --filename=test --bs=4k --iodepth=64 --size=4G --readwrite=randread
################################
echo ${bold}
echo "#########################"
echo "FIO - Escritura aleatoria"
echo "#########################"
echo ${normal}
################################
fio --randrepeat=1 --ioengine=libaio --direct=1 --gtod_reduce=1 --name=test --filename=test --bs=4k --iodepth=64 --size=4G --readwrite=randwrite
################################
echo ${bold}
echo "##############################"
echo "IOPing - Latencia por petición"
echo "##############################"
echo ${normal}
################################
ioping -c 20 .
###################################################################################################################################
echo ${bold}
echo "Commo nota final, podéis usar iotop o iostat en una terminal secundaria para ver el uso en tiempo real al correr estos tests"
echo ${normal}
###################################################################################################################################
#
#
#
#
# si has llegado aquí por el tweet de Érica Aguado, que sepas que nano mola más.
#
#
# >;)
