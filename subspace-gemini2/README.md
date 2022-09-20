<p align="right">
<html>
   <body>
      <a href="https://t.me/detective_gems/">
         Join Channel Detective Gems<img alt="Detective Gems" src="https://user-images.githubusercontent.com/48665887/191190210-b1c14331-4bd5-45ae-a271-e4f967ad7e45.png"
         width="20" height="20">
      </a>
   </body>
</html>
</p>
          
<p align="center">
 <img src="https://user-images.githubusercontent.com/48665887/191175627-c435b3ea-e1e2-4d3e-a1ad-ed35f58dac19.png" width="250">
<p>

# Subspace Gemini 2 Incentivized Testnet 2
---

- Date: September 20, 2022
- Time: 15.00 UTC
- Official Instructions: https://docs.subspace.network/ 
- More info about testnet: https://forum.subspace.network/t/gemini-ii-incentivized-testnet-will-be-live-on-sep-20/675

#### Official documentation:
----
- Official manual: https://github.com/subspace/subspace/blob/main/docs/farming.md
- Telemetry: https://telemetry.subspace.network/#list/0x43d10ffd50990380ffe6c9392145431d630ae67e89dbc9c014cac2a417759101
- Block explorer: https://polkadot.js.org/apps/?rpc=wss%3A%2F%2Feu-1.gemini-2a.subspace.network%2Fws#/explorer

#### Recommended hardware requirements
| Hardware | Specs    |
| :---:   | :---: |
| CPU | 4 CPU   |
| RAM | 8GB RAM |
| DISK | 160 GB SSD STORAGE |
| OS | Ubuntu 20.04 LTS|

#### Required ports :
- TCP port `30333`

Prepare subspace account :
To create subspace account:

1. [Download](https://chrome.google.com/webstore/detail/polkadot%7Bjs%7D-extension/mopnmbcafieddcagagdcbnhejhlodfdd) and install Browser Extension
2. [Navigate](https://polkadot.js.org/apps/?rpc=wss%3A%2F%2Feu-1.gemini-2a.subspace.network%2Fws#/accounts) to Subspace Explorer and press Add account button
3. Save mnemonic and create wallet
4. This will generate wallet address that you will have to use later. Example of wallet address: `st8SsbJcziPrGTrmGsiJ7GeG2oBqpKhmwmHaoCum99ggAHNYu`

## Set up your Subspace full node

Type this (automatic instalation)
```
wget -O subspace.sh https://raw.githubusercontent.com/lukmanc405/testnet/main/subspace-gemini2/subspace.sh && chmod +x subspace.sh && ./subspace.sh
```
### For Azure server (only)
if failed instalation you need additional permission for instalation,the reinstall
```
sudo chmod a+rwx /usr/local/bin/
sudo chmod a+rwx /etc/systemd/system/
sudo chmod a+rwx /home/
```


### Check telemetry :
- Go to [Telemetry Explorer](https://telemetry.subspace.network/#list/0x43d10ffd50990380ffe6c9392145431d630ae67e89dbc9c014cac2a417759101)
- Type your node name in search
 ![image](https://user-images.githubusercontent.com/48665887/191182236-e9d87fb6-b652-4181-9f48-1bed2a77595e.png)

 ### Check node synchronization
If output is `false` your node is synchronized
```
 curl -s -X POST http://localhost:9933 -H "Content-Type: application/json" --data '{"id":1, "jsonrpc":"2.0", "method": "system_health", "params":[]}' | jq .result.isSyncing
 ```
 
 ### Update the node (if needed)
 ```
 cd $HOME && rm -rf subspace-*
APP_VERSION=$(curl -s https://api.github.com/repos/subspace/subspace/releases/latest | jq -r ".tag_name" | sed "s/runtime-/""/g")
wget -O subspace-node https://github.com/subspace/subspace/releases/download/${APP_VERSION}/subspace-node-ubuntu-x86_64-${APP_VERSION}
wget -O subspace-farmer https://github.com/subspace/subspace/releases/download/${APP_VERSION}/subspace-farmer-ubuntu-x86_64-${APP_VERSION}
chmod +x subspace-*
mv subspace-* /usr/local/bin/
systemctl restart subspaced
sleep 30
systemctl restart subspaced-farmer
 ```
### Check node logs
 
```
journalctl -u subspaced -f -o cat
```

### Check farmer logs 
 
```
journalctl -u subspaced-farmer -f -o cat
```
 
### Delete subspace-nodes
```
sudo systemctl stop subspaced subspaced-farmer
sudo systemctl disable subspaced subspaced-farmer
rm -rf ~/.local/share/subspace*
rm -rf /etc/systemd/system/subspaced*
rm -rf /usr/local/bin/subspace*
```
