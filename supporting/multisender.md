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

# Multisender

## Copy repo

```
git clone https://github.com/lukmanc405/multisend.git
```

## Enter folder multisend

```
cd multisend
```

## Install node js

```
curl -fsSL https://deb.nodesource.com/setup_21.x | sudo -E bash - &&\
sudo apt-get install -y nodejs
```

```
npm i
```

## Add sc

```
nano transfer.js
```

## Edit Privkey

```
nano config.js
```

## Run

```
chmod +x run_transfer.sh
```

## Enter screen

```
screen -S multisend
```

## Start multisend

```
./run_transfer.sh
```

## Running backround (close screen)

CTRL + A ,Then Press D

proses akan selesai kurleb 3 jam , setelah 3 jam jgn lupa cek saldo avail lalu jalankan lagi
