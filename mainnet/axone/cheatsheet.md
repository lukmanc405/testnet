# Cheatsheet

## Cheat Sheet

### Wallet <a href="#wallet" id="wallet"></a>

#### Add New Wallet Key <a href="#add-new-wallet-key" id="add-new-wallet-key"></a>

```
axoned keys add wallet
```

#### Recover existing key <a href="#recover-existing-key" id="recover-existing-key"></a>

```
axoned keys add wallet --recover
```

#### List All Keys <a href="#list-all-keys" id="list-all-keys"></a>

```
axoned keys list
```

#### Query Wallet Balance <a href="#query-wallet-balance" id="query-wallet-balance"></a>

```
axoned q bank balances $(axoned keys show wallet -a)
```

#### Check sync status <a href="#check-sync-status" id="check-sync-status"></a>

```
axoned status 2>&1 | jq .sync_info
```

### Create Validator <a href="#create-validator" id="create-validator"></a>

```
axoned tx staking create-validator <(cat <<EOF
{
  "pubkey": $(axoned comet show-validator),
  "amount": "1000000uaxone",
  "moniker": "YOUR_MONIKER_NAME",
  "identity": "YOUR_KEYBASE_ID",
  "website": "YOUR_WEBSITE_URL",
  "security": "YOUR_SECURITY_EMAIL",
  "details": "YOUR_DETAILS",
  "commission-rate": "0.05",
  "commission-max-rate": "0.20",
  "commission-max-change-rate": "0.05",
  "min-self-delegation": "1"
}
EOF
) \
--chain-id axone-1 \
--from wallet \
--gas-prices=0.025uaxone \
--gas-adjustment=1.5 \
--gas=auto \
-y
```

### Edit existing validator <a href="#edit-existing-validator" id="edit-existing-validator"></a>

```
axoned tx staking edit-validator \
--new-moniker "YOUR_MONIKER_NAME" \
--identity "YOUR_KEYBASE_ID" \
--details "YOUR_DETAILS" \
--website "YOUR_WEBSITE_URL" \
--commission-rate 0.05 \
--chain-id axone-1 \
--from wallet \
--gas-prices=0.025uaxone \
--gas-adjustment=1.5 \
--gas=auto \
-y
```

### Delegate Token to your own validator <a href="#delegate-token-to-your-own-validator" id="delegate-token-to-your-own-validator"></a>

```
axoned tx staking delegate $(axoned keys show wallet --bech val -a)  1000000uaxone \
--chain-id=axone-1 \
--from=wallet \
--gas-prices=0.025uaxone \
--gas-adjustment=1.5 \
--gas=auto \
-y 
```

### Withdraw rewards from all validators <a href="#withdraw-rewards-from-all-validators" id="withdraw-rewards-from-all-validators"></a>

```
axoned tx distribution withdraw-all-rewards --from wallet --chain-id axone-1 --gas-adjustment 1.4 --gas auto --gas-prices 0.025uaxone -y
```

### Withdraw rewards and commission from your validator <a href="#withdraw-rewards-and-commission-from-your-validator" id="withdraw-rewards-and-commission-from-your-validator"></a>

```
axoned tx distribution withdraw-rewards $(axoned keys show wallet --bech val -a) --commission --from wallet --chain-id axone-1 --gas-adjustment 1.4 --gas auto --gas-prices 0.025uaxone  -y
```

### Unjail validator <a href="#unjail-validator" id="unjail-validator"></a>

```
axoned tx slashing unjail --from wallet \
--chain-id=axone-1 \
--from=wallet \
--gas-prices=0.025uaxone \
--gas-adjustment=1.5 \
--gas=auto \
-y
```

### Services Management <a href="#services-management" id="services-management"></a>

```
# Reload Service
sudo systemctl daemon-reload

# Enable Service
sudo systemctl enable axoned

# Disable Service
sudo systemctl disable axoned

# Start Service
sudo systemctl start axoned

# Stop Service
sudo systemctl stop axoned

# Restart Service
sudo systemctl restart axoned

# Check Service Status
sudo systemctl status axoned

# Check Service Logs
sudo journalctl -u axoned -f --no-hostname -o cat
```

### Backup Validator <a href="#backup-validator" id="backup-validator"></a>

```
cat $HOME/.axoned/config/priv_validator_key.json
```

### Remove node <a href="#remove-node" id="remove-node"></a>

```
sudo systemctl stop axoned
sudo systemctl disable axoned
rm -rf /etc/systemd/system/axoned.service
sudo systemctl daemon-reload
sudo rm -f /usr/local/bin/axoned
sudo rm -f $(which axoned)
sudo rm -rf $HOME/.axoned
```
