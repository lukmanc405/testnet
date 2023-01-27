#!/bin/bash

echo "=================================================="
echo -e "\033[0;35m"
echo " | |  | | | | |/ /  \/  |  / \  | \ | |  ";
echo " | |  | | | | ' /| |\/| | / _ \ |  \| |  ";
echo " | |__| |_| | . \| |  | |/ ___ \| |\  |  ";
echo " |_____\___/|_|\_\_|  |_/_/   \_\_| \_|  ";
echo -e "\e[0m"
echo "=================================================="  
clear
sleep 2


if [ ! $EMAIL ]; then
        read -p "Enter EMAIL: " EMAIL
        echo 'export EMAIL='$EMAIL >> $HOME/.bash_profile
fi
sleep 1

if [ ! $ASSET_ID ]; then
	read -p "Enter ASSET_ID: " ASSET_ID
	echo 'export ASSET_ID='$ASSET_ID >> $HOME/.bash_profile
fi
source $HOME/.bash_profile

# update package
sudo apt update && sudo apt upgrade -y
# crontab and execute
chmod +x ironfish_auto.sh
source $HOME/.bash_profile
(crontab -l; echo "0 4 * * SAT ./ironfish_auto.sh";) | crontab
(crontab -l; echo "0 1 * * SAT-FRI echo $EMAIL | ironfish faucet";) | crontab

touch /root/logfile.log
source $HOME/.bash_profile
# restart crontab
systemctl disable cron && systemctl stop cron
systemctl enable cron && systemctl start cron && systemctl status cron
