#!/bin/bash
clear
exists()
{
  command -v "$1" >/dev/null 2>&1
}
if exists curl; then
	echo ''
else
   apt install curl -y < "/dev/null"
fi
echo "=================================================="
echo -e "\033[0;35m"
echo " | |  | | | | |/ /  \/  |  / \  | \ | |  ";
echo " | |  | | | | ' /| |\/| | / _ \ |  \| |  ";
echo " | |__| |_| | . \| |  | |/ ___ \| |\  |  ";
echo " |_____\___/|_|\_\_|  |_/_/   \_\_| \_|  ";
echo -e "\e[0m"
echo "=================================================="  
if [[ $(/usr/bin/id -u) -ne 0 ]]; then
    echo "Membatalkan penginstalan: harap gunakan sebagai root user!"
    exit 1
fi

sleep 2
echo -e 'Menginstall dependencies...\n' && sleep 1
sudo apt update && sudo apt upgrade -y
sudo apt install curl tar wget clang pkg-config libssl-dev jq build-essential bsdmainutils git make ncdu gcc git jq chrony liblz4-tool -y
sudo apt . <(wget -qO- https://raw.githubusercontent.com/SecorD0/utils/main/installers/rust.sh

echo -e 'Cloning snarkOS...\n' && sleep 1
rm -rf $HOME/snarkOS $(which snarkos) $(which snarkos) $HOME/.aleo $HOME/aleo
cd $HOME
git clone https://github.com/AleoHQ/snarkOS.git --depth 1
cd snarkOS

echo -e 'Menginstall snarkos ...\n' && sleep 1
./build_ubuntu.sh
source $HOME/.bashrc
source $HOME/.cargo/env
echo -e 'Membuat Aleo account address ...\n' && sleep 1
mkdir $HOME/aleo
echo "==================================================
                  AKUN ALEO ANDA:
==================================================
" > $HOME/aleo/account_new.txt
date >> $HOME/aleo/account_new.txt
snarkos account new >>$HOME/aleo/account_new.txt
sleep 2
cat $HOME/aleo/account_new.txt
echo -e "\033[41m\033[30mPASTIKAN MENYIMPAN PRIVATE KEY DAN VIEW KEY AKUN.\033[0m\n"
sleep 3
mkdir -p /var/aleo/
cat $HOME/aleo/account_new.txt >>/var/aleo/account_backup.txt
echo 'export PROVER_PRIVATE_KEY'=$(grep "Private Key" $HOME/aleo/account_new.txt | awk '{print $3}') >> $HOME/.bash_profile
source $HOME/.bash_profile

# echo -e 'Membuat layanan Aleo Client Node...\n' && sleep 1
# echo "[Unit]
# Description=Aleo Client Node
# After=network-online.target
# [Service]
# User=$USER
# ExecStart=$(which snarkos) start --nodisplay --client ${PROVER_PRIVATE_KEY}
# Restart=always
# RestartSec=10
# LimitNOFILE=10000
# [Install]
# WantedBy=multi-user.target
# " > $HOME/aleo-client.service
#  mv $HOME/aleo-client.service /etc/systemd/system
 tee <<EOF >/dev/null /etc/systemd/journald.conf
Storage=persistent
EOF

sleep 2
systemctl restart systemd-journald
echo -e 'Creating a service for Aleo Prover Node...\n' && sleep 1
echo "[Unit]
Description=Aleo Prover Node
After=network-online.target
[Service]
User=$USER
ExecStart=$(which snarkos) start --nodisplay --prover ${PROVER_PRIVATE_KEY}
Restart=always
RestartSec=10
LimitNOFILE=10000
[Install]
WantedBy=multi-user.target
" > $HOME/aleo-prover.service
 mv $HOME/aleo-prover.service /etc/systemd/system
sleep 1
echo -e "Menginstall Aleo Updater\n"
cd $HOME
wget -q -O $HOME/aleo_updater.sh https://raw.githubusercontent.com/lukmanc405/testnet/main/aleo/aleo_updater.sh && chmod +x $HOME/aleo_updater.sh
echo "[Unit]
Description=Aleo Updater
After=network-online.target
[Service]
User=$USER
WorkingDirectory=$HOME/snarkOS
ExecStart=/bin/bash $HOME/aleo_updater.sh
Restart=always
RestartSec=10
LimitNOFILE=10000
[Install]
WantedBy=multi-user.target
" > $HOME/aleo-updater.service
mv $HOME/aleo-updater.service /etc/systemd/system
systemctl daemon-reload

echo -e 'Mengaktifkan Layanan aleo-updater\n' && sleep 1
systemctl enable aleo-updater
systemctl restart aleo-updater
echo -e '\n\e[42mMenjalankan Aleo Prover Node\e[0m\n' && sleep 1
systemctl enable aleo-prover
systemctl restart aleo-prover

if [[ `service aleo-prover status | grep active` =~ "running" ]]; then
  echo -e "Aleo Prover Node \e[32mtelah terinstall\e[39m!"
  echo -e "Anda dapat memeriksa node status dengan command \e[7msystemctl status aleo-prover\e[0m"
  echo -e "Anda dapat memeriksa log Aleo Prover Node dengan command \e[7mjournalctl -u aleo-prover -f -o cat\e[0m"
  echo -e "Tekan \e[7mctrl+c\e[0m untuk keluar dari logs"
else
  echo -e "Aleo Prover Node \e[31mtidak terinstall dengan benar\e[39m, lakukan install ulang."
fi
