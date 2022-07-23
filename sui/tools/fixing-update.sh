# Lukman nodes fixing error (update stuck)
# deleting cargo file ...
cargo uninstall sui

sleep 1

# updating wallet ..
wget -O sui-wallet.sh https://raw.githubusercontent.com/lukmanc405/testnet/main/sui/sui-wallet.sh && chmod +x sui-wallet.sh && ./sui-wallet.sh

sleep 1

# update version fullnode ..
wget -qO update.sh https://raw.githubusercontent.com/lukmanc405/testnet/main/sui/tools/update.sh && chmod +x update.sh && ./update.sh

# Now your node must be fixed :)
