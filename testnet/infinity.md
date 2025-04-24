# Infinity

Tutorial Lengkap Menginstall GPU-Miner di Ubuntu

* Sistem operasi: Ubuntu (versi 20.04 atau lebih baru direkomendasikan).
* GPU dengan dukungan OpenCL (NVIDIA atau AMD).
* Pastikan driver GPU sudah terinstall (misalnya, NVIDIA driver untuk GPU NVIDIA).

***

Langkah-langkah Instalasi1. Perbarui Sistem dan Install DependensiPerintah ini akan memperbarui daftar paket dan menginstall dependensi yang diperlukan seperti compiler, git, dan library OpenCL

```bash
sudo apt-get update && sudo apt-get install -y \
g++ make git screen ocl-icd-opencl-dev libopencl-clang-dev curl python3 python3-pip clinfo nano
```

Penjelasan:

* apt-get update: Memperbarui daftar paket.
* apt-get install: Menginstall alat seperti g++ (compiler), make (untuk build), git (untuk cloning repo), library OpenCL, curl, python3, pip, clinfo (untuk cek OpenCL), dan nano (editor teks).
* -y: Otomatis menyetujui instalasi.

Verifikasi:

*   Jalankan clinfo untuk memastikan OpenCL terdeteksi

    ```bash
    clinfo
    ```

    Jika output menunjukkan informasi GPU Anda, OpenCL sudah terdeteksi. Jika tidak, Anda mungkin perlu mengkonfigurasi OpenCL (lihat langkah opsional di bawah).

***

2\. Install Paket PythonInstall paket Python yang dibutuhkan untuk proyek ini.bash

```bash
pip3 install pybind11 safe-pysha3 ecdsa web3 coincurve websocket-client websockets python-dotenv
```

Penjelasan:

* pip3 install: Menginstall modul Python seperti pybind11 (untuk binding C++ ke Python), safe-pysha3 (untuk hashing), ecdsa (kriptografi), web3 (interaksi blockchain), dan lainnya.
* Pastikan pip3 terkait dengan Python 3 (jalankan pip3 --version untuk memeriksa).

Verifikasi:

*   Periksa apakah modul terinstall:bash

    ```bash
    pip3 list
    ```

    Cari nama paket seperti pybind11, web3, dll., di daftar.

***

3\. Clone Repository dan Build ProyekClone repository miner-gpu dan build kode sumbernya

```bash
git clone https://github.com/8finity-xyz/miner-gpu.git
cd miner-gpu/
```

***

4\. (Opsional) Konfigurasi OpenCL untuk NVIDIAJika Anda menggunakan GPU NVIDIA dan OpenCL tidak terdeteksi dengan baik, jalankan perintah berikut untuk mengatur ICD (Installable Client Driver)

```bash
sudo mkdir -p /etc/OpenCL/vendors && echo "libnvidia-opencl.so.1" | sudo tee /etc/OpenCL/vendors/nvidia.icd
```

Penjelasan:

* Perintah ini membuat file konfigurasi untuk memberitahu sistem di mana menemukan library OpenCL NVIDIA.
* Jalankan clinfo lagi untuk memastikan OpenCL terdeteksi.

***

5\.  (Opsional)Testing OpenCL, apakah OpenCL bekerja dengan menjalankan skrip tes

```bash
python3 test_opencl_kernel.py
```

Penjelasan:

* Skrip ini memverifikasi bahwa kernel OpenCL berfungsi dengan GPU Anda.
* Jika skrip berjalan tanpa error, OpenCL sudah siap. Jika ada error, periksa driver GPU atau konfigurasi OpenCL.
* **TEKAN CTRL+C** bila dirasa normal, bagian ini hanya testing

***

6\. Konfigurasi File Lingkungan (.env) Edit file .env.example untuk memasukkan alamat miner dan detail RPC&#x20;

```bash
nano .env.example
```

Penjelasan:

* Gunakan editor nano untuk membuka file .env.example.
* Isi detail seperti alamat wallet miner Anda dan URL RPC (sesuai dokumentasi proyek).
*   Contoh isi file .env.example (sesuaikan dengan kebutuhan):plaintext

    ```bash
    MINER_ADDRESS=0xYourWalletAddress
    RPC_URL=https://your-rpc-url
    ```
* Simpan file dengan menekan Ctrl+O, Enter, lalu keluar dengan Ctrl+X.

Kemudian, ganti nama file ke .env

```bash
mv .env.example .env
```

***

7\. Jalankan MinerSetelah semua konfigurasi selesai, jalankan miner dengan perintah berikut

```bash
python3 mine_infinity.py
```

Penjelasan:

* Skrip ini memulai proses mining.
* Jika berhasil, Anda akan melihat output yang menunjukkan aktivitas mining (misalnya, hashrate, block ditemukan, dll.).
* Jika gagal, periksa:
  * Apakah file .env sudah benar.
  * Apakah dependensi dan OpenCL berfungsi.
  * Apakah koneksi internet stabil.

***

Troubleshooting

* Error saat make:
  * Pastikan g++ dan make terinstall (sudo apt-get install build-essential).
  * Periksa apakah library OpenCL terinstall dengan benar.
* OpenCL tidak terdeteksi:
  * Jalankan clinfo untuk debugging.
  * Untuk NVIDIA, pastikan driver terbaru terinstall dan jalankan langkah konfigurasi ICD.
* Error Python:
  * Pastikan semua paket Python terinstall (pip3 list).
  * Gunakan pip3 install --force-reinstall \<nama-paket> jika ada masalah dengan paket tertentu.
* Skrip mine\_infinity.py gagal:
  * Periksa file .env untuk kesalahan penulisan.
  * Pastikan RPC URL valid dan jaringan blockchain dapat diakses.

***

Catatan Tambahan

* Keamanan: Jangan bagikan alamat wallet atau private key Anda.
* Performa: Mining membutuhkan GPU yang kuat dan konsumsi daya tinggi. Pastikan sistem pendingin Anda memadai.
* Dokumentasi Proyek: Baca dokumentasi resmi di repository GitHub ([https://github.com/8finity-xyz/miner-gpu](https://github.com/8finity-xyz/miner-gpu)) untuk informasi lebih lanjut.
* Backup: Simpan salinan file .env di tempat aman.

***

Selamat!Jika semua langkah berhasil, sekarang menjalankan miner-gpu.&#x20;
