# Random-Scripts
My collection of random scripts I've made at work (modified for public use) to make my life simpler for random needs.

<h2>00-soundwork-motd:</h2>

<h4>Dependencies:</h4>
- landscape-common<br>
- neofetch<p>

A MOTD replacement file (you'll need to remove ALL other files under /etc/update-motd.d/). Run the following command:

<code>sudo apt install landscape-common neofetch -y && cd /etc && sudo tar cvf update-motd.d.BKUP.tar.gz update-motd.d && sudo rm -rf /etc/update-motd.d/* && sudo mv update-motd.d.BKUP.tar.gz /etc/update-motd.d/ && sudo touch /etc/update-motd.d/00-soundwork-motd && sudo chmod +x /etc/update-motd.d/00-soundwork-motd && sudo nano /etc/update-motd.d/00-soundwork-motd</code>

Paste the contents of 00-soundwork-motd in to your file, save and exit. All done, go ahead, try to ssh user@localhost :)

<h2>ec2_storage_speed_test.sh</h2>

A selection of different types of storage speed tests geared to deciding between GP2 & GP3 on AWS EC2 based on your needs.

This script will install and test with the following.
- sysstat
- sysbench
- hdparm
- iotop
- fio
- ioping

<h2>mint_themes_ubuntu.sh</h2>



<h2>realtek_rtl8812bu.sh</h2>



<h2>x11vnc_setup.sh</h2>
