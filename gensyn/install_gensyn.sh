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

# Colors for output
GREEN="\033[1;32m"
YELLOW="\033[1;33m"
RESET="\033[0m"

echo -e "${GREEN}Starting Gensyn RL-Swarm Setup...${RESET}"

# Function to check if a package is installed
check_package() {
    if dpkg -l | grep -q "$1"; then
        return 0
    else
        return 1
    fi
}

# Function to check if dependencies are up-to-date
check_apt_updated() {
    echo -e "${YELLOW}Checking if dependencies are up-to-date...${RESET}"
    # Check if apt lists are newer than 1 day (86400 seconds)
    if [ -n "$(find /var/lib/apt/lists -maxdepth 1 -type f -mtime -1)" ]; then
        echo -e "${GREEN}Dependencies are up-to-date, skipping update.${RESET}"
        return 0
    else
        echo -e "${YELLOW}Dependencies need updating...${RESET}"
        return 1
    fi
}

# Update system and install dependencies if needed
if ! check_apt_updated; then
    echo -e "${YELLOW}Updating system and installing dependencies...${RESET}"
    sudo apt install screen curl iptables build-essential git wget lz4 jq make gcc nano automake autoconf tmux htop nvme-cli libgbm1 pkg-config libssl-dev libleveldb-dev tar clang bsdmainutils ncdu unzip libleveldb-dev  -y
else
    echo -e "${GREEN}Dependencies already up-to-date.${RESET}"
fi

# Check and install Node.js 20
if ! command -v node > /dev/null 2>&1; then
    echo -e "${YELLOW}Installing Node.js 20...${RESET}"
    curl -fsSL https://deb.nodesource.com/setup_20.x | sudo -E bash -
    sudo apt update && sudo apt install -y nodejs
else
    echo -e "${GREEN}Node.js is already installed: $(node -v)${RESET}"
fi

# Check and install Yarn
if ! command -v yarn > /dev/null 2>&1; then
    echo -e "${YELLOW}Installing Yarn...${RESET}"
    curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -
    echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list > /dev/null
    sudo apt update && sudo apt install -y yarn
else
    echo -e "${GREEN}Yarn is already installed: $(yarn --version)${RESET}"
fi

# Ask user if they want to install ngrok
echo -e "${YELLOW}Would you like to install ngrok? (y/n)${RESET}"
read -p "Enter your choice: " install_ngrok
if [[ "$install_ngrok" == "y" || "$install_ngrok" == "Y" ]]; then
    if ! command -v ngrok > /dev/null 2>&1; then
        echo -e "${YELLOW}Installing ngrok...${RESET}"
        curl -s https://ngrok-agent.s3.amazonaws.com/ngrok.asc | sudo tee /etc/apt/trusted.gpg.d/ngrok.asc >/dev/null
        echo "deb https://ngrok-agent.s3.amazonaws.com buster main" | sudo tee /etc/apt/sources.list.d/ngrok.list
        sudo apt update && sudo apt install -y ngrok
        echo -e "${GREEN}ngrok installed successfully.${RESET}"
    else
        echo -e "${GREEN}ngrok is already installed: $(ngrok --version)${RESET}"
    fi
else
    echo -e "${YELLOW}Skipping ngrok installation.${RESET}"
fi

# Clone the repo
if [ ! -d "rl-swarm" ]; then
    echo -e "${YELLOW}Cloning Gensyn RL-Swarm repository...${RESET}"
    git clone https://github.com/gensyn-ai/rl-swarm.git
else
    echo -e "${GREEN}rl-swarm repository already exists.${RESET}"
fi

# Another config
sed -i 's/use_vllm: true/use_vllm: false/' /root/rl-swarm/hivemind_exp/configs/gpu/grpo-qwen-2.5-1.5b-deepseek-r1.yaml

# Navigate to rl-swarm directory
cd rl-swarm || exit
echo -e "${GREEN}✅ Setup complete.${RESET}"