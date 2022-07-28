#!/bin/bash
echo "=================================================="
echo -e "\033[0;35m"
echo " | |  | | | | |/ /  \/  |  / \  | \ | |  ";
echo " | |  | | | | ' /| |\/| | / _ \ |  \| |  ";
echo " | |__| |_| | . \| |  | |/ ___ \| |\  |  ";
echo " |_____\___/|_|\_\_|  |_/_/   \_\_| \_|  ";
echo -e "\e[0m"
echo "=================================================="  


echo -e "\e[1m\e[32m1. Pembaruan paket... \e[0m" && sleep 1
sudo apt update && sudo apt upgrade -y

echo -e "\e[1m\e[32m2. Instal paket yang diperlukan... \e[0m" && sleep 1
sudo apt install wget jq git libclang-dev cmake -y

echo -e "\e[1m\e[32m3. Instal Rust... \e[0m" && sleep 1
wget -qO- https://raw.githubusercontent.com/SecorD0/utils/main/installers/rust.sh

echo -e "\e[1m\e[32m4. Buat direktori sui& clone repo... \e[0m" && sleep 1
mkdir -p $HOME/.sui
git clone https://github.com/MystenLabs/sui
cd sui
git remote add upstream https://github.com/MystenLabs/sui && git fetch upstream && git checkout --track upstream/devnet

echo -e "\e[1m\e[32m5. Build file bineri (kecepatan tergantung core prosesor, mungkin memakan waktu 10 menit).. \e[0m" && sleep 1
cargo build --release

echo -e "\e[1m\e[32m6. Pindahkan binari ke folder binari.. \e[0m" && sleep 1
mv $HOME/sui/target/release/{sui,sui-node,sui-faucet} /usr/bin/
cd

echo -e "\e[1m\e[32m7. Download Genesis File.. \e[0m" && sleep 1
wget -qO $HOME/.sui/genesis.blob https://github.com/MystenLabs/sui-genesis/raw/main/devnet/genesis.blob

echo -e "\e[1m\e[32m8. Copy config.. \e[0m" && sleep 1
cp $HOME/sui/crates/sui-config/data/fullnode-template.yaml \
$HOME/.sui/fullnode.yaml

echo -e "\e[1m\e[32m9. Edit config.. \e[0m" && sleep 1
sed -i -e "s%db-path:.*%db-path: \"$HOME/.sui/db\"%; "\
"s%metrics-address:.*%metrics-address: \"0.0.0.0:9184\"%; "\
"s%json-rpc-address:.*%json-rpc-address: \"0.0.0.0:9000\"%; "\
"s%genesis-file-location:.*%genesis-file-location: \"$HOME/.sui/genesis.blob\"%; " $HOME/.sui/fullnode.yaml

echo -e "\e[1m\e[32m10. Buat file service.. \e[0m" && sleep 1
printf "[Unit]
Description=Sui node
After=network-online.target

[Service]
User=$USER
ExecStart=`which sui-node` --config-path $HOME/.sui/fullnode.yaml
Restart=on-failure
RestartSec=3
LimitNOFILE=65535

[Install]
WantedBy=multi-user.target" > /etc/systemd/system/suid.service

echo -e "\e[1m\e[32m11. Mulai menjalankan node.. \e[0m" && sleep 1
sudo systemctl daemon-reload
sudo systemctl enable suid
sudo systemctl restart suid
