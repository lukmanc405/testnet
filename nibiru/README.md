<p align="right">
<html>
   <body>
      <a href="https://t.me/detective_gems/">
         Join Channel Detective Gems  <img alt="Detective Gems"src="https://user-images.githubusercontent.com/48665887/191190210-b1c14331-4bd5-45ae-a271-e4f967ad7e45.png"
         width="20" height="20">
      </a>
   </body>
</html>
</p>

### Introduction Nibiru

---

Nibiru is a sovereign proof-of-stake blockchain, open-source platform, and member of a family of interconnected blockchains that comprise the Cosmos Ecosystem.

Nibiru unifies leveraged derivatives trading, spot trading, staking, and bonded liquidity provision into a seamless user experience, enabling users of over 40 blockchains to trade with leverage using a suite of composable decentralized applications.

<a id="anchor"></a>

Nibiru Chain #7 | Nibiru Incentivized Testnet #1 node tutorial

[<img align="right" alt="Personal Website" width="22px" src="https://raw.githubusercontent.com/iconic/open-iconic/master/svg/globe.svg" />][nibiru-website]
[<img align="right" alt="Nibiru Discord" width="22px" src="https://cdn.jsdelivr.net/npm/simple-icons@v3/icons/discord.svg" />][nibiru-discord]
[<img align="right" alt="Nibiru Medium Blog" width="22px" src="https://cdn.jsdelivr.net/npm/simple-icons@3.13.0/icons/medium.svg"/>][nibiru-medium]

[nibiru-medium]: https://blog.nibiru.fi
[nibiru-website]: https://docs.nibiru.fi
[nibiru-discord]: https://discord.com/invite/pgArXgAxDD

