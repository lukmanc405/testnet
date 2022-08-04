
![68747470733a2f2f6f626f6c2e746563682f6f626f6c6e6574776f726b2e706e67](https://user-images.githubusercontent.com/48665887/180147974-1e7afb58-4996-4ea3-8d81-69d39d2bb07d.png)


[👉Join Channel Telegram ![7e4c70c3-4a81-4d90-828e-c5e57908cab4](https://user-images.githubusercontent.com/48665887/179027908-18257283-eca3-42f8-980c-491f4307ee0c.png)](https://t.me/detective_gems)


[👉Deploy server vps anda dengan menggunakan link refferal kami dan dapatkan bonus 20€ ![73811c4d-8dc6-408c-8ada-65d8ca90c753 (1)](https://user-images.githubusercontent.com/48665887/179025989-29a5e7f2-9e4e-4906-99b6-fdc3675f1747.png)](https://hetzner.cloud/?ref=Z8fHigYuskgS)

### Charon Distributed Validator Node

**Step 1. Buat dan backup up private key untuk charon**

```
wget -O obol.sh https://raw.githubusercontent.com/lukmanc405/testnet/main/obol/obol.sh && chmod +x obol.sh && ./obol.sh
```

nanti akan terlihat seperti ini 

![image](https://user-images.githubusercontent.com/48665887/180239172-6128ce17-906f-48b2-81cb-099aaf05487d.png)

### cara menampilkan ENR:- terbaru
>setiap kali anda melakukan command dibawah ini jangan kaget kalau ENR berubah-ubah karena dia menyesuaikan timestamp
>pastikan anda sudah Backup file privatekey di /root/charon-distributed-validator-node/.charon/ ke PC anda (bisa pakai SFTP)


```
cd $HOME/charon-distributed-validator-node/
sudo chmod a+rwx .charon
docker run --rm -v "$(pwd):/opt/charon" ghcr.io/obolnetwork/charon:v0.9.0 enr
```

### Cara import private key

>Install dulu ini

```
wget -O obol.sh https://raw.githubusercontent.com/lukmanc405/testnet/main/obol/obol.sh && chmod +x obol.sh && ./obol.sh
```

>setelah itu replace file private key di folder .charon pakai file yang sudah dibackup pakai SFTP
