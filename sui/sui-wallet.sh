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

echo -e "\e[1m\e[32m1. Checking dependencies... \e[0m" && sleep 1
# packages
if jq --version >/dev/null 2>&1; then
    echo -e "\e[1m\e[32m1.1 dependencies already installed \e[0m" && sleep 1
else
    echo -e "\e[1m\e[32m1.1 Installing dependencies ... \e[0m" && sleep 1
    sudo wget -qO /usr/local/bin/yq https://github.com/mikefarah/yq/releases/download/v4.23.1/yq_linux_amd64 && chmod +x /usr/local/bin/yq
    sudo apt-get install jq -y 
fi

echo -e "\e[1m\e[32m2.1 Installing sui binaries \e[0m" && sleep 1
version=$(wget -qO- https://api.github.com/repos/SecorD0/Sui/releases/latest | jq -r ".tag_name")
wget -qO- "https://github.com/SecorD0/Sui/releases/download/${version}/sui-linux-amd64-${version}.tar.gz" | sudo tar -C /usr/local/bin/ -xzf - 

echo -e "\e[1m\e[32m3. Updating packages... \e[0m" && sleep 1
sudo apt update && sudo apt upgrade -y

 echo $PATH
 echo -e "y\n" | sui client

 echo -e "\e[1m\e[32m3. Wallet created... \e[0m" && sleep 1