|                                                                               Sections |                                                            Description |
| -------------------------------------------------------------------------------------: | ---------------------------------------------------------------------: |
|                                                   [Install the basic environment](#go) |                           Install golang. Command to check the version |
|                                     [Install other necessary environments](#necessary) |                                  Clone repository. Compilation project |
|                                                                       [Run Node](#run) | Initialize node. Create configuration files. Check logs & sync status. |
|                                                         [Create Validator](#validator) |                          Create valdator & wallet, check your balance. |
| [Useful commands](https://github.com/lukmanc405/testnet/blob/main/usefull_commands.md) |                                     The other administration commands. |
|                                             [Explorer](https://nibiru.explorers.guru/) |                   Check whether your validator is created successfully |

 <p align="center"><a href="https://docs.nibiru.fi/"><img align="right"width="100px"alt="nibiru" src="https://i.ibb.co/865XFvQ/Niburu.png"></p</a>

| Minimum configuration |
| --------------------- |

- 2 CPU
- 4 GB RAM (The requirements written in the official tutorial are too high, the actual 8GB+ is enough)
- 100GB SSD

---

## Manual Instalation

### -Install the basic environment

#### The system used in this tutorial is Ubuntu20.04, please adjust some commands of other systems by yourself. It is recommended to use a foreign VPS.

<a id="go"></a>

#### Install golang (start here)

```
if ! [ -x "$(command -v go)" ]; then
  ver="1.18.2"
  cd $HOME
  wget "https://golang.org/dl/go$ver.linux-amd64.tar.gz"
  sudo rm -rf /usr/local/go
  sudo tar -C /usr/local -xzf "go$ver.linux-amd64.tar.gz"
  rm "go$ver.linux-amd64.tar.gz"
  echo "export PATH=$PATH:/usr/local/go/bin:$HOME/go/bin" >> ~/.bash_profile
  source ~/.bash_profile
fi
```

#### After the installation is complete, run the following command to check the version

```
go version
```

<a id="necessary"></a>
[Up to sections ↑](#anchor)

### -Install other necessary environments

#### Update apt

```
sudo apt update && sudo apt full-upgrade -y
sudo apt list --upgradable
sudo apt install curl tar wget clang pkg-config libssl-dev jq build-essential bsdmainutils git make ncdu gcc git jq chrony liblz4-tool -y
```

```
cd
git clone https://github.com/NibiruChain/nibiru
cd nibiru
git checkout v0.19.2
make install
nibid version # v0.19.2
```

After the installation is complete, you can run `nibid version` to check whether the installation is successful.

Display should be # v0.19.2
<a id="run"></a>

### -Run node

#### Initialize node

**Change XXX with your moniker name**

```
moniker=lukman-nodes
echo 'export moniker='$moniker >> $HOME/.bash_profile
source ~/.bash_profile
nibid config keyring-backend test
nibid config chain-id nibiru-itn-1
nibid init "$moniker" --chain-id nibiru-itn-1
```

#### Download the Genesis file

```
curl -s https://rpc.itn-1.nibiru.fi/genesis | jq -r .result.genesis > $HOME/.nibid/config/genesis.json
curl -s https://snapshots2-testnet.nodejumper.io/nibiru-testnet/addrbook.json > $HOME/.nibid/config/addrbook.json
```

#### Set peer and seed

```
SEEDS="3f472746f46493309650e5a033076689996c8881@nibiru-testnet.rpc.kjnodes.com:39659,a431d3d1b451629a21799963d9eb10d83e261d2c@seed-1.itn-1.nibiru.fi:26656,6a78a2a5f19c93661a493ecbe69afc72b5c54117@seed-2.itn-1.nibiru.fi:26656"
PEERS="a08e5b25443d038b08230177456ee23196509dd5@65.109.92.79:12656,f4a6bcbd4af5cfd82ee3a40c54800176e33e9477@31.220.79.15:26656,62d93ddd046e8092c3717117484ed680cbacbf0d@139.59.239.43:26656,f29c808ff578c7f3a3746b9b0b3e0504b3ee2315@65.108.216.139:26656,8ebed484e09f93b12be00b9f6faa55ea9b13b372@45.84.138.66:39656,4f1c8f3de055988bf15f21b666369287fb5230de@31.220.73.148:26656,c2c2af737665fafa38b52110e591687558fe788a@31.220.78.187:26656,aad0d897a82880e36bb909091c5878607446ab41@138.201.204.5:35656,5f3394bae3791bcb71364df80f99f22bd33cc2c0@95.216.7.169:60556,fe17db7c9a5f8478a2d6a39dbf77c4dc2d6d7232@5.75.189.135:26656"
sed -i 's|^persistent_peers *=.*|persistent_peers = "'$PEERS'"|' $HOME/.nibid/config/config.toml
sed -i 's|^seeds *=.*|seeds = "'$SEEDS'"|; s|^persistent_peers *=.*|persistent_peers = "'$PEERS'"|' $HOME/.nibid/config/config.toml
```

[Up to sections ↑](#anchor)

#### Pruning settings

```
sed -i 's|^pruning *=.*|pruning = "custom"|g' $HOME/.nibid/config/app.toml
sed -i 's|^pruning-keep-recent  *=.*|pruning-keep-recent = "100"|g' $HOME/.nibid/config/app.toml
sed -i 's|^pruning-interval *=.*|pruning-interval = "10"|g' $HOME/.nibid/config/app.toml
sed -i 's|^snapshot-interval *=.*|snapshot-interval = 2000|g' $HOME/.nibid/config/app.toml
```

### Set minimum gas prices and prometheus

```
sed -i 's|^minimum-gas-prices *=.*|minimum-gas-prices = "0.0001unibi"|g' $HOME/.nibid/config/app.toml
sed -i 's|^prometheus *=.*|prometheus = true|' $HOME/.nibid/config/config.toml
```


[Up to sections ↑](#anchor)

#### Start node

```
sudo tee /etc/systemd/system/nibid.service > /dev/null << EOF
[Unit]
Description=Nibiru Node
After=network-online.target
[Service]
User=$USER
ExecStart=$(which nibid) start
Restart=on-failure
RestartSec=10
LimitNOFILE=10000
[Install]
WantedBy=multi-user.target
EOF
```

```
sudo systemctl daemon-reload
sudo systemctl enable nibid
sudo systemctl start nibid
```

---

#### Show log

```
sudo journalctl -u nibid -f --no-hostname -o cat 
```

#### Check sync status

```
curl -s localhost:26657/status | jq .result | jq .sync_info
```

The display `"catching_up":` shows `false` that it has been synchronized. Synchronization takes a while, maybe half an hour to an hour. If the synchronization has not started, it is usually because there are not enough peers. You can consider adding a Peer or using someone else's addrbook.


#### State-sync fast synchronization

```
sudo systemctl stop nibid

cp $HOME/.nibid/data/priv_validator_state.json $HOME/.nibid/priv_validator_state.json.backup

rm -rf $HOME/.nibid/data 
curl https://files.itrocket.net/testnet/nibiru/snap_nibiru.tar.lz4 | lz4 -dc - | tar -xf - -C $HOME/.nibid

mv $HOME/.nibid/priv_validator_state.json.backup $HOME/.nibid/data/priv_validator_state.json

sudo systemctl restart nibid && sudo journalctl -u nibid -f
```

[Up to sections ↑](#anchor)

#### Replace addrbook

```
nibid tendermint unsafe-reset-all --home $HOME/.nibid --keep-addr-book
```

<a id="validator"></a>

### Create a validator

#### Create wallet

```
nibid keys add wallet
```
## `Note please save the mnemonic and priv_validator_key.json file! If you don't save it, you won't be able to restore it later.`

#### SAVE PRIVATE VALIDATOR KEY

```
cat $HOME/.nibid/config/priv_validator_key.json
```

---

### Receive test coins

#### Go to nibiru discord https://discord.gg/p8EudUCrPH

[Up to sections ↑](#anchor)

#### Sent in #faucet channel discord

`$request WALLET_ADDRESS`

- or with command

```
FAUCET_URL="https://faucet.itn-1.nibiru.fi/"
ADDR="nibi1rehrzrxl7kesyutlktncnqkrue0f6u50z06suc" # paste your address
curl -X POST -d '{"address": "'"$ADDR"'", "coins": ["11000000unibi","100000000unusd","100000000uusdt"]}' $FAUCET_URL
```

#### Can be used later

```
nibid q bank balances $(nibid keys show wallet -a)
```

#### Query the test currency balance.

#### Create a validator

`After enough test coins are obtained and the node is synchronized, a validator can be created. Only validators whose pledge amount is in the top 100 are active validators.`

```
# create validator
nibid tx staking create-validator \
--amount=1000000unibi \
--pubkey=$(nibid tendermint show-validator) \
--moniker="$moniker" \
--identity="" \
--details="" \
--website="" \
--chain-id=nibiru-itn-1 \
--commission-rate=0.1 \
--commission-max-rate="0.10" \
--commission-max-change-rate="0.01" \
--min-self-delegation=1 \
--from=wallet \
--gas-adjustment=1.4 \
--gas=auto \
--gas-prices=0.025unibi \
-y
```

## make sure you see the validator details

```
nibid q staking validator $(nibid keys show wallet --bech val -a)
```

#### After that, you can go to the validator table [explorer](https://app.nibiru.fi/stake) to check whether your validator is created successfully.

## And [other commands](https://github.com/lukmanc405/testnet/blob/main/utils/usefull_commands.md)

#### More information

## |[Official website](https://nibiru.fi/) |[Official twitter](https://twitter.com/NibiruChain) | [Discord](https://discord.gg/nsV3a5CdC9) | [Github](https://github.com/NibiruChain) | [Documentation](https://docs.nibiru.fi/)|

### [Up to sections ↑](#anchor)
