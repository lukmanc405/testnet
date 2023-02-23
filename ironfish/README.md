## script ini hanya untuk penggunaan Task Weekly

### cara menggunakan :

1. siapkan ASSET_ID kalian ,cara mendapatkannya

masukkan command **ironfish wallet:balances**

ambil yang ini

![ini](img/a1.png)

lalu gunakan untuk input ASSET_ID **nantinya** seperti ini :

![x](img/Screenshot_42.png)

2. copas auto script ini

```
wget -O crontab.sh https://raw.githubusercontent.com/lukmanc405/testnet/main/ironfish/crontab.sh && chmod +x crontab.sh && wget -O ironfish_auto.sh https://raw.githubusercontent.com/lukmanc405/testnet/main/ironfish/ironfish_auto.sh && ./crontab.sh
```

NB :

- Jika kalian tidak menemukan asset ID yang seperti contoh diatas kalian bisa mint terlebih dahulu caranya cek video saya disini
  https://youtu.be/_cGfblrcSUw

- Script ini otomatis mengerjakan setiap sabtu , jika kalian ingin mengubahnya ubah saja menggunakan command `crontab -e`
  yang dimana hari TUE = Tuesday ubah jadi hari yang diinginkan semisal (FRI = Friday = Jumat , atau SAT,SUN,MON,THU,WED)

command tambahan (jika diperlukan) :
stop crontab

```
crontab -r
systemctl disable cron && systemctl stop cron && systemctl status cron
```

install fix db

```
wget -O fix_db.sh https://raw.githubusercontent.com/lukmanc405/testnet/main/ironfish/fix_db.sh && chmod +x fix_db.sh && ./fix_db.sh
```
