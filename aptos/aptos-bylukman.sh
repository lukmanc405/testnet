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


bash_profile=$HOME/.bash_profile
if [ -f "$bash_profile" ]; then
    . $HOME/.bash_profile
fi

# setupVars
        if [ ! $NODENAME ]; then
                read -p "Enter your Node Username : " NODENAME
                echo 'export NODENAME ='${NODENAME} >> $HOME/.bash_profile
        fi
                if [ ! $YOUR_IP ]; then
                read -p "Enter your VPS IP : " YOUR_IP
                echo 'export YOUR_IP ='${YOUR_IP} >> $HOME/.bash_profile
        fi
sleep 1


echo -e "\e[1m\e[32m [1]. Updating paket... \e[0m" && sleep 1
# update
sudo apt update && sudo apt upgrade -y

echo -e "\e[1m\e[32m [2]. Checking dependencies... \e[0m" && sleep 1
if ! command  jq –version &> /dev/null
    echo -e "\e[1m\e[32m [2]. Installing dependencies... \e[0m" && sleep 1
    # packages
    sudo wget -qO /usr/local/bin/yq https://github.com/mikefarah/yq/releases/download/v4.23.1/yq_linux_amd64 && chmod +x /usr/local/bin/yq
    sudo apt-get install jq -y
fi

echo -e "\e[1m\e[32m [3]. Checking if Docker is installed... \e[0m" && sleep 1
if ! command -v docker &> /dev/null
then
    echo -e "\e[1m\e[32m3.1 Installing Docker... \e[0m" && sleep 1
    sudo apt-get install ca-certificates curl gnupg lsb-release -y
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
    echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
    sudo apt-get update
    sudo apt-get install docker-ce docker-ce-cli containerd.io -y
fi

echo -e "\e[1m\e[32m [4]. Checking if docker compose is installed ... \e[0m" && sleep 1
if ! command docker compose version &> /dev/null
then 
   docker_compose_version=$(wget -qO- https://api.github.com/repos/docker/compose/releases/latest | jq -r ".tag_name")
   sudo wget -O /usr/bin/docker-compose "https://github.com/docker/compose/releases/download/${docker_compose_version}/docker-compose-`uname -s`-`uname -m`"
   sudo chmod +x /usr/bin/docker-compose
fi

echo -e "\e[1m\e[32m [5]. Creating workspace directory ... \e[0m" && sleep 1
export WORKSPACE=testnet
mkdir ~/$WORKSPACE
cd ~/$WORKSPACE

echo -e "\e[1m\e[32m [6]. Download validator.yaml & docker-compose.yaml ... \e[0m" && sleep 1
wget https://raw.githubusercontent.com/aptos-labs/aptos-core/main/docker/compose/aptos-node/docker-compose.yaml
wget https://raw.githubusercontent.com/aptos-labs/aptos-core/main/docker/compose/aptos-node/validator.yaml

echo -e "\e[1m\e[32m [7]. Generate key pairs ... \e[0m" && sleep 1
aptos genesis generate-keys --output-dir ~/$WORKSPACE

echo -e "\e[1m\e[32m [8].  set-validator-configuration ... \e[0m" && sleep 1
cd ~/$WORKSPACE
aptos genesis set-validator-configuration \
    --keys-dir ~/$WORKSPACE --local-repository-dir ~/$WORKSPACE \
    --username ${NODENAME} \
    --validator-host ${YOUR_IP}:6180

if ! [ -f "${WORKSPACE}/layout.yaml" ]
then
cat > ${WORKSPACE}/layout.yaml <<EOF
---
root_key: "F22409A93D1CD12D2FC92B5F8EB84CDCD24C348E32B3E7A720F3D2E288E63394"
users:
  - "${NODENAME}"
chain_id: 40
min_stake: 0
max_stake: 100000
min_lockup_duration_secs: 0
max_lockup_duration_secs: 2592000
epoch_duration_secs: 86400
initial_lockup_timestamp: 1656615600
min_price_per_gas_unit: 1
allow_new_validators: true
EOF
fi

echo -e "\e[1m\e[32m [9].  Download the Aptos Framework ... \e[0m" && sleep 1
wget https://github.com/aptos-labs/aptos-core/releases/download/aptos-framework-v0.2.0/framework.zip
unzip framework.zip

echo -e "\e[1m\e[32m [10].  Compile genesis blob and waypoint ... \e[0m" && sleep 1 
aptos genesis generate-genesis --local-repository-dir ~/testnet --output-dir ~/testnet