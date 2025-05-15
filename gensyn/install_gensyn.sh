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
RED="\033[1;31m"
RESET="\033[0m"

echo -e "${GREEN}Starting Gensyn RL-Swarm Setup...${RESET}"

# Function to check if a package is installed
check_package() {
    dpkg -l | grep -q "$1" && return 0 || return 1
}

# Function to check if apt lists are up-to-date
check_apt_updated() {
    echo -e "${YELLOW}Checking if apt lists are up-to-date...${RESET}"
    if [ -n "$(find /var/lib/apt/lists -maxdepth 1 -type f -mtime -1)" ]; then
        echo -e "${GREEN}Apt lists are up-to-date, skipping update.${RESET}"
        return 0
    else
        echo -e "${YELLOW}Apt lists need updating...${RESET}"
        return 1
    fi
}

# Function to install dependencies with retry mechanism
install_dependencies() {
    local packages=(
        screen curl iptables build-essential git wget lz4 jq make gcc nano
        automake autoconf tmux htop nvme-cli libgbm1 pkg-config libssl-dev
        libleveldb-dev tar clang bsdmainutils ncdu unzip
    )
    echo -e "${YELLOW}Installing dependencies...${RESET}"
    
    # Retry apt update up to 3 times
    for attempt in {1..3}; do
        if sudo apt update; then
            break
        else
            echo -e "${RED}Apt update failed (attempt $attempt/3). Retrying...${RESET}"
            sleep 2
        fi
        [[ $attempt -eq 3 ]] && { echo -e "${RED}Failed to update apt after 3 attempts.${RESET}"; exit 1; }
    done

    # Install each package individually to catch errors
    for pkg in "${packages[@]}"; do
        if check_package "$pkg"; then
            echo -e "${GREEN}$pkg is already installed.${RESET}"
        else
            echo -e "${YELLOW}Installing $pkg...${RESET}"
            if ! sudo apt install -y "$pkg"; then
                echo -e "${RED}Failed to install $pkg. Continuing with other packages...${RESET}"
            fi
        fi
    done
}

# Update system and install dependencies
if ! check_apt_updated; then
    install_dependencies
else
    echo -e "${GREEN}Dependencies already up-to-date.${RESET}"
fi

# Check and install Node.js 20
if ! command -v node > /dev/null 2>&1; then
    echo -e "${YELLOW}Installing Node.js 20...${RESET}"
    curl -fsSL https://deb.nodesource.com/setup_20.x | sudo -E bash - || { echo -e "${RED}Failed to set up Node.js repository.${RESET}"; exit 1; }
    sudo apt update && sudo apt install -y nodejs || { echo -e "${RED}Failed to install Node.js.${RESET}"; exit 1; }
else
    echo -e "${GREEN}Node.js is already installed: $(node -v)${RESET}"
fi

# Check and install Yarn
if ! command -v yarn > /dev/null 2>&1; then
    echo -e "${YELLOW}Installing Yarn...${RESET}"
    curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo gpg --dearmor -o /usr/share/keyrings/yarnkey.gpg
    echo "deb [signed-by=/usr/share/keyrings/yarnkey.gpg] https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list
    sudo apt update && sudo apt install -y yarn || { echo -e "${RED}Failed to install Yarn.${RESET}"; exit 1; }
else
    echo -e "${GREEN}Yarn is already installed: $(yarn --version)${RESET}"
fi

# Check and install ngrok
echo -e "${YELLOW}Would you like to install or configure ngrok? (y/n)${RESET}"
read -p "Enter your choice: " install_ngrok
if [[ "$install_ngrok" == "y" || "$install_ngrok" == "Y" ]]; then
    if ! command -v ngrok > /dev/null 2>&1; then
        echo -e "${YELLOW}Installing ngrok...${RESET}"
        curl -s https://ngrok-agent.s3.amazonaws.com/ngrok.asc | sudo tee /etc/apt/trusted.gpg.d/ngrok.asc >/dev/null
        echo "deb https://ngrok-agent.s3.amazonaws.com buster main" | sudo tee /etc/apt/sources.list.d/ngrok.list
        sudo apt update && sudo apt install -y ngrok || { echo -e "${RED}Failed to install ngrok.${RESET}"; exit 1; }
        echo -e "${GREEN}ngrok installed successfully.${RESET}"
    else
        echo -e "${GREEN}ngrok is already installed: $(ngrok --version)${RESET}"
    fi
    # Ask for ngrok auth token
    echo -e "${YELLOW}Please enter your ngrok auth token:${RESET}"
    read -p "Ngrok auth token: " ngrok_token
    if [ -n "$ngrok_token" ]; then
        echo -e "${YELLOW}Configuring ngrok with provided auth token...${RESET}"
        ngrok config add-authtoken "$ngrok_token" || { echo -e "${RED}Failed to configure ngrok auth token.${RESET}"; exit 1; }
        echo -e "${GREEN}ngrok auth token configured successfully.${RESET}"
    else
        echo -e "${RED}No auth token provided. ngrok will not work without a valid token.${RESET}"
    fi
else
    echo -e "${YELLOW}Skipping ngrok installation/configuration.${RESET}"
fi

# Check if /root/rl-swarm folder exists
if [ -d "/root/rl-swarm" ]; then
    echo -e "${YELLOW}Existing /root/rl-swarm directory detected.${RESET}"
    echo -e "${YELLOW}Do you want to (1) use the existing directory, (2) delete and re-clone, or (3) exit?${RESET}"
    read -p "Enter your choice (1/2/3): " swarm_dir_choice
    case $swarm_dir_choice in
        1)
            echo -e "${GREEN}Using existing /root/rl-swarm directory.${RESET}"
            ;;
        2)
            echo -e "${YELLOW}Deleting existing /root/rl-swarm directory and re-cloning...${RESET}"
            sudo rm -rf /root/rl-swarm
            echo -e "${YELLOW}Cloning Gensyn RL-Swarm repository...${RESET}"
            git clone https://github.com/gensyn-ai/rl-swarm.git /root/rl-swarm || { echo -e "${RED}Failed to clone repository.${RESET}"; exit 1; }
            ;;
        3)
            echo -e "${RED}Exiting setup as per user request.${RESET}"
            exit 0
            ;;
        *)
            echo -e "${RED}Invalid choice. Exiting.${RESET}"
            exit 1
            ;;
    esac
else
    echo -e "${YELLOW}Cloning Gensyn RL-Swarm repository...${RESET}"
    git clone https://github.com/gensyn-ai/rl-swarm.git /root/rl-swarm || { echo -e "${RED}Failed to clone repository.${RESET}"; exit 1; }
fi

# Navigate to rl-swarm directory
cd /root/rl-swarm || { echo -e "${RED}Failed to navigate to /root/rl-swarm directory.${RESET}"; exit 1; }

echo -e "${GREEN}✅ Setup complete.${RESET}"