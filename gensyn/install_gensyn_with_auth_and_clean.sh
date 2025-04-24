#!/bin/bash

# Exit on any error
set -e

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

# Check and delete rl-swarm folder if it exists
if [ -d "$HOME/rl-swarm" ]; then
  echo "Warning: Existing rl-swarm folder found at $HOME/rl-swarm."
  echo "This folder will be deleted to ensure a clean setup."
  echo "Ensure you have backed up swarm.pem if needed!"
  read -p "Press Enter to continue with deletion, or Ctrl+C to cancel..."
  rm -rf "$HOME/rl-swarm"
  echo "rl-swarm folder deleted."
fi

# Clone the RL-Swarm repository
cd $HOME
git clone https://github.com/gensyn-ai/rl-swarm
cd rl-swarm

# Set up Python virtual environment and install dependencies
python3 -m venv venv
source venv/bin/activate
pip install --upgrade pip
pip install -r requirements.txt

# Run RL-Swarm setup (non-interactive, decline Hugging Face Hub integration)
echo "N" | bash setup.sh

# Backup swarm.pem
cp swarm.pem ~/swarm.pem.bak
echo "swarm.pem backed up to ~/swarm.pem.bak. Store this securely!"

# Start ngrok in a screen session for port 3000
screen -dmS ngrok bash -c "ngrok http 3000"

# Start RL-Swarm node in a screen session
screen -dmS rl-swarm bash -c "source venv/bin/activate && python main.py"

# Display instructions
echo "Installation complete!"
echo "Ngrok is running in screen session 'ngrok'. Check public URL with: screen -r ngrok"
echo "RL-Swarm node is running in screen session 'rl-swarm'. Check logs with: screen -r rl-swarm"
echo "Public ngrok URL can be found in the ngrok session or at https://dashboard.ngrok.com"
echo "Ensure port 3000 is open if on a VPS (check firewall or cloud provider rules)."
echo "Backup ~/swarm.pem.bak to your local machine to preserve node identity."
echo "If ngrok fails to start, verify your authtoken at https://dashboard.ngrok.com."