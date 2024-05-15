# Snapshot

## Snapshoot

**Stop the service and reset the data**

```
sudo systemctl stop initiad.service
cp $HOME/.initia/data/priv_validator_state.json $HOME/.initia/priv_validator_state.json.backup
rm -rf $HOME/.initia/data
```

**Download latest snapshot**

```
curl -L https://testnet-file.ruangnode.com/snap-testnet/initia-testnet/snapshot_latest.tar.lz4 | tar -Ilz4 -xf - -C $HOME/.initia
mv $HOME/.initia/priv_validator_state.json.backup $HOME/.initia/data/priv_validator_state.json
```

**Restart the service and check the log**

```
sudo systemctl start initiad.service && sudo journalctl -u initiad.service -f --no-hostname -o cat
```
