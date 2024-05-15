# Upgrade Version

```bash
cd initia
git pull
git checkout v0.2.12
make install
sudo systemctl start initiad && sudo journalctl -u initiad -f --no-hostname -o cat
```
