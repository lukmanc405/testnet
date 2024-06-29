---
layout:
  title:
    visible: true
  description:
    visible: false
  tableOfContents:
    visible: true
  outline:
    visible: true
  pagination:
    visible: true
---

# Schedule Rollback

Untuk menjalankan kode tersebut setiap 2 jam sekali menggunakan crontab, Anda perlu membuat skrip shell yang berisi perintah-perintah tersebut dan kemudian menambahkan entri crontab untuk menjalankan skrip tersebut. Berikut adalah langkah-langkahnya:

1. **Buat Skrip Shell**: Buat file skrip, misalnya `update_stationd.sh dengan perintah`&#x20;

<pre class="language-bash"><code class="lang-bash"><strong>nano update_stationd.sh
</strong></code></pre>

2. Masukkan perintah-perintah Anda ke dalam file tersebut:

```sh
#!/bin/bash
cd $HOME && \
systemctl stop stationd && \
cd tracks && \
git pull && \
go run cmd/main.go rollback && \
sudo systemctl restart stationd && \
sudo journalctl -u stationd -f --no-hostname -o cat
```

lalu simpan dengan tekan `Ctrl + X`, lalu `Y`, dan `Enter`.

Simpan file tersebut di lokasi yang diinginkan, misalnya di `$HOME/scripts`. bisa pakai command ini &#x20;

```
mv update_stationd.sh $HOME/scripts/update_stationd.sh
```

1.  **Buat Skrip Dapat Dieksekusi**: Ubah izin file skrip agar dapat dieksekusi:

    ```sh
    chmod +x $HOME/scripts/update_stationd.sh
    ```
2.  **Tambahkan Entri ke Crontab**: Buka crontab dengan perintah berikut:

    ```sh
    crontab -e
    ```

    Tambahkan entri berikut untuk menjalankan skrip setiap 2 jam sekali:

    ```
    0 */2 * * * /bin/bash $HOME/scripts/update_stationd.sh
    ```

    Entri ini berarti skrip akan dijalankan setiap 2 jam pada menit ke-0.
3. **Simpan dan Keluar**: Simpan file crontab dan keluar dari editor. Jika menggunakan `nano`, tekan `Ctrl + X`, lalu `Y`, dan `Enter`.

Dengan langkah-langkah ini, crontab akan menjalankan skrip Anda setiap 2 jam sekali secara otomatis.
