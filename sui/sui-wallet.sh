apt install cargo -y

sudo curl https://sh.rustup.rs/ -sSf | sh -s -- -y
source $HOME/.cargo/env

cargo install --locked --git https://github.com/MystenLabs/sui.git --branch "devnet" sui

sleep 1
