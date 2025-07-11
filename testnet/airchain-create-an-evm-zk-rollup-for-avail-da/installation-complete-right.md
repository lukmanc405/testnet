# Installation complete, right?

You have completed the installation process. However, currently, you are not earning points. We recommend importing the mnemonics of your Tracker wallet into the Leap wallet and connecting to [https://points.airchains.io/](https://points.airchains.io/). You can view your station and points on the dashboard. Since we haven't made any transactions yet, you will see 100 points pending. The reason for this is that you need to extract a pod to earn points. You can think of a pod as a package consisting of 25 transactions. Each set of 25 transactions will generate 1 pod, and you will earn 5 points from these transactions. The initial 100 points from the installation will become active after the first pod.

For this, we do the following: Initially, we obtained a private key with the command `bin/bash ./scripts/local-keys.sh` and made RPC settings. Then we import this private key into Metamask, in the "Add Network" section.

```
rpc: http://IP:8545

id: 1234

ticker: eEVMOS
```

We enter and confirm.

From here on, you can either deploy a contract or manually send transactions; it's up to you.

For those experiencing RPC errors during the tracking process, they can try to roll back. Sometimes the issue is resolved with 1 rollback, other times it may require 3 rollback operations. Run the command `go run cmd/main.go rollback` as many times as you want to perform a rollback. Wait for the output after each run.

```bash
cd $HOME && \
systemctl stop stationd && \
cd tracks && \
git pull && \
go run cmd/main.go rollback && \
sudo systemctl restart stationd && \
sudo journalctl -u stationd -f --no-hostname -o cat
```

<figure><img src="../../.gitbook/assets/image (11).png" alt=""><figcaption><p><a href="https://points.airchains.io/">https://points.airchains.io/</a></p></figcaption></figure>
