#!/bin/bash
#
# A selection of different types of storage speed tests geared to deciding between GP2 & GP3 on AWS EC2 based on your needs.
# Meant to be ran in an Ubuntu server instance.
#
# v0.3 - 30-07-2021
# dev: @Altersoundwork
#
# This script will install the following.
# - sysstat
# - sysbench
# - hdparm
# - iotop
# - fio
# - ioping
#
# Requirements
bold=$(tput bold)
normal=$(tput sgr0)
#
clear
##############################################
echo ${bold}
echo "########################################"
echo "AWS EC2 Debian based Storage Speed Tests"
echo "########################################"
echo ${normal}
###############################################
echo
echo "A selection of different types of storage speed tests geared to deciding between GP2 & GP3 on AWS EC2 based on your needs. All results are saved in the \"~/benchmark\" folder"
echo
sleep 2
echo "Note that most of these tests are limited to the drive the OS is in. If you wish to test a different drive, this isn't the script for that."
echo
sleep 2
echo "As a side note, you can open another terminal window and use iotop or iostat to view the effect of these tests in real time."
echo
sleep 3
echo "We will now install the required packages for testing."
sleep 2
sudo apt install sysstat sysbench hdparm iotop fio ioping -y > /dev/null 2>&1
mkdir ~/benchmark && cd ~/benchmark
clear
#######################
echo ${bold}
echo "################"
echo "HDParm Speedtest"
echo "################"
echo ${normal}
#######################
echo
echo ${bold}"What partition do you want to test (type the uid you want from the following list and press Enter)?"${normal}
echo
ls /dev/disk/by-partuuid/
echo
echo ${bold}"Partition:"${normal}
read partuid
sudo bash -c "echo \#\#\#\#\#\#\# HDParm speed test \#\#\#\#\#\#\# >> ~/benchmark/hdparm-results"
sudo hdparm -tT /dev/disk/by-partuuid/$partuid |& tee -a ~/benchmark/hdparm-results
echo
#######################################
echo ${bold}
echo "################################"
echo "DD write speed test"
echo "################################"
echo ${normal}
#######################################
echo
sudo bash -c "echo \#\#\#\#\#\#\# DD write speed test \#\#\#\#\#\#\# >> ~/benchmark/dd-write"
sudo bash -c "echo  >> ~/benchmark/dd-write"
sudo dd if=/dev/zero of=benchfile bs=4k count=200000 |& sudo tee -a ~/benchmark/dd-write && sudo sync; sudo rm benchfile
echo
#######################################
echo ${bold}
echo "################################"
echo "DD read speed test"
echo "################################"
echo ${normal}
#######################################
echo
sudo bash -c "echo \#\#\#\#\#\#\# DD read speed test \#\#\#\#\#\#\# >> ~/benchmark/dd-read"
sudo bash -c "echo  >> ~/benchmark/dd-read"
sudo dd if=/dev/zero of=/dev/null count=1000000 |& sudo tee -a ~/benchmark/dd-read && sync 
echo
############################################
echo ${bold}
echo "#####################################"
echo "SysBench (focus on Throughput result)"
echo "#####################################"
echo ${normal}
############################################
echo
sudo bash -c "echo \#\#\#\#\#\#\# SysBench \(focus on Throughput result\) \#\#\#\#\#\#\# >> ~/benchmark/sysbench"
sudo bash -c "echo  >> ~/benchmark/sysbench"
sudo sysbench fileio prepare >/dev/null
sudo sysbench fileio --file-test-mode=rndrw run |& tee -a ~/benchmark/sysbench
rm test_file.*
echo
#######################################################################
echo ${bold}
echo "################################################################"
echo "FIO - 3/1 Random Read/Write test (Emulating a DB-like behaviour)"
echo "################################################################"
echo ${normal}
#######################################################################
echo ${bold}
echo "This creates a 4Gb file and performs random 4Kb reads and writes in a 3 reads per 1 write fashion with 64 operations being executed at the same time."
echo ${normal}
sudo bash -c "echo \#\#\#\#\#\#\# FIO - 3\/1 Random Read\/Write test \(Emulating a DB\-like behaviour\) \#\#\#\#\#\#\# >> ~/benchmark/fio-read3-write1-dbliketest"
sudo bash -c "echo  >> ~/benchmark/fio-read3-write1-dbliketest"
sudo fio --randrepeat=1 --ioengine=libaio --direct=1 --gtod_reduce=1 --name=test --filename=test --bs=4k --iodepth=64 --size=4G --readwrite=randrw --rwmixread=75 |& tee -a ~/benchmark/fio-read3-write1-dbliketest
echo
########################
echo ${bold}
echo "#################"
echo "FIO - Random Read"
echo "#################"
echo ${normal}
########################
echo
sudo bash -c "echo \#\#\#\#\#\#\# FIO Random Read \#\#\#\#\#\#\# >> ~/benchmark/fio-read"
sudo bash -c "echo  >> ~/benchmark/fio-read"
sudo fio --randrepeat=1 --ioengine=libaio --direct=1 --gtod_reduce=1 --name=test --filename=test --bs=4k --iodepth=64 --size=4G --readwrite=randread |& tee -a ~/benchmark/fio-read
echo
################################
echo ${bold}
echo "##################"
echo "FIO - Random Write"
echo "##################"
echo ${normal}
################################
echo
sudo bash -c "echo \#\#\#\#\#\#\# FIO Random Write \#\#\#\#\#\#\# >> ~/benchmark/fio-write"
sudo bash -c "echo  >> ~/benchmark/fio-write"
sudo fio --randrepeat=1 --ioengine=libaio --direct=1 --gtod_reduce=1 --name=test --filename=test --bs=4k --iodepth=64 --size=4G --readwrite=randwrite |& tee -a ~/benchmark/fio-write
echo
#############################
echo ${bold}
echo "######################"
echo "IOPing - Query Latency"
echo "######################"
echo ${normal}
#############################
echo
sudo bash -c "echo \#\#\#\#\#\#\# IOPing - Query Latency \#\#\#\#\#\#\# >> ~/benchmark/ioping-latency"
sudo bash -c "echo  >> ~/benchmark/ioping-latency"
sudo ioping -c 20 . |& tee -a ~/benchmark/ioping-latency
echo
sleep 5
clear
##############
echo ${bold}
echo "#######"
echo "Results"
echo "#######"
echo ${normal}
##############
echo
echo "You can see all your results in the \"~/benchmark\" folder"
sleep 1
echo
ls --format=single-column ~/benchmark
echo
