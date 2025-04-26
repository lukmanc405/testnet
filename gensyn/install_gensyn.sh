#!/bin/bash
echo "=================================================="
echo -e "\033[0;35m"
echo " | |  | | | | |/ /  \/  |  / \  | \ | |  ";
echo " | |  | | | | ' /| |\/| | / _ \ |  \| |  ";
echo " | |__| |_| | . \| |  | |/ ___ \| |\  |  ";
echo " |_____\___/|_|\_\_|  |_/_/   \_\_| \_|  ";
echo -e "\e[0m"
echo "=================================================="  
# Exit on any error

# Step 1: Install Dependencies
# Update system and install core dependencies
 sudo apt update -y
 sudo apt install -y python3 python3-venv python3-pip curl wget screen git lsof nano unzip iproute2 build-essential libgbm1 pkg-config libssl-dev libleveldb-dev tar clang bsdmainutils ncdu
 
 # Install Node.js (v22.x) and Yarn
 curl -fsSL https://deb.nodesource.com/setup_22.x | sudo -E bash -
 sudo apt install -y nodejs
 sudo npm install -g yarn

# Step 2: Check and Delete rl-swarm Folder if it Exists (Already Included)
if [ -d "$HOME/rl-swarm" ]; then
  echo "Warning: Existing rl-swarm folder found at $HOME/rl-swarm."
  echo "This folder will be deleted to ensure a clean setup."
  echo "Ensure you have backed up swarm.pem if needed!"
  read -p "Press Enter to continue with deletion, or Ctrl+C to cancel..."
  rm -rf "$HOME/rl-swarm"
  echo "rl-swarm folder deleted."
fi

# Step 3: Clone the Repository
echo "Cloning the RL-Swarm repository..."
cd $HOME
git clone https://github.com/gensyn-ai/rl-swarm/
cd rl-swarm

# Step 4: Fix .bashrc to Prevent PS1 Error
echo "Fixing .bashrc to prevent PS1 unbound variable error..."
sed -i '1i # ~/.bashrc: executed by bash(1) for non-login shells.\n\n# If not running interactively, don'\''t do anything\ncase $- in\n    *i*) ;;\n    *) return;;\nesac\n' ~/.bashrc

# Step 5: Install Screen
echo "Installing screen..."
apt install screen -y

# Step 6: Install Ngrok and JQ
echo "Installing ngrok and jq..."
curl -s https://ngrok-agent.s3.amazonaws.com/ngrok.asc | sudo tee /etc/apt/trusted.gpg.d/ngrok.asc >/dev/null
echo "deb https://ngrok-agent.s3.amazonaws.com buster main" | sudo tee /etc/apt/sources.list.d/ngrok.list
sudo apt update -y
sudo apt install -y ngrok jq

# Step 7: Prompt for Ngrok Authtoken
echo "Enter your ngrok authtoken (from https://dashboard.ngrok.com/get-started/your-authtoken)."
echo "Sign up at https://ngrok.com if you don't have one. Copy the token exactly, including any dashes:"
read -r NGROK_AUTHTOKEN

# Validate authtoken input
if [ -z "$NGROK_AUTHTOKEN" ]; then
  echo "Error: Ngrok authtoken cannot be empty!"
  echo "Get your authtoken from https://dashboard.ngrok.com/get-started/your-authtoken and rerun the script."
  exit 1
fi

# Configure ngrok
ngrok config add-authtoken "$NGROK_AUTHTOKEN" || {
  echo "Error: Failed to configure ngrok. Verify your authtoken at https://dashboard.ngrok.com/get-started/your-authtoken and try again."
  exit 1
}

# Step 8: Run the Swarm in a Screen Session
echo "Setting up and running the RL-Swarm node..."
# Create a screen session for the swarm
screen -dmS swarm bash -c "cd $HOME/rl-swarm && python3 -m venv .venv && source .venv/bin/activate && echo 'Y\nN' | ./run_rl_swarm.sh"

# Step 9: Start Ngrok in a Screen Session
echo "Starting ngrok to forward port 3000..."
screen -dmS ngrok bash -c "ngrok http 3000"

# Step 10: Fetch the Ngrok Public URL
echo "Fetching ngrok public URL (this may take a few seconds)..."
# Wait for ngrok to start (up to 30 seconds)
for i in {1..30}; do
  sleep 1
  NGROK_URL=$(curl -s http://localhost:4040/api/tunnels | jq -r '.tunnels[0].public_url')
  if [ -n "$NGROK_URL" ] && [ "$NGROK_URL" != "null" ]; then
    break
  fi
  if [ $i -eq 30 ]; then
    echo "Warning: Could not fetch ngrok URL. Check the ngrok session with: screen -r ngrok"
    NGROK_URL="Not available (check manually)"
  fi
done

# Step 11: Display Instructions
echo "Installation complete!"
echo "RL-Swarm node is running in screen session 'swarm'. Check logs with: screen -r swarm"
echo "Ngrok is running in screen session 'ngrok'. Check logs with: screen -r ngrok"
echo "Ngrok public URL: $NGROK_URL"
echo "Ensure port 3000 is open if on a VPS (check firewall or cloud provider rules)."
echo "After seeing 'Waiting for userData.json to be created...' in the logs, the node should be running."
echo "Back up swarm.pem (if generated) from $HOME/rl-swarm/swarm.pem to your local machine."
echo "To check for swarm.pem, run: ls $HOME/rl-swarm/swarm.pem"
echo "If found, back up with: cp $HOME/rl-swarm/swarm.pem ~/swarm.pem.bak && scp root@your-vps-ip:~/swarm.pem.bak ."