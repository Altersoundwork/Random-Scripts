#!/bin/bash
#
# date: 28/03/2021
# dev: @Altersoundwork
#
clear
###################################################################################################################################
echo ${bold}
echo "##################"
echo "VNC Setup (X11VNC)"
echo "##################"
echo ${normal}
###################################################################################################################################
sudo apt autoremove --purge vino -y
sudo apt install x11vnc
sudo mkdir /etc/x11vnc
sudo x11vnc --storepasswd /etc/x11vnc/vncpwd
sudo bash -c "echo [Unit] >> /lib/systemd/system/x11vnc.service"
sudo bash -c "echo Description=Start x11vnc at startup. >> /lib/systemd/system/x11vnc.service"
sudo bash -c "echo After=multi-user.target >> /lib/systemd/system/x11vnc.service"
sudo bash -c "echo  >> /lib/systemd/system/x11vnc.service"
sudo bash -c "echo [Service] >> /lib/systemd/system/x11vnc.service"
sudo bash -c "echo Type=simple >> /lib/systemd/system/x11vnc.service"
sudo bash -c "echo ExecStart=/usr/bin/x11vnc -auth guess -forever -noxdamage -repeat -rfbauth /etc/x11vnc/vncpwd -rfbport 5900 -shared >> /lib/systemd/system/x11vnc.service"
sudo bash -c "echo  >> /lib/systemd/system/x11vnc.service"
sudo bash -c "echo [Install] >> /lib/systemd/system/x11vnc.service"
sudo bash -c "echo WantedBy=multi-user.target >> /lib/systemd/system/x11vnc.service"
sudo systemctl daemon-reload
sudo systemctl enable x11vnc.service
sudo systemctl start x11vnc.service
clear
