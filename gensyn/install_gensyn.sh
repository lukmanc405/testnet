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

# Step 1: Install Dependencies
echo -e "\e[1m\e[32m1. Updating system & installing dependencies...\e[0m" && sleep 1
sudo apt update -y
sudo apt install -y python3 python3-venv python3-pip curl wget screen git lsof nano unzip iproute2 build-essential libgbm1 pkg-config libssl-dev libleveldb-dev tar clang bsdmainutils ncdu

# Install Node.js (v22.x) and Yarn
echo -e "\e[1m\e[32m   Installing Node.js and Yarn...\e[0m" && sleep 1
curl -fsSL https://deb.nodesource.com/setup_22.x | sudo -E bash -
sudo apt install -y nodejs
sudo npm install -g yarn

# Step 2: Check and Handle rl-swarm Folder if Exists
echo -e "\e[1m\e[32m2. Checking for existing rl-swarm folder...\e[0m" && sleep 1
if [ -d "$HOME/rl-swarm" ]; then
  echo -e "\e[1m\e[33m   Warning: Existing rl-swarm folder found at $HOME/rl-swarm.\e[0m"
  echo -e "\e[1m\e[33m   This may contain important data like swarm.pem. Ensure you have backed it up if needed!\e[0m"
  read -p $'\e[1m\e[37m   Do you want to delete the rl-swarm folder for a clean setup? (y/n): \e[0m' DELETE_RESP
  if [ "$DELETE_RESP" = "y" ] || [ "$DELETE_RESP" = "Y" ]; then
    rm -rf "$HOME/rl-swarm"
    echo -e "\e[1m\e[32m   rl-swarm folder deleted.\e[0m"
  else
    echo -e "\e[1m\e[32m   Keeping existing rl-swarm folder. Proceeding with current setup...\e[0m"
  fi
else
  echo -e "\e[1m\e[32m   No existing rl-swarm folder found. Proceeding...\e[0m"
fi

# Step 3: Clone the Repository
echo -e "\e[1m\e[32m3. Cloning RL-Swarm repository...\e[0m" && sleep 1
cd $HOME
git clone https://github.com/gensyn-ai/rl-swarm/
cd rl-swarm

# Step 4: Fix .bashrc
echo -e "\e[1m\e[32m4. Fixing .bashrc for PS1 error...\e[0m" && sleep 1
sed -i '1i # ~/.bashrc: executed by bash(1) for non-login shells.\n\n# If not running interactively, don'\''t do anything\ncase $- in\n    *i*) ;;\n    *) return;;\nesac\n' ~/.bashrc

# Step 5: Install Screen
echo -e "\e[1m\e[32m5. Installing screen...\e[0m" && sleep 1
sudo apt install screen -y

# Step 6: Install Ngrok and JQ
echo -e "\e[1m\e[32m6. Installing ngrok and jq...\e[0m" && sleep 1
curl -s https://ngrok-agent.s3.amazonaws.com/ngrok.asc | sudo tee /etc/apt/trusted.gpg.d/ngrok.asc >/dev/null
echo "deb https://ngrok-agent.s3.amazonaws.com buster main" | sudo tee /etc/apt/sources.list.d/ngrok.list
sudo apt update -y
sudo apt install -y ngrok jq

# Step 7: Prompt for Ngrok Authtoken
echo -e "\e[1m\e[32m7. Configuring ngrok...\e[0m" && sleep 1
echo -e "\e[1m\e[33m   Enter your ngrok authtoken (from https://dashboard.ngrok.com/get-started/your-authtoken):\e[0m"
read -r NGROK_AUTHTOKEN

# Validate authtoken input
if [ -z "$NGROK_AUTHTOKEN" ]; then
  echo -e "\e[1m\e[31m   Error: Ngrok authtoken cannot be empty!\e[0m"
  echo -e "\e[1m\e[31m   Get your authtoken from https://dashboard.ngrok.com/get-started/your-authtoken and rerun the script.\e[0m"
  exit 1
fi

# Configure ngrok
ngrok config add-authtoken "$NGROK_AUTHTOKEN" || {
  echo -e "\e[1m\e[31m   Error: Failed to configure ngrok. Verify your authtoken and try again.\e[0m"
  exit 1
}
echo -e "\e[1m\e[32m   Ngrok configured successfully.\e[0m"

sed -i -E 's/(startup_timeout: *float *= *)[0-9.]+/\1120/' $(python3 -c "import hivemind.p2p.p2p_daemon as m; print(m.__file__)")

sleep 2

# Step 8: Run the Swarm in a Screen Session
echo -e "\e[1m\e[32m8. Starting RL-Swarm node...\e[0m" && sleep 1
screen -dmS swarm bash -c "cd $HOME/rl-swarm && chmod +x run_rl_swarm.sh && python3 -m venv .venv && source .venv/bin/activate && echo 'Y\nN' | ./run_rl_swarm.sh"

sleep 3

# Step 9: Start Ngrok in a Screen Session
echo -e "\e[1m\e[32m9. Starting ngrok to forward port 3000...\e[0m" && sleep 1
screen -dmS ngrok bash -c "ngrok http 3000"

# Step 10: Fetch the Ngrok Public URL
echo -e "\e[1m\e[32m10. Fetching ngrok public URL...\e[0m" && sleep 1
for i in {1..30}; do
  sleep 1
  NGROK_URL=$(curl -s http://localhost:4040/api/tunnels | jq -r '.tunnels[0].public_url')
  if [ -n "$NGROK_URL" ] && [ "$NGROK_URL" != "null" ]; then
    break
  fi
  if [ $i -eq 30 ]; then
    echo -e "\e[1m\e[33m   Warning: Could not fetch ngrok URL. Check the ngrok session with: screen -r ngrok\e[0m"
    NGROK_URL="Not available (check manually)"
  fi
done

# Step 11: Display Instructions
echo -e "\e[1m\e[32m11. Installation complete!\e[0m" && sleep 1
echo -e "\e[1m\e[32m   RL-Swarm node is running in screen session 'swarm'. Check logs with: screen -r swarm\e[0m"
echo -e "\e[1m\e[32m   Ngrok is running in screen session 'ngrok'. Check logs with: screen -r ngrok\e[0m"
echo -e "\e[1m\e[32m   Ngrok public URL: $NGROK_URL\e[0m"
echo -e "\e[1m\e[32m   Ensure port 3000 is open if on a VPS (check firewall or cloud provider rules).\e[0m"
echo -e "\e[1m\e[32m   After seeing 'Waiting for userData.json to be created...' in the logs, the node should be running.\e[0m"
echo -e "\e[1m\e[32m   Back up swarm.pem (if generated) from $HOME/rl-swarm/swarm.pem to your local machine.\e[0m"
echo -e "\e[1m\e[32m   To check for swarm.pem, run: ls $HOME/rl-swarm/swarm.pem\e[0m"
echo -e "\e[1m\e[32m   If found, back up with: cp $HOME/rl-swarm/swarm.pem ~/swarm.pem.bak && scp root@your-vps-ip:~/swarm.pem.bak .\e[0m"

echo -e "\e[1m\e[32m---RL-SWARM NODE SETUP COMPLETE---\e[0m"