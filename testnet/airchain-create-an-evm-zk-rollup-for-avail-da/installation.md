---
layout:
  title:
    visible: true
  description:
    visible: false
  tableOfContents:
    visible: true
  outline:
    visible: true
  pagination:
    visible: true
---

# Installation

```bash
# install dependencies, if needed
sudo apt update && \
sudo apt install curl git jq build-essential gcc unzip wget lz4 -y
```

```bash
#install go
cd $HOME && \
ver="1.22.0" && \
wget "https://golang.org/dl/go$ver.linux-amd64.tar.gz" && \
sudo rm -rf /usr/local/go && \
sudo tar -C /usr/local -xzf "go$ver.linux-amd64.tar.gz" && \
rm "go$ver.linux-amd64.tar.gz" && \
echo "export PATH=$PATH:/usr/local/go/bin:$HOME/go/bin" >> ~/.bash_profile && \
source ~/.bash_profile && \
go version
```

```bash
#  Downloading the necessary repositories
git clone https://github.com/airchains-network/evm-station.git
git clone https://github.com/airchains-network/tracks.git
```

```bash
# We are starting the setup of our Evmos network, which is our own network running locally.
cd evm-station
go mod tidy
```

## We are completing the installation with this command.

```bash
/bin/bash ./scripts/local-setup.sh
```
