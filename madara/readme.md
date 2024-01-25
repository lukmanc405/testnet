ini buat garap clashnode avail x madara
install madara 

```
wget -qO madara.sh https://raw.githubusercontent.com/lukmanc405/testnet/main/madara/madara.sh && chmod +x madara.sh && ./madara.sh
```

inisialisasi new app chain ,jangan lupa isi saldo availnya


> Enter you app chain name: ISI_NAMA_CHAIN_SESUKA_LU 

> Select mode for your app chain: Sovereign

> Select DA layer for your app chain: Avail

contoh :

- Enter you app chain name: luke
- Select mode for your app chain: Sovereign
- Select DA layer for your app chain: Avail


```
./target/release/madara init
```

Run your app chain:

```
./target/release/madara run
```