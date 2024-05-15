[👉Join Channel Telegram ![7e4c70c3-4a81-4d90-828e-c5e57908cab4](https://user-images.githubusercontent.com/48665887/179027908-18257283-eca3-42f8-980c-491f4307ee0c.png)](https://t.me/detective_gems)

[👉Deploy server vps anda dengan menggunakan link refferal kami dan dapatkan bonus 20€ ![73811c4d-8dc6-408c-8ada-65d8ca90c753 (1)](https://user-images.githubusercontent.com/48665887/179025989-29a5e7f2-9e4e-4906-99b6-fdc3675f1747.png)](https://hetzner.cloud/?ref=Z8fHigYuskgS)

## Tutorial Fullnode SUI on VPS by lukman (source code manual) (●'◡'●)

1. pkg update

```
sudo apt update && sudo apt upgrade -y
```

2. Install Depencies

```
sudo apt install wget jq git libclang-dev cmake -y
```

3. Install rust

```
echo source $HOME/.cargo/env || curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
```

then update rust

```
rustup update
```

4. Install screen

```
apt-get install screen -y
```

then create new screen

```
screen -R "sui-core"
```

_wait till open new window_

5. Open Ports

```
cd || return
```

then

```
apt install ufw -y
ufw allow ssh
ufw allow https
ufw allow http
ufw allow 9000
ufw allow 9184
ufw enable
```

_Press y then Enter_

6. Install SUI Binaries

```
cargo install --locked --git https://github.com/MystenLabs/sui.git --branch testnet sui sui-node
```

_This instalation may take long time, estimated 1-2 hours_

7. Install Integrated Development Environment

```
cargo install --git https://github.com/move-language/move move-analyzer --features "address20"
```

8. Create wallet

```
sui client active-address
```

press `y`

then ENTER ,

after then choose 0 ,enter

To view your address use ` sui client active-address`

9. Setup validator

- Dowload source code

  ```
  git clone https://github.com/MystenLabs/sui.git --branch testnet
  ```

- open directory sui

```
cd sui
```

10. Set up the Sui repository as a git remote:

```
git remote add upstream https://github.com/MystenLabs/sui
```

11. sync fork

```
git fetch upstream
```

12. copy fullnode template + genesis

```
cp crates/sui-config/data/fullnode-template.yaml fullnode.yaml && curl -fLJO https://github.com/MystenLabs/sui-genesis/raw/main/testnet/genesis.blob
```

13. open screen again with
    `   screen -S sui`
    then put this code

```
cargo run --release --bin sui-node -- --config-path fullnode.yaml
```

Close screen by CTRL A+D

Check your NODE here :
https://node.sui.zvalid.com/

paste your IP
