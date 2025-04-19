# Madara

ini buat garap clashnode avail x madara

1. install madara

```
wget -qO madara.sh https://raw.githubusercontent.com/lukmanc405/testnet/main/madara/madara.sh && chmod +x madara.sh && ./madara.sh
```

install cargo

```
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
source "$HOME/.cargo/env"

```

2. inisialisasi new app chain ,jangan lupa isi saldo availnya

```
cd madara-cli
cargo build --release
```

```
./target/release/madara init
```

> Enter you app chain name: ISI\_NAMA\_CHAIN\_SESUKA\_LU

> Select mode for your app chain: Sovereign

> Select DA layer for your app chain: Avail

contoh :

* Enter you app chain name: luke
* Select mode for your app chain: Sovereign
* Select DA layer for your app chain: Avail

3. Run your app chain in screen:

create screen with

```
screen -R "madara"
```

then input this one

```
./target/release/madara run
```

jarak 2 menit klik `ctrl a+d`

4. ambil uuid disini

* copy lalu pakai buat submit pr https://www.uuidgenerator.net/

submit pr disini https://github.com/karnotxyz/avail-campaign-listing
