echo -e "\e[1m\e[32m1. open permission... \e[0m" && sleep 1
cd $HOME/charon-distributed-validator-node/ && sudo chmod a+rwx .charon && sudo chmod -R 666 .charon
sudo chmod -R 666 .charon/validator_keys && sudo chmod a+rwx .charon/validator_keys
echo -e "\e[1m\e[32m2. mengahapus file keystore-0.json.lock... \e[0m" && sleep 1
sudo chmod a+rwx .charon && sudo chmod -R 666 .charon
rm -rf .charon/validator_keys/keystore-0.json.lock
echo -e "\e[1m\e[32m3. update versi charon terbaru... \e[0m" && sleep 1
sudo chmod a+rwx .charon && sudo chmod -R 666 .charon && docker run --rm -v "$(pwd):/opt/charon" ghcr.io/obolnetwork/charon:v0.9.0 enr
echo -e "\e[1m\e[32m4. setting file docker-compose.yaml & deposit-data.json... \e[0m" && sleep 1
docker-compose down
sudo chmod a+rwx .charon && sudo chmod -R 666 .charon
git pull
rm -rf $HOME/charon-distributed-validator-node/.charon/deposit-data.json && rm -rf $HOME/charon-distributed-validator-node/docker-compose.yaml
wget -qO $HOME/charon-distributed-validator-node/docker-compose.yml https://raw.githubusercontent.com/lukmanc405/testnet/main/obol/docker-compose.yml
wget -qO $HOME/charon-distributed-validator-node/.charon/deposit-data.json https://raw.githubusercontent.com/lukmanc405/testnet/main/obol/deposit-data.json
git checkout docker-compose.yml
docker-compose up -d
echo -e "\e[1m\e[32m5. selesai... \e[0m" && sleep 1
