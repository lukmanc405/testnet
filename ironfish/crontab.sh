# variable
#!/bin/bash
clear
echo "=================================================="
echo -e "\033[0;35m"
echo " | |  | | | | |/ /  \/  |  / \  | \ | |  ";
echo " | |  | | | | ' /| |\/| | / _ \ |  \| |  ";
echo " | |__| |_| | . \| |  | |/ ___ \| |\  |  ";
echo " |_____\___/|_|\_\_|  |_/_/   \_\_| \_|  ";
echo -e "\e[0m"
echo "=================================================="  
sleep 2

if [ ! $ASSET_ID ]; then
	read -p "Enter ASSET_ID: " ASSET_ID
	echo 'export ASSET_ID='$ASSET_ID >> $HOME/.bash_profile
fi
source $HOME/.bash_profile

# crontab and execute
chmod +x ironfish_auto.sh
cat > /etc/cron.d/myjob << EOF
SHELL=/bin/bash 
PATH=/sbin:/bin:/usr/sbin:/usr/bin 
MAILTO=root HOME=/  
0 0 * * */TUE root bash ./ironfish_auto.sh
EOF

touch /root/logfile.log
source $HOME/.bash_profile
# restart crontab
systemctl disable cron && systemctl stop cron
systemctl enable cron && systemctl start cron && systemctl status cron
