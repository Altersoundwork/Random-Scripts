#!/bin/bash
#
# This will install Minth X and Y themes on Ubuntu systems 18.04 and up.
# v0.1 - 29-07-2021
# dev: @Altersoundwork
#
clear
###############################################
echo ${bold}
echo "######################"
echo "Mint Themes for Ubuntu"
echo "######################"
echo ${normal}
###############################################
mkdir ~/mint-themes && cd ~/mint-themes
wget http://packages.linuxmint.com/pool/main/m/mint-x-icons/mint-x-icons_1.5.2_all.deb
wget http://packages.linuxmint.com/pool/main/m/mint-y-icons/mint-y-icons_1.3.4_all.deb
wget http://packages.linuxmint.com/pool/main/m/mint-themes/mint-themes_1.8.2_all.deb
sudo dpkg -i mint-x-icons_1.5.2_all.deb
sudo dpkg -i mint-y-icons_1.3.4_all.deb
sudo dpkg -i mint-themes_1.8.2_all.deb
cd .. && sudo rm -rf mint-themes/
clear
