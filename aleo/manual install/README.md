1. Menginstall dependencies

```
sudo apt update && sudo apt upgrade -y
sudo apt install curl tar wget clang pkg-config libssl-dev jq build-essential bsdmainutils git make ncdu gcc git jq chrony liblz4-tool -y
```

2. Cloning snarkOS

```
rm -rf $HOME/snarkOS $(which snarkos) $(which snarkos) $HOME/.aleo $HOME/aleo
cd $HOME
git clone https://github.com/AleoHQ/snarkOS.git --depth 1
```

3. Masuk folder snarkOS

```
cd snarkOS
```

4. Menginstall snarkos

```
./build_ubuntu.sh
source $HOME/.bashrc
source $HOME/.cargo/env
```

5. Membuat account address Aleo (PASTIKAN MENYIMPAN PRIVATE KEY DAN VIEW KEY AKUN)

```
mkdir $HOME/aleo
date >> $HOME/aleo/account_new.txt
snarkos account new >>$HOME/aleo/account_new.txt
cat $HOME/aleo/account_new.txt
mkdir -p /var/aleo/
cat $HOME/aleo/account_new.txt >>/var/aleo/account_backup.txt
echo 'export PROVER_PRIVATE_KEY'=$(grep "Private Key" $HOME/aleo/account_new.txt | awk '{print $3}') >> $HOME/.bash_profile
source $HOME/.bash_profile
```

6.a Membuat layanan Aleo Client Node

```
echo "[Unit]
Description=Aleo Client Node
After=network-online.target
[Service]
User=$USER
ExecStart=$(which snarkos) start --nodisplay --client ${PROVER_PRIVATE_KEY}
Restart=always
RestartSec=10
LimitNOFILE=10000
[Install]
WantedBy=multi-user.target
" > $HOME/aleo-client.service
 mv $HOME/aleo-client.service /etc/systemd/system
 tee <<EOF >/dev/null /etc/systemd/journald.conf
Storage=persistent
EOF
systemctl restart systemd-journald
```

6.b Membuat service untuk Aleo Prover Node

```
echo "[Unit]
Description=Aleo Prover Node
After=network-online.target
[Service]
User=$USER
ExecStart=$(which snarkos) start --nodisplay --prover ${PROVER_PRIVATE_KEY}
Restart=always
RestartSec=10
LimitNOFILE=10000
[Install]
WantedBy=multi-user.target
" > $HOME/aleo-prover.service
 mv $HOME/aleo-prover.service /etc/systemd/system
```

7. Menginstall Aleo Updater

```
cd $HOME
wget -q -O $HOME/aleo_updater.sh https://raw.githubusercontent.com/lukmanc405/testnet/main/aleo/aleo_updater.sh && chmod +x $HOME/aleo_updater.sh
echo "[Unit]
Description=Aleo Updater
After=network-online.target
[Service]
User=$USER
WorkingDirectory=$HOME/snarkOS
ExecStart=/bin/bash $HOME/aleo_updater.sh
Restart=always
RestartSec=10
LimitNOFILE=10000
[Install]
WantedBy=multi-user.target
" > $HOME/aleo-updater.service
mv $HOME/aleo-updater.service /etc/systemd/system
systemctl daemon-reload
```

8. Mengaktifkan Layanan aleo-updater

```
systemctl enable aleo-updater
systemctl restart aleo-updater
```

9. Menjalankan Aleo Prover Node

```
systemctl enable aleo-prover
systemctl restart aleo-prover
```
