---
layout:
  title:
    visible: true
  description:
    visible: false
  tableOfContents:
    visible: true
  outline:
    visible: true
  pagination:
    visible: true
---

# Install Initia Validator

{% code fullWidth="false" %}
```bash
# install dependencies, if needed
sudo apt update && \
sudo apt install curl git jq build-essential gcc unzip wget lz4 -y
```
{% endcode %}

<pre class="language-bash" data-full-width="false"><code class="lang-bash"><strong>#install go
</strong><strong>cd $HOME &#x26;&#x26; \
</strong>ver="1.22.0" &#x26;&#x26; \
wget "https://golang.org/dl/go$ver.linux-amd64.tar.gz" &#x26;&#x26; \
sudo rm -rf /usr/local/go &#x26;&#x26; \
sudo tar -C /usr/local -xzf "go$ver.linux-amd64.tar.gz" &#x26;&#x26; \
rm "go$ver.linux-amd64.tar.gz" &#x26;&#x26; \
echo "export PATH=$PATH:/usr/local/go/bin:$HOME/go/bin" >> ~/.bash_profile &#x26;&#x26; \
source ~/.bash_profile &#x26;&#x26; \
go version
</code></pre>

{% code fullWidth="false" %}
```bash
git clone https://github.com/initia-labs/initia.git
cd initia
git checkout v0.2.12
make install

#jika install make error bisa gunakan perintah ini : 
sudo apt install build-essential
```
{% endcode %}

{% code fullWidth="false" %}
```bash
# set vars (change "XXXX" to your validator username)
echo 'export MONIKER="XXXX"' >> ~/.bash_profile
echo 'export CHAIN_ID="initiation-1"' >> ~/.bash_profile
echo 'export WALLET_NAME="wallet"' >> ~/.bash_profile
echo 'export RPC_PORT="26657"' >> ~/.bash_profile
source $HOME/.bash_profile
```
{% endcode %}

{% code fullWidth="false" %}
```bash
cd $HOME
initiad init $MONIKER --chain-id $CHAIN_ID
initiad config set client chain-id $CHAIN_ID
initiad config set client node tcp://localhost:$RPC_PORT
initiad config set client keyring-backend os # You can set it to "test" so you will not be asked for a password
```
{% endcode %}

{% code fullWidth="false" %}
```bash
# download genesis and addrbook
wget -O $HOME/.initia/config/genesis.json https://initia.s3.ap-southeast-1.amazonaws.com/initiation-1/genesis.json
```
{% endcode %}

<pre class="language-bash" data-full-width="false"><code class="lang-bash"><strong># setup PEERS and SEEDS
</strong><strong>PEERS="e3ac92ce5b790c76ce07c5fa3b257d83a517f2f6@178.18.251.146:30656,2692225700832eb9b46c7b3fc6e4dea2ec044a78@34.126.156.141:26656,2a574706e4a1eba0e5e46733c232849778faf93b@84.247.137.184:53456,40d3f977d97d3c02bd5835070cc139f289e774da@168.119.10.134:26313,1f6633bc18eb06b6c0cab97d72c585a6d7a207bc@65.109.59.22:25756,4a988797d8d8473888640b76d7d238b86ce84a2c@23.158.24.168:26656,e3679e68616b2cd66908c460d0371ac3ed7795aa@176.34.17.102:26656,d2a8a00cd5c4431deb899bc39a057b8d8695be9e@138.201.37.195:53456,329227cf8632240914511faa9b43050a34aa863e@43.131.13.84:26656,517c8e70f2a20b8a3179a30fe6eb3ad80c407c07@37.60.231.212:26656,07632ab562028c3394ee8e78823069bfc8de7b4c@37.27.52.25:19656,028999a1696b45863ff84df12ebf2aebc5d40c2d@37.27.48.77:26656,3c44f7dbb473fee6d6e5471f22fa8d8095bd3969@185.219.142.137:53456,8db320e665dbe123af20c4a5c667a17dc146f4d0@51.75.144.149:26656,c424044f3249e73c050a7b45eb6561b52d0db456@158.220.124.183:53456,767fdcfdb0998209834b929c59a2b57d474cc496@207.148.114.112:26656,edcc2c7098c42ee348e50ac2242ff897f51405e9@65.109.34.205:36656,140c332230ac19f118e5882deaf00906a1dba467@185.219.142.119:53456,4eb031b59bd0210481390eefc656c916d47e7872@37.60.248.151:53456,ff9dbc6bb53227ef94dc75ab1ddcaeb2404e1b0b@178.170.47.171:26656,ffb9874da3e0ead65ad62ac2b569122f085c0774@149.28.134.228:26656" &#x26;&#x26; \
</strong>SEEDS="2eaa272622d1ba6796100ab39f58c75d458b9dbc@34.142.181.82:26656,c28827cb96c14c905b127b92065a3fb4cd77d7f6@testnet-seeds.whispernode.com:25756" &#x26;&#x26; \
sed -i \
    -e "s/^seeds *=.*/seeds = \"$SEEDS\"/" \
    -e "s/^persistent_peers *=.*/persistent_peers = \"$PEERS\"/" \
    "$HOME/.initia/config/config.toml"
</code></pre>

{% code fullWidth="false" %}
```bash
# config pruning (to save storage)
sed -i \
    -e "s/^pruning *=.*/pruning = \"custom\"/" \
    -e "s/^pruning-keep-recent *=.*/pruning-keep-recent = \"100\"/" \
    -e "s/^pruning-interval *=.*/pruning-interval = \"10\"/" \
    "$HOME/.initia/config/app.toml"

# set minimum gas price
sed -i -e "s/^minimum-gas-prices *=.*/minimum-gas-prices = \"0.15uinit,0.01uusdc\"/" $HOME/.initia/config/app.toml
```
{% endcode %}

{% code fullWidth="false" %}
```bash
# create service file
sudo tee /etc/systemd/system/initiad.service > /dev/null <<EOF
[Unit]
Description=Initia Node
After=network.target

[Service]
User=$USER
Type=simple
ExecStart=$(which initiad) start --home $HOME/.initia
Restart=on-failure
LimitNOFILE=65535

[Install]
WantedBy=multi-user.target
EOF
```
{% endcode %}

{% code fullWidth="false" %}
```bash
# enable and start service
sudo systemctl daemon-reload && \
sudo systemctl enable initiad && \
sudo systemctl restart initiad && \
sudo journalctl -u initiad -f -o cat
```
{% endcode %}

#### Create Wallet

{% code fullWidth="false" %}
```bash
# to create a new wallet, use the following command. don’t forget to save the mnemonic
initiad keys add $WALLET_NAME

# to restore exexuting wallet, use the following command
initiad keys add $WALLET_NAME --recover

# save wallet and validator addres

# check sync status, once your node is fully synced, the output from above will print "false"
initiad status 2>&1 | jq 

# before creating a validator, you need to fund your wallet and check balance
initiad q bank balances $(initiad keys show wallet -a)
```
{% endcode %}

#### Create Validator (make sure your node synced before creating validator)

```bash
initiad tx mstaking create-validator \
--amount 1000000uinit \
--pubkey $(initiad tendermint show-validator) \
--moniker=$MONIKER \
--chain-id=$CHAIN_ID \
--identity "" \
--details "Independent & experienced validator with high performance and availability services." \
--website "" \
--commission-rate 0.05 \
--commission-max-rate 0.20 \
--commission-max-change-rate 0.05 \
--from=$WALLET_NAME \
--gas-adjustment 1.4 \
--gas auto \
--gas-prices 0.15uinit \
-y
```
