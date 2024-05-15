# Snapshot

```bash
sudo systemctl stop initiad
cp $HOME/.initia/data/priv_validator_state.json $HOME/.initia/priv_validator_state.json.backup
rm -rf $HOME/.initia/data

curl -o - -L https://snapshots.polkachu.com/testnet-snapshots/initia/initia_113153.tar.lz4 | lz4 -c -d - | tar -x -C $HOME/.initia
mv $HOME/.initia/priv_validator_state.json.backup $HOME/.initia/data/priv_validator_state.json

sudo systemctl restart initiad && sudo journalctl -fu initiad -o cat
```
