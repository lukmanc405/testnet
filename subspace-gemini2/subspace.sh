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

# set vars
echo -e "\e[1m\e[32mMasukkan node name dibawah ini dengan nama node kamu\e[0m"
if [ ! $NAMANODE ]; then
	read -p "Enter node name: " NAMANODE
	echo 'export NAMANODE='$NAMANODE >> $HOME/.bash_profile
fi
echo -e "\e[1m\e[32mMasukkan wallet address dibawah ini dengan account address dari akun subspace yang anda buat tadi\e[0m"
if [ ! $ADDRESS_SUBSPACE ]; then
	read -p "Enter wallet address: " ADDRESS_SUBSPACE
	echo 'export ADDRESS_SUBSPACE='$ADDRESS_SUBSPACE >> $HOME/.bash_profile
fi
echo -e "\e[1m\e[32mMasukkan plot size dalam gigabytes atau terabytes, untuk instance 100G atau 2T (tapi sisakan setidaknya 10G dari disk space untuk node)\e[0m"
echo -e "\e[1m\e[31mDefault plot size akan diatur menjadi 100 GB maximum (farmers mungkin akan mengubah plot size kurang dari 100 GB, tapi tidak lebih)\e[0m"
if [ ! $UKURAN_PLOT ]; then
	read -p "Enter plot size , max 100GB(ex. Format 100GB) : " UKURAN_PLOT
	echo 'export UKURAN_PLOT='$UKURAN_PLOT >> $HOME/.bash_profile
fi
source ~/.bash_profile

echo '================================================='
echo -e "Your node name: \e[1m\e[32m$NAMANODE\e[0m"
echo -e "Your wallet name: \e[1m\e[32m$ADDRESS_SUBSPACE\e[0m"
echo -e "Your plot size: \e[1m\e[32m$UKURAN_PLOT\e[0m"
echo -e '================================================='
sleep 3

echo -e "\e[1m\e[32m1. Updating packages... \e[0m" && sleep 1
# update packages
sudo apt update && sudo apt upgrade -y

echo -e "\e[1m\e[32m2. Installing dependencies... \e[0m" && sleep 1
# update dependencies
sudo apt install curl jq ocl-icd-opencl-dev libopencl-clang-dev libgomp1 -y

# update executables
cd $HOME
rm -rf subspace-*
APP_VERSION=$(curl -s https://api.github.com/repos/subspace/subspace/releases/latest | jq -r ".tag_name" | sed "s/runtime-/""/g")
wget -O subspace-node https://github.com/subspace/subspace/releases/download/${APP_VERSION}/subspace-node-ubuntu-x86_64-${APP_VERSION}
wget -O subspace-farmer https://github.com/subspace/subspace/releases/download/${APP_VERSION}/subspace-farmer-ubuntu-x86_64-${APP_VERSION}
chmod +x subspace-*
mv subspace-* /usr/local/bin/

echo -e "\e[1m\e[32m4. Starting service... \e[0m" && sleep 1
# create subspace-node service 
tee $HOME/subspaced.service > /dev/null <<EOF
[Unit]
Description=Subspace Node
After=network.target

[Service]
User=$USER
Type=simple
ExecStart=$(which subspace-node) --chain gemini-2a --execution wasm --state-pruning archive --validator --name $NAMANODE
Restart=on-failure
LimitNOFILE=65535

[Install]
WantedBy=multi-user.target
EOF

# create subspaced-farmer service 
tee $HOME/subspaced-farmer.service > /dev/null <<EOF
[Unit]
Description=Subspaced Farm
After=network.target

[Service]
User=$USER
Type=simple
ExecStart=$(which subspace-farmer) farm --reward-address $ADDRESS_SUBSPACE --plot-size $UKURAN_PLOT
Restart=on-failure
LimitNOFILE=65535

[Install]
WantedBy=multi-user.target
EOF

mv $HOME/subspaced* /etc/systemd/system/
sudo systemctl restart systemd-journald
sudo systemctl daemon-reload
sudo systemctl enable subspaced subspaced-farmer
sudo systemctl restart subspaced
sleep 30
sudo systemctl restart subspaced-farmer
sleep 5
