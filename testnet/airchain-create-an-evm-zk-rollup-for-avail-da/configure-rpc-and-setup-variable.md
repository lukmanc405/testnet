# Configure RPC & Setup Variable

## Configure RPC



Edit your  `app.toml`

```bash
nano ~/.evmosd/config/app.toml
```

Change `127.0.0.1` to `0.0.0.0`  like this image below

<figure><img src="../../.gitbook/assets/image (2).png" alt=""><figcaption></figcaption></figure>

## Setup Variables

We are creating an environment for the system file to function properly.

```bash
nano ~/.rollup-env
```

#### There is nothing to change ın the code block here.

```bash
CHAINID="stationevm_1234-1"
MONIKER="localtestnet"
KEYRING="test"
KEYALGO="eth_secp256k1"
LOGLEVEL="info"
HOMEDIR="$HOME/.evmosd"
TRACE=""
BASEFEE=1000000000
CONFIG=$HOMEDIR/config/config.toml
APP_TOML=$HOMEDIR/config/app.toml
GENESIS=$HOMEDIR/config/genesis.json
TMP_GENESIS=$HOMEDIR/config/tmp_genesis.json
VAL_KEY="mykey"
```

## Create Service Files

```bash
# You can copy and paste the entire block with just one command.
sudo tee /etc/systemd/system/rolld.service > /dev/null << EOF
[Unit]
Description=ZK
After=network.target

[Service]
User=root
EnvironmentFile=/root/.rollup-env
ExecStart=/root/evm-station/build/station-evm start --metrics "" --log_level info --json-rpc.api eth,txpool,personal,net,debug,web3 --chain-id stationevm_9000-1
Restart=always
RestartSec=3

[Install]
WantedBy=multi-user.target
EOF
```

### Start Service rolld (please copy one by one for this)

```bash
sudo systemctl daemon-reload
sudo systemctl enable rolld
sudo systemctl start rolld
sudo journalctl -u rolld -f --no-hostname -o cat
```

<figure><img src="../../.gitbook/assets/image (1) (1).png" alt=""><figcaption></figcaption></figure>

This command will give us a private key, which we should store securely. (save to your notepad)

```
/bin/bash ./scripts/local-keys.sh
```

We will use Avail Turing as the DA layer. You can also use a mock DA (mock will allow earning points for a period of time). Currently, on the testnet, the DA cannot be changed later, but they said they will make this possible with an update.

```bash
cd $HOME
git clone https://github.com/availproject/availup.git
cd availup
/bin/bash availup.sh --network "turing" --app_id 36
```

#### Close with Ctrl+c, press Enter

<figure><img src="../../.gitbook/assets/image (2) (1).png" alt=""><figcaption></figcaption></figure>

```bash
# You can copy and paste the entire block with just one command.
sudo tee /etc/systemd/system/availd.service > /dev/null <<'EOF'
[Unit]
Description=Avail Light Node
After=network.target
StartLimitIntervalSec=0

[Service]
User=root
Type=simple
Restart=always
RestartSec=120
ExecStart=/root/.avail/turing/bin/avail-light --network turing --app-id 36 --identity /root/.avail/identity/identity.toml

[Install]
WantedBy=multi-user.target
EOF
```

### Start Service availd (please copy one by one for this)

```bash
systemctl daemon-reload 
sudo systemctl enable availd
sudo systemctl start availd
sudo journalctl -u availd -f --no-hostname -o cat
```

<figure><img src="../../.gitbook/assets/image (3).png" alt=""><figcaption></figcaption></figure>

Inside the file `~/.avail/identity/identity.toml`, you will find the Mnemonics of your Avail wallet. Copy and store these words. Close with Ctrl+c, press Enter, and make a note of the other `Avail-Mnemonics` given as they will be needed. Add the copied Mnemonics to Polkadot.js or Talisman wallet get your wallet address on the Avail Turing network and receive tokens from the faucet.

<figure><img src="../../.gitbook/assets/image (4).png" alt=""><figcaption></figcaption></figure>

### Avail Turing Faucet : [https://faucet.avail.tools/](https://faucet.avail.tools/)

### We are now moving on to the track and station section.

```bash
cd $HOME
cd tracks
go mod tidy
```

_**Change \<Avail-Wallet-Adress> and \<moniker-name>**_

```bash
go run cmd/main.go init --daRpc "http://127.0.0.1:7000" --daKey "<Avail-Wallet-Adress>" --daType "avail" --moniker "<moniker-name>" --stationRpc "http://127.0.0.1:8545" --stationAPI "http://127.0.0.1:8545" --stationType "evm"
```

output will like this

<figure><img src="../../.gitbook/assets/image (7).png" alt=""><figcaption></figcaption></figure>

Now we are creating a tracker address. Please replace `<moniker-name>`.

```bash
go run cmd/main.go keys junction --accountName <moniker-name> --accountPath $HOME/.tracks/junction-accounts/keys
```

output will like this

<figure><img src="../../.gitbook/assets/image (9).png" alt=""><figcaption></figcaption></figure>

### Run Prover

```bash
go run cmd/main.go prover v1EVM
```

Now , Search Your `NODE ID`

#### You can search for the node id with, go to the bottom, and scroll up a bit.

```bash
nano ~/.tracks/config/sequencer.toml
```

<figure><img src="../../.gitbook/assets/image (10).png" alt=""><figcaption></figcaption></figure>

### Prepare some preparations for this part and prepare the following command. SERVER(VPS) IP `<IP>` Get `nodeid>` in the `nano ~/.tracks/config/sequencer.toml` file Enter the `AIRCHAIN wallet address` you created before `<WALLET_ADDRESS>` Enter the validator name `<moniker-name>`

```bash
go run cmd/main.go create-station --accountName <moniker-name> --accountPath $HOME/.tracks/junction-accounts/keys --jsonRPC "https://airchains-testnet-rpc.cosmonautstakes.com/" --info "EVM Track" --tracks <WALLET_ADDRESS> --bootstrapNode "/ip4/<IP>/tcp/2300/p2p/<node_id>"
```

We have set up the station, now let's run it with a service.

```bash
sudo tee /etc/systemd/system/stationd.service > /dev/null << EOF
[Unit]
Description=station track service
After=network-online.target
[Service]
User=root
WorkingDirectory=/root/tracks/
ExecStart=/usr/local/go/bin/go run cmd/main.go start
Restart=always
RestartSec=3
LimitNOFILE=65535
[Install]
WantedBy=multi-user.target
EOF
```

### Start Service stationd (please copy one by one for this)

```bash
sudo systemctl daemon-reload
sudo systemctl enable stationd
sudo systemctl restart stationd
sudo journalctl -u stationd -f --no-hostname -o cat
```

