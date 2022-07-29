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
wget -qO- https://raw.githubusercontent.com/kir3d/Sui_binary/main/sui_binary.sh
