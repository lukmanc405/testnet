#!/bin/bash

# Prompt for ngrok authtoken
echo "Please enter your ngrok authtoken (get it from https://dashboard.ngrok.com):"
read -r NGROK_AUTHTOKEN

# Validate authtoken input
if [ -z "$NGROK_AUTHTOKEN" ]; then
  echo "Error: Ngrok authtoken cannot be empty!"
  echo "Sign up at https://ngrok.com, get your authtoken, and rerun the script."
  exit 1
fi

# Update system and install core dependencies
sudo apt update -y
sudo apt install -y python3 python3-venv python3-pip curl wget screen git lsof nano unzip iproute2 build-essential libgbm1 pkg-config libssl-dev libleveldb-dev tar clang bsdmainutils ncdu

# Install Node.js (v22.x) and Yarn
curl -fsSL https://deb.nodesource.com/setup_22.x | sudo -E bash -
sudo apt install -y nodejs
sudo npm install -g yarn

# Install ngrok
curl -s https://ngrok-agent.s3.amazonaws.com/ngrok.asc | sudo tee /etc/apt/trusted.gpg.d/ngrok.asc >/dev/null
echo "deb https://ngrok-agent.s3.amazonaws.com buster main" | sudo tee /etc/apt/sources.list.d/ngrok.list
sudo apt update -y
sudo apt install -y ngrok

# Configure ngrok with the provided authtoken
ngrok config add-authtoken "$NGROK_AUTHTOKEN" || {
  echo "Error: Failed to configure ngrok. Verify your authtoken and try again."
  exit 1
}

# Clone the RL-Swarm repository
cd $HOME
git clone https://github.com/gensyn-ai/rl-swarm
cd rl-swarm
