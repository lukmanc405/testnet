
[👉Join Channel Telegram ![7e4c70c3-4a81-4d90-828e-c5e57908cab4](https://user-images.githubusercontent.com/48665887/179027908-18257283-eca3-42f8-980c-491f4307ee0c.png)](https://t.me/detective_gems)


[👉Deploy server vps anda dengan menggunakan link refferal kami dan dapatkan bonus 20€ ![73811c4d-8dc6-408c-8ada-65d8ca90c753 (1)](https://user-images.githubusercontent.com/48665887/179025989-29a5e7f2-9e4e-4906-99b6-fdc3675f1747.png)](https://hetzner.cloud/?ref=Z8fHigYuskg)


### Tutorial Testnet SUI dengan VPS by lukman (●'◡'●)

### **System Requirement**

- 2vCPU
- 8GB RAM
- Ubuntu 20.04

**Install sui full nodes**
```
wget -O sui.sh https://raw.githubusercontent.com/lukmanc405/testnet/main/sui/sui.sh && chmod +x sui.sh && ./sui.sh
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
>**JOIN DISCORD SUI**
https://discord.gg/UZFSc68qU9

Paste IP kalian disini

![image](https://user-images.githubusercontent.com/48665887/179150535-4287085d-91a5-4a6c-b6db-cd7346b662c0.png)

### Buat wallet SUI
Karena penginstalan cukup lama kalian bisa gunakan `new screen`

Buka dulu `new screen`

```
screen -R "wallet-sui"
```

mulai jalankan script nya
```
wget -O sui-wallet.sh https://raw.githubusercontent.com/lukmanc405/testnet/main/sui/sui-wallet.sh && chmod +x sui-wallet.sh && ./sui-wallet.sh
```

kalian bisa menutupnya dengan menggunakan `CTRL+A` lalu `D`

wallet akan jadi dalam waktu 30-60 menit kalian bisa menutup terminal dulu

setelah melewati waktu yang ditentukan , kalian bisa gunakan command 

```
sui client
```

Jika menemukan tulisan seperti ini cukup enter saja

![image](https://user-images.githubusercontent.com/48665887/179157296-39212044-b36d-47f5-9fdf-9fe91a3bcdc3.png)


ubah gateway wallet

```
sui client switch --gateway https://gateway.devnet.sui.io:443
```

cek address

```
sui client active-address
```

serta `sui --help` untuk command lainnya

