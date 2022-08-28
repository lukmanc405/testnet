### HOW TO USE NHC

** 1. Download the baseline configuration YAML **
```
mkdir /tmp/nhc && cd /tmp/nhc && wget https://raw.githubusercontent.com/lukmanc405/testnet/main/aptos/nhc/ait3_validator.yaml
```

** 2. Edit baseline**
>change `_NODE_URL_` WITH your own node IP

```
nano ait3_validator.yaml
```

** 3. run docker **
make sure you run in `_cd /tmp/nhc/_`

```
docker run -v /tmp/nhc:/nhc -p 20121:20121 -d -t aptoslabs/node-checker:nightly /usr/local/bin/aptos-node-checker server run --baseline-node-config-paths /nhc/ait3_validator.yaml
```

** 4. Request NHC**
>change NODE_URL with your own node IP

```
curl 'http://NODE_URL:20121/check_node?node_url=http://lukman-nodes.duckdns.org&baseline_configuration_name=ait3_validator&api_port=80&noise_port=6180&metrics_port=9101' | jq
```

>YOU CAN CHECK IN ANY SERVER IP
>make sure you already installed docker & jq
