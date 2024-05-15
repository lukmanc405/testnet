# Sui

#### Tutorial Testnet SUI dengan VPS by lukman (●'◡'●)

#### **System Requirement**

* 2vCPU
* 8GB RAM
* Ubuntu 20.04

**Install sui full nodes**

```
wget -O sui_docker.sh https://raw.githubusercontent.com/lukmanc405/testnet/main/sui/sui_docker.sh && chmod +x sui_docker.sh && ./sui_docker.sh
```

**Cek node status**

```
curl -s -X POST http://127.0.0.1:9000 -H 'Content-Type: application/json' -d '{ "jsonrpc":"2.0", "method":"rpc.discover","id":1}' | jq .result.info
```

**Cek lima tx terakhir**

```
curl --location --request POST 'http://127.0.0.1:9000/' --header 'Content-Type: application/json' \
--data-raw '{ "jsonrpc":"2.0", "id":1, "method":"sui_getRecentTransactions", "params":[5] }' | jq .
```

**Dapatkan detail tx**

```
curl --location --request POST 'http://127.0.0.1:9000/' --header 'Content-Type: application/json' \
--data-raw '{ "jsonrpc":"2.0", "id":1, "method":"sui_getTransaction", "params":["<RECENT_TXN_FROM_ABOVE>"] }' | jq .
```

> **JOIN DISCORD SUI** https://discord.gg/UZFSc68qU9

Paste IP kalian disini

![image](https://user-images.githubusercontent.com/48665887/179150535-4287085d-91a5-4a6c-b6db-cd7346b662c0.png)

#### Buat wallet SUI

mulai jalankan script nya

```
wget -O sui-wallet.sh https://raw.githubusercontent.com/lukmanc405/testnet/main/sui/sui-wallet.sh && chmod +x sui-wallet.sh && ./sui-wallet.sh
```

setelah melewati waktu yang ditentukan , kalian bisa gunakan command

```
sui client
```

ubah gateway wallet

```
sui client switch --gateway https://gateway.devnet.sui.io:443
```

cek address

```
sui client active-address
```

#### Backup

`wallet.key , wallet.yaml , keystore` Pakai SFTP

serta `sui --help` untuk command lainnya

Cara dapatkan faucet:

* copy address anda
* tempelkan kesini

![image](https://user-images.githubusercontent.com/48665887/179158274-fbec303b-8c4f-4b72-8b90-acd2461d258d.png)

#### Update versi SUI Fullnode

```
wget -qO update_docker.sh https://raw.githubusercontent.com/lukmanc405/testnet/main/sui/tools/update_docker.sh && chmod +x update_docker.sh && ./update_docker.sh
```

**Cek kesehatan node**

Masukkan node IP [https://node.sui.zvalid.com/](https://node.sui.zvalid.com/)

Node yang sehat terlihat seperti ini: ![image](https://user-images.githubusercontent.com/48665887/179166315-6d4164d6-970d-4e49-a2a1-73925cb7068c.png)

Command lainnya

Check node

```
docker ps -a
```

Stop node

```
cd $HOME/sui && docker-compose down --volumes
```
