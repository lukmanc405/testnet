# Gensyn-ai

<figure><img src="../.gitbook/assets/HYuS2M6NAL.jpg" alt=""><figcaption></figcaption></figure>

* CPU: Minimum 16GB RAM (more RAM recommended for larger models or datasets).

OR

*   GPU (Optional): Supported CUDA devices for enhanced performance:

    * RTX 3090
    * RTX 4090
    * A100
    * H100

    > recommend GPUs with >=24GB vRAM.
* **Note**: You can run the node without a GPU using CPU-only mode.

Create Ngrok account on here :\
\
[https://dashboard.ngrok.com/get-started/setup/linux](https://dashboard.ngrok.com/get-started/setup/linux)\
\
copy your token

### 1) Install Node

```bash
curl -o install_gensyn.sh curl -o install_gensyn.sh https://raw.githubusercontent.com/lukmanc405/testnet/refs/heads/main/gensyn/install_gensyn.sh && chmod +x install_gensyn.sh && ./install_gensyn.sh
```

***

***

### 2) Login



**1- You have to receive `Waiting for userData.json to be created...` in log**![](../.gitbook/assets/image.png)

**2-  Back to /root**

![](<../.gitbook/assets/image (18).png>)

**Find this link and click or copy then paste to your browser**

**3- Login with your email**

* After login, your terminal starts installation.



<sup>**4-**</sup>**&#x20;Optional**<sup>**:**</sup>**&#x20;**_**Push models to huggingface**_

* _Enter your `HuggingFace` access token you've created when it prompted_
* _This will need `2GB` upload bandwidth for each model you train, you can pass it by entering_&#x20;



***

#### Node Name



*   Now your node started running, Find your name after word `INFO:hivemind_exp.trainer.hivemind_grpo_trainer:` , like mine is `aquatic monstrous peacock` as in the image below (You can use `CTRL+SHIFT+F` to search `INFO:hivemind_exp.trainer.hivemind_grpo_trainer:` in terminal\
    \


    <figure><img src="../.gitbook/assets/image (1).png" alt="" width="375"><figcaption></figcaption></figure>

***

#### Screen commands



* Minimize: `CTRL` + `A` + `D`
* Return: `screen -r swarm`
* Stop and Kill: `screen -XS swarm quit`

***

### Backup



**You need to backup `swarm.pem`**.

#### `VPS`:



Connect your VPS using `Mobaxterm` client to be able to move files to your local system. Back up these files:\*\*

* `/root/rl-swarm/swarm.pem`

#### `WSL`:



Search `\\wsl.localhost` in your _**Windows Explorer**_ to see your Ubuntu directory. Your main directories are as follows:

* If installed via a username: `\\wsl.localhost\Ubuntu\home\<your_username>`
* If installed via root: `\\wsl.localhost\Ubuntu\root`
* Look for `rl-swarm/swarm.pem`

#### `GPU servers (.eg, Hyperbolic)`:



**1- Connect to your GPU server by entering this command in `Windows PowerShell` terminal**

```
sftp -P PORT ubuntu@xxxx.hyperbolic.xyz
```

* Replace `ubuntu@xxxx.hyperbolic.xyz` with your given GPU hostname
* Replace `PORT` with your server port (in your server ssh connection command)
* `ubuntu` is the user of my hyperbolic gpu, it can be _**anything else**_ or it's `root` if you test it out for `vps`

Once connected, you’ll see the SFTP prompt:

```
sftp>
```

**2- Navigate to the Directory Containing the Files**

* After connecting, you’ll start in your home directory on the server. Use the `cd` command to move to the directory of your files:

```
cd /home/ubuntu/rl-swarm
```

**3- Download Files**

* Use the `get` command to download the files to your `local system`. They’ll save to your current local directory unless you specify otherwise:

```
get swarm.pem
```

* Downloaded file is in the main directory of your `Powershell` or `WSL` where you entered the sFTP command.
  * If entered sftp command in `Powershell`, the `swarm.pem` file might be in `C:\Users\<pc-username>`.
* You can now type `exit` to close connection. The files are in the main directory of your `Powershell` or `WSL` where you entered the first SFTP command.

***

#### Recovering Backup file (upload)



If you need to upload files from your `local machine` to the `server`.

* `WSL` & `VPS`: Drag & Drop option.

**`GPU servers (.eg, Hyperbolic)`:**

1- Connect to your GPU server using sFTP

2- Upload Files Using the `put` Command:

In SFTP, the put command uploads files from your local machine to the server.

```bash
put swarm.pem /home/ubuntu/rl-swarm/swarm.pem
```

***

## Run on Hyperbolic GPUs



* To install the node on **Hyperbolic** check this [Guide: Rent & Connect to GPU](https://github.com/0xmoei/Hyperbolic-GPU)
* Add this flag: `-L 3000:localhost:3000` in front of your Hyperbolic's `SSH-command`, this will allow you to access to login page via local system

***

## Run on Vast.ai GPUs



* 1- Register in [Vast.ai](https://cloud.vast.ai/?ref_id=228875)
* 2- Create ssh key in your local system (If you don't have already) with this [Guide: step 1-5](https://github.com/0xmoei/Hyperbolic-GPU)
* 3- Paste SSH public key to `Setting > SSH Keys` [here](https://cloud.vast.ai/account/)
* 4- Select Pytorch(Vast) template [here](https://cloud.vast.ai/templates/)
* 5- Choose a supported GPU (I recommend >=24GB Per-GPU vRAM)
* 6- Increase `Disk Space` slidebar to `200GB`
* 7- Top-up with credits and rent it.
* 8- Go to [instances](https://cloud.vast.ai/instances/), refresh the page, click on `key` button
* 9- Create an ssh key,
* 10- Copy SSH Command, and Replace `-L 3000:localhost:3000` in front of the command.
* 11- Enter the command in `Windows Powershell` and run it

***

## Node Health



#### Official Dashboard



* Top 100 round-participants: [https://dashboard.gensyn.ai/](https://dashboard.gensyn.ai/)

[![image](https://private-user-images.githubusercontent.com/90371338/428832899-cd8e8cd3-f057-450a-b1a2-a90ca10aa3a6.png?jwt=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJnaXRodWIuY29tIiwiYXVkIjoicmF3LmdpdGh1YnVzZXJjb250ZW50LmNvbSIsImtleSI6ImtleTUiLCJleHAiOjE3NDUwMTk3MzEsIm5iZiI6MTc0NTAxOTQzMSwicGF0aCI6Ii85MDM3MTMzOC80Mjg4MzI4OTktY2Q4ZThjZDMtZjA1Ny00NTBhLWIxYTItYTkwY2ExMGFhM2E2LnBuZz9YLUFtei1BbGdvcml0aG09QVdTNC1ITUFDLVNIQTI1NiZYLUFtei1DcmVkZW50aWFsPUFLSUFWQ09EWUxTQTUzUFFLNFpBJTJGMjAyNTA0MTglMkZ1cy1lYXN0LTElMkZzMyUyRmF3czRfcmVxdWVzdCZYLUFtei1EYXRlPTIwMjUwNDE4VDIzMzcxMVomWC1BbXotRXhwaXJlcz0zMDAmWC1BbXotU2lnbmF0dXJlPWU3YzhmYWNiNGE2ZDQzMjE4ZWEzYzQ3ZWQ5MTM1MjU2YzVhMjhhYTZlN2FjYTQyNzc5MzM1NzU1MDQyOTY0NWQmWC1BbXotU2lnbmVkSGVhZGVycz1ob3N0In0.v_JibJddc9McjPZbNYNpDFccVPpZ4BExamZb3qm2vQ4)](https://private-user-images.githubusercontent.com/90371338/428832899-cd8e8cd3-f057-450a-b1a2-a90ca10aa3a6.png?jwt=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJnaXRodWIuY29tIiwiYXVkIjoicmF3LmdpdGh1YnVzZXJjb250ZW50LmNvbSIsImtleSI6ImtleTUiLCJleHAiOjE3NDUwMTk3MzEsIm5iZiI6MTc0NTAxOTQzMSwicGF0aCI6Ii85MDM3MTMzOC80Mjg4MzI4OTktY2Q4ZThjZDMtZjA1Ny00NTBhLWIxYTItYTkwY2ExMGFhM2E2LnBuZz9YLUFtei1BbGdvcml0aG09QVdTNC1ITUFDLVNIQTI1NiZYLUFtei1DcmVkZW50aWFsPUFLSUFWQ09EWUxTQTUzUFFLNFpBJTJGMjAyNTA0MTglMkZ1cy1lYXN0LTElMkZzMyUyRmF3czRfcmVxdWVzdCZYLUFtei1EYXRlPTIwMjUwNDE4VDIzMzcxMVomWC1BbXotRXhwaXJlcz0zMDAmWC1BbXotU2lnbmF0dXJlPWU3YzhmYWNiNGE2ZDQzMjE4ZWEzYzQ3ZWQ5MTM1MjU2YzVhMjhhYTZlN2FjYTQyNzc5MzM1NzU1MDQyOTY0NWQmWC1BbXotU2lnbmVkSGVhZGVycz1ob3N0In0.v_JibJddc9McjPZbNYNpDFccVPpZ4BExamZb3qm2vQ4)

#### Telegram Bot



Search you `Node ID` here with `/check` here: [https://t.me/gensyntrackbot](https://t.me/gensyntrackbot)

* `Node-ID` is near your Node name
* ⚠️ If receiving `EVM Wallet: 0x0000000000000000000000000000000000000000`, your `onchain-participation` is not being tracked and you have to Install with `New Email` and _**Delete old****&#x20;****`swarm.pem`**_

***

## Troubleshooting:



#### ⚠️ Upgrade viem & Node version in Login Page



1- Modify: `package.json`

```
cd rl-swarm
nano modal-login/package.json
```

* Update: `"viem":` to `"2.25.0"`

2- Upgrade

```
cd rl-swarm
cd modal-login
yarn install

yarn upgrade && yarn add next@latest && yarn add viem@latest

cd ..
```

#### ⚠️ CPU-only Users: Ran out of input



Navigate:

```
cd rl-swarm
```

Edit:

```
nano hivemind_exp/configs/mac/grpo-qwen-2.5-0.5b-deepseek-r1.yaml
```

* Lower `max_steps` to `5`

