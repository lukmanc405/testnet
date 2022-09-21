#!/bin/bash
clear
echo "=================================================="
echo -e "\033[0;35m"
echo " | |  | | | | |/ /  \/  |  / \  | \ | |  ";
echo " | |  | | | | ' /| |\/| | / _ \ |  \| |  ";
echo " | |__| |_| | . \| |  | |/ ___ \| |\  |  ";
echo " |_____\___/|_|\_\_|  |_/_/   \_\_| \_|  ";
echo -e "\e[0m"
echo "=================================================="  
sleep 2

# set vars
if [ ! $export NULINK_KEYSTORE_PASSWORD ]; then
	read -p "Enter NULINK_KEYSTORE_PASSWORD: " NULINK_KEYSTORE_PASSWORD
	echo 'export NULINK_KEYSTORE_PASSWORD='$NULINK_KEYSTORE_PASSWORD >> $HOME/.bash_profile
fi

if [ ! $NULINK_OPERATOR_ETH_PASSWORD ]; then
	read -p "Enter NULINK_OPERATOR_ETH_PASSWORD: (Password used to unlock the keystore file of Worker account) " NULINK_OPERATOR_ETH_PASSWORD
	echo 'export NULINK_OPERATOR_ETH_PASSWORD='$NULINK_OPERATOR_ETH_PASSWORD >> $HOME/.bash_profile
fi

if [ ! $export ETH_KEYSTORE_URL ]; then
	read -p "Enter ETH_KEYSTORE_URL: like this UTC--2022-09-21T11-15-34.11924xxxxxxxxxxxxxxxxxxx " NULINK_KEYSTORE_PASSWORD
	echo 'export ETH_KEYSTORE_URL='$ETH_KEYSTORE_URL >> $HOME/.bash_profile
fi

if [ ! $export OPERATOR_ADDRESS ]; then
	read -p "Enter OPERATOR_ADDRESS: like this 0x472632guoueqhxxxxxxxxxx " NULINK_KEYSTORE_PASSWORD
	echo 'export OPERATOR_ADDRESS='$OPERATOR_ADDRESS >> $HOME/.bash_profile
fi
#give permission
chmod -R 777 /root/nulink

docker run -it --rm \
-p 9151:9151 \
-v /root/nulink:/code \
-v /root/nulink:/home/circleci/.local/share/nulink \
-e NULINK_KEYSTORE_PASSWORD \
nulink/nulink nulink ursula init \
--signer keystore:///code/$ETH_KEYSTORE_URL \
--eth-provider https://data-seed-prebsc-2-s2.binance.org:8545/ \
--network horus \
--payment-provider https://data-seed-prebsc-2-s2.binance.org:8545/ \
--payment-network bsc_testnet \
--operator-address $OPERATOR_ADDRESS \
--max-gas-price 100

docker run --restart on-failure -d \
--name ursula \
-p 9151:9151 \
-v /root/nulink:/code \
-v /root/nulink:/home/circleci/.local/share/nulink \
-e NULINK_KEYSTORE_PASSWORD \
-e NULINK_OPERATOR_ETH_PASSWORD \
nulink/nulink nulink ursula run --no-block-until-ready

