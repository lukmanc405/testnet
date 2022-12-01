#!/bin/bash
exists()
{
  command -v "$1" >/dev/null 2>&1
}
if exists curl; then
        echo ''
else
  sudo apt install curl -y < "/dev/null"
fi

echo -e 'Menghapus semua snarkos files ...\n\n'
echo '/etc/systemd/system/aleod.service'
echo '/etc/systemd/system/aleod-miner.service'
echo '$HOME/.aleo'
echo '$HOME/.cargo'
echo '$HOME/.rustup'
echo '$HOME/.ledger-2'
echo '.ledger-2'
echo '$HOME/snarkOS'
echo '$HOME/aleo'
echo '$HOME/aleo_snarkos2.sh'
echo '/usr/bin/snarkos (or other dir)'

services=$(ls /etc/systemd/system | grep aleo)

if [ -z "$services" ]; then
        echo "service files telah dihapus"
else
        systemctl stop aleod aleod-miner aleo-prover aleo-client aleo-updater
        systemctl disable aleod aleod-miner aleo-prover aleo-client aleo-updater
        rm -rf /etc/systemd/system/aleod*
fi

cd $HOME/
#rm -rf aleo
rm -rf aleo .aleo .cargo .rustup .ledger-2 snarkOS aleo_snarkos2.sh

if exists snarkos; then
        rm $(which snarkos)
else
        echo "snarkos is telah dihapus"
fi
echo -e 'Aleo Testnet2 snarkos is telah dihapus \n' && sleep 1