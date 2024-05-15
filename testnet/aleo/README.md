# Aleo

#### Testnet3 Aleo telah dimulai.

***

* Date: Phase 2 & phase 3: started 02/12/2023 - end(TBA)
* Official Instructions: https://github.com/AleoHQ/snarkOS/#2-build-guide
* More info about testnet: https://www.aleo.org/post/testnet-3-incentives-kickoff
* Aleo Testnet Leaderboard : https://www.aleo.network/leaderboard
* Aleo Explorer : https://www.aleo.network/transactions

**snarkOS adalah sistem operasi terdesentralisasi untuk aplikasi tanpa pengetahuan. Kode ini membentuk tulang punggung jaringan Aleo, yang memverifikasi transaksi dan menyimpan aplikasi status terenkripsi dengan cara yang dapat diverifikasi secara publik.**

***

**Recommended hardware requirements**

***

| Hardware |       Specs       |
| :------: | :---------------: |
|    CPU   |       32 CPU      |
|    RAM   |      32GB RAM     |
|   DISK   | 128GB SSD STORAGE |
|    OS    |  Ubuntu 20.04 LTS |
|  NETWORK |       20mbps      |

### Instalation

#### Penginstalan Automatis

> penginstalan membutuhkan waktu 10-20 menit

```
wget -qO aleo_3.sh https://raw.githubusercontent.com/lukmanc405/testnet/main/aleo/aleo_3.sh && chmod +x aleo_3.sh && ./aleo_3.sh
```

#### Penginstalan Manual

[DISINI](manual-install.md)

### Command tambahan (**bila perlu**)

cek akun aleo

```
cat $HOME/aleo/account_new.txt
```

Cek logs

```
journalctl -u aleo-prover -f -o cat
```

Stop node client and hanya running prover

```
systemctl stop aleo-client
systemctl restart aleo-prover
```

Periksa Aleo Private Key apa yang digunakan oleh prover.

```
grep "prover" /etc/systemd/system/aleo-prover.service | awk '{print $5}'
```

Hapus snarkos and semua source file, termasuk aleo miner address.(ini digunakan untuk shutdown node dan menghapus semua file berkaitan dengan Aleo)

```
wget -qO hapus_snarkOS.sh https://raw.githubusercontent.com/lukmanc405/testnet/main/aleo/hapus_snarkOS.sh && chmod +x hapus_snarkOS.sh && ./hapus_snarkOS.sh
```
