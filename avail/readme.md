The Light Client Lift-off challenge

![image](https://imgur.com/a/EMM0iWG)

Official doc : https://docs.availproject.org/docs/operate-a-node/run-a-light-client/light-client-challenge

Time : 2 April 2024 hingga 9 April 2024.

### Minimum spec :
2 vCPU, 4GB ram and 200GB storage


### Update package & install depencies 

```
sudo apt update && sudo apt full-upgrade -y && sudo apt install curl tar wget clang pkg-config libssl-dev jq build-essential bsdmainutils git make ncdu gcc git jq chrony liblz4-tool
```

###  Screen

install screen 

```
apt install screen 
```
create screen

```
screen -S avail-light
```

### Masukkan command untuk run node light client avail


```
curl -sL1 avail.sh | bash
```

ambil public-key nya disini,sewaktu penginstalan copy publickeynya yang ane tandain 

![image](https://imgur.com/JaPOvNt)

setelah itu keluar screen pakai

ctrl A + D



### jangan lupa signup kesini
https://lightclient.availproject.org/

DONE