
### Testnet yang ditunggu-tunggu dari tim Bundlr telah dimulai.
![image](https://user-images.githubusercontent.com/48665887/178899422-b914ca03-12c1-4157-868e-2b92b010ade2.png)

> explorer :
> https://bundlr.network/explorer

### Persyaratan Perangkat Keras

- Memory: 8 GB RAM
- CPU: Quad-Core
- Disk: 250 GB SSD Storage
- Bandwidth: 1 Gbps for Download/100 Mbps for Upload

### Langkah-langkah instalasi:
Anda dapat setting Bundlr Node Anda dalam hitungan menit menggunakan skrip otomatis di bawah ini.

`wget -O lukmanbundlr.sh https://raw.githubusercontent.com/lukmanc405/testnet/main/bundlr/lukmanbundlr.sh && chmod +x lukmanbundlr.sh && ./lukmanbundlr.sh`

### Langkah-langkah setelah Instalasi
Buka situs Arweave dan buat wallet: https://faucet.arweave.net/

Saat Anda membuka situs, layar akan muncul seperti pada gambar, centang kotak dan klik tombol `continue`.
![image](https://user-images.githubusercontent.com/48665887/178900055-40467956-462f-4236-a9bf-8b5ba395125d.png)
Pada layar kedua, tandai kotak centang lagi dan klik tombol `download wallet`.
![image](https://user-images.githubusercontent.com/48665887/178900246-fb4db0a3-5a72-485a-932b-fa53ec4dff04.png)

Klik tombol Buka `Tweet Pop-up` di layar berikutnya, sebuah window akan terbuka untuk tweet, alamat dompet Anda akan tertulis di sana. Salin alamat wallet anda.


![image](https://user-images.githubusercontent.com/48665887/178902152-a3af2c8d-eac6-48bb-905e-6884c9d244c1.png)

Buka https://bundlr.network/faucet dan tempel alamat wallet yang anda salin. Kemudian tweet dari situs ini. Kunjungi situs tersebut dan tempelkan tautan tweet yang anda kirim.

anda berhasil download dompet anda ke komputer dan menerima koin anda dari faucet.

Yang perlu kita lakukan sekarang adalah mengedit nama dompet yang kita download.

- File yang Anda unduh terlihat seperti ini: `arweave-key-QeKJ_TTBe....................ejQ.json`

Perbarui nama file ini ke` wallet.json`. **DAN HARUS BACKUP**

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
Instalasi memakan waktu sekitar 10 menit. Oleh karena itu, disarankan untuk membuat layar terlebih dahulu untuk mencegah gangguan koneksi.
**Buat New Screen**


`screen -R "bundlr"`
**Jalankan docker**

`cd ~/validator-rust && docker compose up -d`


Periksa Log:

`cd ~/validator-rust && docker compose logs --tail=100 -f`


