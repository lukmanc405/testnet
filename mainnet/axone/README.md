# Axone

## Installation

### Minimum hardware requirement <a href="#minimum-hardware-requirement" id="minimum-hardware-requirement"></a>

4 Cores, 8G Ram, 160G NVME, Ubuntu 22.04

### Installation of required packages <a href="#installation-of-required-packages" id="installation-of-required-packages"></a>

```
sudo apt update && sudo apt upgrade -y
sudo apt install curl git wget htop tmux build-essential jq make lz4 gcc unzip -y
```

### Installation GO <a href="#installation-go" id="installation-go"></a>

```
cd ~
VER="1.23.4" # Make sure that this version does not broke any other apps you run!
wget "https://golang.org/dl/go$VER.linux-amd64.tar.gz"
sudo rm -rf /usr/local/go
sudo tar -C /usr/local -xzf "go$VER.linux-amd64.tar.gz"
rm "go$VER.linux-amd64.tar.gz"
[ ! -f ~/.bash_profile ] && touch ~/.bash_profile
echo "export PATH=$PATH:/usr/local/go/bin:~/go/bin" >> ~/.bash_profile
source $HOME/.bash_profile
[ ! -d ~/go/bin ] && mkdir -p ~/go/bin
```

### Downloading and installing node <a href="#downloading-and-installing-node" id="downloading-and-installing-node"></a>

```
cd $HOME
git clone https://github.com/axone-protocol/axoned
cd axoned
git checkout v12.0.0
make install
axoned version
```

### Set node configuration <a href="#set-node-configuration" id="set-node-configuration"></a>

```
axoned init NODENAME --chain-id axone-1
```

### Downloading genesis and addressbook <a href="#downloading-genesis-and-addressbook" id="downloading-genesis-and-addressbook"></a>

```
curl -Ls https://snapshot.axone.detectivegems.com/axone/genesis.json > $HOME/.axoned/config/genesis.json
curl -Ls https://snapshot.axone.detectivegems.com/axone/addrbook.json > $HOME/.axoned/config/addrbook.json
```

```
# Set seeds
peers="88a89303f7efed5310d2333fc40940aaacac7d3d@217.160.102.31:26656,ea1d3b5b70ac85d553a645561fbfd95577afee4c@148.113.153.62:26656,b356ae3dbfc97a21a89db0d58fdf00c7158d4d85@142.132.131.184:26656,9b372f7335ae09b38080c4d09106821757f8f7e2@65.21.32.216:26656,46f9edbbce02f0e6cf8aac82f65fe7aedecf3abd@51.159.96.236:36656"
sed -i.bak -e "s/^persistent_peers *=.*/persistent_peers = \"$peers\"/" $HOME/.axoned/config/config.toml

# Set minimum gas price
sed -i -E 's|^minimum-gas-prices\s*=.*|minimum-gas-prices = "0.001uaxone"|' $HOME/.axoned/config/app.toml

# Set pruning
sed -i \
  -e 's|^pruning *=.*|pruning = "custom"|' \
  -e 's|^pruning-keep-recent *=.*|pruning-keep-recent = "100"|' \
  -e 's|^pruning-interval *=.*|pruning-interval = "17"|' \
  $HOME/.axoned/config/app.toml


# Change ports
sed -i -e "s%:1317%:17617%; s%:8080%:17680%; s%:9090%:17690%; s%:9091%:17691%; s%:8545%:17645%; s%:8546%:17646%; s%:6065%:17665%" $HOME/.axoned/config/app.toml
sed -i -e "s%:26658%:17658%; s%:26657%:17657%; s%:6060%:17660%; s%:26656%:17656%; s%:26660%:17661%" $HOME/.axoned/config/config.toml

# Download latest chain data snapshot
curl -L https://snapshot.axone.detectivegems.com/axone/axone-latest.tar.lz4 | lz4 -dc - | tar -xf - -C "$HOME/.axoned"
```

### Creating service file <a href="#creating-service-file" id="creating-service-file"></a>

```
sudo tee /etc/systemd/system/axoned.service > /dev/null <<EOF
[Unit]
Description=axone Validator
After=network-online.target

[Service]
User=root
ExecStart=$(which axoned) start
Restart=always
RestartSec=3
LimitNOFILE=65535

[Install]
WantedBy=multi-user.target
EOF
```

### Start node <a href="#start-node" id="start-node"></a>

```
sudo systemctl daemon-reload
sudo systemctl enable axoned
sudo systemctl start axoned
sudo journalctl -u axoned -f --no-hostname -o cat
```
