<p align="center">
 <img src="https://user-images.githubusercontent.com/48665887/191175627-c435b3ea-e1e2-4d3e-a1ad-ed35f58dac19.png" width="250">
<p>

# Subspace Gemini 2 Incentivized Testnet 2
---

- Date: September 20, 2022
- Time: 15.00 UTC
- Official Instructions: https://docs.subspace.network/ More info about testnet: https://forum.subspace.network/t/gemini-ii-incentivized-testnet-will-be-live-on-sep-20/675

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

### Check telemetry :
- Go to [Telemetry Explorer](https://telemetry.subspace.network/#list/0x43d10ffd50990380ffe6c9392145431d630ae67e89dbc9c014cac2a417759101)
- Type your node name in search
