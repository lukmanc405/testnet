cd $HOME/charon-distributed-validator-node/ && docker-compose down
rm -rf docker-compose.yml
wget -qO $HOME/charon-distributed-validator-node/docker-compose.yml https://raw.githubusercontent.com/ObolNetwork/charon-distributed-validator-node/main/docker-compose.yml
git pull && docker-compose up -d
