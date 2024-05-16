# Upgrade Version

```bash
# Clone project repository
cd $HOME
rm -rf initia
git clone https://github.com/initia-labs/initia
cd initia
git checkout v0.2.14
export GOPATH="${HOME}/lib"
make install

mv ${HOME}/lib/bin/* ~/go/bin/

sudo systemctl restart initiad && sudo journalctl -u initiad -f
```
