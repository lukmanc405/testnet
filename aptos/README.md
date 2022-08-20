![image](https://user-images.githubusercontent.com/48665887/185726831-3bdb42a3-3b6f-4a64-a9fd-3515f14ce7fb.png)

### Halaman ini memberikan guide tentang bagaimana cara deploy ke berbagai macam server project

[👉Join Channel Telegram ![7e4c70c3-4a81-4d90-828e-c5e57908cab4](https://user-images.githubusercontent.com/48665887/179027908-18257283-eca3-42f8-980c-491f4307ee0c.png)](https://t.me/detective_gems)


[👉Deploy server vps anda dengan menggunakan link refferal kami dan dapatkan bonus 20€ ![73811c4d-8dc6-408c-8ada-65d8ca90c753 (1)](https://user-images.githubusercontent.com/48665887/179025989-29a5e7f2-9e4e-4906-99b6-fdc3675f1747.png)](https://hetzner.cloud/?ref=Z8fHigYuskgS)


### Tutorial Testnet Aptos dengan VPS by lukman (●'◡'●)
### System Requirement
- 8vCPU
- 32GB RAM
- 16 Threads
- Ubuntu 20.04 LTS

### Register community aptos
> https://aptoslabs.com/incentivized-testnet

### Buat dan konek wallet
> link download https://github.com/aptos-labs/aptos-core/releases?q=wallet&expanded=true

tutorial install wallet dengan video :
https://youtu.be/-03D_M7vMZ4

### Install aptos validator

```
wget -qO aptos-bylukman.sh https://raw.githubusercontent.com/lukmanc405/testnet/main/aptos/aptos-bylukman.sh && chmod +x aptos-bylukman.sh && ./aptos-bylukman.sh
```

### aktifkan port yang diperlukan

```
apt install ufw -y
ufw allow ssh
ufw allow https
ufw allow http
ufw allow 6180
ufw allow 80
ufw allow 9101
ufw allow 181
ufw allow 182
ufw allow 8080
ufw allow 9103
ufw enable
```

### Cek kesehatan node
> https://node.aptos.zvalid.com/

![image](https://user-images.githubusercontent.com/48665887/185727035-b0d6e2eb-fe3c-47db-844c-0aa1e43c0a0c.png)

### Cek aptos sync version

```
curl 127.0.0.1:9101/metrics 2> /dev/null | grep "aptos_state_sync_version{.*\"synced\"}" | awk '{print $2}'
```

### Untuk cek log (Bila perlu)

```
docker logs testnet-validator-1 -f
```
### Setelah penginstalan
isi data :
> https://aptoslabs.com/it3

NB : untuk bagian ini

kalian bisa dapatkan data ini di 
`cat ~/$WORKSPACE/$USERNAME/operator.yaml && cat ~/$WORKSPACE/$USERNAME/owner.yaml`

![image](https://user-images.githubusercontent.com/48665887/185727483-44ffed88-22e3-46cf-b329-9663dda88f80.png)

![image](https://user-images.githubusercontent.com/48665887/185727519-6c34f36c-a25e-4e17-830e-a7a3ffd7b5df.png)

Kalau sudah isi diatas tinggal `validate node`


### cara uninstall aptos 

```
cd ~/WORKSPACE && docker-compose down -v
```
