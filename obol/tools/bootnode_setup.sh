echo -e "\e[1m\e[32m [1]. open permission... \e[0m" && sleep 1
cd $HOME/charon-distributed-validator-node/ && sudo chmod a+rwx .charon && sudo chmod -R 666 .charon
sudo chmod -R 666 .charon/validator_keys && sudo chmod a+rwx .charon/validator_keys
echo -e "\e[1m\e[32m [2]. setting file docker-compose.yaml & deposit-data.json... \e[0m" && sleep 1
docker-compose down
rm -rf $HOME/charon-distributed-validator-node/docker-compose.yaml
rm -rf $HOME/charon-distributed-validator-node/.charon/deposit-data.json
wget -qO $HOME/charon-distributed-validator-node/docker-compose.yml https://raw.githubusercontent.com/lukmanc405/testnet/main/obol/docker-compose.yml
wget -qO $HOME/charon-distributed-validator-node/.charon/deposit-data.json https://raw.githubusercontent.com/lukmanc405/testnet/main/obol/deposit-data.json
sudo chmod -R 666 .charon
sudo chmod a+rwx .charon
docker-compose up -d
echo -e "\e[1m\e[32m -selesai- \e[0m" && sleep 1
