#!/bin/bash
echo "=================================================="
echo -e "\033[0;35m"
echo " | |  | | | | |/ /  \/  |  / \  | \ | |  ";
echo " | |  | | | | ' /| |\/| | / _ \ |  \| |  ";
echo " | |__| |_| | . \| |  | |/ ___ \| |\  |  ";
echo " |_____\___/|_|\_\_|  |_/_/   \_\_| \_|  ";
echo -e "\e[0m"
echo "=================================================="  

sleep 2
# Install Binaries && cargo
apt install cargo -y
sudo curl https://sh.rustup.rs/ -sSf | sh -s -- -y
source $HOME/.cargo/env && cargo install --locked --git https://github.com/MystenLabs/sui.git --branch "devnet" sui

sleep 1

echo -e "\e[1m\e[32m1. Updating packages... \e[0m" && sleep 1
# update
sudo apt update && sudo apt upgrade -y

sleep 1



# confirmation instalation
echo $PATH

sleep 1



# open wallet
cd sui

echo -e "\e[1m\e[32mSui Wallet Created \e[0m"

echo -e "\e[1m\e[32mSelanjutnya anda perlu mengetik sui \e[0m"
