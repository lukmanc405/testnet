# Upgrade Version

```bash
cd $HOME/initia && git fetch --all && git checkout v0.2.15 && git pull origin v0.2.15 && make build && sudo mv $HOME/initia/build/initiad $(which initiad) && sudo systemctl restart initiad && sudo journalctl -u initiad -f
```
