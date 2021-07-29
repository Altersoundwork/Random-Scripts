#!/bin/bash
#
# Installs and configures the Realtek RTL8812BU wireless card on Debian based systems.
# v0.1 - 29-07-2021
# dev: @Altersoundwork
#
clear
################################################
echo ${bold}
echo "##########################################"
echo "Install & Configure Realtek RTL8812BU Wifi"
echo "##########################################"
echo ${normal}
#################################################
sudo apt-get update
sudo apt-get install build-essential git
git clone https://github.com/cilynx/rtl88x2BU_WiFi_linux_v5.2.4.4_25643.20171212_COEX20171012-5044.git
cd rtl88x2BU_WiFi_linux_v5.2.4.4_25643.20171212_COEX20171012-5044
VER=$(cat ./version)
sudo rsync -rvhP ./ /usr/src/rtl88x2bu-${VER}
sudo dkms add -m rtl88x2bu -v ${VER}
sudo dkms build -m rtl88x2bu -v ${VER}
sudo dkms install -m rtl88x2bu -v ${VER}
sudo modprobe 88x2bu
echo
read -p "${bold}All good?${normal}" -n 1 -r
echo    # (optional) move to a new line
if [[ ! $REPLY =~ ^[Yy]$ ]]
then
    [[ "$0" = "$BASH_SOURCE" ]] && echo && echo "Fix it then!" && echo && exit 1 || return 1 # handle exits from shell or function but don't exit interactive shell
fi
clear
echo
read -p "${bold}You will now need to reboot. Press Y to do no or N to do it later. ${normal}" -n 1 -r
echo    # (optional) move to a new line
if [[ ! $REPLY =~ ^[Yy]$ ]]
then
    [[ "$0" = "$BASH_SOURCE" ]] && echo && echo "${bold}The system must be restarted before continuing for correct functionality. Please manually restart as soon as possible.${normal}" && echo && exit 1 || return 1 # handle exits from shell or function but don't exit interactive shell
fi
sudo reboot
