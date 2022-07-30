### Join Channel
https://t.me/detective_gems

### Testnet yang ditunggu-tunggu dari tim Bundlr telah dimulai.
![image](https://user-images.githubusercontent.com/48665887/178899422-b914ca03-12c1-4157-868e-2b92b010ade2.png)

> explorer :
> https://bundlr.network/explorer

### Persyaratan Hardware

- Memory: 8 GB RAM
- CPU: 4 Core
- Disk: 250 GB SSD Storage
- Bandwidth: 1 Gbps buat Download/100 Mbps buat Upload

### Langkah-langkah instalasi:
Anda dapat setting Bundlr Node Anda dalam hitungan menit menggunakan skrip otomatis di bawah ini.

```
wget -O lukmanbundlr.sh https://raw.githubusercontent.com/lukmanc405/testnet/main/bundlr/lukmanbundlr.sh && chmod +x lukmanbundlr.sh && ./lukmanbundlr.sh
```

### Langkah-langkah setelah Instalasi
Buka situs Arweave dan buat wallet: https://faucet.arweave.net/

Saat Anda membuka situs, layar akan muncul seperti pada gambar, centang kotak dan klik tombol `continue`.

![image](https://user-images.githubusercontent.com/48665887/178900055-40467956-462f-4236-a9bf-8b5ba395125d.png)

Pada new window, tandai kotak centang lagi dan klik tombol `download wallet`.

![image](https://user-images.githubusercontent.com/48665887/178900246-fb4db0a3-5a72-485a-932b-fa53ec4dff04.png)

Klik tombol Buka `Tweet Pop-up` di layar berikutnya, sebuah window akan terbuka untuk tweet, alamat dompet Anda akan tertulis di sana. Salin alamat wallet anda.


![image](https://user-images.githubusercontent.com/48665887/178902152-a3af2c8d-eac6-48bb-905e-6884c9d244c1.png)

Buka https://bundlr.network/faucet dan tempel alamat wallet yang anda salin. Kemudian tweet dari situs ini. Kunjungi situs tersebut dan tempelkan tautan tweet yang anda kirim.

anda berhasil download dompet anda ke komputer dan menerima koin anda dari faucet.

Yang perlu kita lakukan sekarang adalah mengedit nama dompet yang kita download.

- File yang Anda unduh terlihat seperti ini: `arweave-key-QeKJ_TTBe....................ejQ.json`

Perbarui nama file ini jadi ` wallet.json`. **DAN HARUS BACKUP**

Kemudian pindah file wallet ini ke folder `validator-rust` di server .(dalam proses ini bisa pakai SFTP)
contoh :

![image](https://user-images.githubusercontent.com/48665887/178907113-f89d9396-787d-43ee-a0c0-e9539edca4ee.png)


### Buat file service
```
tee $HOME/validator-rust/.env > /dev/null <<EOF
PORT=80
BUNDLER_URL="https://testnet1.bundlr.network"
GW_CONTRACT="RkinCLBlY4L5GZFv8gCFcrygTyd5Xm91CzKlR6qxhKA"
GW_ARWEAVE="https://arweave.testnet1.bundlr.network"
EOF
```
### Mulai Docker:

Instalasi memakan waktu sekitar 10 menit. Oleh karena itu, disarankan untuk membuat `new screen` terlebih dahulu untuk mencegah gangguan koneksi.

Install `screen`

```
apt install screen
```

**Buat New Screen**
```
screen -R "bundlr"
```
**Jalankan docker**

```
cd ~/validator-rust && git pull origin master
docker compose build
docker compose up -d
```


Periksa Log:

```
cd ~/validator-rust && docker compose logs --tail=100 -f
```

![image](https://user-images.githubusercontent.com/48665887/178907619-43bc8495-1450-4943-82b4-063d2507fa84.png)

**Inisialisasi Pemverifikasi:**

```
npm i -g @bundlr-network/testnet-cli -y
```

Tambahkan validator anda ke jaringan. Edit alamat `ipkowe` Anda:
>ipkowe=IP VPS

```
cd /root/validator-rust && testnet-cli join RkinCLBlY4L5GZFv8gCFcrygTyd5Xm91CzKlR6qxhKA -w wallet.json -u "http://ipkowe:80" -s 25000000000000 
```

nanti akan terlihat seperti ini 


![image](https://user-images.githubusercontent.com/48665887/178915313-518e4595-c39a-4e49-930d-88fa59eef964.png)

>Anda dapat memeriksa alamat wallet Anda dari Explorer.
>https://bundlr.network/explorer

### Cek address

```
cd $HOME/validator-rust && cargo run --bin wallet-tool show-address --wallet wallet.json
```

### Cek validator apakah sudah berjalan
>ganti XXX dengan address

```
npx @bundlr-network/testnet-cli@latest check  RkinCLBlY4L5GZFv8gCFcrygTyd5Xm91CzKlR6qxhKA XXX
```


### Cek saldo

```
testnet-cli balance <address>
```

>ubah `<address>` jadi address ente

### Cek versi bundlr

```
npx @bundlr-network/testnet-cli -V
```

### Update Version node bundlr
```
npm install -g npm@latest
npm audit fix
npm update -g @bundlr-network/testnet-cli
npx @bundlr-network/testnet-cli -V
```

### Untuk stop & hapus node

```
cd ~/validator-rust && docker-compose down -v
cd $HOME
rm -rf ~/validator-rust
```
