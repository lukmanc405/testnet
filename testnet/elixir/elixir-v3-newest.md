# Elixir v3 (NEWEST)

**Recommended hardware requirements**

| Hardware |       Specs      |
| :------: | :--------------: |
|    CPU   |       2 CPU      |
|    RAM   |      8GB RAM     |
|   DISK   |  100 GB STORAGE  |
|    OS    | Ubuntu 22.04 LTS |

Official [documentation](https://docs.elixir.xyz/running-an-elixir-validator) says that **8RAM, 100GB** disk will be enough.

## **Prerequisite** <a href="#id-4a62" id="id-4a62"></a>

1\) Update the local package repository database & upgrade installed packages to their latest versions based on the updated package database:

```bash
sudo apt-get update && apt-get upgrade -y
```

2\) Install packages:

```bash
sudo apt install wget -y
```

3\) Install Docker:

```bash
sudo apt install docker.io -y && \
docker --version
```

## **Installation** <a href="#af42" id="af42"></a>

1\) Create `elixir` folder:

```bash
mkdir elixir
```

2\) Move to `elixir` folder:

```bash
cd elixir
```

3\) Download the validator environment template file:

```bash
wget https://files.elixir.finance/validator.env
```

4\) Open `validator.env` with nano:

```bash
nano validator.env
```

5\) Fill the info about the wallet that you’ll be using for this validator.\
**For security reasons, this wallet should never be used for anything other than running a testnet validator.**

> STRATEGY\_EXECUTOR\_IP\_ADDRESS=your IP address\
> STRATEGY\_EXECUTOR\_DISPLAY\_NAME=your moniker\
> STRATEGY\_EXECUTOR\_BENEFICIARY=**your address for validator rewards**\
> SIGNER\_PRIVATE\_KEY=**your private key (use private key from newly created wallet, not the EXECUTOR\_BENEFICIARY)**

<figure><img src="https://miro.medium.com/v2/resize:fit:363/1*GMY8DkzllaUsEya9Ppgs-A.png" alt="" height="145" width="363"><figcaption></figcaption></figure>

6\) Save and exit:

> [Ctrl+X \
> Y \
> Enter](#user-content-fn-1)[^1]

## **Enroll validator** <a href="#id-424a" id="id-424a"></a>

1\) Go to [faucet](https://testnet-3.elixir.xyz/) and mint MOCK tokens on the Ethereum Sepolia test network.\
&#xNAN;_&#x4E;ote, that You can mint tokens to any wallet, such as EXECUTOR\_BENEFICIARY from above. It will require some_ [_Sepolia ETH_](https://www.alchemy.com/faucets/ethereum-sepolia) _for gas fee._

2\) Approve received MOCK tokens and stake them.

<figure><img src="https://miro.medium.com/v2/resize:fit:633/1*Wnwlr7Koqt97Rq3LF9YnFQ.png" alt="" height="356" width="633"><figcaption></figcaption></figure>

3\) Click the “CUSTOM VALIDATOR” button above the active validator list.\
In the Custom validator modal that appears, enter your validator’s public wallet address of SIGNER\_PRIVATE\_KEY from above and click “DELEGATE”.\
Confirm the transaction and wait for it to complete on-chain.

<figure><img src="https://miro.medium.com/v2/resize:fit:700/1*brTIxGyTTqHNkN9tXaanQg.png" alt="" height="214" width="700"><figcaption></figcaption></figure>

## Running Your Validator <a href="#id-7b0d" id="id-7b0d"></a>

1\) Pull the Docker image:

```bash
docker pull elixirprotocol/validator:v3 --platform linux/amd64
```

2\) Run the validator:

```bash
docker run --env-file /root/elixir/validator.env --platform linux/amd64 -p 17690:17690 --restart unless-stopped elixirprotocol/validator:v3
```

3\) Check if Docker image was created:

```bash
docker ps
```

You should see such info:

<figure><img src="https://miro.medium.com/v2/resize:fit:700/1*h835MvQwMK3tr9D609kwtA.png" alt="" height="35" width="700"><figcaption></figcaption></figure>

## **Logs** <a href="#id-5b75" id="id-5b75"></a>

To check logs run:

```bash
docker logs <CONTAINER_ID>
```

Where `<CONTAINER_ID>` is an ID from previous step.

Should look like this:

<figure><img src="https://miro.medium.com/v2/resize:fit:700/1*Hj6kmCFy4KX9RJpE9MDs-Q.png" alt="" height="140" width="700"><figcaption></figcaption></figure>

## Useful commands <a href="#e0d9" id="e0d9"></a>

Running A Validator On Apple/ARM Silicon

```bash
docker run -d --env-file /root/elixir/validator.env --name elixir --platform linux/amd64 elixirprotocol/validator:v3
```

Exposing Health Checks and Metrics

```bash
docker run -d --env-file /root/elixir/validator.env --name elixir -p 17690:17690 elixirprotocol/validator:v3
```

## Upgrading your validator <a href="#id-313e" id="id-313e"></a>

```bash
docker ps | grep elixirprotocol | awk '{print $1}' | xargs docker stop && \
docker pull elixirprotocol/validator:v3 --platform linux/amd64 && \
docker run --env-file /root/elixir/validator.env --platform linux/amd64 -p 17690:17690 --restart unless-stopped elixirprotocol/validator:v3
```

## **Delete Node (If campaigns already over)** <a href="#c584" id="c584"></a>

```bash
docker ps | grep elixirprotocol | awk '{print $1}' | xargs docker stop && \
cd && \
rm –rf elixir && \
docker system prune -a && \
docker volume prune -f && \
docker network prune -f
```

\


[^1]: 
