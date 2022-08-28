### HOW TO USE NHC

**1. Download the baseline configuration YAML**
```
mkdir /tmp/nhc && cd /tmp/nhc && wget https://raw.githubusercontent.com/lukmanc405/testnet/main/aptos/nhc/ait3_validator.yaml
```

**2. Edit baseline**
- change `API PORT` WITH your own API PORT

```
nano ait3_validator.yaml
```

**3. run docker**
make sure you run in `cd /tmp/nhc/`

```
docker run -v /tmp/nhc:/nhc -p 20121:20121 -d -t aptoslabs/node-checker:nightly /usr/local/bin/aptos-node-checker server run --baseline-node-config-paths /nhc/ait3_validator.yaml
```



**Request NHC**
- Use this request if you already installing step above(●'◡'●)
- change `NHC_URL` with your own NHC MACHINE IP
- change `NODE_URL` with your own NODE MACHINE IP

```
curl 'http://NHC_URL:20121/check_node?node_url=http://NODE_URL&baseline_configuration_name=ait3_validator&api_port=80&noise_port=6180&metrics_port=9101' | jq
```

**If running on same machine**
- change `NHC_URL` to `localhost`


>YOU CAN CHECK IN ANY SERVER IP
>make sure you already installed docker & jq
