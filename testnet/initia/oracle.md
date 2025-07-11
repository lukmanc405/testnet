# Oracle

## SETUP ORACLE

#### Clone repository

```bash
cd $HOME
rm -rf slinky
git clone https://github.com/skip-mev/slinky.git
cd slinky
git checkout v0.4.3
```

#### Build binaries

```bash
make build
```

#### Move binary to local bin

```bash
mv build/slinky /usr/local/bin/
rm -rf build
```

#### Enable oracle extension

```
nano $HOME/.initia/config/app.toml
```

#### Edit your oracle code ,scroll down must be same with this

```bash
###############################################################################
###                                  Oracle                                 ###
###############################################################################
[oracle]
# Enabled indicates whether the oracle is enabled.
enabled = "true"

# Oracle Address is the URL of the out of process oracle sidecar. This is used to
# connect to the oracle sidecar when the application boots up. Note that the address
# can be modified at any point, but will only take effect after the application is
# restarted. This can be the address of an oracle container running on the same
# machine or a remote machine.
oracle_address = "127.0.0.1:8080"

# Client Timeout is the time that the client is willing to wait for responses from 
# the oracle before timing out.
client_timeout = "500ms"

# MetricsEnabled determines whether oracle metrics are enabled. Specifically
# this enables instrumentation of the oracle client and the interaction between
# the oracle and the app.
metrics_enabled = "false"

```

#### Restart node

```bash
sudo systemctl restart initiad && sudo journalctl -u initiad -f -o cat
```

#### Create Oracle System Service

```bash
sudo tee /etc/systemd/system/slinky.service > /dev/null <<EOF
[Unit]
Description=Initia Slinky Oracle
After=network-online.target

[Service]
User=$USER
ExecStart=$(which slinky) --oracle-config-path $HOME/slinky/config/core/oracle.json --market-map-endpoint 127.0.0.1:9090
Restart=on-failure
RestartSec=30
LimitNOFILE=65535

[Install]
WantedBy=multi-user.target
EOF
```

#### Enable start system oracle

```bash
sudo systemctl daemon-reload \
sudo systemctl enable slinky.service \
sudo systemctl start slinky.service
```

Run oracle

```bash
make run-oracle-client
```

#### Example successfull log

```
root@initia-catnodes:~/slinky# make run-oracle-client
2024/05/15 10:03:34 Calling Prices RPC...
2024/05/15 10:03:34 Currency Pair, Price: (AAVE/USD, 8171039830)
2024/05/15 10:03:34 Currency Pair, Price: (ADA/USD, 4338320209)
2024/05/15 10:03:34 Currency Pair, Price: (AEVO/USD, 838151509)
2024/05/15 10:03:34 Currency Pair, Price: (AGIX/USD, 8479003642)
2024/05/15 10:03:34 Currency Pair, Price: (ALGO/USD, 1736795911)
```

#### check slinky (oracle logs)

```bash
journalctl -fu slinky --no-hostname
```

```
May 15 10:04:00 slinky[33362]: {"level":"info","ts":"2024-05-15T10:04:00.238Z","caller":"oracle/oracle.go:163","msg":"oracle updated prices","pid":33362,"process":"oracle","last_sync":"2024-05-15T10:04:00.238Z","num_prices":65}
May 15 10:04:00 slinky[33362]: {"level":"info","ts":"2024-05-15T10:04:00.488Z","caller":"oracle/oracle.go:163","msg":"oracle updated prices","pid":33362,"process":"oracle","last_sync":"2024-05-15T10:04:00.488Z","num_prices":65}
May 15 10:04:00 slinky[33362]: {"level":"info","ts":"2024-05-15T10:04:00.737Z","caller":"oracle/oracle.go:163","msg":"oracle updated prices","pid":33362,"process":"oracle","last_sync":"2024-05-15T10:04:00.737Z","num_prices":65}
May 15 10:04:00 slinky[33362]: {"level":"info","ts":"2024-05-15T10:04:00.742Z","caller":"marketmap/fetcher.go:116","msg":"successfully fetched market map data from module; checking if market map has changed","pid":33362,"process":"provider_orchestrator"}
```

