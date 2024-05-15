# Install Initia Validator

{% code fullWidth="true" %}
```bash
# install dependencies, if needed
sudo apt update && sudo apt upgrade -y
sudo apt install curl git wget htop tmux build-essential jq make lz4 gcc unzip -y
```
{% endcode %}

{% code fullWidth="true" %}
```bash
# install go, if needed
cd $HOME
VER="1.22.2"
wget "https://golang.org/dl/go$VER.linux-amd64.tar.gz"
sudo rm -rf /usr/local/go
sudo tar -C /usr/local -xzf "go$VER.linux-amd64.tar.gz"
rm "go$VER.linux-amd64.tar.gz"
[ ! -f ~/.bash_profile ] && touch ~/.bash_profile
echo "export PATH=$PATH:/usr/local/go/bin:~/go/bin" >> ~/.bash_profile
source $HOME/.bash_profile
[ ! -d ~/go/bin ] && mkdir -p ~/go/bin
```
{% endcode %}

{% code fullWidth="true" %}
```bash
# set vars (change "test" to your validator username)
echo "export WALLET="wallet"" >> $HOME/.bash_profile
echo "export MONIKER="test"" >> $HOME/.bash_profile
echo "export INITIA_CHAIN_ID="initiation-1"" >> $HOME/.bash_profile
echo "export INITIA_PORT="51"" >> $HOME/.bash_profile
source $HOME/.bash_profile
```
{% endcode %}

{% code fullWidth="true" %}
```bash
# download binary
cd $HOME
rm -rf initia
git clone https://github.com/initia-labs/initia.git
cd initia
git checkout v0.2.12
make install
```
{% endcode %}

{% code fullWidth="true" %}
```bash
# config and init app
initiad init $MONIKER
sed -i -e "s|^node *=.*|node = \"tcp://localhost:${INITIA_PORT}657\"|" $HOME/.initia/config/client.toml
```
{% endcode %}

{% code fullWidth="true" %}
```bash
# download genesis and addrbook
wget -O $HOME/.initia/config/genesis.json https://initia.s3.ap-southeast-1.amazonaws.com/initiation-1/genesis.json
```
{% endcode %}

{% code fullWidth="true" %}
```bash
# set seeds and peers
PEERS="aee7083ab11910ba3f1b8126d1b3728f13f54943@initia-testnet-peer.itrocket.net:11656,16a7709332221a8b1c1edeb6533076fd7a445113@5.252.55.156:26656,07632ab562028c3394ee8e78823069bfc8de7b4c@37.27.52.25:19656,1f6633bc18eb06b6c0cab97d72c585a6d7a207bc@65.109.59.22:25756,767fdcfdb0998209834b929c59a2b57d474cc496@207.148.114.112:26656,e8dfba2642dd70e74476dcbcfaf7b249ffcdbfc5@195.26.255.211:15056,093e1b89a498b6a8760ad2188fbda30a05e4f300@35.240.207.217:26656,5f934bd7a9d60919ee67968d72405573b7b14ed0@65.21.202.124:29656,4d4de8fa78e70a34fbb5a35bef15b57cef456a6e@195.26.247.148:26656"
SEEDS="2eaa272622d1ba6796100ab39f58c75d458b9dbc@34.142.181.82:26656,c28827cb96c14c905b127b92065a3fb4cd77d7f6@testnet-seeds.whispernode.com:25756"
sed -i -e "s/^seeds *=.*/seeds = \"$SEEDS\"/; s/^persistent_peers *=.*/persistent_peers = \"$PEERS\"/" $HOME/.initia/config/config.toml
```
{% endcode %}

{% code fullWidth="true" %}
```bash
# config pruning
sed -i -e "s/^pruning *=.*/pruning = \"custom\"/" $HOME/.initia/config/app.toml
sed -i -e "s/^pruning-keep-recent *=.*/pruning-keep-recent = \"100\"/" $HOME/.initia/config/app.toml
sed -i -e "s/^pruning-interval *=.*/pruning-interval = \"50\"/" $HOME/.initia/config/app.toml

# set minimum gas price, enable prometheus and disable indexing
sed -i -e "s|^minimum-gas-prices *=.*|minimum-gas-prices = \"0.15uinit,0.01uusdc\"|" $HOME/.initia/config/app.toml
sed -i -e "s/prometheus = false/prometheus = true/" $HOME/.initia/config/config.toml
sed -i -e "s/^indexer *=.*/indexer = \"null\"/" $HOME/.initia/config/config.toml
```
{% endcode %}

{% code fullWidth="true" %}
```bash
# create service file
sudo tee /etc/systemd/system/initiad.service > /dev/null <<EOF
[Unit]
Description=Initia node
After=network-online.target
[Service]
User=$USER
WorkingDirectory=$HOME/.initia
ExecStart=$(which initiad) start --home $HOME/.initia
Restart=on-failure
RestartSec=5
LimitNOFILE=65535
[Install]
WantedBy=multi-user.target
EOF
```
{% endcode %}

```bash
# reset and download snapshot
sudo systemctl stop initiad
cp $HOME/.initia/data/priv_validator_state.json $HOME/.initia/priv_validator_state.json.backup
rm -rf $HOME/.initia/data

curl -o - -L https://snapshots.polkachu.com/testnet-snapshots/initia/initia_113153.tar.lz4 | lz4 -c -d - | tar -x -C $HOME/.initia
mv $HOME/.initia/priv_validator_state.json.backup $HOME/.initia/data/priv_validator_state.json
```

{% code fullWidth="true" %}
```bash
# enable and start service
sudo systemctl daemon-reload
sudo systemctl enable initiad
sudo systemctl restart initiad && sudo journalctl -u initiad -f
```
{% endcode %}

#### Create Wallet

```bash
# to create a new wallet, use the following command. don’t forget to save the mnemonic
initiad keys add $WALLET

# to restore exexuting wallet, use the following command
initiad keys add $WALLET --recover

# save wallet and validator address
WALLET_ADDRESS=$(initiad keys show $WALLET -a)
VALOPER_ADDRESS=$(initiad keys show $WALLET --bech val -a)
echo "export WALLET_ADDRESS="$WALLET_ADDRESS >> $HOME/.bash_profile
echo "export VALOPER_ADDRESS="$VALOPER_ADDRESS >> $HOME/.bash_profile
source $HOME/.bash_profile

# check sync status, once your node is fully synced, the output from above will print "false"
initiad status 2>&1 | jq 

# before creating a validator, you need to fund your wallet and check balance
initiad query bank balances $WALLET_ADDRESS 
```

#### Create Validator&#x20;

```bash
initiad tx mstaking create-validator \
--amount 1000000uinit \
--pubkey $(initiad tendermint show-validator) \
--moniker "$MONIKER" \
--identity "YOUR_IDENTITY" \
--details "YOUR_DETAILS" \
--website "YOUR_WEBSITE" \
--chain-id initiation-1 \
--commission-rate 0.05 \
--commission-max-rate 0.20 \
--commission-max-change-rate 0.05 \
--from $WALLET \
--gas-adjustment 1.4 \
--gas auto \
--gas-prices 0.15uinit \
-y
```
