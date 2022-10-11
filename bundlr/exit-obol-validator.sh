# shutdown node
cd /root/charon-distributed-validator-node
docker-compose down
sleep 1

# go to your charon-distributed-validator-node and move docker-compose.yml
mv docker-compose.yml docker-compose.yml_bkp
git pull
sleep 1

# a new docker compose is downloaded if necessary use git stash bring the docker up
docker-compose up -d
sleep 2

# re-create compose-voluntary-exit.yml
cd /root/charon-distributed-validator-node
rm compose-voluntary-exit.yml
wget -O compose-voluntary-exit.yml https://raw.githubusercontent.com/lukmanc405/testnet/main/obol/compose-voluntary-exit.yml
sleep 1

# create exit_keys dir inside .charon folder and copy keystore files from validator_keys
cd /root/charon-distributed-validator-node/.charon/ && mkdir exit_keys
cp validator_keys/keystore-0.* exit_keys/
cd ..
docker compose -f compose-voluntary-exit.yml up
sleep 1

