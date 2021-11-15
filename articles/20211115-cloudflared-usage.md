```
download from https://github.com/cloudflare/cloudflared/releases/
./cloudflared-linux-amd64 login
./cloudflared-linux-amd64 tunnel create tw42
./cloudflared-linux-amd64 tunnel route dns tw42 tw42.kskb.eu.org
./cloudflared-linux-amd64 --url http://proxy:4242 tunnel run tw42
```
