# stop main docker
cd ~/charon-distributed-validator-node
docker-compose down
sleep 1

# cd go to your charon-distributed-validator-node in my case
cd ~/charon-distributed-validator-node
mv docker-compose.yml docker-compose.yml_bkp
git pull
sleep 1

# a new docker compose is downloaded if necessary use git stash bring the docker up
docker-compose up -d
sleep 3

# let it sync for a while,
cd ~/charon-distributed-validator-node
rm compose-voluntary-exit.yml
wget -O compose-voluntary-exit.yml https://raw.githubusercontent.com/lukmanc405/testnet/main/obol/compose-voluntary-exit.yml
cd .charon/ && mkdir exit_keys
cp validator_keys/keystore-0.* exit_keys/
sleep 2

# go back to charon main dir and run docker compose -f compose-voluntary-exit.yml up
cd ..
docker-compose -f compose-voluntary-exit.yml up
sleep 1
