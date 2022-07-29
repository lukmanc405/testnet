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

# update package
sudo apt update && sudo apt upgrade -y

sleep 1

bash_profile=$HOME/.bash_profile
if [ -f "$bash_profile" ]; then
    . $HOME/.bash_profile
fi

function setupVars {
        if [ ! $IPKOWE ]; then
                read -p "Enter your IP : " IP_KOWE
                echo 'export IP_KOWE ='${IP_KOWE} >> $HOME/.bash_profile
        fi
        
ADDRESS=$(cargo run --bin wallet-tool -- show-address)

# install docker
sudo apt-get install ca-certificates curl gnupg lsb-release -y
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update
sudo apt-get install docker-ce docker-ce-cli containerd.io -y

sleep 1

# install docker-compose

mkdir -p ~/.docker/cli-plugins/
curl -SL https://github.com/docker/compose/releases/download/v2.6.1/docker-compose-linux-x86_64 -o ~/.docker/cli-plugins/docker-compose
chmod +x ~/.docker/cli-plugins/docker-compose

sudo chown $USER /var/run/docker.sock

sleep 1

# install depencies
sudo apt-get install curl wget jq libpq-dev libssl-dev \
build-essential pkg-config openssl ocl-icd-opencl-dev \
libopencl-clang-dev libgomp1 -y

sleep 1

# install npm
apt install npm -y

sleep 1

# NVM
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | bash
export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
source ~/.bashrc
nvm install 16
nvm use 16

sleep 1

# validator repository
git clone --recurse-submodules https://github.com/Bundlr-Network/validator-rust.git

sleep 1

# create wallet
cargo run --bin wallet-tool create | tee wallet.json |  cargo run --bin wallet-tool -- show-address

sleep 1

# create file service
tee $HOME/validator-rust/.env > /dev/null <<EOF
PORT=80
BUNDLER_URL="https://testnet1.bundlr.network"
GW_CONTRACT="RkinCLBlY4L5GZFv8gCFcrygTyd5Xm91CzKlR6qxhKA"
GW_ARWEAVE="https://arweave.testnet1.bundlr.network"
EOF

sleep 1

# running docker
cd ~/validator-rust && git pull origin master
docker compose build
docker compose up -d

sleep 1

# inisialisasi verifikasi
npm i -g @bundlr-network/testnet-cli
cd /root/validator-rust && testnet-cli join RkinCLBlY4L5GZFv8gCFcrygTyd5Xm91CzKlR6qxhKA -w wallet.json -u "http://$IP_KOWE:80" -s 25000000000000 

# check join status
npx @bundlr-network/testnet-cli@latest check RkinCLBlY4L5GZFv8gCFcrygTyd5Xm91CzKlR6qxhKA $ADDRESS
