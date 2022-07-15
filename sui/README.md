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
wallet
```

serta `wallet --help` untuk command lainnya
