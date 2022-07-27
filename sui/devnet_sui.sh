rm -rf $HOME/sui
source $HOME/.cargo/env
cd $HOME
git clone https://github.com/MystenLabs/sui.git
cd $HOME/sui
git remote add upstream https://github.com/MystenLabs/sui
git fetch upstream
git checkout -B devnet --track upstream/devnet
curl https://sh.rustup.rs -sSf | sh
curl -fLJO https://github.com/MystenLabs/sui-genesis/blob/main/devnet/genesis.blob
cargo run --release --bin sui-node -- --config-path fullnode.yaml
rm -rf $HOME/sui source $HOME/.cargo/env 
cd $HOME git clone https://github.com/MystenLabs/sui.git cd $HOME/sui git remote add upstream https://github.com/MystenLabs/sui git fetch upstream git checkout -B devnet --track upstream/devnet curl -fLJO https://github.com/MystenLabs/sui-genesis/blob/main/devnet/genesis.blob cargo run --release --bin sui-node -- --config-path fullnode.yaml
