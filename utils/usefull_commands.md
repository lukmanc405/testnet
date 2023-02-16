# Other common commands

### _`CHAIN`- the name of your chain. For example: `nibid`, `gaiad`, `evmosd`_

### Service management

#### check log

```
sudo journalctl -u CHAINd -f
```

#### run/restart node

```
sudo systemctl restart CHAINd
```

#### stop node

```
sudo systemctl stop CHAINd
```

### Node information

#### Synchronization information

```
CHAINd status 2>&1 | jq .SyncInfo
```

### Validator information

```
CHAINd status 2>&1 | jq .ValidatorInfo
```

#### node information

```
CHAINd status 2>&1 | jq .NodeInfo
```

#### get node id

```
CHAINd tendermint show-node-id
```

### Wallet operation

#### show all wallets

```
CHAINd keys list
```

#### restore wallet

```
CHAINd keys add YOUR_WALLET_NAME --recover
```

#### delete wallet

```
CHAINd keys delete YOUR_WALLET_NAME
```

### Check balances

```
CHAINd query bank balances WALLET_ADDRESS
```

#### send tokens

```
CHAINd tx bank send YOUR_WALLET_NAME RECIPIENT AMOUNT_unibi --from YOR_WALLET_NAME -y --chain-id=CHAIN_ID_FROM_DOC --fees 5000unibi
```

`Note: 1nibi=1000000unibi`

#### vote

```
CHAINd tx gov vote NUMBER yes --from YOUR_WALLET -y --chain-id=CHAIN_ID_FROM_DOC --fees 5000unibi
```

`Voting options include yes/no/no_with_veto/abstain. In most cases, we just vote yes.`

### Stake, withdraw rewards

#### pledge

```
CHAINd tx staking delegate VALIDATOR_ADDRESS AMOUNTunibi --from WALLET_NAME -y --chain-id=CHAIN_ID_FROM_DOC --fees 5000unibi
```

#### release pledge

```
CHAINd tx staking unbond VALIDATOR_ADDRESS_to_CANCEL AMOUNTunibi --from WALLET_NAME -y --chain-id=CHAIN_ID_FROM_DOC --fees 5000unibi
```

#### Withdraw staking rewards and validator commissions

```
CHAINd tx distribution withdraw-rewards VALIDATOR_ADDRESS --commission --from WALLET_NAME -y --chain-id=CHAIN_ID_FROM_DOC --fees 5000unibi
```

#### Withdraw all rewards

```
CHAINd tx distribution withdraw-all-rewards --from=WALLET_NAME -y --chain-id=CHAIN_ID_FROM_DOC --fees 5000unibi
```

### Validator Management

### Modify validator information

```
CHAINd tx staking edit-validator \
  --new-moniker=YOUR_MONIKER \
  --identity= keybase id \
  --website="website.com" \
  --details="YOUR DESCRIPTION" \
  --from=WALLET \
  --fees 5000unibi \
  --chain-id=CHAIN_ID_FROM_DOC
```

#### Suppose you want to display your validator logo in the block explorer. You need to register a keybase account and upload your logo. Set it in the validator information, `--identity= keybase id` and your keybase logo will be displayed in the blockchain browser as the validator logo.

#### Unjail

```
CHAINd tx slashing unjail --from <WALLET> -y --chain-id=CHAIN_ID_FROM_DOC --fees 5000unibi
```
