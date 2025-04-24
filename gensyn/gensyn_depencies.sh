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

# Configure ngrok (replace YOUR_NGROK_AUTHTOKEN with your actual token)
ngrok config add-authtoken YOUR_NGROK_AUTHTOKEN