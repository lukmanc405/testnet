# API and sync

## Api & Sync

Explorer:

```
https://explorer.detectivegems.com/Axone-Mainnet
```

API:

```
https://api.axone.detectivegems.com/
```

RPC:

```
https://rpc.axone.detectivegems.com/
```

#### Peers Scanner: <a href="#peers-scanner" id="peers-scanner"></a>

```
PEERS="170735d649528ac9b86ccddae1aa861712c73b6d@2.58.66.195:26657,b356ae3dbfc97a21a89db0d58fdf00c7158d4d85@142.132.131.184:26657,ca26ae682d9bb9ae1c6cbab80fdf163ec8ed4409@65.109.26.242:26657,740741048700f4e8cc1fb6609bddc569e5b9d6d5@65.108.236.5:26657,46f9edbbce02f0e6cf8aac82f65fe7aedecf3abd@51.159.96.236:26657,d6b085b7760a91173239749aed6c3b5dd3fc80a5@144.76.106.139:26657,88a89303f7efed5310d2333fc40940aaacac7d3d@217.160.102.31:26657,9ae2608641ed016c38a5357c5ab1051da2cafba2@148.72.141.245:26657,39c9c7c58acaff14f4cf390d1ff7beb0a0e0e823@65.108.77.252:26657,b5b93e898b3df6ac6ee658cf6bc8cb7cac52b3d4@104.234.124.70:26657,41caa4106f68977e3a5123e56f57934a2d34a1c1@95.214.55.227:26657,17cadb3115c706bd0338a081121c6c7252b7a5f2@65.21.237.228:26657,e97341e910d0f8c92257f16d38dcf5513196dd41@65.109.125.172:26657,a963a7a927a49dd66e9bf1c1a04127d34d7edb6f@65.21.227.52:26657,59187af99c56ef82e0284cc992d03c201a64dc78@158.69.125.73:26657,6d36d8c89f767543bda82f2a3cc3a5752f2c1bcd@85.10.201.125:26657,dbec5b1a7d54e7e71d85f09eba17c3caad4b846e@31.7.196.140:26657,276fc1c6ece1983b4b35819555694451f40bf7f1@65.108.73.25:26657,01c5ea12715ca34bd71c5596c39a9cbf06fefb91@144.76.15.203:26657,8638a5ec1622743940c8e30322f6fa503631d468@95.217.85.81:26657"
sed -i -e "/^\[p2p\]/,/^\[/{s/^[[:space:]]*persistent_peers *=.*/persistent_peers = \"$PEERS\"/}" $HOME/.axoned/config/config.toml
```

#### State sync <a href="#state-sync" id="state-sync"></a>

```
sudo systemctl stop axoned
cp $HOME/.axoned/data/priv_validator_state.json $HOME/.axoned/priv_validator_state.json.backup
axoned comet unsafe-reset-all --home $HOME/.axoned--keep-addr-book

SNAP_RPC="https://axone-rpc.nodesync.top:443"
LATEST_HEIGHT=$(curl -s $SNAP_RPC/block | jq -r .result.block.header.height); \
BLOCK_HEIGHT=$((LATEST_HEIGHT - 1000)); \
TRUST_HASH=$(curl -s "$SNAP_RPC/block?height=$BLOCK_HEIGHT" | jq -r .result.block_id.hash)

sed -i "/\[statesync\]/, /^enable =/ s/=.*/= true/;\
/^rpc_servers =/ s|=.*|= \"$SNAP_RPC,$SNAP_RPC\"|;\
/^trust_height =/ s/=.*/= $BLOCK_HEIGHT/;\
/^trust_hash =/ s/=.*/= \"$TRUST_HASH\"/" $HOME/.axoned/config/config.toml
mv $HOME/.axoned/priv_validator_state.json.backup $HOME/.axoned/data/priv_validator_state.json

sudo systemctl restart axoned && sudo journalctl -u axoned -fo cat
```

#### Snapshot <a href="#snapshot" id="snapshot"></a>

```
sudo systemctl stop axoned

cp $HOME/.axoned/data/priv_validator_state.json $HOME/.axoned/priv_validator_state.json.backup

axoned tendermint unsafe-reset-all --home $HOME/.axoned --keep-addr-book
curl -L https://snapshot.axone.detectivegems.com/axone/axone-latest.tar.lz4 | lz4 -dc - | tar -xf - -C "$HOME/.axoned"

mv $HOME/.axoned/priv_validator_state.json.backup $HOME/.axoned/data/priv_validator_state.json

sudo systemctl restart axoned
sudo journalctl -u axoned -f --no-hostname -o cat
```
